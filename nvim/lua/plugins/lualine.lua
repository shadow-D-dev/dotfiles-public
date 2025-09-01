return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function(_, opts)
      opts = opts or {}
      opts.options = opts.options or {}

      -- safe requires
      local ok_color, color_util = pcall(require, "utils.color")
      if not ok_color then
        color_util = nil
      end
      local ok_lazy, LazyVim = pcall(require, "lazyvim.util")
      -- theme resolution helper
      local function resolve_theme(t)
        if type(t) == "table" then
          return t
        end
        if type(t) == "string" then
          local ok, tbl = pcall(require, "lualine.themes." .. t)
          if ok and type(tbl) == "table" then
            return tbl
          end
        end
        local ok_auto, auto = pcall(require, "lualine.themes.auto")
        return ok_auto and auto or {}
      end

      local theme = resolve_theme(opts.options.theme)

      ----------------------------------------------------------------
      -- Config knobs
      ----------------------------------------------------------------
      local fallback_bg = "#002b36"
      local fallback_fg = "#eee8d5"
      local brighten_amt = 0.18 -- adjust to increase/decrease separator brightness

      ----------------------------------------------------------------
      -- mode helpers & theme pickers
      ----------------------------------------------------------------
      local mode_map = {
        n = "normal",
        i = "insert",
        v = "visual",
        V = "visual",
        [""] = "visual",
        c = "command",
        R = "replace",
        s = "visual",
        S = "visual",
        t = "normal",
      }
      local function mode_key()
        local m = (vim.api.nvim_get_mode() or {}).mode or "n"
        return mode_map[m] or "normal"
      end

      local function pick_section(mkey, key)
        local src = (theme[mkey] or theme.normal) or {}
        return src[key] or (theme.normal and theme.normal[key]) or {}
      end
      local function safe_bg(sec, fb)
        if type(sec) == "table" and type(sec.bg) == "string" then
          return sec.bg
        end
        return fb
      end
      local function safe_fg(sec, ff)
        if type(sec) == "table" and type(sec.fg) == "string" then
          return sec.fg
        end
        return ff
      end

      ----------------------------------------------------------------
      -- small per-redraw cache to avoid repeating theme lookups many times
      ----------------------------------------------------------------
      local color_cache = { last_mode = nil, cache = {} }
      local function get_colors_for_key(key)
        local mk = mode_key()
        if color_cache.last_mode ~= mk then
          color_cache.last_mode = mk
          color_cache.cache = {}
        end
        if color_cache.cache[key] then
          return color_cache.cache[key]
        end
        local sec = pick_section(mk, key)
        local fg = safe_fg(sec, fallback_fg)
        local bg = safe_bg(sec, fallback_bg)
        local tbl = { fg = fg, bg = bg, gui = sec.gui }
        color_cache.cache[key] = tbl
        return tbl
      end

      ----------------------------------------------------------------
      -- color functions (used by lualine)
      ----------------------------------------------------------------
      local function block_color_fn(key)
        return function()
          local c = get_colors_for_key(key)
          return { fg = c.fg, bg = c.bg, gui = c.gui }
        end
      end

      local function tri_color_fn(leftKey, rightKey)
        return function()
          local leftc = get_colors_for_key(leftKey)
          local rightc = get_colors_for_key(rightKey)
          local tri_fg = (color_util and color_util.brighten(leftc.bg, brighten_amt)) or leftc.bg
          return { fg = tri_fg, bg = rightc.bg }
        end
      end

      ----------------------------------------------------------------
      -- component wrappers (safe, normalizes cond)
      ----------------------------------------------------------------
      local function normalize_cond(maybe_cond)
        if maybe_cond == nil then
          return nil
        end
        if type(maybe_cond) == "function" then
          return maybe_cond
        end
        if type(maybe_cond) == "boolean" then
          if maybe_cond then
            return nil
          else
            return function()
              return false
            end
          end
        end
        -- anything else -> ignore
        return nil
      end

      local function rect_component(comp, key, opts_comp)
        opts_comp = opts_comp or {}
        local item = {}

        -- copy component table fields (so we never hand lualine a nested table as the "callable")
        if type(comp) == "table" then
          for k, v in pairs(comp) do
            item[k] = v
          end
        else
          item[1] = comp
        end

        -- prefer explicit cond from opts_comp; otherwise preserve any cond in the component table
        local chosen_cond = opts_comp.cond ~= nil and opts_comp.cond or item.cond
        item.cond = normalize_cond(chosen_cond)

        item.color = block_color_fn(key)
        item.padding = opts_comp.padding or item.padding or { left = 1, right = 1 }
        return item
      end

      local function triangle(direction, leftKey, rightKey, maybe_cond)
        local sym = (direction == "left") and "" or ""
        local t = {
          function()
            return sym
          end,
          padding = 0,
          color = tri_color_fn(leftKey, rightKey),
        }
        local ncond = normalize_cond(maybe_cond)
        if ncond ~= nil then
          t.cond = ncond
        end
        return t
      end

      ----------------------------------------------------------------
      -- diagnostics helper (used as cond for diagnostics component)
      ----------------------------------------------------------------
      local function diag_has_any()
        local e = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        local w = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
        local i = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
        local h = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
        return (e + w + i + h) > 0
      end

      ----------------------------------------------------------------
      -- Build sections (declarative but explicit where needed)
      ----------------------------------------------------------------
      local left = {}

      -- Mode block (with recording)
      local function mode_block()
        local reg = vim.fn.reg_recording()
        if reg ~= "" then
          return "REC @" .. reg
        end
        local m = (vim.api.nvim_get_mode() or {}).mode or "n"
        local mm = {
          n = "NORMAL",
          i = "INSERT",
          v = "VISUAL",
          V = "V-LINE",
          [""] = "V-BLOCK",
          c = "COMMAND",
          R = "REPLACE",
          s = "SELECT",
          S = "S-LINE",
          t = "TERMINAL",
        }
        return mm[m] or m:upper()
      end

      table.insert(left, rect_component(mode_block, "a"))
      table.insert(left, triangle("right", "a", "b"))

      -- branch
      table.insert(left, rect_component("branch", "b"))

      -- dynamic triangle after branch: if diagnostics exist, it should point to diagnostics block;
      -- otherwise it should point to the center 'c' block. We implement that in color fn directly.
      table.insert(left, {
        function()
          return ""
        end,
        padding = 0,
        color = function()
          local nextKey = diag_has_any() and "b" or "c"
          local prevc = get_colors_for_key("b")
          local nextc = get_colors_for_key(nextKey)
          local tri_fg = (color_util and color_util.brighten(prevc.bg, brighten_amt)) or prevc.bg
          return { fg = tri_fg, bg = "#002b36" }
        end,
      })

      -- diagnostics block (only show if present)
      -- local diag_component = {
      --   "diagnostics",
      --   sources = { "nvim_diagnostic" },
      --   sections = { "error", "warn", "info", "hint" },
      --   symbols = { error = " ", warn = " ", info = " ", hint = " " },
      --   colored = true,
      --   update_in_insert = false,
      --   cond = diag_has_any,
      -- }
      -- table.insert(left, rect_component(diag_component, "b", { cond = diag_has_any }))

      -- triangle to center (b -> c)
      -- table.insert(left, triangle("right", "b", "c"))

      ----------------------------------------------------------------
      -- Center: exact placement at lualine_c[4] (wrapped so it uses our block coloring)
      ----------------------------------------------------------------
      opts.sections = opts.sections or {}
      opts.sections.lualine_c = opts.sections.lualine_c or {}

      local pretty_path_component
      if ok_lazy and LazyVim and LazyVim.lualine and LazyVim.lualine.pretty_path then
        pretty_path_component = LazyVim.lualine.pretty_path({
          length = 0,
          relative = "cwd",
          modified_hl = "MatchParen",
          directory_hl = "",
          filename_hl = "Bold",
          modified_sign = "",
          readonly_icon = " 󰌾 ",
        })
      else
        pretty_path_component = { "filename", path = 1 }
      end
      opts.sections.lualine_c[4] = rect_component(pretty_path_component, "c")

      ----------------------------------------------------------------
      -- Right side
      ----------------------------------------------------------------
      local right = {}
      -- table.insert(right, triangle("left", "c", "b"))
      table.insert(right, rect_component("encoding", "c"))
      table.insert(right, triangle("left", "b", "c"))
      table.insert(right, rect_component("fileformat", "b"))
      table.insert(right, triangle("left", "a", "b"))
      table.insert(right, rect_component("filetype", "a"))
      table.insert(right, triangle("left", "b", "a"))
      table.insert(right, rect_component("progress", "b"))
      table.insert(right, triangle("left", "c", "b"))
      table.insert(right, rect_component("location", "c"))

      ----------------------------------------------------------------
      -- Finalize opts
      ----------------------------------------------------------------
      opts.options.icons_enabled = opts.options.icons_enabled == nil and true or opts.options.icons_enabled
      opts.options.component_separators = { left = "", right = "" }
      opts.options.section_separators = { left = "", right = "" }
      opts.options.globalstatus = true
      opts.options.theme = opts.options.theme or theme

      opts.sections.lualine_a = left
      opts.sections.lualine_b = {}
      -- center preserved at lualine_c[4]
      opts.sections.lualine_x = right
      opts.sections.lualine_y = {}
      opts.sections.lualine_z = {}
    end,
  },
}

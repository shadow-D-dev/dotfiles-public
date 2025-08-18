vim.g.mapleader = " "

local opt = vim.opt
-- Basic settings
opt.number = true
opt.relativenumber = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.winborder = "rounded"

--search settings
opt.ignorecase = true
opt.smartcase = true

-- cursor line
opt.cursorline = true -- highlight the current cursor line

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position
-- snacks animations
vim.g.snacks_animate = false
vim.opt.conceallevel = 2
vim.opt.concealcursor = "nc"

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    local function continue_list()
      local line = vim.api.nvim_get_current_line()
      local indent = line:match("^%s*") or ""

      -- Numbered list
      local num = line:match("^%s*(%d+)%.%s*")
      if num then
        return indent .. (tonumber(num) + 1) .. ". "
      end

      -- Checkbox task
      local task = line:match("^%s*([%-%*%+]%s+%[[ xX]?%]%s+)")
      if task then
        local bullet = task:match("^[%-%*%+]")
        return indent .. bullet .. " [ ] "
      end

      -- Bullet list
      local bullet = line:match("^%s*([%-%*%+])%s+")
      if bullet then
        return indent .. bullet .. " "
      end

      -- Todo keyword
      local todo = line:match("^%s*([Tt][Oo][Dd][Oo]:?)%s*")
      if todo then
        return indent .. "TODO "
      end

      return indent
    end

    -- Insert-mode continuation (Enter)
    vim.keymap.set("i", "<CR>", function()
      return "<CR>" .. continue_list()
    end, { buffer = true, expr = true })

    -- Normal mode continuation (o / O)
    vim.keymap.set("n", "o", function()
      return "o" .. continue_list()
    end, { buffer = true, expr = true })

    vim.keymap.set("n", "O", function()
      return "O" .. continue_list()
    end, { buffer = true, expr = true })
  end,
})

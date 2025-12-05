return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	init = function()
		vim.g.lualine_laststatus = vim.o.laststatus
		if vim.fn.argc(-1) > 0 then
			vim.o.statusline = " "
		else
			vim.o.laststatus = 0
		end
	end,
	opts = function()
		local icons = {
			diagnostics = {
				Error = " ",
				Warn = " ",
				Hint = " ",
				Info = " ",
			},
			git = {
				added = " ",
				modified = " ",
				removed = " ",
			},
		}

		vim.o.laststatus = vim.g.lualine_laststatus

		-- LazyVim's format function for custom highlighting
		local function format(component, text, hl_group)
			if not hl_group then
				return text
			end
			---@type table<string, string>
			component.hl_cache = component.hl_cache or {}
			local lualine_hl_group = component.hl_cache[hl_group]
			if not lualine_hl_group then
				local utils = require("lualine.utils.utils")
				local mygui = function()
					local mybold = utils.extract_highlight_colors(hl_group, "bold") and "bold"
					local myitalic = utils.extract_highlight_colors(hl_group, "italic") and "italic"
					if mybold and myitalic then
						return mybold .. "," .. myitalic
					elseif mybold then
						return mybold
					elseif myitalic then
						return myitalic
					else
						return ""
					end
				end
				lualine_hl_group = component:create_hl({
					fg = utils.extract_highlight_colors(hl_group, "fg"),
					gui = mygui(),
				}, "LV_" .. hl_group)
				component.hl_cache[hl_group] = lualine_hl_group
			end
			return component:format_hl(lualine_hl_group) .. text .. component:get_default_hl()
		end

		-- LazyVim's pretty_path function
		---@param opts? {relative: "cwd"|"root", modified_hl: string?, filename_hl: string?, dirpath_hl: string?}
		local function pretty_path(opts)
			opts = vim.tbl_extend("force", {
				relative = "cwd",
				modified_hl = "MatchParen", -- Red/prominent color when modified
				filename_hl = "Bold", -- Bold for filename
				dirpath_hl = "", -- Normal for directory path
			}, opts or {})

			return function(self)
				local path = vim.fn.expand("%:p") --[[@as string]]

				if path == "" then
					return ""
				end

				-- Get root directory (you can replace this with vim.fn.getcwd() if not using project root detection)
				local root = vim.fn.getcwd()
				local cwd = vim.fn.getcwd()

				-- Make path relative
				if opts.relative == "cwd" and path:find(cwd, 1, true) == 1 then
					path = path:sub(#cwd + 2)
				elseif path:find(root, 1, true) == 1 then
					path = path:sub(#root + 2)
				end

				local sep = package.config:sub(1, 1)
				local parts = vim.split(path, "[\\/]")

				-- Shorten path if too long (more than 3 parts)
				if #parts > 3 then
					parts = { parts[1], "…", parts[#parts - 1], parts[#parts] }
				end

				-- Apply highlighting: red if modified, bold otherwise
				if opts.modified_hl and vim.bo.modified then
					parts[#parts] = format(self, parts[#parts], opts.modified_hl)
				else
					parts[#parts] = format(self, parts[#parts], opts.filename_hl)
				end

				-- Apply dirpath highlighting if specified
				if #parts > 1 then
					local dirpath = table.concat({ unpack(parts, 1, #parts - 1) }, sep)
					dirpath = format(self, dirpath, opts.dirpath_hl)
					return dirpath .. sep .. parts[#parts]
				end

				return table.concat(parts, sep)
			end
		end

		return {
			options = {
				theme = "auto",
				globalstatus = vim.o.laststatus == 3,
				disabled_filetypes = {
					statusline = { "dashboard", "alpha", "ministarter" },
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch" },
				lualine_c = {
					{
						"diagnostics",
						symbols = {
							error = icons.diagnostics.Error,
							warn = icons.diagnostics.Warn,
							info = icons.diagnostics.Info,
							hint = icons.diagnostics.Hint,
						},
					},
					{
						"filetype",
						icon_only = true,
						separator = "",
						padding = { left = 1, right = 0 },
					},
					{
						pretty_path(),
					},
				},
				lualine_x = {
					{
						"diff",
						symbols = {
							added = icons.git.added,
							modified = icons.git.modified,
							removed = icons.git.removed,
						},
						source = function()
							local gitsigns = vim.b.gitsigns_status_dict
							if gitsigns then
								return {
									added = gitsigns.added,
									modified = gitsigns.changed,
									removed = gitsigns.removed,
								}
							end
						end,
					},
					"encoding",
					"fileformat",
					"filetype",
				},
				lualine_y = {
					{ "progress", separator = " ", padding = { left = 1, right = 0 } },
					{ "location", padding = { left = 0, right = 1 } },
				},
				lualine_z = {
					function()
						return " " .. os.date("%R")
					end,
				},
			},
			extensions = { "neo-tree", "lazy", "fzf" },
		}
	end,
}

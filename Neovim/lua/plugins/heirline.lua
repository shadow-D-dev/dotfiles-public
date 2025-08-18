return {
	"rebelot/heirline.nvim",
	event = "BufReadPre",
	dependencies = { "echasnovski/mini.icons" },
	config = function()
		local conditions = require("heirline.conditions")
		local utils = require("heirline.utils")
		local colors = {
			bg = "#282a36",
			fg = "#f8f8f2",
			red = "#ff5555",
			green = "#50fa7b",
			blue = "#8be9fd",
			yellow = "#f1fa8c",
			purple = "#bd93f9",
			pink = "#ff79c6",
			orange = "#ffb86c",
		}

		-- Mode component
		local ViMode = {
			init = function(self)
				self.mode = vim.fn.mode(1)
			end,
			static = {
				mode_names = {
					n = "N",
					i = "I",
					v = "V",
					V = "V-I",
					["\22"] = "V-B",
					c = "C",
					s = "SELECT",
					S = "S-LINE",
					R = "REPLACE",
					r = "HIT-ENTER",
				},
				mode_colors = {
					n = "purple",
					i = "green",
					v = "red",
					V = "red",
					["\22"] = "purple",
					c = "orange",
					R = "pink",
					r = "pink",
				},
			},
			provider = function(self)
				return " " .. self.mode_names[self.mode] .. " "
			end,
			hl = function(self)
				local mode_color = self.mode_colors[self.mode]
				return { fg = colors.bg, bg = colors[mode_color], bold = true }
			end,
		}

		-- Git branch
		local Git = {
			condition = conditions.is_git_repo,
			provider = function()
				local branch = vim.b.gitsigns_head
				return branch and ("  " .. branch .. " ") or ""
			end,
			hl = { fg = colors.purple, bg = colors.bg },
		}
		-- Git diff
		local GitDiff = {
			condition = conditions.is_git_repo,
			static = {
				icons = {
					added = "",
					changed = "󰦓",
					removed = "",
				},
			},
			init = function(self)
				local gsd = vim.b.gitsigns_status_dict or {}
				self.added = gsd.added or 0
				self.changed = gsd.changed or 0
				self.removed = gsd.removed or 0
			end,
			{
				provider = function(self)
					return self.added > 0 and (self.icons.added .. self.added .. " ")
				end,
				hl = { fg = colors.green, bg = colors.bg },
			},
			{
				provider = function(self)
					return self.changed > 0 and (self.icons.changed .. self.changed .. " ")
				end,
				hl = { fg = colors.yellow, bg = colors.bg },
			},
			{
				provider = function(self)
					return self.removed > 0 and (self.icons.removed .. self.removed)
				end,
				hl = { fg = colors.red, bg = colors.bg },
			},
		}
		local Diagnostics = {
			condition = conditions.has_diagnostics,
			static = {
				error_icon = "  ",
				warn_icon = "  ",
				info_icon = "  ",
				hint_icon = " 󰠠 ",
			},
			init = function(self)
				self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
				self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
				self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
				self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
			end,
			{
				provider = function(self)
					return self.errors > 0 and (self.error_icon .. self.errors .. " ") or ""
				end,
				hl = { bg = colors.bg, fg = "#ff5555" }, -- red for errors
			},
			{
				provider = function(self)
					return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ") or ""
				end,
				hl = { bg = colors.bg, fg = "#f1fa8c" }, -- yellow for warnings
			},
			{
				provider = function(self)
					return self.info > 0 and (self.info_icon .. self.info .. " ") or ""
				end,
				hl = { bg = colors.bg, fg = "#8be9fd" }, -- cyan for info
			},
			{
				provider = function(self)
					return self.hints > 0 and (self.hint_icon .. self.hints) or ""
				end,
				hl = { bg = colors.bg, fg = "#50fa7b" }, -- green for hints
			},
		}
		local LSPClients = {
			condition = conditions.lsp_attached,
			provider = function()
				local names = {}
				for _, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
					table.insert(names, server.name)
				end
				return table.concat(names, ", ")
			end,
			hl = { fg = colors.purple, bg = colors.bg },
		}
		-- Right side info
		local Ruler = {
			provider = " %l:%c / %L ",
			hl = { fg = colors.purple, bg = colors.bg },
		}

		require("heirline").setup({
			statusline = {
				ViMode,
				Git,
				GitDiff,
				{ provider = "%=" }, -- align to right
				Diagnostics,
				LSPClients,
				Ruler,
			},
		})
	end,
}

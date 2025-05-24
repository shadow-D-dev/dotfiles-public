return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,

  opts = {
    dashboard = {
      preset = {
        keys = {},
        header = [[
 ███████╗██╗  ██╗ █████╗ ██████╗  ██████╗ ██╗    ██╗
 ██╔════╝██║  ██║██╔══██╗██╔══██╗██╔═══██╗██║    ██║
 ███████╗███████║███████║██║  ██║██║   ██║██║ █╗ ██║
 ╚════██║██╔══██║██╔══██║██║  ██║██║   ██║██║███╗██║
 ███████║██║  ██║██║  ██║██████╔╝╚██████╔╝╚███╔███╔╝
 ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝  ╚═════╝  ╚══╝╚══╝
      ]],
      },
    },
    picker = {

      layout = {
        preset = "ivy",
        cycle = false,
      },
      layouts = {
        ivy = {
          layout = {
            box = "vertical",
            backdrop = false,
            row = -1,
            width = 0,
            height = 0.5,
            border = "top",
            title = " {title} {live} {flags}",
            title_pos = "left",
            { win = "input", height = 1, border = "bottom" },
            {
              box = "horizontal",
              { win = "list", border = "none" },
              { win = "preview", title = "{preview}", width = 0.5, border = "left" },
            },
          },
        },
      },
    },
  },
  -- opts completed
  keys = {

    {
      "<leader><space>",
      function()
        Snacks.picker.files({
          finder = "files",
          format = "file",
          show_empty = true,
          supports_live = true,
          -- In case you want to override the layout for this keymap
          -- layout = "vscode",
        })
      end,
      desc = "Find Files",
    },
  },
}

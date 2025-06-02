-- This is the popup files with vim actions support things like dd, yy, etc
return {
  "echasnovski/mini.files",
  opts = function(_, opts)
    opts.mappings = vim.tbl_deep_extend("force", opts.mappings or {}, {
      close = "<esc>",
      go_in = "l",
      go_in_plus = "<CR>",
      go_out = "H",
      go_out_plus = "h",
      reset = "<BS>",
      reveal_cwd = ".",
      show_help = "g?",
      synchronize = "s",
      trim_left = "<",
      trim_right = ">",
    })

    opts.custom_keymaps = {
      open_tmux_pane = "<M-t>",
      copy_to_clipboard = "<space>yy",
      zip_and_copy = "<space>yz",
      paste_from_clipboard = "<space>p",
      copy_path = "<M-c>",
      preview_image = "<space>i",
      preview_image_popup = "<M-i>",
    }

    opts.windows = vim.tbl_deep_extend("force", opts.windows or {}, {
      preview = true,
      width_focus = 30,
      width_preview = 80,
    })

    opts.options = vim.tbl_deep_extend("force", opts.options or {}, {
      use_as_default_explorer = true,
      permanent_delete = false,
    })
    return opts
  end,

  keys = {

    {
      -- Open the directory of the file currently being edited
      -- If the file doesn't exist because you maybe switched to a new git branch
      -- open the current working directory
      "<leader>m",
      function()
        local buf_name = vim.api.nvim_buf_get_name(0)
        local dir_name = vim.fn.fnamemodify(buf_name, ":p:h")
        if vim.fn.filereadable(buf_name) == 1 then
          -- Pass the full file path to highlight the file
          require("mini.files").open(buf_name, true)
        elseif vim.fn.isdirectory(dir_name) == 1 then
          -- If the directory exists but the file doesn't, open the directory
          require("mini.files").open(dir_name, true)
        else
          -- If neither exists, fallback to the current working directory
          require("mini.files").open(vim.uv.cwd(), true)
        end
      end,
      desc = "Open mini.files (Directory of Current File or CWD if not exists)",
    },
    {
      "<leader>M",
      function()
        require("mini.files").open(vim.uv.cwd(), true)
      end,
      desc = "Open mini.files (cwd)",
    },
  },

  config = function(_, opts)
    -- Set up mini.files
    require("mini.files").setup(opts)

    -- Removed `mini_files_km.setup(opts)` and `mini_files_git.setup()`
    -- because they were undefined, causing the error.
  end,
}

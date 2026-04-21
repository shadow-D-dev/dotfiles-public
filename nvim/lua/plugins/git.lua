return {
  "dinhhuy258/git.nvim",
  event = "BufReadPre",
  opts = {
    keymaps = {
      -- Open blame window
      blame = "<Leader>gb",
      -- Open file/folder as git repository in a browser
      browse = "<Leader>go",
    },
  },
}

return {
  -- Add Solarized Osaka colorscheme
  { "craftzdog/solarized-osaka.nvim" },

  -- Configure LazyVim to load Solarized Osaka
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "solarized-osaka",
      transparent = true,
    },
  },
}

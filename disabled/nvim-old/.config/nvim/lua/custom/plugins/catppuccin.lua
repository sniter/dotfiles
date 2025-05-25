return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  init = function()
    require("catppuccin").setup{
      flavour = "frappe",
      transparent_background = true,
    }
    vim.cmd.colorscheme 'catppuccin-frappe'
  end,
}

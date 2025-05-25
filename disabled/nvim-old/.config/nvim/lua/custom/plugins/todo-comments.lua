return {
  'folke/todo-comments.nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = { signs = false },
  init = function()
    vim.keymap.set('n', '<space>ct', '<cmd>TodoQuickFix<CR>', { desc = '[C]ode [T]odos' })
  end,
}

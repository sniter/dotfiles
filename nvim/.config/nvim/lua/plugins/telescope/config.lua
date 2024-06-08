local setup = function()
  local actions = require("telescope.actions")
  require("telescope").setup({
    defaults = {
      file_ignore_patterns =  { "target", "node_modules", "out"  },
      prompt_prefix = ">",  
      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
      mappings = {
          i = {
            ["<C-u>"] = false,
            ["<C-d>"] = false,
          },
          n = {
            ["f"] = actions.send_to_qflist,
          }
      },
    },
    -- Enable to search hidden files
    -- pickers = {
    --     find_files = {
    --         hidden = true
    --     }
    -- },
  })

  -- Enable telescope fzf native, if installed
  -- pcall(require("telescope").load_extension, "fzf")
  require("telescope").load_extension("fzy_native")

  local builtin = require('telescope.builtin')
  vim.keymap.set('n', '<leader>tf', builtin.find_files, {})
  vim.keymap.set('n', '<leader>tg', builtin.live_grep, {})
  vim.keymap.set('n', '<leader>tc', builtin.git_commits, {})
  vim.keymap.set('n', '<leader>tS', builtin.git_stash, {})
  vim.keymap.set('n', '<leader>ts', builtin.git_status, {})
  vim.keymap.set('n', '<leader>tb', builtin.buffers, {})
  vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
end

return {
  setup = setup
}

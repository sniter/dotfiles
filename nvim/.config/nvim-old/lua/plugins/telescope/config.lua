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
  pcall(require("telescope").load_extension, "fzf")
  pcall(require('telescope').load_extension, 'ui-select')

  local builtin = require('telescope.builtin')
  vim.keymap.set('n', '<leader>sb', builtin.git_branches, { desc = '[S]earch [B]ranches' })
  vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
  vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
  vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
  vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
  vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
  vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
  vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
  vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
  vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
  vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
end

return {
  setup = setup
}

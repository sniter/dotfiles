-- Telescope fuzzy finding (all the things)
return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = vim.fn.executable("make") == 1 },
		},
		config = function()
			require("telescope").setup({
				defaults = {
					mappings = {
						i = {
							["<C-u>"] = false,
							["<C-d>"] = false,
						},
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
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>tf', builtin.find_files, {})
            vim.keymap.set('n', '<leader>tg', builtin.live_grep, {})
            vim.keymap.set('n', '<leader>tgc', builtin.git_commits, {})
            vim.keymap.set('n', '<leader>tgS', builtin.git_stash, {})
            vim.keymap.set('n', '<leader>tgs', builtin.git_status, {})
            vim.keymap.set('n', '<leader>tb', builtin.buffers, {})
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
		end,
	},
}
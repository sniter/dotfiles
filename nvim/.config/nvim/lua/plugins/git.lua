return {
    {
        "tpope/vim-fugitive",
        cmd = {
            "Git",
            "Gread",
        },
        keys = {
            {
                "<leader>ga",
                "<cmd>Git add %<cr>",
                desc = "git add All",
            },
            {
                "<leader>gs",
                "<cmd>vertical Git<cr>",
                desc = "git status",
            },
            {
                "<leader>gl",
                "<cmd>0GlLog!<cr>",
                desc = "git log for buffer",
            },
            {
                "<leader>gb",
                "<cmd>Git blame<cr>",
                desc = "git log for buffer",
            },
            {
                "<leader>gc",
                "<cmd>Git commit -v -q %:p<cr>",
                desc = "git commit",
            },
            {
                "<leader>gB",
                "<cmd>Git branch -c %:p<cr>",
                desc = "git create new branch",
            },
            {
                "<leader>gp",
                "<cmd>Git push<cr>",
                desc = "git push",
            }
        },
    },
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            signs                        = {
                add          = { text = '│' },
                change       = { text = '│' },
                delete       = { text = '_' },
                topdelete    = { text = '‾' },
                changedelete = { text = '~' },
                untracked    = { text = '┆' },
            },
            signcolumn                   = true, -- Toggle with `:Gitsigns toggle_signs`
            numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
            linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
            word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
            watch_gitdir                 = {
                follow_files = true
            },
            auto_attach                  = true,
            attach_to_untracked          = false,
            current_line_blame           = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
            current_line_blame_opts      = {
                virt_text = true,
                virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
                delay = 1000,
                ignore_whitespace = false,
                virt_text_priority = 100,
            },
            current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
            sign_priority                = 6,
            update_debounce              = 100,
            status_formatter             = nil, -- Use default
            max_file_length              = 40000, -- Disable if file is longer than this (in lines)
            preview_config               = {
                -- Options passed to nvim_open_win
                border = 'single',
                style = 'minimal',
                relative = 'cursor',
                row = 0,
                col = 1
            },
            yadm                         = {
                enable = false
            },
        },
        event = "VeryLazy",
        config = function(plugin, opts)
            require("gitsigns").setup(opts)
        end
    },
}

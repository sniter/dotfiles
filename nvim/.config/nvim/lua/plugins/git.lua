return {
    {
        "tpope/vim-fugitive",
        cmd = {
            "Git",
            "Gread",
        },
        keys = {
            {
                "<leader>gg",
                "<cmd>vertical Git<cr>",
                desc = "git status",
            },
            {
                "<leader>gb",
                "<cmd>0GlLog!<cr>",
                desc = "git log for buffer",
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
        event = "BufReadPre",
    },
}

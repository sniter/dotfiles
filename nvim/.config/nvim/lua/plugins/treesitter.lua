return {
    {
        "nvim-treesitter/nvim-treesitter",
        version = false,
        build = ":TSUpdate",
        event = "BufReadPost",
        opts = {
            highlight = {
                enable = true,
                -- disable = {"vue"},
            },
            indent = {
                enable = true,
                -- disable = {"vue"},
            },
            context_commentstring = { enable = true, enable_autocmd = false },
            ensure_installed = {
                "bash",
                "diff",
                "gitignore",
                "haskell",
                "haskell_persistent",
                "hocon",
                "ini",
                "json",
                "jq",
                "lua",
                "markdown",
                "markdown_inline",
                "ocaml",
                "ocaml_interface",
                "properties",
                "query",
                "regex",
                "rust",
                "scala",
                "sql",
                "tmux",
                "toml",
                "vim",
                "yaml",
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = "<nop>",
                    node_decremental = "<bs>",
                },
            },
        },
        config = function(plugin, opts)
            require("nvim-treesitter.configs").setup(opts)
        end
    }
}

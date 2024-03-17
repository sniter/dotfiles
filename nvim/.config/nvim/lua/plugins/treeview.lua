return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        },
        opts = {
            sources = {
                "filesystem",
                "buffers",
                "git_status",
                -- "document_symbols",
            },
            close_if_last_window = true,
            default_component_configs = {
                git_status = {
                    symbols = {
                        -- Change type
                        added     = "✚",
                        deleted   = "✖",
                        modified  = "",
                        renamed   = "󰁕",
                        -- Status type
                        untracked = "",
                        ignored   = "",
                        unstaged  = "󰄱",
                        staged    = "",
                        conflict  = "",
                    }
                }
            },
            window = {
                mappings = {
                    ["<F5>"] = "refresh"
                }
            },
            filesystem = {
                filtered_items = {
                    hide_dotfiles = true,
                    hide_gitignored = true,
                    hide_by_name = {
                        ".DS_Store",
                        "thumbs.db",
                        --"node_modules",
                    },
                    hide_by_pattern = {
                        --"*.meta",
                        --"*/src/*/tsconfig.json",
                    },
                    always_show = { -- remains visible even if other settings would normally hide it
                        --".gitignored",
                    },
                    never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
                        --".DS_Store",
                        --"thumbs.db",
                    },
                    never_show_by_pattern = { -- uses glob style patterns
                        --".null-ls_*",
                    },

                },
                group_empty_dirs = true,
                follow_current_file = {
                    enabled = true,
                    leave_dirs_open = true,
                },
            }
        },
        config = function(plugin, opts)
            require("neo-tree").setup(opts)
        end
    }
}

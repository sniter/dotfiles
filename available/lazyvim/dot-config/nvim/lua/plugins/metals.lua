return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        metals = {
          keys = {
            {
              "<leader>me",
              function()
                -- require("telescope").extensions.metals.commands()
                local commands = require("metals.commands").commands_table
                local opts = {
                  prompt = 'Metals:',
                  format_item = function(item)
                      return item.label
                  end,
                }
                local picker = function(choice)
                  pcall(require("metals")[choice.id])
                end

                vim.ui.select(commands, opts, picker)
              end,
              desc = "Metals commands",
            },
            {
              "<leader>mi",
              function()
                require("metals").import_build()
              end,
              desc = "Metals import build",
            },
            {
              "<leader>mt",
              function()
                require("metals.tvp").toggle_tree_view()
              end,
              desc = "Metals toggle tree view",
            },
            {
              "<leader>mr",
              function()
                require("metals.tvp").reveal_in_tree()
              end,
              desc = "Metals reveal in tree",
            },
          },
          settings = {
            testUserInterface = "Test Explorer",
          },
          tvp = {
            panel_alignment = "right",
            icons = {
              enabled = true,
              symbols = {
                project = "",
                package = "",
                target = "󰩷",
                ["symbol-field"] = "",
                ["symbol-folder"] = "󰉋",
                ["symbol-object"] = "",
                ["symbol-trait"] = "󰆼",
                ["symbol-class"] = "󰆧",
                ["symbol-interface"] = "",
                ["symbol-val"] = "󰏿",
                ["symbol-var"] = "󰀫",
                ["symbol-method"] = "󰊕",
                ["symbol-enum"] = "",
              },
            },
          }
        },
      },
    },
  },
}

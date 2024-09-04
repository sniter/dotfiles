local setup = function()
  local metals_config = require("metals").bare_config()

  -- Example of settings
  metals_config.settings = {
    showImplicitArguments = true,
    excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
  }

  -- *READ THIS*
  -- I *highly* recommend setting statusBarProvider to either "off" or "on"
  --
  -- "off" will enable LSP progress notifications by Metals and you'll need
  -- to ensure you have a plugin like fidget.nvim installed to handle them.
  --
  -- "on" will enable the custom Metals status extension and you *have* to have
  -- a have settings to capture this in your statusline or else you'll not see
  -- any messages from metals. There is more info in the help docs about this
  metals_config.init_options.statusBarProvider = "off"

  -- Example if you are using cmp how to make sure the correct capabilities for snippets are set
  metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

  metals_config.tvp = {
    panel_width = 40,
    panel_alignment = "right",
    toggle_node_mapping = "<CR>",
    node_command_mapping = "r",
    collapsed_sign = "▸",
    expanded_sign = "▾",
    icons = {
      enabled = true,
      symbols = {
        object = "",
        trait = "",
        class = "ﭰ",
        interface = "",
        val = "",
        var = "",
        method = "ﬦ",
        enum = "",
        field = "",
        package = "",
      },
    },
  }
  metals_config.on_attach = function(client, bufnr)
    require("metals").setup_dap()

    -- LSP mappings
    vim.keymap.set("n", "gD", vim.lsp.buf.definition)
    vim.keymap.set("n", "K", vim.lsp.buf.hover)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
    vim.keymap.set("n", "gr", vim.lsp.buf.references)
    vim.keymap.set("n", "gds", vim.lsp.buf.document_symbol)
    vim.keymap.set("n", "gws", vim.lsp.buf.workspace_symbol)
    vim.keymap.set("n", "<leader>mr", vim.lsp.codelens.run)
    vim.keymap.set("n", "<leader>sh", vim.lsp.buf.signature_help)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
    vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)

    vim.keymap.set("n", "<leader>mtr", function() 
      require("metals").reveal_in_tree()
    end)

    vim.keymap.set("n", "<leader>mtw", function() 
      require("metals.tvp").toggle_tree_view()
    end)

    vim.keymap.set("n", "<leader>ws", function()
      require("metals.tvp").hover_worksheet()
    end)

    -- all workspace diagnostics
    vim.keymap.set("n", "<leader>aa", vim.diagnostic.setqflist)

    -- all workspace errors
    vim.keymap.set("n", "<leader>ae", function()
      vim.diagnostic.setqflist({ severity = "E" })
    end)

    -- all workspace warnings
    vim.keymap.set("n", "<leader>aw", function()
      vim.diagnostic.setqflist({ severity = "W" })
    end)

    -- buffer diagnostics only
    vim.keymap.set("n", "<leader>d", vim.diagnostic.setloclist)

    vim.keymap.set("n", "[c", function()
      vim.diagnostic.goto_prev({ wrap = false })
    end)

    vim.keymap.set("n", "]c", function()
      vim.diagnostic.goto_next({ wrap = false })
    end)

    -- Example mappings for usage with nvim-dap. If you don't use that, you can
    -- skip these
    vim.keymap.set("n", "<leader>dc", function()
      require("dap").continue()
    end)

    vim.keymap.set("n", "<leader>drt", function()
      require("dap").repl.toggle()
    end)

    vim.keymap.set("n", "<leader>dK", function()
      require("dap.ui.widgets").hover()
    end)

    vim.keymap.set("n", "<leader>db", function()
      require("dap").toggle_breakpoint()
    end)

    vim.keymap.set({'n', 'v'}, '<leader>dp', function()
      require('dap.ui.widgets').preview()
    end)

    vim.keymap.set('n', '<leader>df', function()
      local widgets = require('dap.ui.widgets')
      widgets.centered_float(widgets.frames)
    end)

    vim.keymap.set('n', '<leader>dsc', function()
      local widgets = require('dap.ui.widgets')
      widgets.centered_float(widgets.scopes)
    end)

    vim.keymap.set("n", "<leader>dso", function()
      require("dap").step_over()
    end)

    vim.keymap.set("n", "<leader>dsi", function()
      require("dap").step_into()
    end)

    vim.keymap.set("n", "<leader>dl", function()
      require("dap").run_last()
    end)

    -- Telescope
    vim.keymap.set("n", "<leader>tmc", require("telescope").extensions.metals.commands)
    vim.keymap.set("n", "<leader>tms", require("telescope.builtin").lsp_document_symbols)
    vim.keymap.set("n", "<leader>tmw", require("telescope.builtin").lsp_dynamic_workspace_symbols)

    local wk = require("which-key")
    wk.register({
      ["<leader>d"] = {
        name = "Dap",
        b = { "Toggle breakpoint" },
        c = { "Continue" },
        so = {"Step over"},
        si = {"Step into"},
        rt = {"Toggle output"},
        f = {"Show frames"},
        sc = {"Show scope"},
        l = {"Last run"}
      },
      ["<leader>t"] = {
        mc = { "Metals commands" },
        ms = { "Document symbold" },
        mw = { "Workspace symbols" },
      },
    })
  end

  return metals_config
end

return {
  setup = setup
}
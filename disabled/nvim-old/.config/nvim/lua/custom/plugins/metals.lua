local map = vim.keymap.set
return {
  'scalameta/nvim-metals',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'j-hui/fidget.nvim',
      opts = {},
    },
    {
      'mfussenegger/nvim-dap',
      config = function(self, opts)
        -- Debug settings if you're using nvim-dap
        local dap = require 'dap'

        dap.configurations.scala = {
          {
            type = 'scala',
            request = 'launch',
            name = 'RunOrTest',
            metals = {
              runType = 'runOrTestFile',
              --args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
            },
          },
          {
            type = 'scala',
            request = 'launch',
            name = 'Test Target',
            metals = {
              runType = 'testTarget',
            },
          },
        }
      end,
    },
  },
  ft = { 'scala', 'sbt', 'java' },
  opts = function()
    local metals_config = require('metals').bare_config()

    -- Example of settings
    metals_config.settings = {
      showImplicitArguments = true,
      showInferredType = true,
      showImplicitConversionsAndClasses = true,
      verboseCompilation = true,
      excludedPackages = { 'akka.actor.typed.javadsl', 'com.github.swagger.akka.javadsl' },
      -- serverVersion = '1.3.5',
      -- bloopVersion = '2.0.0',
      testUserInterface = 'Test Explorer',
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
    metals_config.init_options.statusBarProvider = 'off'

    -- Example if you are using cmp how to make sure the correct capabilities for snippets are set
    metals_config.capabilities = require('cmp_nvim_lsp').default_capabilities()

    metals_config.on_attach = function(client, bufnr)
      require('metals').setup_dap()

      -- LSP mappings
      map('n', 'gD', vim.lsp.buf.definition)
      map('n', 'K', vim.lsp.buf.hover)
      map('n', 'gi', vim.lsp.buf.implementation)
      map('n', 'gr', vim.lsp.buf.references)
      map('n', 'gds', vim.lsp.buf.document_symbol)
      map('n', 'gws', vim.lsp.buf.workspace_symbol)
      map('n', '<leader>cl', vim.lsp.codelens.run)
      map('n', '<leader>sh', vim.lsp.buf.signature_help)
      map('n', '<leader>rn', vim.lsp.buf.rename)
      map('n', '<leader>f', vim.lsp.buf.format)
      map('n', '<leader>ca', vim.lsp.buf.code_action)

      map('n', '<leader>mc', function()
        require('telescope').extensions.metals.commands()
      end, { desc = '[M]etals [C]ommands' })

      map('n', '<leader>mwh', function()
        require('metals').hover_worksheet()
      end, { desc = '[M]etals open [W]orksheet' })

      -- all workspace diagnostics
      map('n', '<leader>mla', vim.diagnostic.setqflist, { desc = 'show [A]ll messages' })

      -- all workspace errors
      map('n', '<leader>mle', function()
        vim.diagnostic.setqflist { severity = 'E' }
      end, { desc = 'show [E]rrors' })

      -- all workspace warnings
      map('n', '<leader>mlw', function()
        vim.diagnostic.setqflist { severity = 'W' }
      end, { desc = 'show [W]arnings' })

      map('n', '[c', function()
        vim.diagnostic.goto_prev { wrap = false }
      end)

      map('n', ']c', function()
        vim.diagnostic.goto_next { wrap = false }
      end)

      -- Example mappings for usage with nvim-dap. If you don't use that, you can
      -- skip these

      require('dap').listeners.after['event_terminated']['nvim-metals'] = function()
        vim.notify 'dap finished!'
        --dap.repl.open()
      end

      -- REPL

      -- map('n', '<leader>dR', function()
      --   require('dap').repl.open()
      -- end, { desc = '[D]ap REPL open' })

      map('n', '<leader>dr', function()
        require('dap').repl.toggle()
      end, { desc = '[D]ap REPL toggle' })

      -- Breakpoints

      map('n', '<leader>db', function()
        require('dap').toggle_breakpoint()
      end, { desc = '[D]ap toggle [B]reakpoint' })

      map('n', '<leader>dB', function()
        require('dap').clear_breakpoints()
      end, { desc = '[D]ap clear all [B]reakpoints' })

      -- Debug control
      map('n', '<leader>dc', function()
        require('dap').continue()
      end, { desc = '[D]ap [C]ontinue' })

      map('n', '<leader>dv', function()
        require('dap').step_over()
      end, { desc = '[D]ap step o[V]er' })

      map('n', '<leader>di', function()
        require('dap').step_into()
      end, { desc = '[D]ap step [I]nto' })

      map('n', '<leader>du', function()
        require('dap').step_out()
      end, { desc = '[D]ap step [O]ut' })

      map('n', '<leader>dl', function()
        require('dap').run_last()
      end, { desc = '[D]ap [L]ast run' })

      -- DAP UI
      map('n', '<leader>dp', function()
        require('dap.ui.widgets').hover()
      end, { desc = '[D]ap short [P]review' })

      map({ 'n', 'v' }, '<Leader>dP', function()
        require('dap.ui.widgets').preview()
      end, { desc = '[D]ap [P]review in buffer' })

      map({ 'n' }, '<Leader>dLb', function()
        require('dap').list_breakpoints()
      end, { desc = '[D]ap [L]ist [B]reakpoints' })

      map('n', '<Leader>df', function()
        local widgets = require 'dap.ui.widgets'
        widgets.centered_float(widgets.frames)
      end, { desc = '[D]ap [F]rames' })

      map('n', '<Leader>dt', function()
        local widgets = require 'dap.ui.widgets'
        widgets.centered_float(widgets.threads)
      end, { desc = '[D]ap [T]hreads' })

      map('n', '<Leader>dv', function()
        local widgets = require 'dap.ui.widgets'
        widgets.centered_float(widgets.scopes)
      end, { desc = '[D]ap [V]ariables' })

      map('n', '<Leader>ds', function()
        local widgets = require 'dap.ui.widgets'
        widgets.centered_float(widgets.sessions)
      end, { desc = '[D]ap [S]essions' })

      map('n', '<Leader>de', function()
        local widgets = require 'dap.ui.widgets'
        widgets.centered_float(widgets.expression)
      end, { desc = '[D]ap [E]xpressions' })
    end

    return metals_config
  end,
  config = function(self, metals_config)
    local nvim_metals_group = vim.api.nvim_create_augroup('nvim-metals', { clear = true })
    vim.api.nvim_create_autocmd('FileType', {
      pattern = self.ft,
      callback = function()
        require('metals').initialize_or_attach(metals_config)
      end,
      group = nvim_metals_group,
    })
  end,
}

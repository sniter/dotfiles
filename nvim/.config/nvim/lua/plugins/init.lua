local api = vim.api
local cmd = vim.cmd

return require("lazy").setup({
  { 
    "catppuccin/nvim", 
    name = "catppuccin", 
    priority = 1000,
    config = function(self, opts)
      cmd.colorscheme "catppuccin-mocha"
    end
  },
  {"folke/neodev.nvim", lazy = true}, 
  "folke/which-key.nvim",
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-vsnip" },
      { "hrsh7th/vim-vsnip" },
      { "hrsh7th/cmp-nvim-lsp-signature-help" },
    },
    config = function()
      require("plugins.cmp.config").setup()
    end
  },
  {
    "neovim/nvim-lspconfig"
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { 
      { "nvim-lua/popup.nvim" },
      { "folke/which-key.nvim" },
      { "nvim-lua/plenary.nvim" },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
    config = function()
      require("plugins.telescope.config").setup()
    end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("plugins.treesitter.config").setup()
    end
  },
  require 'plugins.neo_tree',
  -- {
  --   "nvim-neo-tree/neo-tree.nvim",
  --   branch = "v3.x",
  --   dependencies = {
  --       "nvim-lua/plenary.nvim",
  --       "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
  --       "MunifTanjim/nui.nvim",
  --       -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  --   },
  --   keys = {
  --     { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  --   },
  --   opts = {
  --     default_component_configs = {
  --       git_status = {
  --           symbols = {
  --               -- Change type
  --               added     = "✚",
  --               deleted   = "✖",
  --               modified  = "",
  --               renamed   = "󰁕",
  --               -- Status type
  --               untracked = "",
  --               ignored   = "",
  --               unstaged  = "󰄱",
  --               staged    = "",
  --               conflict  = "",
  --           }
  --         }
  --     },
  --     filesystem = {
  --       window = {
  --         mappings = {
  --           ['\\'] = 'close_window',
  --         },
  --       },
  --     },
  --   },
  --   -- config = function(plugin, opts)
  --   --   require("plugins.neo_tree.config").setup()
  --   -- end,
  -- },
  {
    "scalameta/nvim-metals",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "j-hui/fidget.nvim",
        opts = {},
      },
      {
        "mfussenegger/nvim-dap",
        config = function()
          require("plugins.metals.dap").setup()
        end
      }
    },
    ft = { "scala", "sbt", "java" },
    opts = function()
      return require("plugins.metals.opts").setup()
    end,
    config = function(self, metals_config)
      local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = self.ft,
        callback = function()
          require("metals").initialize_or_attach(metals_config)
        end,
        group = nvim_metals_group,
      })
    end
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require("plugins.lualine.config").setup()
    end
  },
  -- GIT Related
  require 'plugins.git.gitsigns',
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "Gread" },
    keys = function()
      return require("plugins.git.fugitive").keys
    end
  },
  -- {
  --   "lewis6991/gitsigns.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     require("plugins.git.gitsigns").setup()
  --   end
  -- },
  -- Rust
  -- {
  --   'mrcjkb/rustaceanvim',
  --   version = '^5', -- Recommended
  --   lazy = false, -- This plugin is already lazy
  -- },
})

local api = vim.api
local cmd = vim.cmd

return require("lazy").setup({
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
      { 
        "folke/which-key.nvim", 
        config = function() 
          require("plugins.telescope.which_key").setup()
        end
      },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-fzy-native.nvim" },
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
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function(plugin, opts)
      require("plugins.neo_tree.config").setup()
    end,
  },
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
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "Gread" },
    keys = function()
      return require("plugins.git.fugitive").keys
    end
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    config = function()
      require("plugins.git.gitsigns").setup()
    end
  }
})

local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    --dependencies = {
    --  -- format & linting
    --  {
    --    "jose-elias-alvarez/null-ls.nvim",
    --    config = function()
    --      require "custom.configs.null-ls"
    --    end,
    --  },
    --},
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },
  {
    "liuchengxu/vista.vim",
    lazy = false
  },
  {
    "sindrets/diffview.nvim",
    lazy = false
  },
  {
    "ahmedkhalf/project.nvim",
    lazy = false,
    config = function()
      local opts = {
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {
          enable = true,
          update_root = true
        },
      };
      require("project_nvim").setup { opts }
    end
  },

  -- FZF

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      highlight = {
        enable = true,
        disable = function(_, bufnr) -- Disable in large buffers
          return vim.api.nvim_buf_line_count(bufnr) > 4000
        end,
      },
      ensure_installed = {
        "bash",
        "bibtex",
        "c",
        "cmake",
        "comment",
        "cpp",
        "diff", -- git
        "dot",
        "doxygen",
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "json",
        "kconfig",
        "latex",
        "llvm", -- BRAINLET MOMENT
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "meson",
        "ninja",
        "proto", -- protocol buffers (google)
        "python",
        "regex",
        "rust",
        "rust",
        "verilog",
        "vim",
        "vimdoc",
        "yaml",
      },
    }
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "jbyuki/venn.nvim",
    keys = { " v", "n" },
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    'chomosuke/typst-preview.nvim',
    lazy = false, -- or ft = 'typst'
    version = '0.3.*',
    build = function() require 'typst-preview'.update() end,
  },

  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
}

return plugins

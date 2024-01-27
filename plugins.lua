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
      require("project_nvim").setup{opts}
    end
  },

  -- FZF

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
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
    },
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
    lazy = false,
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

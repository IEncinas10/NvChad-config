---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  theme = "vscode_dark",
  theme_toggle = { "ayu_dark", "ayu_dark" },

  -- vscode_dark, ayu_dark, yoru, radium

  hl_override = highlights.override,
  hl_add = highlights.add,
  tabufline = {
    show_numbers = true,
  },
  statusline = {
    theme = "vscode_colored",
    separator_style = "default",
    overriden_modules = function(modules)
          -- adding a module between 2 modules
          -- Use the table.insert functin to insert at specific index
          -- This will insert a new module at index 2 and previous index 2 will become 3 now

          table.insert(
            modules,
            6,
            (function()
              local cwd = vim.fn.getcwd()
              local curr_buff_path = vim.api.nvim_buf_get_name(0)

              -- avoid cluttering everything, best hack till now
              if(vim.api.nvim_win_get_width(0) < 120) then
                return ""
              end

              -- Handle unnamed buffer
              if(curr_buff_path == "") then
                curr_buff_path = cwd
              end
              -- Check if the file is nested inside the current working directory
              local clean_curr_buff_path = curr_buff_path:gsub(vim.fn.getcwd(), ".")
              if(string.find(curr_buff_path, cwd) == nil) then
                clean_curr_buff_path = "%#St_lspWarning# " .. clean_curr_buff_path
              end

              -- Control huge paths that clutter the UI
              local length = string.len(clean_curr_buff_path)
              if(length > 140) then
                return ""
              end

              return "%#St_lspInfo#" .. clean_curr_buff_path
            end)()
          )
        end,

  }
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"


-- Disable logging. Enable when need for debug
vim.lsp.set_log_level("off")
-- vim.lsp.set_log_level("debug")

-- Relative numbers by default
vim.cmd('set relativenumber')

-------------------------------------
----------- Ascii art ---------------
  -- venn.nvim: enable or disable keymappings
function _G.Toggle_venn()
    local venn_enabled = vim.inspect(vim.b.venn_enabled)
    if venn_enabled == "nil" then
        vim.b.venn_enabled = true
        vim.cmd[[setlocal ve=all]]
        -- draw a line on HJKL keystokes
        vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", {noremap = true})
        -- draw a box by pressing "f" with visual selection
        vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", {noremap = true})
    else
        vim.cmd[[setlocal ve=]]
        vim.cmd[[mapclear <buffer>]]
        vim.b.venn_enabled = nil
    end
end

vim.api.nvim_set_keymap('n', '<leader>v', ":lua Toggle_venn()<CR>", { noremap = true})
----------- Ascii art ---------------
-------------------------------------

-- disable #ifdef ... graying out
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    client.server_capabilities.semanticTokensProvider = nil
  end,
})

-- INLAY HINTS begin
-- https://vinnymeller.com/posts/neovim_nightly_inlay_hints/
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        -- Check that inlay_hint exists. Will be available in nvim-10
        if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            vim.lsp.inlay_hint.enable(args.buf, true)
        end
    end
})

vim.api.nvim_set_keymap('n', '<A-i>', ":lua if vim.lsp.inlay_hint then vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled()) end<CR>", { noremap = true})
-- INLAY HINTS end

return M

-- Function that toggles (enables/disables) diagnostics inside a buffer
function _G.toggle_diagnostics()
  -- _G part is important
  ---A global variable (not a function) that holds the global environment (see [§2.2](http://www.lua.org/manual/5.4/manual.html#2.2)). Lua itself does not use this variable; changing its value does not affect any environment, nor vice versa.
  ---
  ---[View documents](http://www.lua.org/manual/5.4/manual.html#pdf-_G)
  ---
  ---@class _G
  --_G = {}

  if vim.diagnostic.is_disabled() then
    vim.diagnostic.enable()
  else
    vim.diagnostic.disable()
  end
end

---@type MappingsTable
local M = {}

M.disabled = {
  n = {
    --["<leader>t"] = ""
    -- nvterm: just use alt (toggle)
    -- ["<A-h>"] = "",
    ["<A-i>"] = "",
    -- ["<A-v>"] = "",
    ["<leader>v"] = "",
    ["<leader>h"] = "",
    -- NvimTree
    ["<C-n>"] = "",
    ["<A-t>"] = "",
    -- Diagnostics
    ["<leader>q"] = "",
    ["<tab>"] = "",
    -- navigation
    ["<leader>gb"] = "",
    ["<leader>gn"] = "",
    --["gi"] = "",
    -- LaTeX
    ["<leader>i"] = "",
    ["<leader>s"] = "",
  }
}


M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<A-t>"] = { ":lua toggle_diagnostics()<CR>", "Toggle diagnostics", opts = { nowait = true } },
    -- filesystem
    ["<F2>"] = { ":NvimTreeToggle<CR>", "NvimTreeToggle", opts = { nowait = true } },
    -- buffers
    ["<leader>l"] = { ":bnext<CR>", "Buffer next", opts = { nowait = true } },
    ["<leader>h"] = { ":bprev<CR>", "Buffer prev", opts = { nowait = true } },
    ["<leader>d"] = { ":lua vim.diagnostic.setloclist()<CR>", "List diagnostics", opts = { nowait = true } },
    ["<leader><leader>"] = { "<C-^>", "Go previous", opts = { nowait = true } },
    -- FZF
    ["<leader>;"] = { ":Telescope buffers<CR>", "Telescope buffers", opts = { nowait = true } },
    -- navigation
    ["<leader>gb"] = { "<C-O>", "Navigation: Go back", opts = { nowait = true } },
    ["<leader>gn"] = { "<C-I>", "Navigation: Go next", opts = { nowait = true } },
    ["<tab>"] = { ":Vista!!<CR>", "LSP symbol viewer", opts = { nowait = true } },
    -- Sorry lord
    ["<leader>1"] = { ":lua vim.api.nvim_set_current_buf(vim.t.bufs[1])<CR>", "Change to buffer 1", opts = {
      nowait = true } },
    ["<leader>2"] = { ":lua vim.api.nvim_set_current_buf(vim.t.bufs[2])<CR>", "Change to buffer 2", opts = {
      nowait = true } },
    ["<leader>3"] = { ":lua vim.api.nvim_set_current_buf(vim.t.bufs[3])<CR>", "Change to buffer 3", opts = {
      nowait = true } },
    ["<leader>4"] = { ":lua vim.api.nvim_set_current_buf(vim.t.bufs[4])<CR>", "Change to buffer 4", opts = {
      nowait = true } },
    ["<leader>5"] = { ":lua vim.api.nvim_set_current_buf(vim.t.bufs[5])<CR>", "Change to buffer 5", opts = {
      nowait = true } },
    ["<leader>6"] = { ":lua vim.api.nvim_set_current_buf(vim.t.bufs[6])<CR>", "Change to buffer 6", opts = {
      nowait = true } },
    ["<leader>7"] = { ":lua vim.api.nvim_set_current_buf(vim.t.bufs[7])<CR>", "Change to buffer 7", opts = {
      nowait = true } },
    ["<leader>8"] = { ":lua vim.api.nvim_set_current_buf(vim.t.bufs[8])<CR>", "Change to buffer 8", opts = {
      nowait = true } },
    ["<leader>9"] = { ":lua vim.api.nvim_set_current_buf(vim.t.bufs[9])<CR>", "Change to buffer 9", opts = {
      nowait = true } },
    ["<leader>0"] = { ":lua vim.api.nvim_set_current_buf(vim.t.bufs[10])<CR>", "Change to buffer 10", opts = {
      nowait = true } },
    --"latex ernesto
    ["<leader>i"] = {
      ":<cmd>r!RAND=$(openssl rand -hex 8); IMAGEPATH=~/Pictures/capturaslatex/$RAND.png; spectacle -b -r -n -e -o $IMAGEPATH 2>/dev/null && latexScrot $IMAGEPATH<CR>",
      "Add screenshot (shared storage)", opts = { nowait = true } },
    ["<leader>s"] = {
      "<cmd>r!RAND=$(openssl rand -hex 8); IMAGEPATH=images/$RAND.png; spectacle -b -r -n -e -o %:p:h/$IMAGEPATH 2>/dev/null && latexScrot $IMAGEPATH<CR> ",
      "Add screenshot (project storage)", opts = { nowait = true } },
    ["<A-l>"] = { ":lua vim.lsp.set_log_level('debug')<CR>", "LSP log debug", opts = { nowait = true } },
    ["<A-m>"] = { ":lua vim.lsp.set_log_level('off')<CR>", "LSP log off", opts = { nowait = true } },
    ["<C-t>"] = { ":TodoTelescope<CR>", "todo-comment telescope menu" },
    ["<leader>vm"] = { ":marks<CR>", "Open marks" },
  },
}

M.gitsigns = {
  n = {

    -- Actions
    -- map('n', '<leader>hs', gs.stage_hunk)
    -- map('n', '<leader>hr', gs.reset_hunk)
    -- map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
    -- map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
    -- map('n', '<leader>hS', gs.stage_buffer)
    -- map('n', '<leader>hu', gs.undo_stage_hunk)
    -- map('n', '<leader>hR', gs.reset_buffer)
    -- map('n', '<leader>hp', gs.preview_hunk)
    -- map('n', '<leader>hb', function() gs.blame_line{full=true} end)
    -- map('n', '<leader>tb', gs.toggle_current_line_blame)
    -- map('n', '<leader>hd', gs.diffthis)
    -- map('n', '<leader>hD', function() gs.diffthis('~') end)
    -- map('n', '<leader>td', gs.toggle_deleted)
    ["<leader>gs"] = {
      function()
        require("gitsigns").stage_hunk()
      end,
      "Stage hunk",
    },
    ["<leader>gS"] = {
      function()
        require("gitsigns").stage_buffer()
      end,
      "Stage hunk",
    },
    ["<leader>gr"] = {
      function()
        require("gitsigns").reset_hunk()
      end,
      "Reset hunk",
    },
    ["<leader>gu"] = {
      function()
        require("gitsigns").undo_stage_hunk()
      end,
      "Reset hunk",
    },
    ["<leader>B"] = {
      function()
        return require("gitsigns").blame_line({ full = true })
      end,
      "Reset hunk",
    },
  },

  -- Visual mode mapping
  v = {
    ["<leader>gs"] = {
      function()
        return require("gitsigns").stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
      end,
      "Stage hunk",
    },
    ["<leader>gr"] = {
      function()
        return require("gitsigns").reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
      end,
      "Reset hunk",
    },
  },

}

--vim.lsp.set_log_level("off")
--vim.lsp.set_log_level("debug")

-- Doesnt work
-- for i = 1, 9, 1 do
--   vim.keymap.set("n", string.format("<leader>%s", i), function ()
--     vim.api.nvim_set_current_buf(vim.t.bufs[i])
--   end)
-- end

-- more keybinds!

-- luado vim.diagnostic.hide()
-- luado vim.diagnostic.hide()
--

return M

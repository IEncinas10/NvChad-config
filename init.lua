 local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
 autocmd("VimResized", {
   pattern = "*",
   command = "tabdo wincmd =",
 })

 -- Popup. Main example: autocomplete
 vim.o.pumheight = 8
 vim.o.pumblend = 20

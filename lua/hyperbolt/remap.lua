vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Standard Keybindings for Go to Definition & Implementation
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to Definition' })
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to Implementation' })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'Show References' })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation' })

-- A global shortcut (e.g., <leader>q) to close the quickfix from anywhere
vim.keymap.set("n", "<leader>q", "<cmd>cclose<cr>", { desc = "Close References Pane" })

-- Keep visual selection alive after indenting
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and keep selection" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and keep selection" })

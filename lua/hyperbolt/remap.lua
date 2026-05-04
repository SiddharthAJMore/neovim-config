vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)


vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- Move line down
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- Move line up


vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, {
  desc = "Show line diagnostic",
})

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

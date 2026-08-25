return {
    "tpope/vim-fugitive",
    config = function()
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
        vim.keymap.set("n", "<leader>gc", "<cmd>Git commit<cr>" ) 
        vim.keymap.set("n", "<leader>gp", "<cmd>Git push<cr>")
        vim.keymap.set("n", "<leader>gl", "<cmd>Git pull<cr>")
        vim.keymap.set("n", "<leader>gb", "<cmd>Git blame<cr>")
        vim.keymap.set("n", "<leader>gbb", ":Git branch<CR>")
        vim.keymap.set("n", "<leader>gd", "<cmd>Git diff<cr>")
        vim.keymap.set("n", "<leader>gf", ":Git fetch<cr>")
        vim.keymap.set("n", "<leader>gco", ":Git checkout<CR>")
    end
}

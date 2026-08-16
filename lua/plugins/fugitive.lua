return {
    "tpope/vim-fugitive",
    config = function()
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
        vim.keymap.set("n", "<leader>gc", vim.cmd.GitCommit)
        vim.keymap.set("n", "<leader>gp", vim.cmd.GitPush)
        vim.keymap.set("n", "<leader>gl", vim.cmd.GitPull)
        vim.keymap.set("n", "<leader>gb", vim.cmd.GitBlame)
        vim.keymap.set("n", "<leader>gd", vim.cmd.GitDiff)
        vim.keymap.set("n", "<leader>gco", vim.cmd.GitCheckout)
    end
}

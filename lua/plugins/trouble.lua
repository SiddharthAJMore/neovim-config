return {
    "folke/trouble.nvim",
    config = function()
        require("trouble").setup {
            icons = false,
        }

        vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>")
    end
}

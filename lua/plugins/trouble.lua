return {
    "folke/trouble.nvim",
    -- dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
        {
            "<leader>tt",
            "<cmd>Trouble diagnostics toggle<cr>",
            desc = "Diagnostics (Trouble)",
        },
        {
            "<leader>tw",
            "<cmd>Trouble workspace_diagnostics toggle<cr>",
            desc = "Workspace Diagnostics (Trouble)",
        },
        {
            "<leader>td",
            "<cmd>Trouble document_diagnostics toggle<cr>",
            desc = "Document Diagnostics (Trouble)",
        },
        {
            "<leader>tl",
            "<cmd>Trouble loclist toggle<cr>",
            desc = "Location List (Trouble)",
        },
        {
            "<leader>xQ",
            "<cmd>Trouble qflist toggle<cr>",
            desc = "Quickfix List (Trouble)",
        },
    },
}

return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "plenary"
    },
    config = function()
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find Files' })
        vim.keymap.set('n', '<leader>pws', function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end, { desc = 'Search Word Under Cursor' })

        vim.keymap.set('n', '<leader>pWs', function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end, { desc = 'Search Word Under Cursor' })


        vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Find Git Files' })
        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({search = vim.fn.input("Grep > ")})
        end, { desc = 'Live Grep' })
    end
}

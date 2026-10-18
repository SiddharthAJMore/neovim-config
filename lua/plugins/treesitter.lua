return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    branch = 'main',
    config = function()
        require('nvim-treesitter').setup()

        -- Your list of parsers
        local ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "javadoc", "python", "bash", "java", "go" }
        
        -- Automatically install any missing parsers from your list
        local already_installed = require('nvim-treesitter.config').get_installed()
        local parsers_to_install = vim.iter(ensure_installed)
            :filter(function(parser)
                return not vim.tbl_contains(already_installed, parser)
            end)
            :totable()

        if #parsers_to_install > 0 then
            require('nvim-treesitter').install(parsers_to_install)
        end

        -- Enable native Neovim highlighting and indentation features
        vim.api.nvim_create_autocmd('FileType', {
            callback = function()
                pcall(vim.treesitter.start)
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end,
}

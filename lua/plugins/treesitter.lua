return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    main = "nvim-treesitter.configs",
    branch = "master", 
    opts = {
        ensure_installed = { "c", "lua", "vim", "help", "javadoc", "python", "bash", "java", "go" },
        auto_install = true,
        highlight = { 
            enable = true,
            additional_vim_regex_highlighting = { "markdown" },
        },
        indent = { enable = true },
    },
    config = function(_, opts)
        local status_ok, configs = pcall(require, "nvim-treesitter.configs")
        if not status_ok then
            return
        end
        configs.setup(opts)
    end,
}

return {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip").filetype_extend("lua", { "luadoc" })
        require("luasnip").filetype_extend("python", { "pydoc" })

        require("luasnip").filetype_extend("java", { "javadoc" })
        require("luasnip").filetype_extend("c", { "cdoc" })
        require("luasnip").filetype_extend("sh", { "shelldoc" })

    end,
}

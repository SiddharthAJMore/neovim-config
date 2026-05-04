return {
  -- Core LSP config
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- LSP installer
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",

      -- Completion engine
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",

      -- Snippets
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },

    config = function()
      -------------------------------------------------
      -- LSP capabilities (for completion)
      -------------------------------------------------
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      -------------------------------------------------
      -- Mason setup
      -------------------------------------------------
      require("mason").setup()

      require("mason-lspconfig").setup({
        ensure_installed = {
          -- Add/remove as you like
          "lua_ls",
          "ts_ls",
          "pyright",
          "bashls",
          "jsonls",
          "yamlls",
        },
        automatic_installation = true,
      })

      -------------------------------------------------
      -- LSP servers
      -------------------------------------------------
      local lspconfig = require("lspconfig")

      -- Lua
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              checkThirdParty = false,
            },
            completion = {
              callSnippet = "Replace",
            },
          },
        },
      })

      -- TypeScript / JavaScript
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
      })

      -- Python
      lspconfig.pyright.setup({
        capabilities = capabilities,
      })

      -- Bash
      lspconfig.bashls.setup({
        capabilities = capabilities,
      })

      -- JSON
      lspconfig.jsonls.setup({
        capabilities = capabilities,
      })

      -- YAML
      lspconfig.yamlls.setup({
        capabilities = capabilities,
      })

      -------------------------------------------------
      -- Global LSP keymaps
      -------------------------------------------------
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
          local opts = { buffer = ev.buf, silent = true }

          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "<leader>ds", vim.lsp.buf.document_symbol, opts)
        end,
      })
    end,
  },

  -------------------------------------------------
  -- Autocompletion
  -------------------------------------------------
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      luasnip.config.setup({})

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
          { name = "buffer" },
        }),
      })
    end,
  },
}

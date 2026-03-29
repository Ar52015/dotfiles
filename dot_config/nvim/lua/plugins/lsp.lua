return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "basedpyright",
                "clangd",
                "vtsls",
                "jdtls",
                "bashls",
            },
        })

        local lspconfig = require("lspconfig")
        local servers = { "basedpyright", "clangd", "vtsls", "jdtls", "bashls" }

        for _, server in ipairs(servers) do
            lspconfig[server].setup({})
        end

        lspconfig.lua_ls.setup({
            settings = {
                Lua = {
                    runtime = { version = "LuaJIT" },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                    },
                },
            },
        })

        -- Keymaps
        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(event)
                local map = function(keys, func, desc)
                    vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
                end

                map("gd", vim.lsp.buf.definition, "Go to definition")
                map("gr", vim.lsp.buf.references, "Go to references")
                map("K", vim.lsp.buf.hover, "Hover documentation")
                map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
                map("<leader>ca", vim.lsp.buf.code_action, "Code action")
                map("<leader>D", vim.lsp.buf.type_definition, "Type definitions")
            end,
        })
    end,
}


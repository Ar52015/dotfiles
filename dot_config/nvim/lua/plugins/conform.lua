return {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    keys = {
        { "<leader>cf", function()
            require("conform").format({ async = true })
        end, desc = "Format buffer" },
    },
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            python = { "ruff_format" },
            bash = { "shfmt" },
            sh = { "shfmt" },
            c = { "clang-format" },
            cpp = { "clang-format" },
            javascript = { "prettier" },
            typescript = { "prettier" },
            java = { "google-java-format" },
            go = { "goimports", "gofumpt" },
            toml = { "taplo" },
            yaml = { "prettier" },
            json = { "prettier" },
            markdown = { "prettier" },
            qml = { "qmlformat" },
        },
        formatters = {
            -- qt6-declarative installs qmlformat outside PATH
            qmlformat = { command = "/usr/lib/qt6/bin/qmlformat" },
        },
        format_on_save = {
            timeout_ms = 500,
            lsp_format = "fallback",
        },
    },
}

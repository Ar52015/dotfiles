return {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
        ensure_installed = {
            "stylua",
            "prettier",
            "ruff",
            "shfmt",
            "clang-format",
            "taplo",
            "google-java-format",
        },
    },
}

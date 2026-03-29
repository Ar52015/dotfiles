return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter").install({
            "lua",
            "vim",
            "vimdoc",
            "bash",
            "python",
            "c",
            "cpp",
            "javascript",
            "typescript",
            "java",
            "toml",
            "yaml",
            "json",
            "markdown",
            "markdown_inline",
            "dockerfile",
        })
    end,
}

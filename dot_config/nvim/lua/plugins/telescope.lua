return {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
        },
        "nvim-telescope/telescope-ui-select.nvim",
    },

    config = function()
        require("telescope").setup({
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown(),
                },
            },
        })
        
        require("telescope").load_extension("fzf")
        require("telescope").load_extension("ui-select")
    
        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files"})
        vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Find by grep"})
        vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffer"})
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help"})
        vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Find diagnostics"})
        vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "Find resume"})
        vim.keymap.set("n", "<leader>f.", builtin.oldfiles, { desc = "Find recent files"})
    end,
}

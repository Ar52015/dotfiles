return {
    "RedsXDD/neopywal.nvim",
    name = "neopywal",
    lazy = false,
    priority = 1000,
    config = function()
        require("neopywal").setup({
            use_palette = "wallust",
        })
        vim.cmd.colorscheme("neopywal")

        local C = require("neopywal").get_colors()

        -- Strings get variable.member color (color2)
        vim.api.nvim_set_hl(0, "String", { fg = C.color2 })
        vim.api.nvim_set_hl(0, "@string", { fg = C.color2 })

        -- Swap variable and variable.member colors
        vim.api.nvim_set_hl(0, "Variable", { fg = C.string, italic = true })
        vim.api.nvim_set_hl(0, "@variable", { fg = C.string, italic = true })
        vim.api.nvim_set_hl(0, "@variable.member", { fg = C.variable, italic = true })

        -- Functions get blended bright pink
        local U = require("neopywal.utils.color")
        local fn_color = U.lighten(C.color1, 50)
        vim.api.nvim_set_hl(0, "Function", { fg = fn_color })
        vim.api.nvim_set_hl(0, "@function", { fg = fn_color })
        vim.api.nvim_set_hl(0, "@function.call", { fg = fn_color })
        vim.api.nvim_set_hl(0, "@function.builtin", { fg = fn_color })
        vim.api.nvim_set_hl(0, "@function.method.call", { fg = fn_color })

        -- Make property use variable colors
        vim.api.nvim_set_hl(0, "@property", { fg = C.string, italic = true })

    end,
}

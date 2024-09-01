---- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
--
---- optionally enable 24-bit colour
vim.opt.termguicolors = true
--
--
-- OR setup with some options
require("nvim-tree").setup({
    sort = {
        sorter = "case_sensitive",
    },
    view = {
        width = 40 },
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = false,
    },
    actions = {
        change_dir = {
            restrict_above_cwd = true,
        },
    }
})



local function open_nvim_tree()
    require("nvim-tree.api").tree.open()
end
---- alaways open the tree
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

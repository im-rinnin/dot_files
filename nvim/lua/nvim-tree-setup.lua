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
   view = { adaptive_size = true },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
})

local function open_nvim_tree()
  require("nvim-tree.api").tree.open()
end
---- alaways open the tree
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

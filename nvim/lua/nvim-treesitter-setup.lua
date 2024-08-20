require("nvim-treesitter.configs").setup {
    ensure_installed = { 'bash', 'css', 'html', 'javascript', 'json', 'jsonc', 'lua', 'rust', 'typescript', 'c', 'cpp', 'python', 'xml' },
    sync_install = false,
    highlight = { enable = true },
    indent = { enable = true },
    auto_install = true,
    incremental_selection = {
        enable = true,
         keymaps = {
             init_selection = "<C-n>", -- set to `false` to disable one of the mappingstsctsctsctsctsctsctsctsctsc
             node_incremental = "<C-n>",
             scope_incremental = "<C-s>",
             node_decremental = "<C-b>"
         },
    }
}

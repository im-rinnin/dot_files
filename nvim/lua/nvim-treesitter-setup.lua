require("nvim-treesitter.configs").setup(
    {
        ensure_installed = { 'bash', 'css', 'html', 'javascript', 'json', 'jsonc', 'lua', 'rust', 'typescript','c','cpp','python' ,'xml'},
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
        auto_install = true,
        incremental_selection = {
            enable = true,
           keymaps = {
               init_selection = '<C-0>',
               --scope_incremental = '<C-i>',
               node_incremental = '<C-0>',
               node_decremental = '<C-9>',
           },
        }
    })

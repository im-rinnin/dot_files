--- install lazy
vim.g.vimspector_enable_mappings = "HUMAN"
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- add plugin here-----------
require("lazy").setup({
    -- clolorscheme
    "sainnhe/gruvbox-material",
    --- file exploer
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
    },
    -- undo
    "simnalamburt/vim-mundo",
    -- auto save
    "pocco81/auto-save.nvim",
    -- telescope
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = { "nvim-lua/plenary.nvim", "BurntSushi/ripgrep" },
        event = "VimEnter",
    },
    -- use gcc/gbc to comment line
    {
        "numToStr/Comment.nvim",
        opts = {},
    },
    --nvim-treesitter
    {
        "nvim-treesitter/nvim-treesitter",
    },


    --which key
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
    },

    ---------------------- git
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",         -- required
            "sindrets/diffview.nvim",        -- optional - Diff integration
            -- Only one of these is needed, not both.
            "nvim-telescope/telescope.nvim", -- optional
        },
        config = true,
    },
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
            },
        },
    },
    --- use :diffview
    ---: diffviewfilehistory
    "sindrets/diffview.nvim",

    --------------------------------------------------------------------------------------- auto complete---------------------------------------------------------------------------------
    -- Vscode-like pictograms
    {
        "onsails/lspkind.nvim",
        event = { "VimEnter" },
    },
    -- Auto-completion engine
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "lspkind.nvim",
            "hrsh7th/cmp-nvim-lsp", -- lsp auto-completion
            "hrsh7th/cmp-buffer",   -- buffer auto-completion
            "hrsh7th/cmp-path",     -- path auto-completion
            "hrsh7th/cmp-cmdline",  -- cmdline auto-completion
        },
    },
    -- Code snippet engine
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
    },
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------


    ------------------------------------------------------------------------------------ lsp
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",

    ---------------------------------------------------------------------------------------------------------------
    -- dap
    'mfussenegger/nvim-dap',
    { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },



    -- Highlight todo, notes, etc in comments
    {
        "folke/todo-comments.nvim",
        -- TODO:
        -- HACK::
        -- TODO
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            -- remove ":" in KEYWORDS
            pattern = [[\b(KEYWORDS)\b]], -- ripgrep regex
        },
    },

    { -- Collection of various small independent plugins/modules
        "echasnovski/mini.nvim",
        config = function()
            -- Better Around/Inside textobjects
            --
            -- Examples:
            --  - va)  - [V]isually select [A]round [)]paren
            --  - yinq - [Y]ank [I]nside [N]ext [']quote
            --  - ci'  - [C]hange [I]nside [']quote
            require("mini.ai").setup({ n_lines = 500 })

            -- Add/delete/replace surroundings (brackets, quotes, etc.)
            --
            -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
            -- - sd'   - [S]urround [D]elete [']quotes
            -- - sr)'  - [S]urround [R]eplace [)] [']
            require("mini.surround").setup()

            -- Simple and easy statusline.
            --  You could remove this setup call if you don't like it,
            --  and try some other statusline plugin
            local statusline = require("mini.statusline")
            -- set use_icons to true if you have a Nerd Font
            statusline.setup({ use_icons = vim.g.have_nerd_font })

            -- You can configure sections in the statusline by overriding their
            -- default behavior. For example, here we set the section for
            -- cursor location to LINE:COLUMN
            ---@diagnostic disable-next-line: duplicate-set-field
            statusline.section_location = function()
                return "%2l:%-2v"
            end

            -- ... and there is more!
            --  Check out: https://github.com/echasnovski/mini.nvim
        end,
    },

    { -- Add indentation guides even on blank lines
        'lukas-reineke/indent-blankline.nvim',
        -- Enable `lukas-reineke/indent-blankline.nvim`
        -- See `:help ibl`
        main = 'ibl',
        opts = {},
    },

    -- terminal
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        opts = {
            open_mapping = [[<c-\>]], -- or { [[<c-\>]], [[<c-¥>]] } if you also use a Japanese keyboard.
        }
    },
    -- auto pair

    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true,
        opts = {}
    },

    -- seesion
    'tpope/vim-obsession',

    -- Highlight word under cursor
    -- alt-n/p jump to next position has same symbol under cursor
    'RRethy/vim-illuminate',

})

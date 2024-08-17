require('mason').setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})



-- Customized on_attach function
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    if client.name == "rust_analyzer" then
        -- This requires Neovim 0.10 or later
        vim.lsp.inlay_hint.enable()
    end

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr ,desc="lsp"}
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
    vim.keymap.set("n", "gh", vim.lsp.buf.hover, bufopts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
    vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, bufopts)

    vim.keymap.set("n", "gwa", vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set("n", "gwr", vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set("n", "gwl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set("n", "gtd", vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set("n", "grn", vim.lsp.buf.rename, bufopts)
    vim.keymap.set("n", "gf", vim.lsp.buf.format, bufopts)

end

-- How to add a LSP for a specific language?
-- 1. Use `:Mason` to install the corresponding LSP.
-- 2. Add configuration below.

-- Set different settings for different languages' LSP
-- LSP list: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- How to use setup({}): https://github.com/neovim/nvim-lspconfig/wiki/Understanding-setup-%7B%7D
--     - the settings table is sent to the LSP
--     - on_attach: a lua callback function to run after LSP attaches to a given buffer
local lspconfig = require("lspconfig")

require('mason-lspconfig').setup({
    -- A list of servers to automatically install if they're not already installed
    ensure_installed = { 'pyright', 'lua_ls', 'rust_analyzer', 'clangd', 'jsonls', 'asm_lsp' },
})

lspconfig.pyright.setup({
    on_attach = on_attach,
})


lspconfig.lua_ls.setup({
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
})


-- source: https://rust-analyzer.github.io/manual.html#nvim-lsp
lspconfig.rust_analyzer.setup({
    on_attach = on_attach,
})

lspconfig.clangd.setup({
    on_attach = on_attach,
})
lspconfig.jsonls.setup({
    on_attach = on_attach,
})


lspconfig.asm_lsp.setup({
    on_attach = on_attach,
})

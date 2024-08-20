-- define common options
local opts = {
    noremap = true, -- non-recursive
    silent = true,  -- do not show message
}

-----------------
-- Normal mode --
-----------------
---
-- quit
vim.keymap.set('n', 'qq', ":quit<CR>", { desc = "[Q]uit current window" })

-- Hint: see `:h vim.map.set()`
-- Better window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
vim.keymap.set('n', '<C-l>', '<C-w>l', opts)

vim.keymap.set("n", "=", [[<cmd>vertical resize +2<cr>]])   -- make the window biger vertically
vim.keymap.set("n", "-", [[<cmd>vertical resize -2<cr>]])   -- make the window smaller vertically
vim.keymap.set("n", "+", [[<cmd>horizontal resize +2<cr>]]) -- make the window bigger horizontally by pressing shift and =
vim.keymap.set("n", "_", [[<cmd>horizontal resize -2<cr>]]) -- make the window smaller horizontally by pressing shift and -

-- Resize with arrows
-- delta: 2 lines
vim.keymap.set('n', '<C-Up>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<C-Down>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', opts)

-- set leader key
vim.g.mapleader = ","
vim.g.maplocalleader = ","


vim.keymap.set('n', '<leader>ta', ":tabnew<CR>", {})

-- nvimtree
vim.keymap.set('n', '<M-n>', ":NvimTreeToggle<CR>", {})


-- neogit
vim.keymap.set('n', '<leader>ng', ":Neogit<CR>", {})
-- mundo
vim.keymap.set('n', '<leader>md', ":MundoToggle<CR>", {})
-- telescope start with <leader>f
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fw', builtin.grep_string, {})
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set('n', '<leader>gs', ":Telescope lsp_workspace_symbols query=", { desc = '[S]earch Symbol("." for repeat)' })
vim.keymap.set('n', '<leader>f?', builtin.keymaps, { desc = '[S]earch Symbol("." for repeat)' })

vim.keymap.set('n', '<leader>fch', builtin.command_history, { desc = '[C]command history' })
vim.keymap.set('n', '<leader>fr', builtin.registers, { desc = '[S]earch register' })
vim.keymap.set('n', '<leader>fm', builtin.marks, { desc = '[S]earch marks' })
vim.keymap.set('n', '<leader>fs', builtin.search_history, { desc = '[S]earch history' })
vim.keymap.set('n', '<leader>fj', builtin.jumplist, { desc = '[J]ump list' })

-- telescope git
vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = '[G]it status' })
vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = '[G]it files' })
vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = '[G]it commits' })

-- telescope lsp
vim.keymap.set('n', '<leader>lr', builtin.lsp_references, { desc = '[L]sp references' })
vim.keymap.set('n', '<leader>ld', builtin.lsp_definitions, { desc = '[L]sp definitions' })
vim.keymap.set('n', '<leader>li', builtin.lsp_implementations, { desc = '[L]sp implementations' })
vim.keymap.set('n', '<leader>lo', builtin.lsp_document_symbols, { desc = '[L]sp document Symbol' })
vim.keymap.set('n', '<leader>lw', builtin.lsp_workspace_symbols, { desc = '[L]sp _workspace_symbols' })
vim.keymap.set('n', '<leader>ldd', builtin.lsp_dynamic_workspace_symbols, { desc = '[L]sp dynamic_workspace_symbols' })

-- terminal
function _G.set_terminal_keymaps()
    local opts = { buffer = 0 }
    vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
    vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')


--- diffview
vim.keymap.set('n', '<leader>vo', ":DiffviewOpen<CR>", { desc = '[D]iff view open' })
vim.keymap.set('n', '<leader>vc', ":DiffviewClose<CR>", { desc = '[D]iff view close' })
vim.keymap.set('n', '<leader>vh', ":DiffviewFileHistory<CR>", { desc = '[D]iff view file history close' })

-- git blame
vim.keymap.set('n', '<leader>bl', ":GitBlameToggle<CR>", { desc = 'git [B]lame current file' })



-- gitsigns
require('gitsigns').setup {
    on_attach = function(bufnr)
        local gitsigns = require('gitsigns')

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
            if vim.wo.diff then
                vim.cmd.normal({ ']c', bang = true })
            else
                gitsigns.nav_hunk('next')
            end
        end)

        map('n', '[c', function()
            if vim.wo.diff then
                vim.cmd.normal({ '[c', bang = true })
            else
                gitsigns.nav_hunk('prev')
            end
        end)

        -- Actions
        map('n', '<leader>hs', gitsigns.stage_hunk)
        map('n', '<leader>hr', gitsigns.reset_hunk)
        map('v', '<leader>hs', function() gitsigns.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
        map('v', '<leader>hr', function() gitsigns.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
        map('n', '<leader>hS', gitsigns.stage_buffer)
        map('n', '<leader>hu', gitsigns.undo_stage_hunk)
        map('n', '<leader>hR', gitsigns.reset_buffer)
        map('n', '<leader>hp', gitsigns.preview_hunk)
        map('n', '<leader>hb', function() gitsigns.blame_line { full = true } end)
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
        map('n', '<leader>hd', gitsigns.diffthis)
        map('n', '<leader>hD', function() gitsigns.diffthis('~') end)
        map('n', '<leader>td', gitsigns.toggle_deleted)

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    end

}
vim.keymap.set('n', '<T-p>', function() require('illuminate').goto_next_reference() end)

-- dap
dap = require('dap')
vim.keymap.set('n', '<F4>', function() require('dap').terminate(nil, nil, nil) end)
vim.keymap.set('n', '<F5>', function() require('dap').continue() end, { desc = "dap continue" })
vim.keymap.set({ 'n', 'v' }, '<F6>', function() require("dapui").toggle() end)
vim.keymap.set('n', '<F7>', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<F8>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F9>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F10>', function() require('dap').step_out() end)

vim.keymap.set('n', '<Leader>dl',
    function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<Leader>dc', function() require('dap').set_breakpoint(vim.fn.input('break condition'), nil, nil) end)

vim.keymap.set('n', '<Leader>du', function() dap.up() end)
vim.keymap.set('n', '<Leader>dd', function() dap.down() end)



vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)

--- dap ui
vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
    require('dap.ui.widgets').hover()
end)
vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function()
    require('dap.ui.widgets').preview()
end)
vim.keymap.set('n', '<Leader>df', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<Leader>ds', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.scopes)
end)
--

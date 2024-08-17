-- mark me befor push to git
local debugpy_path="/Users/ningwang/tmp/python/.virtualenvs/debugpy/bin/python"
local dap = require('dap')
dap.adapters.python = function(cb, config)
    if config.request == 'attach' then
        ---@diagnostic disable-next-line: undefined-field
        local port = (config.connect or config).port
        ---@diagnostic disable-next-line: undefined-field
        local host = (config.connect or config).host or '127.0.0.1'
        cb({
            type = 'server',
            port = assert(port, '`connect.port` is required for a python `attach` configuration'),
            host = host,
            options = {
                source_filetype = 'python',
            },
        })
    else
        cb({
            type = 'executable',
            command = debugpy_path,
            args = { '-m', 'debugpy.adapter' },
            options = {
                source_filetype = 'python',
            },
        })
    end
end


local dap = require('dap')
dap.adapters.lldb = {
  type = 'executable',
  command = '/opt/homebrew/opt/llvm/bin/lldb-dap',
  name = 'lldb'
}


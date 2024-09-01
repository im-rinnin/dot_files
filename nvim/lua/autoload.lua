-- 获取当前工作目录
local start_dir = vim.fn.getcwd()
local autorun_file_name = "setting.lua"
local session_file_name = "Session.vim"

local autorun_path = start_dir .. '/' .. autorun_file_name
local sesssion_path = start_dir .. '/' .. session_file_name

-- 检查是否存在并加载
if vim.fn.filereadable(autorun_path) == 1 then
    dofile(autorun_path)
end

if vim.fn.filereadable(sesssion_path) == 1 then
    vim.cmd('source ' .. sesssion_path)
end

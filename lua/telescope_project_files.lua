local builtin = require("telescope.builtin")
local M = {}

-- cache
local is_inside_work_tree = {}
M.project_files = function()
    local cwd = vim.fn.getcwd()

    if is_inside_work_tree[cwd] == nil then
        vim.fn.system("git rev-parse --is-inside-work-tree")
        is_inside_work_tree[cwd] = vim.v.shell_error == 0
    end

    if is_inside_work_tree[cwd] then
        builtin.git_files()
    else
        builtin.find_files({
            find_command = { "fd", "-u", "--type", "f", "--strip-cwd-prefix" },
        })
    end
end

return M

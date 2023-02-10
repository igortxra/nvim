local status_ok, dap = pcall(require, 'dap')
if not status_ok then
  return
end

-- Python debugger
dap.adapters.python = {
  type = "executable";
  command = os.getenv('HOME') .. '/venv/bin/python';
  args = { '-m', 'debugpy.adapter' };
}

dap.configurations.python = {
  {
    type = 'python';
    request = 'launch';
    name = "Launch file";
    program = "${file}";
    pythonPath = function()
      return '/usr/bin/python'
    end;
  },
}

-- Debugger Keymaps
vim.keymap.set('n', '<leader>db',function() require"dap".toggle_breakpoint() end)
vim.keymap.set('n', '<leader>dH', ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
vim.keymap.set({'n', 't'}, '<A-k>', function() require"dap".step_out() end)
vim.keymap.set({'n', 't'}, "<A-l>", function() require"dap".step_into() end)
vim.keymap.set({'n', 't'}, '<A-j>', function() require"dap".step_over() end)
vim.keymap.set({'n', 't'}, '<A-h>', function() require"dap".continue() end)
vim.keymap.set('n', '<leader>dn', function() require"dap".run_to_cursor() end)
vim.keymap.set('n', '<leader>dc', function() require"dap".terminate() end)
vim.keymap.set('n', '<leader>dR', function() require"dap".clear_breakpoints() end)
vim.keymap.set('n', '<leader>de', function() require"dap".set_exception_breakpoints({"all"}) end)
vim.keymap.set('n', '<leader>da', function() require"debugHelper".attach() end)
vim.keymap.set('n', '<leader>dA', function() require"debugHelper".attachToRemote() end)
vim.keymap.set('n', '<leader>di', function() require"dap.ui.widgets".hover() end)
vim.keymap.set('n', '<leader>d?', function()

local widgets = require "dap.ui.widgets";
    widgets.centered_float(widgets.scopes)
end)

vim.keymap.set('n', '<leader>dk', ':lua require"dap".up()<CR>zz')
vim.keymap.set('n', '<leader>dj', ':lua require"dap".down()<CR>zz')
vim.keymap.set('n', '<leader>dr', ':lua require"dap".repl.toggle({}, "vsplit")<CR><C-w>l')
vim.keymap.set('n', '<leader>du', ':lua require"dapui".toggle()<CR>')

vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})

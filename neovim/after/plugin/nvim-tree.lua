require('nvim-tree').setup({
  open_on_setup = false,
  renderer = {
    indent_markers = {
      enable = true
    }
  },
  filters = {
    dotfiles = false
  },
  git = {
    enable = true,
    ignore = false
  },
  update_focused_file = {
    enable = true,
    debounce_delay = 15,
    update_root = false,
    ignore_list = {},
  },
})

vim.keymap.set({'n', 'v'}, '<leader>tt', vim.cmd.NvimTreeToggle)

vim.keymap.set({'n', 'v'}, '<leader>t=', function()
  vim.cmd('NvimTreeResize +5')
end)

vim.keymap.set({'n', 'v'}, '<leader>t-', function()
  vim.cmd('NvimTreeResize -5')
end)


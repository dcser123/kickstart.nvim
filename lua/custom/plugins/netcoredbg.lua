return {
  'Cliffback/netcoredbg-macOS-arm64.nvim',
  dependencies = { 'mfussenegger/nvim-dap' },
  enabled = vim.fn.has 'macunix' == 1,
}

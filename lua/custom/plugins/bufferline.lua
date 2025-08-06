return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    require('bufferline').setup {
      options = {
        offsets = {
          {
            filetype = 'neo-tree',
            text = 'File Explorer',
            -- highlight = 'Directory',
            -- text_align = 'center',
            -- separator = true,
          },
        },
      },
      vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', { silent = true, noremap = true, desc = 'Next Buffer' }),
      vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', { silent = true, noremap = true, desc = 'Previous Buffer' }),
    }
  end,
}

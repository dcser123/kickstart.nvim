return {
  'catgoose/nvim-colorizer.lua',
  branch = 'master',
  event = 'BufReadPre',
  opts = {
    user_default_options = {
      names = false,
      mode = 'virtualtext', -- Set the display mode
      -- Virtualtext character to use
      virtualtext = '■■',
      -- Display virtualtext inline with color.  boolean|'before'|'after'.  True sets to 'after'
      virtualtext_inline = true,
      -- Virtualtext highlight mode: 'background'|'foreground'
      virtualtext_mode = 'foreground',
    },
  },
}

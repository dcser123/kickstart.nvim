return {
  'lervag/vimtex',
  lazy = false, -- we don't want to lazy load VimTeX
  -- tag = "v2.15", -- uncomment to pin to a specific release
  init = function()
    -- VimTeX configuration goes here, e.g.
    vim.g.vimtex_compiler_latexmk = {
      options = {
        '-shell-escape',
        '-verbose',
        '-file-line-error',
        '-synctex=1',
        '-interaction=nonstopmode',
      },
    }
    vim.g.vimtex_view_method = 'zathura_simple'
    vim.g.vimtex_view_zathura_use_synctex = 0
    vim.g.vimtex_imaps_enabled = 0
    vim.g.vimtex_syntax_conceal = {
      sections = 1,
    }

    vim.g.vimtex_view_general_viewer = 'okular'
    vim.g.vimtex_view_general_options = '--unique file:@pdf\\#src:@line@tex'

    vim.g.vimtex_quickfix_mode = 0
    vim.g.vimtex_quickfix_ignore_filters = {
      'Command terminated with space',
      'LaTeX Font Warning: Font shape',
      'Package caption Warning: The option',
      [[Underfull \\hbox (badness [0-9]*) in]],
      'Package enumitem Warning: Negative labelwidth',
      [[Overfull \\hbox ([0-9]*.[0-9]*pt too wide) in]],
      [[Package caption Warning: Unused \\captionsetup]],
      'Package typearea Warning: Bad type area settings!',
      [[Package fancyhdr Warning: \\headheight is too small]],
      [[Underfull \\hbox (badness [0-9]*) in paragraph at lines]],
      'Package hyperref Warning: Token not allowed in a PDF string',
      [[Overfull \\hbox ([0-9]*.[0-9]*pt too wide) in paragraph at lines]],
    }

    vim.g.vimtex_fold_enabled = 1
    vim.g.vimtex_fold_manual = 1
    vim.g.vimtex_fold_types = {
      envs = {
        whitelist = {
          'figure',
          'frame',
          'table',
          'example',
          'answer',
          'titlepage',
          'cvskills',
          'cventries',
          'cvhonors',
        },
      },
      items = {
        enabled = 0,
      },
      sections = {
        sections = {
          '%(add)?part',
          '%(chapter|addchap)',
          '%(section|section\\*)',
          '%(subsection|subsection\\*)',
          '%(subsubsection|subsubsection\\*)',
          'paragraph',
        },
      },
    }
  end,
}

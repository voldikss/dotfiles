local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ';' -- Make sure to set `mapleader` before lazy so your mappings are correct
require('lazy').setup({
  {
    'nvim-tree/nvim-tree.lua',
    enabled = false,
    lazy = false,
    config = function()
      require('nvim-tree').setup({
        sort_by = 'case_sensitive',
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = true,
        },
      })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          'bash',
          'c',
          'cpp',
          'css',
          'go',
          'html',
          'java',
          'javascript',
          'json',
          'markdown',
          'python',
          'rust',
          'toml',
          'tsx',
          'typescript',
          'vue',
          'yaml'
        },
        highlight = {
          enable = true,
          disable = function(lang, bufnr) -- Disable in large buffers
            local linecnt = vim.api.nvim_buf_line_count(bufnr)
            return lang == 'yaml' or lang == "cpp" and linecnt > 50000 or lang == "typescript" and linecnt > 1500
          end
        },
        indent = {
          enable = false
        },
        incremental_selection = {
          enable = true,
          disable = { 'cpp', 'lua' },
          keymaps = {
            init_selection = 'gnn',
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          }
        },
        refactor = {
          highlight_definitions = {
            enable = true
          },
          highlight_current_scope = {
            enable = true
          },
          smart_rename = {
            enable = true,
            keymaps = {
              smart_rename = "grr"
            }
          },
          navigation = {
            enable = true,
            keymaps = {
              goto_definition = "gnd",
              list_definitions = "gnD"
            }
          }
        },
        textobjects = {
          enable = true,
          disable = {},
          keymaps = {
            ["iL"] = {
              -- you can define your own textobjects directly here
              python = "(function_definition) @function",
              cpp = "(function_definition) @function",
              c = "(function_definition) @function",
              java = "(method_declaration) @function"
            },
            -- or you use the queries from supported languages with textobjects.scm
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["aC"] = "@class.outer",
            ["iC"] = "@class.inner",
            ["ac"] = "@conditional.outer",
            ["ic"] = "@conditional.inner",
            ["ae"] = "@block.outer",
            ["ie"] = "@block.inner",
          }
        }
      })
    end
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    config = function()
      require 'treesitter-context'.setup({
        enable = true, -- Disabled default
        max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
        patterns = {   -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
          -- For all filetypes
          -- Note that setting an entry here replaces all other patterns for this entry.
          -- By setting the 'default' entry below, you can control which nodes you want to
          -- appear in the context window.
          default = {
            'class',
            'function',
            'method',
            'for', -- These won't appear in the context
            'while',
            'if',
            'switch',
            'case',
          },
          -- Example for a specific filetype.
          -- If a pattern is missing, *open a PR* so everyone can benefit.
          --   rust = {
          --       'impl_item',
          --   },
        },
        exact_patterns = {
          -- Example for a specific filetype with Lua patterns
          -- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
          -- exactly match "impl_item" only)
          -- rust = true,
        },

        -- [!] The options below are exposed but shouldn't require your attention,
        --     you can safely ignore them.

        zindex = 20, -- The Z-index of the context window
      })
    end
  },
  {
    'justinmk/vim-dirvish',
    keys = { '-' },
    cmd = 'Dirvish',
    config = function()
      vim.keymap.set('n', '-', '<Plug>(dirvish_up)')
    end
  },
  {
    'kevinhwang91/nvim-bqf',
    config = function()
      require('bqf').setup({
        auto_resize_height = false,
        preview = {
          win_height = 25,
          win_vheight = 18,
          delay_syntax = 80,
          border_chars = { '│', '│', '─', '─', '╭', '╮', '╰', '╯', '█' }
        },
        func_map = {
          open = 'o',
          openc = '<CR>'
        }
      })
      vim.api.nvim_set_hl(0, 'BqfPreviewBorder', { fg = '#50a14f', ctermfg = 71 })
      vim.api.nvim_set_hl(0, 'BqfPreviewRange', { link = 'Search' })
      vim.g.coc_enable_locationlist = false
      vim.api.nvim_create_autocmd('User', {
        pattern = "CocLocationsChange",
        desc = "Update location list on locations change",
        callback = function()
          local locs = vim.g.coc_jump_locations
          vim.fn.setloclist(0, {}, " ", { title = "CocLocationList", items = locs })
          local winid = vim.fn.getloclist(0, { winid = 0 }).winid
          if winid == 0 then
            vim.cmd("bel lw")
          else
            vim.api.nvim_set_current_win(winid)
          end
        end,
      })
    end
  },
  {
    'nacro90/numb.nvim',
    config = function()
      require('numb').setup()
    end
  },
  'tversteeg/registers.nvim',
  {
    'iamcco/markdown-preview.nvim',
    ft = 'markdown',
    build = 'cd app && npm install',
    config = function()
      vim.g.mkdp_auto_close = 0
    end
  },
  'rust-lang/rust.vim',
  {
    'neoclide/coc.nvim',
    branch = 'release',
    config = function()
      vim.api.nvim_set_hl(0, 'CocPum', { link = 'Pmenu' })
      vim.api.nvim_set_hl(0, 'CocMenuSel', { link = 'PmenuSel' })
      vim.g.coc_data_home = '~/.config/coc'
      vim.keymap.set('n', '<C-b>', ':call keymap#n#scroll_win(0)<CR>', { silent = true })
      vim.keymap.set('n', '<C-f>', ':call keymap#n#scroll_win(1)<CR>', { silent = true })
      vim.cmd([[
        inoremap <silent><nowait><expr> <C-f>
        \ coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" :
        \ "<C-r>=keymap#exec('normal! w')<CR>"
        inoremap <silent><nowait><expr> <C-b>
        \ coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" :
        \ "<C-r>=keymap#exec('normal! b')<CR>"
        " coc-snippets
        " 不要改动
        inoremap <silent><expr> <TAB>
        \ coc#pum#visible() ? coc#pum#next(1) :
        \ CheckBackspace() ? "\<Tab>" :
        \ coc#refresh()
        inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

        function! CheckBackspace() abort
          let col = col('.') - 1
          return !col || getline('.')[col - 1]  =~# '\s'
        endfunction

        augroup CocRelatedAutocmds
          autocmd!
          autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
          autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
        augroup END
      ]])
      -- general
      vim.keymap.set('n', '<M-n>', '<Plug>(coc-diagnostic-next)', { silent = true })
      vim.keymap.set('n', '<M-p>', '<Plug>(coc-diagnostic-prev)', { silent = true })
      vim.keymap.set('n', '<Leader>cf', '<Plug>(coc-fix-current)', { silent = true })
      vim.keymap.set('n', '<Leader>cd', '<Plug>(coc-definition)', { silent = true })
      vim.keymap.set('n', '<Leader>cr', '<Plug>(coc-refactor)', { silent = true })
      vim.keymap.set('n', '<Leader>ci', '<Plug>(coc-implementation)', { silent = true })
      vim.keymap.set('n', '<Leader>rn', '<Plug>(coc-rename)', { silent = true })
      vim.keymap.set('n', '<Leader>rf', '<Plug>(coc-references-used)', { silent = true })

      -- text object
      vim.keymap.set('x', 'ic', '<Plug>(coc-classobj-a)', { silent = true })
      vim.keymap.set('o', 'ic', '<Plug>(coc-classobj-a)', { silent = true })
      vim.keymap.set('x', 'if', '<Plug>(coc-funcobj-a)', { silent = true })
      vim.keymap.set('o', 'if', '<Plug>(coc-funcobj-a)', { silent = true })
      vim.keymap.set('x', 'if', '<Plug>(coc-git-chunk-inner)', { silent = true })
      vim.keymap.set('o', 'if', '<Plug>(coc-git-chunk-inner)', { silent = true })

      -- coc-git
      vim.keymap.set('n', 'gs', ':CocCommand git.chunkStage<CR>', { silent = true })
      vim.keymap.set('n', 'go', ':CocCommand git.browserOpen<CR>', { silent = true })
      vim.keymap.set('n', 'gd', ':CocCommand git.chunkInfo<CR>', { silent = true })
      vim.keymap.set('n', 'gm', ':CocCommand git.showCommit<CR>', { silent = true })
      vim.keymap.set('n', 'gw', ':call file#refresh()<CR>:Gw<CR>:call file#refresh()<CR>', { silent = true })
      vim.keymap.set('n', 'gW', ':AsyncRun -cwd=<root> -silent=1 git add .<CR>', { silent = true })
      vim.keymap.set('n', 'gca', ':Git commit --amend -v<CR>', { silent = true })
      vim.keymap.set('n', 'gcm', ':Git commit -v<CR>', { silent = true })
      vim.keymap.set('n', 'gcu', ':CocCommand git.chunkUndo<CR>', { silent = true })

      vim.g.coc_snippet_next = '<Tab>'
      vim.g.coc_snippet_prev = '<S-Tab>'
      vim.g.coc_global_extensions = {
        -- 'coc-dash-complete',
        -- 'coc-just-complete',
        -- 'coc-browser',
        -- 'coc-clang-format-style-options',
        -- 'coc-floaterm',
        -- 'coc-java',
        -- 'coc-marketplace',
        -- 'coc-styled-components',
        -- 'coc-webpack',
        'coc-clangd',
        'coc-cmake',
        'coc-css',
        'coc-diagnostic',
        'coc-dictionary',
        'coc-docker',
        'coc-emmet',
        'coc-emoji',
        'coc-eslint',
        'coc-explorer',
        'coc-git',
        'coc-go',
        'coc-highlight',
        'coc-html',
        'coc-html-css-support',
        'coc-json',
        'coc-lists',
        'coc-pairs',
        'coc-prettier',
        'coc-pyright',
        'coc-rust-analyzer',
        'coc-syntax',
        'coc-snippets',
        'coc-svg',
        'coc-tag',
        'coc-tasks',
        'coc-toml',
        'coc-translator',
        'coc-tsserver',
        'coc-vimlsp',
        'coc-word',
        'coc-yaml',
      }
    end
  },
  {
    'yaegassy/coc-volar',
    build = 'yarn install --frozen-lockfile'
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    ft = { 'yaml' },
    config = function()
      vim.g.indent_blankline_char_highlight = 'Delimiter'
      vim.g.indent_blankline_filetype = { 'yaml' }
    end
  },
  'kshenoy/vim-signature',
  {
    'guns/xterm-color-table.vim',
    cmd = 'XtermColorTable'
  },
  {
    'itchyny/lightline.vim',
    config = function()
      vim.g.lightline = ({
        colorscheme = 'powerline',
        active = {
          left = {
            { 'mode' },
            { 'fugitive',       'readonly' },
            { 'active_filename' }
          },
          right = {
            { 'lineinfo' },
            { 'percent' },
            { 'cocstatus',        'asyncrun_status', 'floaterm_exec_status' },
            { 'fileformat',       'fileencoding' },
            { 'filetype' },
            { 'translator_status' }
          }
        },
        inactive = {
          left = {
            { 'inactive_filename' }
          },
          right = {}
        },
        tabline = {
          left = {
            { 'buffers' }
          },
          right = {},
          subseparator = {
            left = '│',
            right = '│'
          }
        },
        component = {
          lineinfo = ' %l,%-v',
          percent = '%p%%'
        },
        component_function = {
          asyncrun_status = 'mylightline#AsyncRunStatus',
          floaterm_exec_status = 'mylightline#FloatermExecStatus',
          translator_status = 'mylightline#Translator_Status',
          mode = 'mylightline#Mode',
          fugitive = 'mylightline#GitBranch',
          cocstatus = 'coc#status',
          readonly = 'mylightline#ReadOnly',
          fileformat = 'mylightline#FileFormat',
          fileencoding = 'mylightline#FileEncoding',
          filetype = 'mylightline#FileType',
          active_filename = 'mylightline#ActiveFileinfo',
          inactive_filename = 'mylightline#InactiveFileinfo',
        },
        component_expand = {
          buffers = 'lightline#bufferline#buffers'
        },
        component_type = {
          buffers = 'tabsel'
        },
        subseparator = {
          left = '│',
          right = '│'
        }
      })
    end
  },
  {
    'mengelbrecht/lightline-bufferline',
    commit = '7b0d302',
    dependencies = {
      'ryanoasis/vim-devicons'
    },
    config = function()
      vim.g['lightline#bufferline#clickable']                      = 1
      vim.g['lightline#bufferline#disable_more_buffers_indicator'] = 1
      vim.g['lightline.component_raw']                             = { buffers = 1 }
      vim.g['lightline#bufferline#unnamed']                        = '[No Name]'
      vim.g['lightline#bufferline#filename_modifier']              = ':t'
      vim.g['lightline#bufferline#enable_devicons']                = 0
      vim.g['lightline#bufferline#unicode_symbols']                = 1
      vim.g['lightline#bufferline#show_number']                    = 0
      vim.g['lightline#bufferline#number_map']                     = {
        '⁰',
        '¹',
        '²',
        '³',
        '⁴',
        '⁵',
        '⁶',
        '⁷',
        '⁸',
        '⁹',
      }
      vim.keymap.set('n', '<Leader>1', '<Plug>lightline#bufferline#go(1)')
      vim.keymap.set('n', '<Leader>2', '<Plug>lightline#bufferline#go(2)')
      vim.keymap.set('n', '<Leader>3', '<Plug>lightline#bufferline#go(3)')
      vim.keymap.set('n', '<Leader>4', '<Plug>lightline#bufferline#go(4)')
      vim.keymap.set('n', '<Leader>5', '<Plug>lightline#bufferline#go(5)')
      vim.keymap.set('n', '<Leader>6', '<Plug>lightline#bufferline#go(6)')
      vim.keymap.set('n', '<Leader>7', '<Plug>lightline#bufferline#go(7)')
      vim.keymap.set('n', '<Leader>8', '<Plug>lightline#bufferline#go(8)')
      vim.keymap.set('n', '<Leader>9', '<Plug>lightline#bufferline#go(9)')
    end
  },
  {
    'mhinz/vim-startify',
    cmd = 'Startify',
    keys = { '<Leader><Space>' },
    dependencies = {
      'ryanoasis/vim-devicons'
    },
    config = function()
      vim.g.webdevicons_enable_startify = 1
      vim.cmd([[
        nnoremap <silent> <Leader><Space> <Esc>:Startify<CR>
        function! s:stdpath_config() abort
          if has('nvim')
            return stdpath('config')
          else
            return has('unix') ? '~/.config/nvim' : 'C:\Users\dyzh\AppData\Local\nvim'
          endif
        endfunction
        let g:startify_bookmarks = [
        \ {'c': <SID>stdpath_config() . '/coc-settings.json'},
        \ {'v': <SID>stdpath_config() . '/init.vim'}
        \ ]

        augroup StartifyAutocmds
          autocmd!
          autocmd User Startified setlocal buflisted
        augroup END
      ]])
      vim.g.startify_files_number = 8
      vim.g.startify_padding_left = 15
      vim.cmd([[
        highlight StartifyHeader guifg=#FF00FF
        highlight StartifyNumber guifg=#00FF00
        highlight StartifyPath   guifg=#00AFFF
        highlight StartifySlash  guifg=#DF875F
      ]])
    end
  },
  {
    'ryanoasis/vim-devicons'
  },
  {
    'itchyny/vim-cursorword',
    config = function()
      vim.cmd([[
        let g:cursorword_highlight = 1
        hi CursorWord0 guibg=#404D3D
        hi link CursorWord1 CursorLine
      ]])
    end
  },
  'tpope/vim-fugitive',
  'tpope/vim-git',
  {
    'junegunn/gv.vim',
    cmd = 'GV'
  },
  {
    'phaazon/hop.nvim',
    keys = {
      { "'", '<Cmd>HopWord<CR>' }
    },
    config = function()
      require 'hop'.setup()
      vim.keymap.set('n', "'", '<Cmd>HopWord<CR>')
      vim.keymap.set('v', "'", '<Cmd>HopWord<CR>')
    end
  },
  {
    'yangmillstheory/vim-snipe',
    keys = {
      { 'f', '<Plug>(snipe-f)' },
      { 'F', '<Plug>(snipe-F)' }
    },
    config = function()
      vim.keymap.set('n', 'f', '<Plug>(snipe-f)', { silent = true })
      vim.keymap.set('n', 'F', '<Plug>(snipe-F)', { silent = true })
      vim.keymap.set('v', 'f', '<Plug>(snipe-f)', { silent = true })
      vim.keymap.set('v', 'F', '<Plug>(snipe-F)', { silent = true })
    end
  },
  {
    'Yggdroot/LeaderF',
    build = './install.sh',
    dependencies = {
      'ryanoasis/vim-devicons'
    },
    config = function()
      vim.g.Lf_Extensions            = vim.tbl_get(vim.g, 'Lf_Extensions') or vim.empty_dict()
      vim.g.Lf_WindowHeight          = 0.4
      vim.g.Lf_WorkingDirectoryMode  = 'Ac'
      vim.g.Lf_Extensions.spell      = {
        source = "leaderf#source#spell#gather",
        arguments = {
          {
            name = { "pattern" },
            nargs = 1
          }
        },
        accept = 'leaderf#source#spell#sink'
      }
      vim.g.Lf_Extensions.man        = {
        source = 'leaderf#source#man#gather',
        accept = 'leaderf#source#man#sink'
      }
      vim.g.Lf_CacheDirectory        = vim.fn.expand('~/.cache/nvim')
      vim.g.Lf_CommandMap            = {
        ['<Up>'] = { '<C-p>' },
        ['<Down>'] = { '<C-n>' },
        ['<Home>'] = { '<C-A>' }
      }
      vim.g.Lf_Ctags                 = "ctags"
      vim.g.Lf_DefaultExternalTool   = ""
      vim.g.Lf_FilerShowDevIcons     = 1
      vim.g.Lf_GtagsAutoGenerate     = 0
      vim.g.Lf_GtagsAutoUpdate       = 0
      vim.g.Lf_Gtagslabel            = 'native-pygments'
      vim.g.Lf_HideHelp              = 1
      vim.g.Lf_IndexTimeLimit        = 10
      vim.g.Lf_MruFileExclude        = { '*.so', '*.py[c0]', '*.exe', '*.sw?' }
      vim.g.Lf_PreviewInPopup        = 1
      vim.g.Lf_PopupShowBorder       = 1
      vim.g.Lf_PopupBorders          = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
      vim.g.Lf_PopupPreviewPosition  = 'right'
      vim.g.Lf_WindowPosition        = 'bottom'
      vim.g.Lf_PreviewResult         = {
        File = 0,
        Buffer = 0,
        Mru = 0,
        Tag = 0,
        BufTag = 0,
        Function = 0,
        Line = 0,
        Colorscheme = 1,
        Rg = 0,
        Gtags = 0
      }
      vim.g.Lf_RgConfig              = {
        "--glob=!OmegaOptions.bak",
        "--glob=!**/e2e/*",
        "--glob=!logs",
        "--glob=!logs-meta",
        "--glob=!node_modules",
        "--glob=!dist",
        "--glob=!lib/**/*.js",
        "--glob=!yarn.lock",
        "--glob=!package-lock.json",
        "--glob=!target",
        "--glob=!tags",
        "--glob=!.git",
        "--glob=!.yarn",
        "--glob=!.ccls-cache",
        "--max-columns=150",
        "--hidden"
      }
      vim.g.Lf_RootMarkers           = {
        '.project',
        '.svn',
        '.git',
        '.idea',
      }
      vim.g.Lf_ShowHidden            = 1
      vim.g.Lf_ShowRelativePath      = 1
      vim.g.Lf_StlColorscheme        = 'gruvbox_material'
      vim.g.Lf_StlSeparator          = { left = '', right = '', font = '' }
      vim.g.Lf_UseVersionControlTool = 0
      vim.g.Lf_WildIgnore            = {
        dir = {
          '.svn',
          '.git',
          '.hg',
          '.cache',
          '.idea',
          '.ccls-cache',
          '.android',
          '.gradle',
          '.IntelliJIdea*',
          'node_modules',
          'dist',
        },
        file = {
          '*.sw?',
          '~$*',
          '*.exe',
          '*.o',
          '*.so',
          '*.py[co]'
        }
      }
      vim.keymap.set('n', 'z=', ':Leaderf spell <cword><CR>', { silent = true })
      vim.keymap.set('n', '<C-p>', ':<C-U><C-R>=printf("Leaderf file %s", path#get_root())<CR><CR>', { silent = true })
      vim.keymap.set('n', '<Leader>fb', ':Leaderf buffer --all<CR>', { silent = true })
      vim.keymap.set('n', '<Leader>fc', ':Leaderf! --recall<CR>', { silent = true })
      vim.keymap.set('n', '<Leader>ff', ':<C-U><C-R>=printf("Leaderf file %s", path#get_root())<CR><CR>',
        { silent = true })
      vim.keymap.set('n', '<Leader>fg', ':Leaderf rg<CR>', { silent = true })
      vim.keymap.set('n', '<Leader>fh', ':Leaderf cmdHistory<CR>', { silent = true })
      vim.keymap.set('n', '<Leader>fl', ':Leaderf line --all<CR>', { silent = true })
      vim.keymap.set('n', '<Leader>fm', ':Leaderf mru<CR>', { silent = true })
      vim.keymap.set('n', '<Leader>ft', ':Leaderf bufTag<CR>', { silent = true })
      vim.keymap.set('n', '<Leader>fu', ':Leaderf function<CR>', { silent = true })
      vim.keymap.set('n', '<Leader>fr',
        ':<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>',
        { silent = true })
      vim.keymap.set('n', '<Leader>fd',
        ':<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>',
        { silent = true })
      vim.keymap.set('n', '<Leader>fn', ':<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>', { silent = true })
      vim.keymap.set('n', '<Leader>fp', ':<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>',
        { silent = true })
    end
  },
  {
    'andrewradev/sideways.vim',
    config = function()
      vim.keymap.set('n', '<C-left>', ':SidewaysLeft<CR>', { silent = true })
      vim.keymap.set('n', '<C-right>', ':SidewaysRight<CR>', { silent = true })
      vim.keymap.set('o', 'as', '<Plug>SidewaysArgumentTextobjA', { silent = true, remap = true })
      vim.keymap.set('x', 'as', '<Plug>SidewaysArgumentTextobjA', { silent = true, remap = true })
      vim.keymap.set('o', 'as', '<Plug>SidewaysArgumentTextobjI', { silent = true, remap = true })
      vim.keymap.set('x', 'as', '<Plug>SidewaysArgumentTextobjI', { silent = true, remap = true })
    end
  },
  {
    'foosoft/vim-argwrap',
    keys = {
      { '<Leader>aw', '<Plug>(ArgWrapToggle)' }
    },
    config = function()
      vim.keymap.set('n', '<Leader>aw', '<Plug>(ArgWrapToggle)', { silent = true })
    end
  },
  {
    'junegunn/vader.vim',
    enabled = false
  },
  {
    'junegunn/vim-easy-align',
    keys = { '<Plug>(EasyAlign)', 'ga' },
    config = function()
      vim.keymap.set('x', 'ga', '<Plug>(EasyAlign)', { silent = true, noremap = false })
      vim.keymap.set('n', 'ga', '<Plug>(EasyAlign)', { silent = true, noremap = false })
    end
  },
  {
    'liuchengxu/vista.vim',
    cmd = 'Vista',
    config = function()
      vim.g.vista_echo_cursor_strategy = 'floating_win'
      vim.g.vista_close_on_jump = 0
      vim.g.vista_executive_for = {
        typescriptreact = 'coc'
      }
    end
  },
  {
    'matze/vim-move',
    config = function()
      vim.g.move_map_keys    = 0
      vim.g.move_auto_indent = 1
      vim.keymap.set('n', 'J', '<Plug>MoveLineDown', { silent = true, remap = true })
      vim.keymap.set('n', 'K', '<Plug>MoveLineUp', { silent = true, remap = true })
      vim.keymap.set('v', 'J', '<Plug>MoveBlockDown', { silent = true, remap = true })
      vim.keymap.set('v', 'K', '<Plug>MoveBlockUp', { silent = true, remap = true })
    end
  },
  {
    'simnalamburt/vim-mundo',
    cmd = 'MundoToggle',
    config = function()
      vim.g.mundo_width              = 30
      vim.g.mundo_preview_height     = 10
      vim.g.mundo_right              = 0
      vim.g.mundo_preview_bottom     = 1
      vim.g.mundo_auto_preview_delay = 10
    end
  },
  {
    'skywind3000/asyncrun.vim',
    cmd = { 'AsyncRun', 'AsyncStop' },
    config = function()
      vim.g.asyncrun_status = ''
      vim.g.asyncrun_open = 9
      vim.g.asyncrun_rootmarks = { '.git', '.root', '.tasks' }
    end
  },
  {
    'skywind3000/asynctasks.vim',
    config = function()
      vim.g.asynctasks_term_pos = 'bottom'
      vim.g.asynctasks_term_reuse = 0
      vim.g.asynctasks_term_rows = 8
    end
  },
  'skywind3000/vim-dict',
  {
    'tommcdo/vim-exchange',
    keys = { 'cx', 'X' },
    config = function()
      vim.keymap.set('n', 'cx', '<Plug>(Exchange)', { silent = true, remap = true })
      vim.keymap.set('x', 'X', '<Plug>(Exchange)', { silent = true, remap = true })
      vim.keymap.set('n', 'cxc', '<Plug>(ExchangeClear)', { silent = true, remap = true })
      vim.keymap.set('n', 'cxx', '<Plug>(ExchangeLine)', { silent = true, remap = true })
    end
  },
  {
    'tomtom/tcomment_vim',
    keys = { 'gC', 'gc' },
    config = function()
      vim.g['tcomment#filetype#guess_vue'] = 0
      vim.g.tcomment_types = {
        c = '// %s',
        jsonc = '// %s',
        vue = '// %s',
        javascript_inline = '/** %s */',
        javascript_block = {
          commentstring = '/** %s */',
          middle = ' * ',
        },
        typescript_inline = '/** %s */',
        typescript_block = {
          commentstring = '/** %s */',
          middle = ' * ',
        },
      }
      vim.keymap.set('n', 'gC', 'vil:TCommentInline<CR>', { silent = true })
      vim.keymap.set('v', 'gC', 'TCommentBlock', { silent = true })
    end
  },
  'tpope/vim-repeat',
  'tpope/vim-surround',
  {
    'voldikss/vim-browser-search',
    config = function()
      vim.g.browser_search_engines = {
        q = 'https://doc.qt.io/qt-5/search-results.html?q=%s',
        cppreference = 'https://en.cppreference.com/mwiki/index.php?title=Special:Search&search=%s'
      }
      vim.keymap.set('n', '<Leader>s', '<Plug>SearchNormal', { silent = true })
      vim.keymap.set('v', '<Leader>s', '<Plug>SearchNormal', { silent = true })
    end
  },
  {
    'voldikss/vim-skylight',
    config = function()
      vim.api.nvim_set_hl(0, 'SkylightBorder', { bg = 'skyblue', fg = 'black' })
    end
  },
  'voldikss/vim-codelf',
  {
    'voldikss/vim-floaterm',
    config = function()
      vim.g.floaterm_exec_status   = ''
      vim.g.floaterm_title         = 'floaterm ($1|$2)'
      vim.g.floaterm_width         = 0.65
      vim.g.floaterm_height        = 0.65
      vim.g.floaterm_position      = 'center'
      vim.g.floaterm_opener        = 'edit'
      vim.g.floaterm_autoclose     = 2
      vim.g.floaterm_autohide      = true
      vim.g.floaterm_autoinsert    = false
      vim.g.floaterm_keymap_new    = '<F7>'
      vim.g.floaterm_keymap_prev   = '<F8>'
      vim.g.floaterm_keymap_next   = '<F9>'
      vim.g.floaterm_keymap_toggle = '<F12>'
      vim.g.floaterm_rootmarkers   = { '.git' }
      vim.api.nvim_set_hl(0, 'FloatermBorder', { fg = 'orange' })
    end
  },
  {
    'voldikss/vim-translator',
    keys = { ',t', ',w', ',r', ',t', ',w', ',r' },
    config = function()
      vim.g.translator_status = ''
      vim.g.translator_history_enable = 1
      vim.g.translator_default_engines = { 'bing', 'google', 'haici', 'youdao' }
      vim.g.translator_window_max_height = 0.7
      vim.g.translator_window_max_width = 0.7
      vim.g.translator_proxy_url = 'socks5://127.0.0.1:1081'
      vim.keymap.set('n', ',t', '<Plug>Translate', { silent = true })
      vim.keymap.set('n', ',w', '<Plug>TranslateW', { silent = true })
      vim.keymap.set('n', ',r', '<Plug>TranslateR', { silent = true })
      vim.keymap.set('v', ',t', '<Plug>TranslateV', { silent = true })
      vim.keymap.set('v', ',w', '<Plug>TranslateWV', { silent = true })
      vim.keymap.set('v', ',r', '<Plug>TranslateRV', { silent = true })
    end
  },
  {
    'voldikss/LeaderF-emoji',
    config = function()
    end
  },
  'wellle/targets.vim',
  'yianwillis/vimcdoc',
})

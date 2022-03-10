" make sure you have node.js and npm installed
" if you get 'python provider doesn't exists' error maybe you need to install pynvim
" pip install pynvim
" 
" install xclip
"
"""""""""""""""""""""""""""""""""""""""""""
"                  PLUGINS                "
"""""""""""""""""""""""""""""""""""""""""""


call plug#begin('~/.config/nvim/plugged')
"""""""""""""""""""""""""
Plug 'nvim-lua/plenary.nvim' " some plugins like telescope need this
"""""""""""""""""""""""""


"""""""""""""""""""""""""
Plug 'windwp/nvim-autopairs'
Plug 'blackcauldron7/surround.nvim'
Plug 'mattn/emmet-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'numToStr/Comment.nvim'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
"""""""""""""""""""""""""


"""""""""""""""""""""""""
Plug 'kyazdani42/nvim-web-devicons'
Plug 'akinsho/nvim-bufferline.lua'
Plug 'hoob3rt/lualine.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'norcalli/nvim-colorizer.lua'
Plug 'folke/todo-comments.nvim'
"""""""""""""""""""""""""
"

"""""""""""""""""""""""""
" IDE functionalities
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'kyazdani42/nvim-tree.lua'
Plug 'nvim-telescope/telescope.nvim' " fuzzy finder
Plug 'ahmedkhalf/project.nvim'       " finds the root of project
Plug 'akinsho/toggleterm.nvim'
Plug 'ThePrimeagen/refactoring.nvim'
" Plug 'github/copilot.vim'

" adds yarn Plug'n'Play support
Plug 'lbrayner/vim-rzip'
"""""""""""""""""""""""""


"""""""""""""""""""""""""
" Themes
Plug 'rktjmp/lush.nvim'
Plug 'ellisonleao/gruvbox.nvim'
Plug 'bluz71/vim-moonfly-colors'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

" prisma syntax highlighting
Plug 'pantharshit00/vim-prisma'
"""""""""""""""""""""""""

call plug#end()
"""""""""""""""""""""""""""""""""""""""""""
"              END OF PLUGINS             "
"""""""""""""""""""""""""""""""""""""""""""




"""""""""""""""""""""""""""""""""""""""""""
"               VIM SETTINGS              "
"""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""
" General settings

let mapleader = ";"
inoremap jk <ESC>

set number
set relativenumber
set cursorline
set termguicolors
set signcolumn=yes

set nowrap
set scrolloff=7
set sidescrolloff=20

set splitbelow
set splitright

set tabstop=2
set shiftwidth=2
set expandtab
"""""""""""""""""""""""""


"""""""""""""""""""""""""
" Background
set bg=dark

" let g:gruvbox_contrast_dark = 'hard'
" let g:gruvbox_italic = 1
" let g:gruvbox_sign_column = 'bg0'
" let g:gruvbox_color_column = 'bg0'
" colorscheme gruvbox

let g:tokyonight_style = "night"
colorscheme tokyonight

"""""""""""""""""""""""""


"""""""""""""""""""""""""
" Highlights

" hi SignColumn guibg=NONE
" hi CustomGitSignsAdd guifg=#89d138 guibg=none
" hi CustomGitSignsChange guifg=#f7a636 guibg=none
" hi CustomGitSignsDelete guifg=#f94f6f guibg=none
hi SignColumn guibg=none
" hi NvimTreeNormal guibg=#041226
hi CocFloating guibg=#0b0e11

" Highlight Bad Whitespace
au BufRead,BufNewFile *.py match BadWhitespace /\s\+$/
highlight BadWhitespace ctermbg=red guibg=darkred

" hi Visual guifg=#000000 guibg=#f7768e gui=none
"""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""
"            END OF VIM SETTINGS          "
"""""""""""""""""""""""""""""""""""""""""""




"""""""""""""""""""""""""""""""""""""""""""
"               KEYBINDINGS               "
"""""""""""""""""""""""""""""""""""""""""""

nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ'z

" Undo breakpoints
" inoremap , ,<c-g>u        
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

" Jumb list mutations
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

nnoremap cn *``cgn
nnoremap cN *``cgN

nnoremap <leader>sv :vsplit<CR>
nnoremap <leader>sh :split<CR>

" Toggle Transparent Background
let t:is_transparent = 1
function! Toggle_transparent_background()
  if t:is_transparent == 0
    set bg=dark
    let t:is_transparent = 1
  else
    hi Normal guibg=NONE ctermbg=NONE
    let t:is_transparent = 0
  endif
endfunction
nnoremap <leader>tt :call Toggle_transparent_background()<CR>


" Toggle line numbers
nmap <leader>tn :set nu!<CR>


" use clipboard
vmap <leader>y "+y
nmap <leader>y "+y
nmap <leader>p "+p


" move selected lines in visual mode
vnoremap J :move '>+1<CR>gv=gv
vnoremap K :move '<-2<CR>gv=gv


" resizing splits
nnoremap <C-Up> :resize +2<CR>
nnoremap <C-Down> :resize -2<CR>
nnoremap <C-Left> :vertical resize +2<CR>
nnoremap <C-Right> :vertical resize -2<CR>


" better indenting
vnoremap > >gv
vnoremap < <gv


" removes search highlights
nnoremap <leader>h :set hlsearch!<CR>

" delete current buffer
nnoremap <leader>d :bd<CR>

"""""""""""""""""""""""""""""""""""""""""""
"             END OF KEYBINDINGS          "
"""""""""""""""""""""""""""""""""""""""""""




"""""""""""""""""""""""""""""""""""""""""""
"              PLUGIN SETTINGS            "
"""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""
" plugin: todo-comments
lua << EOF
  require("todo-comments").setup {
    signs = false,
  }
EOF

nnoremap <leader>ft <CMD>TodoTelescope<CR>
"""""""""""""""""""""""""


"""""""""""""""""""""""""
" plugin: lualine
lua <<EOF
local colors = {
  bg = "#202328",
  fg = "#bbc2cf",
  yellow = "#e0af68",
  cyan = "#008080",
  darkblue = "#081633",
  green = "#9ECE6A",
  orange = "#FF8800",
  violet = "#a9a1e1",
  magenta = "#c678dd",
  purple = "#c678dd",
  blue = "#7DCFFF",
  red = "#F7768E",
  gray1  = '#5c6370',
  gray2  = '#2c323d',
  gray3  = '#3e4452',
  red1   = '#e06c75',
  red2   = '#be5046',
  white  = '#fff',
  black= '#000',
}

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

local lualine = require('lualine')

local theme = {
  normal = {
    a = { fg = colors.black, bg = colors.yellow},
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.black, bg = colors.black},
  },
  insert = { a = { fg = colors.black, bg = colors.blue } },
  visual = { a = { fg = colors.black, bg = colors.red} },
  replace = { a = { fg = colors.black, bg = colors.green} },
  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.black, bg = colors.black },
  },
}

local config = {
    options= {
      theme = theme,
      icons_enabled = true,
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = { "NvimTree" },
    },
    sections = {
      lualine_a = {
        {
          function()
            return " "
          end,
          padding = { left = 0, right = 0 },
          color = {},
          cond = nil,
        },
      },
      lualine_b = {
        {
          "b:gitsigns_head",
          icon = " ",
          color = { gui = "bold" },
        },
        {
          "filename",
          color = {},
          cond = nil,
        },
      },
      lualine_c = {
        {
            "diff",
            source = diff_source,
            symbols = { added = "  ", modified = "柳", removed = " " },
            diff_color = {
              added = { fg = colors.green },
              modified = { fg = colors.yellow },
              removed = { fg = colors.red },
            },
            color = {},
            cond = nil,
        }
      },
      lualine_x = {
        {
          "diagnostics",
          sources = { "coc" },
          symbols = { error = " ", warn = " ", info = " ", hint = " " },
        },
        "filetype"
      },
      lualine_y = {},
      lualine_z = {
        {
          function()
            local current_line = vim.fn.line "."
            local total_lines = vim.fn.line "$"
            local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
            local line_ratio = current_line / total_lines
            local index = math.ceil(line_ratio * #chars)
            return chars[index]
          end,
          padding = { left = 0, right = 0 },
          color = { fg = colors.yellow, bg = colors.bg},
          cond = nil,
        },
      }
    },
    inactive_sections = {
      lualine_a = {
        "filename",
      },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    extensions = { "nvim-tree" },
}

lualine.setup(config)
EOF
"""""""""""""""""""""""""


"""""""""""""""""""""""""
" plugin: nvim-web-devicons
lua require("nvim-web-devicons").setup()
"""""""""""""""""""""""""


"""""""""""""""""""""""""
" plugin: toggleterm
lua <<EOF
require("toggleterm").setup{
  direction = 'float',
  open_mapping = [[<c-t>]],
}

EOF
"""""""""""""""""""""""""


"""""""""""""""""""""""""
" plugin: surround.nvim
lua <<EOF
require"surround".setup{}
EOF
"""""""""""""""""""""""""


"""""""""""""""""""""""""
" plugin: bufferline
lua <<EOF
require("bufferline").setup({
  options = {
    diagnostics = false,
    show_buffer_close_icons = false,
    show_close_icon = false,
    offsets = {{filetype = "NvimTree", text = "File Explorer" , text_align = "center"}},
  }
})
EOF
nnoremap <Leader>b :BufferLineCyclePrev<CR>
nnoremap <Leader>n :BufferLineCycleNext<CR>
"""""""""""""""""""""""""


"""""""""""""""""""""""""
" plugin: nvim-autopairs
lua require("nvim-autopairs").setup()
"""""""""""""""""""""""""


"""""""""""""""""""""""""
" plugin: colorizer
lua require("colorizer").setup()
"""""""""""""""""""""""""


"""""""""""""""""""""""""
" plugin: gitsigns

lua << EOF
require("gitsigns").setup({
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '▎', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '▎', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '▎', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '▎', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '▎', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
})
EOF
"""""""""""""""""""""""""


"""""""""""""""""""""""""
" plugin: nvim-treesitter

lua << EOF
require('nvim-treesitter.configs').setup {
  ensure_installed = {"javascript", "typescript", "css", "html", "python", "rust"}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
EOF
"""""""""""""""""""""""""


"""""""""""""""""""""""""
" plugin: telescope

lua << EOF
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = require('telescope.actions').close,
      },
    }
  },
}
EOF

nnoremap <c-f> <CMD>Telescope find_files<CR>
nnoremap <c-g> <CMD>Telescope live_grep<CR>
"""""""""""""""""""""""""


"""""""""""""""""""""""""
" plugin: project_nvim
lua require("project_nvim").setup {}
"""""""""""""""""""""""""


"""""""""""""""""""""""""
" plugin: telescope
lua require('telescope').load_extension('projects')
"""""""""""""""""""""""""


"""""""""""""""""""""""""
" plugin: nvim-tree

let g:nvim_tree_show_icons = {
    \ 'git': 0,
    \ 'folders': 1,
    \ 'files': 1,
    \ 'folder_arrows': 1,
    \ }
let g:nvim_tree_quit_on_open = 1
let g:nvim_tree_highlight_opened_files = 1
lua << EOF
require'nvim-tree'.setup {
  open_on_setup = true,
  update_focused_file = {
    enable = true,
  },
	filters = {
					custom = { ".git", "node_modules", ".cache", ".next" }
  }
}
EOF

nnoremap <c-n> :NvimTreeToggle<CR>
"""""""""""""""""""""""""


"""""""""""""""""""""""""
" plugin: Comment.nvim

lua <<EOF
require('Comment').setup()
EOF

nmap <leader>c gcc
vmap <leader>c gc
"""""""""""""""""""""""""


"""""""""""""""""""""""""
" plugin: vim-vsnip

imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

let g:vsnip_filetypes = {}
let g:vsnip_filetypes.javascriptreact = ['javascript']
let g:vsnip_filetypes.typescriptreact = ['typescript']
let g:vsnip_snippet_dir = "~/.config/nvim/snippets"
"""""""""""""""""""""""""


"""""""""""""""""""""""""
" plugin: coc.nvim
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c


" These plugins will be installed automaticly
let g:coc_global_extensions = [
      \'coc-tsserver',
      \'coc-pyright',
      \'coc-rust-analyzer',
      \'coc-markdownlint',
      \'coc-html',
      \'coc-css',
      \'coc-json',
      \'coc-prettier',
      \'coc-eslint',
      \'coc-snippets',
      \'coc-tailwindcss',
      \'coc-prisma',
      \]

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" focus on float window
nmap <leader>fw <Plug>(coc-float-jump)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')


"""""""""""""""""""""""""


"""""""""""""""""""""""""
" plugin: vim-rzip
 
" Decode URI encoded characters
function! DecodeURI(uri)
    return substitute(a:uri, '%\([a-fA-F0-9][a-fA-F0-9]\)', '\=nr2char("0x" . submatch(1))', "g")
endfunction

" Attempt to clear non-focused buffers with matching name
function! ClearDuplicateBuffers(uri)
    " if our filename has URI encoded characters
    if DecodeURI(a:uri) !=# a:uri
        " wipeout buffer with URI decoded name - can print error if buffer in focus
        sil! exe "bwipeout " . fnameescape(DecodeURI(a:uri))
        " change the name of the current buffer to the URI decoded name
        exe "keepalt file " . fnameescape(DecodeURI(a:uri))
        " ensure we don't have any open buffer matching non-URI decoded name
        sil! exe "bwipeout " . fnameescape(a:uri)
    endif
endfunction

function! RzipOverride()
    " Disable vim-rzip's autocommands
    autocmd! zip BufReadCmd   zipfile:*,zipfile:*/*
    exe "au! zip BufReadCmd ".g:zipPlugin_ext

    " order is important here, setup name of new buffer correctly then fallback to vim-rzip's handling
    autocmd zip BufReadCmd   zipfile:*  call ClearDuplicateBuffers(expand("<amatch>"))
    autocmd zip BufReadCmd   zipfile:*  call rzip#Read(DecodeURI(expand("<amatch>")), 1)

    if has("unix")
        autocmd zip BufReadCmd   zipfile:*/*  call ClearDuplicateBuffers(expand("<amatch>"))
        autocmd zip BufReadCmd   zipfile:*/*  call rzip#Read(DecodeURI(expand("<amatch>")), 1)
    endif

    exe "au zip BufReadCmd ".g:zipPlugin_ext."  call rzip#Browse(DecodeURI(expand('<amatch>')))"
endfunction

autocmd VimEnter * call RzipOverride()
"""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""
          " END OF PLUGIN SETTINGS        "
"""""""""""""""""""""""""""""""""""""""""""

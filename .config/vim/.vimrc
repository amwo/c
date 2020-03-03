syntax on

filetype plugin indent on

if has("multi_lang")
    language C
endif

let g:rustfmt_autosave = 1
let g:rustfmt_command = '$HOME/.cargo/bin/rustfmt'
let g:go_fmt_command = "goimports"
let g:go_gocode_unimported_packages = 1
let dart_format_on_save = 1
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let mapleader = "\<Space>"
let loaded_matchparen = 1
let g:vim_jsx_pretty_disable_tsx = 1
let g:vim_jsx_pretty_highlight_close_tag = 1
let g:svelte_indent_script = 0

set runtimepath+=$HOME/.config/vim,$HOME/.config/vim/after
set wildignore+=log/**,tmp/**,target/**,dist/**,.bundle/**,.git/**,node_modules/**
set encoding=utf-8
set fileencodings=utf-8
set fileformats=unix,dos,mac
set nocompatible
set cwh=1
set visualbell t_vb=
set nobackup
set noswapfile
set noerrorbells
set autoread
set hidden
set virtualedit=onemore
set backspace=indent,eol,start
set breakindent
set smartindent
set expandtab
set shiftwidth=4
set tabstop=4
set hlsearch
set incsearch
set whichwrap=b,s,h,l,<,>,[,]
set ignorecase
set pumheight=10
set foldlevel=200
set clipboard+=unnamed
set laststatus=2
set statusline=%f%m%=\ %{&fenc!=''?&fenc:&enc}
set display=lastline

nnoremap <C-n> :bn<cr>
nnoremap <C-p> :bp<cr>
nnoremap <esc><esc> :nohlsearch<cr>
nnoremap <silent>rr :RustRun<cr>
nnoremap <silent>rt :RustTest<cr>
nnoremap <silent>rt :Ctest -- --nocapture<cr>
nnoremap <silent>j gj
nnoremap <silent>k gk
nnoremap <Leader>f :Ex<CR>
nnoremap <Leader>q :q!<CR>
nnoremap <Leader>d :bw!<CR>
nnoremap <Leader>w :Gwrite<CR>
nnoremap <Leader>c :Gcommit<CR>
nnoremap <Leader><Leader> :vim  **<left><left><left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
inoremap <C-h> <Left>
vmap <silent> <expr> p <sid>Repl()

call plug#begin('~/.config/vim/plugins')
Plug 'othree/html5.vim'
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'rust-lang/rust.vim'
Plug 'pangloss/vim-javascript'
Plug 'evanleck/vim-svelte'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'dart-lang/dart-vim-plugin'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'posva/vim-vue'
Plug 'honza/vim-snippets'
Plug 'garbas/vim-snipmate'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'tpope/vim-fugitive'
Plug 'dsawardekar/wordpress.vim'
Plug 'leafgarland/typescript-vim'
call plug#end()

autocmd BufWritePre * :%s/\s\+$//ge
autocmd BufWritePre * call s:remove_line_in_last_line()
autocmd VimEnter,WinEnter,ColorScheme * highlight TrailingSpaces term=underline guibg=Red ctermbg=Red
autocmd VimEnter,WinEnter * match TrailingSpaces /\s\+$/
autocmd FileType netrw setl bufhidden=delete
autocmd QuickFixCmdPost *grep* cwindow
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

function! s:remove_line_in_last_line()
    if getline('$') == ""
        $delete _
    endif
endfunction
function! RestoreRegister()
    let @" = s:restore_reg
    return ''
endfunction
function! s:Repl()
    let s:restore_reg = @"
    return "p@=RestoreRegister()\<cr>"
endfunction

" Utills
function! s:get_syn_id(transparent)
  let synid = synID(line("."), col("."), 1)
  if a:transparent
    return synIDtrans(synid)
  else
    return synid
  endif
endfunction
function! s:get_syn_attr(synid)
  let name = synIDattr(a:synid, "name")
  let ctermfg = synIDattr(a:synid, "fg", "cterm")
  let ctermbg = synIDattr(a:synid, "bg", "cterm")
  let guifg = synIDattr(a:synid, "fg", "gui")
  let guibg = synIDattr(a:synid, "bg", "gui")
  return {
        \ "name": name,
        \ "ctermfg": ctermfg,
        \ "ctermbg": ctermbg,
        \ "guifg": guifg,
        \ "guibg": guibg}
endfunction
function! s:get_syn_info()
  let baseSyn = s:get_syn_attr(s:get_syn_id(0))
  echo "name: " . baseSyn.name .
        \ " ctermfg: " . baseSyn.ctermfg .
        \ " ctermbg: " . baseSyn.ctermbg .
        \ " guifg: " . baseSyn.guifg .
        \ " guibg: " . baseSyn.guibg
  let linkedSyn = s:get_syn_attr(s:get_syn_id(1))
  echo "link to"
  echo "name: " . linkedSyn.name .
        \ " ctermfg: " . linkedSyn.ctermfg .
        \ " ctermbg: " . linkedSyn.ctermbg .
        \ " guifg: " . linkedSyn.guifg .
        \ " guibg: " . linkedSyn.guibg
endfunction
command! SyntaxInfo call s:get_syn_info()

hi clear
hi! link cConstant NONE
hi! netrwTreeBar ctermfg=0 guifg=#ffffff
hi! EndOfBuffer ctermfg=0 guifg=#ffffff
hi Comment ctermfg=234 guifg=#ffffff
"hi! VertSplit ctermbg=NONE guibg=NONE
hi VertSplit cterm=NONE ctermfg=0 ctermbg=NONE
hi Todo ctermfg=199 ctermbg=0 guifg=#ffffff
hi! link Search Todo
hi! link IncSearch Todo
hi StatusLine ctermfg=232 ctermbg=240 guifg=#ffffff
hi StatusLineNC ctermfg=232 ctermbg=234 guifg=#ffffff
hi ModeMsg ctermfg=0 ctermbg=15 guifg=#ffffff
hi! link ErrorMsg ModeMsg
hi! link MoreMsg ModeMsg
hi! link WarningMsg ModeMsg
hi Visual ctermfg=0 ctermbg=15 guifg=#ffffff
hi! String ctermfg=15 guifg=#ffffff
hi! link CursorLine String
hi! link MatchParen String
hi! link SpecialKey String
hi! link NonText String
hi! link Directory String
hi! link LineNr String
hi! link CursorLineNr String
hi! link Question String
hi! link Title String
hi! link VisualNOS String
hi! link WildMenu String
hi! link Folded String
hi! link FoldColumn String
hi! link DiffAdd String
hi! link DiffChange String
hi! link DiffDelete String
hi! link DiffText String
hi! link SignColumn String
hi! link Conceal String
hi! link SpellBad String
hi! link SpellCap String
hi! link SpellRare String
hi! link SpellLocal String
hi! link Pmenu String
hi! link PmenuSel String
hi! link PmenuSbar String
hi! link PmenuThumb String
hi! link TabLine String
hi! link TabLineSel String
hi! link TabLineFill String
hi! link CursorColumn String
hi! link ColorColumn String
hi! link Statement String
hi! link Type String
hi! link Constant String
hi! link Identifier String
hi! link ToolbarLine String
hi! link ToolbarButton String
hi! link Special String
hi! link PreProc String
hi! link Underlined String
hi! link Ignore String
hi! link Error String
hi! link TrailingSpaces String

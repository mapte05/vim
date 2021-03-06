"setting in incompatibility mode with vi
set nocompatible

"Keyboard tweaks
nnoremap <tab> %
vnoremap <tab> %

" Move cursor by display lines when scrolling (helpful for wrapped lines)
nnoremap j gj
nnoremap k gk

"Map , to leader key
let mapleader=','
let g:mapleader = ","

"map ; to : to prevent more key strokes
nnoremap ; :

"Mapping jj sequence to <ESC>
inoremap jj <ESC>
inoremap jk <ESC>O

"Disable the arrow keys to encourage habit of using hjkl
"noremap <Up> <nop>
"noremap <Down> <nop>
"noremap <Left> <nop>
"noremap <Right> <nop>

"Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"Correcting Typos
cmap WQ wq
cmap wQ wq
cmap Tabe tabe
"For better habit
cmap wq x

"insert a newline below current line
nnoremap <CR> <ESC>o<ESC>k
"insert a newline above when pressing shift-enter
nnoremap <S-CR> <ESC>O<ESC>j
"above on itself does not work for iTerm - so this is a hack
"(http://stackoverflow.com/questions/5388562/cant-map-s-cr-in-vim)
nmap ✠ <S-CR>

"zh/zl for subword motion in vim
map <silent> zh :call search("[A-Z]\\\|\\\>","b")<CR>
map <silent> zl :call search("[A-Z]\\\|\\\>","")<CR>

"insert blank space and enter replace mode at cursor location when pressing space in normal mode
nmap <space> i_<ESC>r

"make K behave opposite of J
nmap K i<cr><ESC>k$

"Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

"Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

"searching
set ignorecase "Ignore case while searching
set smartcase
set hlsearch "highlight searched term
set incsearch "find as you type search - incremental search
nmap <silent> <leader>/ :nohlsearch<CR>

"removing toolbars and scrollbars
set guioptions-=T
set guioptions-=r
set guioptions-=L

"no backup file creation
set nobackup
set noswapfile

"Vim to have a large undo buffer, a large history of commands,
set history=1000         "remember more commands and search history
set undolevels=1000      "use many muchos levels of undo

"ignore some file extensions when completing names by pressing Tab, and be
set wildignore=*.swp,*.bak,*.pyc,*.class

"silent about invalid cursor moves and other errors.
set visualbell           "don't beep
set noerrorbells         "don't beep

"change the terminal's title
set title

"hidden allows to edit other files using :e without needing to save current buffer
set hidden


"allow mouse motion
set mouse=a

"Change Working Directory to that of the current file
cmap cwd lcd %:p:h
cmap cd. lcd %:p:h

"Set encodings
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8

"set line numbering to be relative to current line
"set relativenumber : Replaced by plugin: vim-numbertoggle

"add highlight to FIXED to C code // TODO -> make work for python and others
syn keyword cTodo contained TODO FIXME XXX FIXED

"To save as sudo, use :w!!
cmap w!! w !sudo tee >/dev/null "%"

"indentation
set autoindent
set smartindent

"Remove backspace issue - make backspace work like most other apps
set backspace=2

"Do not wrap long lines
"set nowrap

"Color scheme for vim
colorscheme mustang
set t_Co=16

"filetype specific settings
filetype off
filetype plugin indent on
syntax enable

"tabs and other spacing
set expandtab
"these should be overridden in filetype specific syntax files
set tabstop=2
set shiftwidth=2
set softtabstop=2

"map F v%zf
set tags=./tags;/
set autowrite
if has("cscope")
  set csprg=/usr/bin/cscope
  set csto=0
  set cst
  set nocsverb
  "add any database in current directory
  if filereadable("cscope.out")
    cs add cscope.out
    "else add database pointed to by environment
  elseif $CSCOPE_DB != ""
    cs add $CSCOPE_DB
  endif
endif

au BufWinLeave * silent! mkview
au BufWinEnter * silent! loadview

"
""IMPORTANT: grep will sometimes skip displaying the file name if you
""search in a singe file. This will confuse Latex-Suite. Set your grep
""program to always generate a file-name.
set grepprg=grep\ -nH\ $*
"
""OPTIONAL: This enables automatic indentation as you type.
"
""OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults
"to
""'plaintex' instead of 'tex', which results in vim-latex not being loaded.
""The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

""for automatically exiting from scratch preview pane
autocmd CursorMovedI * if pumvisible() == -1|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

"Show mode
set showmode
set showcmd

"search options

"Statusline // use vim airline instead
set laststatus=2    "always show statusline
"set statusline+=%l/%L   "cursor line/total lines
"set statusline+=\ %c,     "cursor column
"set statusline+=\ %P    "percent through file
"set statusline+=\ %t       "tail of the filename
"set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
"set statusline+=%{&ff}] "file format
"set statusline+=%h      "help file flag
"set statusline+=%m      "modified flag
"set statusline+=%r      "read only flag
"set statusline+=%y      "filetype
"set statusline+=%=      "left/right separator

"Resizing horizontal splits
if bufwinnr(1)
    map + <C-W>+
    map - <C-W>-
endif

"auto-read file if modified elsewhere
set autoread

"Fast saving. <leader>w would save the file
nmap <leader>w :w!<cr>

"Highlight current cursor line
set cursorline

"Set 7 lines to the cursor - when moving vertically using j/k
set so=7

"Return to last edit position when opening files (You want this!)
augroup last_edit_pos
    au!
    autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \ exe "normal! g`\""|
     \ endif
augroup END

"CTRL-C, CTRL-X and CTRL-V for copy-cut-pasting to system clipboard
imap <C-v> "+gp
vmap <C-C> "+y
vmap <C-X> "+d
nnoremap <leader>v <C-V>

inoremap " ""<esc>i

"CTRL-A in normal mode for select all
nmap <C-A> <ESC>G$vgg

"Allow backspacing over everything in insertmode
set backspace=indent,eol,start
set whichwrap+=<,>,h,l

"Time out on mapping after two seconds, time out on key codes after
"a tenth of a second
set timeout
set timeoutlen=2000
set ttimeoutlen=100

"code folding stuff
set foldmethod=marker
set foldmethod=indent

"load syntax depending on filetype
" Detect proto files
augroup filetype
au! BufRead,BufNewFile *.proto setfiletype proto
augroup end

"Detect go files
augroup filetype
au! BufRead,BufNewFile *.go setfiletype go
augroup end

"Scons files are python files
augroup filetype
au! BufRead,BufNewFile SConstruct setfiletype python
augroup end
augroup filetype
au!  BufRead,BufNewFile SConscript setfiletype python
augroup end

"Config for GitHub Flavored Markdown
augroup markdown
    au!
    au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END

"Auto-delete any trailing white space on save
autocmd BufWritePre * :%s/\s\+$//e

"----------------- Plugin specific configurations -------------------

"Pathogen - used to manage vim plugins
execute pathogen#infect()
"call pathogen#helptags()

"NERDtree settings
let NERDTreeIgnore=['\.o$', '\~$', '\.pyc$', '\.swp']
"Toggle Nerd tree using F2.
map <F2> :NERDTreeToggle<CR>
"NerdTreeMirrorToggle of nerd-tree-tabs is a smarter option
map <F2> :NERDTreeMirrorToggle<CR>
"Shift-F2 toggles nerdtree in all tabs
map <S-F2> :NerdTreeTabsToggle<CR>
"Don't synchronise view(scroll and cursor position)of different nerdtrees
let g:nerdtree_tabs_synchronize_view=0

"CtrlP configuration
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.m2,*.git  "MacOSX/Linux
let g:ctrlp_map = '<leader>p'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }
"let g:ctrlp_user_command = 'find %s -type f'        "MacOSX/Linux

"Rainbow parantheses (highilighting nested brackets)
au VimEnter * RainbowParenthesesToggleAll
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

"GUndo
nnoremap <F5> :GundoToggle<CR>

"Tagbar
let g:tagbar_ctags_bin='/usr/local/bin/ctags'  "Proper Ctags locations
let g:tagbar_width=40                          "Default is 40, seems too wide
nmap <silent> <leader>y :TagbarToggle<CR><C-w><C-w>

"Command-T settings
let g:CommandTMaxFiles=200000

"YouCompleteMe
let g:ycm_confirm_extra_conf = 0 "Do not ask confirmation when loading conf file from parent
let g:ycm_show_diagnostics_ui = 1 "Show diagnostic UI by default
source /home/abhay/.vim/thoughtspot/copyright.vim

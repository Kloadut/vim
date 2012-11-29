set nocompatible

" VUNDLE : Git bundle manager
"
" mkdir -p ~/.vim/bundle
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
" vim +BundleInstall +qall
"
" {
if filereadable(expand("$HOME/.vim/bundle/vundle/README.md"))
    filetype off " required!

    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()

    " let Vundle manage Vundle
    " required!
    Bundle 'gmarik/vundle'

    Bundle "garbas/vim-snipmate"
    " snipMate dependencies
    Bundle "MarcWeber/vim-addon-mw-utils"
    Bundle "tomtom/tlib_vim"
    Bundle "honza/snipmate-snippets"

    Bundle 'Gundo'
    Bundle 'The-NERD-tree'
    Bundle 'The-NERD-Commenter'
    Bundle 'closetag.vim'
endif
" }

" Load Tomorrow-Night colorscheme if exists, and check if 256colors term
"
" mkdir -p ~/.vim/colors
" wget -O ~/.vim/colors/Tomorrow-Night.vim https://raw.github.com/Kloadut/vim/mini/.vim/colors/Tomorrow-Night.vim
"
" {
if &t_Co > 2
    if filereadable(expand("$VIMRUNTIME/colors/Tomorrow-Night.vim"))
        colorscheme Tomorrow-Night
    elseif filereadable(expand("$HOME/.vim/colors/Tomorrow-Night.vim"))
        colorscheme Tomorrow-Night
    else
        colorscheme default
    endif
endif
" }

syntax on
filetype indent plugin on

if !filewritable($HOME."/.vim/backup")    " if backup directory doesn't exists yet
    call mkdir($HOME."/.vim/backup", "p") " create it
endif
set backup                      " backups are nice ...
set backupdir=~/.vim/backup/
if has('persistent_undo')
    set undofile                " so is persistent undo ...
    set undodir=~/.vim/backup/
    set undolevels=1000         " maximum number of changes that can be undone
    set undoreload=10000        " maximum number lines to save for undo on a buffer reload
endif

set encoding=utf-8
set fileencoding=utf-8
set backspace=indent,eol,start  " backspace for dummies
set linespace=0                 " No extra spaces between rows
set nu                          " Line numbers on
set incsearch                   " find as you type search
set hlsearch                    " highlight search terms
set winminheight=0              " windows can be 0 line high
set ignorecase                  " case insensitive search
set smartcase                   " case sensitive when uc present
set wildmenu                    " show list instead of just completing
set wildmode=list:longest,full  " command <Tab> completion, list matches, then longest common part, then all.
set scrolljump=5                " lines to scroll when cursor leaves screen
set scrolloff=3                 " minimum lines to keep above and below cursor
set foldenable                  " auto fold code
set wrap                        " wrap long lines
set autoindent                  " indent at the same level of the previous line
set shiftwidth=4                " use indents of 4 spaces
set expandtab                   " tabs are spaces, not tabs
set tabstop=4                   " an indentation every four columns
set softtabstop=4               " let backspace delete indent
set ttyfast                     " force redraw of the terminal emulator instead of scrolling
set pastetoggle=<F2>            " Toggle paste-mode

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif

" Remember info about open buffers on close
set viminfo^=%

" Save as root
cab wr w! !sudo tee % > /dev/null

" Splitted window key binding
nmap <C-Up> <C-W>k<C-W>_zz
nmap <C-Down> <C-W>j<C-W>_zz

" Easy access toggle
map <F3> <ESC>:NERDTreeToggle<CR>
map <F4> <ESC>:GundoToggle<CR>

" Gvim options
highlight Normal guifg=gray guibg=#202020
set guioptions=rm
"set cursorline

" MISC
" {
" Every spaces/tabs at the end of line will be highlighted.
au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\s\+$', -1)
map <F5> <ESC>:%s/\s*$//<CR>
" }

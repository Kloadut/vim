set nocompatible        " must be first line

" Windows Compatible {
" On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
" across (heterogeneous) systems easier.
    if has('win32') || has('win64')
      set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
    endif
" }
"
" Setup Bundle Support {
" The next three lines ensure that the ~/.vim/bundle/ system works
    filetype off
    set rtp+=~/.vim/bundle/vundle
    call vundle#rc()
" }

" }

" Bundles {
" Deps
    Bundle 'gmarik/vundle'
    Bundle 'MarcWeber/vim-addon-mw-utils'
    Bundle 'tomtom/tlib_vim'
    if executable('ack-grep')
        let g:ackprg="ack-grep -H --nocolor --nogroup --column"
        Bundle 'mileszs/ack.vim'
    elseif executable('ack')
        Bundle 'mileszs/ack.vim'
    endif

" Use local bundles if available {
    if filereadable(expand("~/.vimrc.bundles.local"))
        source ~/.vimrc.bundles.local
    endif
" }

" In your .vimrc.bundles.local file"
" list only the plugin groups you will use
    if !exists('g:spf13_bundle_groups')
        let g:spf13_bundle_groups=['general', 'programming', 'php', 'ruby', 'python', 'javascript', 'html', 'misc']
    endif

" To override all the included bundles, put
" g:override_spf13_bundles = 1
" in your .vimrc.bundles.local file"
    if !exists("g:override_spf13_bundles")

" General
        if count(g:spf13_bundle_groups, 'general')
            Bundle 'scrooloose/nerdtree'
            Bundle 'tpope/vim-surround'
            "Bundle 'AutoClose' "Make some bugs
            Bundle 'kien/ctrlp.vim'
            Bundle 'matchit.zip'
            Bundle 'Lokaltog/vim-powerline'
            Bundle 'jistr/vim-nerdtree-tabs'
            Bundle 'corntrace/bufexplorer'
            Bundle 'mbbill/undotree'
        endif

" General Programming
        if count(g:spf13_bundle_groups, 'programming')
" Pick one of the checksyntax, jslint, or syntastic
            Bundle 'scrooloose/syntastic'
            Bundle 'garbas/vim-snipmate'
            Bundle 'spf13/snipmate-snippets'
" Source support_function.vim to support snipmate-snippets.
            if filereadable(expand("~/.vim/bundle/snipmate-snippets/snippets/support_functions.vim"))
                source ~/.vim/bundle/snipmate-snippets/snippets/support_functions.vim
            endif

            Bundle 'tpope/vim-fugitive'
            Bundle 'scrooloose/nerdcommenter'
            Bundle 'godlygeek/tabular'
            if executable('ctags')
                Bundle 'majutsushi/tagbar'
            endif
            Bundle 'Shougo/neocomplcache'
        endif

" PHP
        if count(g:spf13_bundle_groups, 'php')
            Bundle 'spf13/PIV'
        endif

" HTML
        if count(g:spf13_bundle_groups, 'html')
            Bundle 'amirh/HTML-AutoCloseTag'
            Bundle 'ChrisYip/Better-CSS-Syntax-for-Vim'
        endif

" Misc
        if count(g:spf13_bundle_groups, 'misc')
            Bundle 'spf13/vim-preview'
        endif

    endif
" }

if has("syntax")
    syntax on
endif

set bg=dark 
set guifont=Monaco\ for\ Powerline\ 9
set ruler
set encoding=utf-8
set fileencoding=utf-8

filetype plugin on

source ~/.color.vim

if !filewritable($HOME."/.vim/backup") " Si le repertoire n'existe pas
call mkdir($HOME."/.vim/backup", "p") " Creation du repertoire de sauvegarde
endif
set backup                      " backups are nice ...
set backupdir=~/.vim/backup/
if has('persistent_undo')
    set undofile                "so is persistent undo ...
    set undodir=~/.vim/backup/
    set undolevels=1000         "maximum number of changes that can be undone
    set undoreload=10000        "maximum number lines to save for undo on a buffer reload   
endif

set backspace=indent,eol,start  " backspace for dummies
set linespace=0                 " No extra spaces between rows
set nu                          " Line numbers on
set mouse=a
set showmatch                   " show matching brackets/parenthesis
set incsearch                   " find as you type search
set hlsearch                    " highlight search terms
set winminheight=0              " windows can be 0 line high
set ignorecase                  " case insensitive search
set smartcase                   " case sensitive when uc present
set wildmenu                    " show list instead of just completing
set wildmode=list:longest,full  " command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]   " backspace and cursor keys wrap to
set scrolljump=5                " lines to scroll when cursor leaves screen
set scrolloff=3                 " minimum lines to keep above and below cursor
set foldenable                  " auto fold code
"set list
"set listchars=tab:,.,trail:.,extends:#,nbsp:. " Highlight problematic whitespace
set cursorline
highlight CursorLine guibg=#000000

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%

" Formatting {
    set nowrap                      " wrap long lines
    set autoindent                  " indent at the same level of the previous line
    set shiftwidth=4                " use indents of 4 spaces
    set expandtab                   " tabs are spaces, not tabs
    set tabstop=4                   " an indentation every four columns
    set softtabstop=4               " let backspace delete indent
    "set matchpairs+=<:>                " match, to be used with %
    set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
    "set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
    " Remove trailing whitespaces and ^M chars
    autocmd FileType c,cpp,java,php,javascript,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'subst$
    autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig
" }

" Key (re)Mappings {

    "The default leader is '\', but many people prefer ',' as it's in a standard
    "location
    let mapleader = ','

    " Making it so ; works like : for commands. Saves typing and eliminates :W style typos due to lazy holding shift.
    nnoremap ; :

    " Wrapped lines goes down/up to next row, rather than next line in file.
    nnoremap j gj
    nnoremap k gk

    " Prevent cursor from moving back one character on insert mode exit
    "inoremap <silent> <Esc> <Esc>`^
    autocmd InsertLeave * :normal `^
    "inoremap <silent> <Esc> <C-O>:stopinsert<CR>

    " For when you forget to sudo.. Really Write the file.
    cmap w!! w !sudo tee % >/dev/null

    " NERDCommenter bind modification
    nmap <S-C> <leader>c<space>
    vmap <S-C> <leader>c<space>

    " Good clipboard management
    nnoremap <C-C> "+yy
    inoremap <C-C> "+yy
    nnoremap <C-X> "+dd
    inoremap <C-X> "+dd
    vnoremap <C-C> "+y
    vnoremap <C-X> "+d
    nnoremap <C-V> "+p
    inoremap <C-V> <ESC>"+p
    vnoremap <C-V> "_d"+p

    " Remap Tab, CR, Backspace & Del to activate insert mode
    nnoremap <Tab> i<Tab>
    nnoremap <CR> i<CR>
    nnoremap <BS> i<BS>
    nnoremap <Del> <Del>i

    " Vimgrep bind
    map <F4> :execute "vimgrep /" . expand("<cword>") . "/j **" <Bar> cw<CR>
" }


" OmniComplete {
    if has("autocmd") && exists("+omnifunc")
        autocmd Filetype *
            \if &omnifunc == "" |
            \setlocal omnifunc=syntaxcomplete#Complete |
            \endif
    endif

    hi Pmenu  guifg=#000000 guibg=#F8F8F8 ctermfg=black ctermbg=Lightgray
    hi PmenuSbar  guifg=#8A95A7 guibg=#F8F8F8 gui=NONE ctermfg=darkcyan ctermbg=lightgray cterm=NONE
    hi PmenuThumb  guifg=#F8F8F8 guibg=#8A95A7 gui=NONE ctermfg=lightgray ctermbg=darkcyan cterm=NONE

    " some convenient mappings (wat ?)
    "inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
    "inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
    "inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
    "inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
    "inoremap <expr> <C-d>      pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
    "inoremap <expr> <C-u>      pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"

    " automatically open and close the popup menu / preview window
    "au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
    "set completeopt=menu,preview,longest
" }


" NerdTree {
    map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
    map <leader>e :NERDTreeFind<CR>
    nmap <leader>nt :NERDTreeFind<CR>

    let NERDTreeShowBookmarks=1
    let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
    let NERDTreeChDirMode=0
    let NERDTreeQuitOnOpen=1
    let NERDTreeShowHidden=1
    let NERDTreeKeepTreeInNewTab=1
" }

" ctrlp {
    let g:ctrlp_working_path_mode = 2
    nnoremap <silent> <D-t> :CtrlP<CR>
    nnoremap <silent> <D-r> :CtrlPMRU<CR>
    let g:ctrlp_custom_ignore = {
        \ 'dir':  '\.git$\|\.hg$\|\.svn$',
        \ 'file': '\.exe$\|\.so$\|\.dll$' }
" }


" TagBar {
    nnoremap <silent> <leader>E :TagbarToggle<CR>
"}


" neocomplcache {
    let g:neocomplcache_enable_at_startup = 1
    let g:neocomplcache_enable_camel_case_completion = 1
    let g:neocomplcache_enable_smart_case = 1
    let g:neocomplcache_enable_underbar_completion = 1
    let g:neocomplcache_min_syntax_length = 3
    let g:neocomplcache_enable_auto_delimiter = 1

    " AutoComplPop like behavior.
    let g:neocomplcache_enable_auto_select = 0

    " SuperTab like snippets behavior.
    imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ?$

    " Plugin key-mappings.
    imap <C-k>     <Plug>(neocomplcache_snippets_expand)
    smap <C-k>     <Plug>(neocomplcache_snippets_expand)
    inoremap <expr><C-g>     neocomplcache#undo_completion()
    inoremap <expr><C-l>     neocomplcache#complete_common_string()


    " <CR>: close popup
    " <s-CR>: close popup and save indent.
    inoremap <expr><CR>  pumvisible() ? neocomplcache#close_popup() : "\<CR>"
    inoremap <expr><Up>  pumvisible() ? neocomplcache#close_popup() : "\<Up>"
    inoremap <expr><Down>  pumvisible() ? neocomplcache#close_popup() : "\<Down>"
    inoremap <expr><s-CR> pumvisible() ? neocomplcache#close_popup() "\<CR>" : "\<CR>"
    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

	" <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
    inoremap <expr><C-y>  neocomplcache#close_popup()
    inoremap <expr><C-e>  neocomplcache#cancel_popup()

    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

    " Enable heavy omni completion.
    if !exists('g:neocomplcache_omni_patterns')
        let g:neocomplcache_omni_patterns = {}
    endif
    let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
    "autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
    let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
    let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
    let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

    " For snippet_complete marker.
    if has('conceal')
        set conceallevel=2 concealcursor=i
    endif

" }

" UndoTree {
	nnoremap <c-u> :UndotreeToggle<CR>
" }


" Ctags {
    set tags=./tags;/,~/.vimtags
" }

" Use local vimrc if available {
    if filereadable(expand("~/.vimrc.local"))
        source ~/.vimrc.local
    endif
" }

" Use local gvimrc if available and gui is running {
    if has('gui_running')
        if filereadable(expand("~/.gvimrc.local"))
            source ~/.gvimrc.local
        endif
    endif
" }

highlight Normal guifg=gray guibg=#202020
set guioptions=
set guioptions+=r

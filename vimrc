" An example for a vimrc file.
"
" Maintainer: Bram Moolenaar <Bram@vim.org>
" Last change: 2008 Dec 17
"
" To use it, copy it to
" for Unix and OS/2: ~/.vimrc
" for Amiga: s:.vimrc
" for MS-DOS and Win32: $VIM\_vimrc
" for OpenVMS: sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start
"do not keep a backup file
"if has("vms")
" set nobackup " do not keep a backup file, use versions instead
"else
" set backup " keep a backup file
"endif
set history=50	" keep 50 lines of command line history
set ruler	" show the cursor position all the time
set showcmd	" display incomplete commands
set incsearch	" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot. Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

" Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

" For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \ exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent	" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
\ | wincmd p | diffthis
endif
"自己添加的一些设置
set number
set showmatch
nnoremap <silent><F4> :TlistToggle<CR>
let Tlist_Ctags_Cmd='ctags'	"可以址接运行
let Tlist_Use_Left_Window=1	"让窗口在在边显示
let Tlist_Show_One_File=0	"让taglist可以同时显示多个文件
let Tlist_File_Fold_Auto_Close=1	"非当前文件，函数列表自动折叠
let Tlist_Exit_OnlyWindow=1	"当 taglist 是最后一个窗口时，自动退出
let Tlist_Process_File_Always=1	"一直实时更新tags
let Tlist_Inc_Winwidth=0
let Tlist_Auto_Open=0
let Tlist_Auto_Update=1
set smartindent
set shellslash
set fencs=utf-8,GB18030,ucs-bom,default,lati
set tags+=tags;
let mapleader=","
nmap <F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
imap <F12> <ESC>:w <CR><F12>
if has("cscope")
set csprg=/usr/bin/cscope
set csto=0
set cst
set nocsverb
" add any database in current directory
if filereadable("cscope.out")
cs add cscope.out
" else add database pointed to by environment
elseif $CSCOPE_DB != ""
cs add $CSCOPE_DB
endif
set csverb
endif

set completeopt=longest,menu
set nowrap
"set cursorline
nmap <F2>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <F2>d :cs find d <C-R>=expand("<cword>")<CR><CR>
nmap <F2>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <F2>f :cs find f <C-R>=expand("<cword>")<CR><CR>
nmap <F2>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <F2>i :cs find i <C-R>=expand("<cword>")<CR><CR>
nmap <F2>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <F2>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <F8> :SrcExplToggle<CR>
let g:SrcExpl_pluginList = [
        \ "__Tag_List__",
        \ "_NERD_tree_",
        \ "Source_Explorer"
    \ ]
set laststatus=2
set statusline=%f
set wildmenu
set wildmode=list:longest
let g:pydiction_location='~/.vim/bundle/Pydiction/complete-dict'

nmap<leader>n :cn<cr>
nmap<leader>p :cp<cr>
nmap<leader>w :cw 10<cr>

"For vundle
set nocompatible	"be iMproved
filetype	off "required!
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarlk/vundle'
"vim-scripts repos
Bundle 'bash-support.vim'
Bundle 'perl-support.vim'
Bundle 'taglist.vim'
Bundle 'The-NERD-tree'
Bundle 'The-NERD-Commenter'
"Bundle 'c.vim'
"Bundle 'OmniCppComplete'
Bundle 'Pydiction'
"to no user ctrl+p
"Bundle 'AutoComplPop'	
Bundle 'python.vim'
"Bundle 'LaTeX-Suite-aka-Vim-LaTeX'
Bundle 'LaTeX-Box-Team/LaTeX-Box'
Bundle 'EasyMotion'
Bundle 'fatih/vim-go'
Bundle 'dgryski/vim-godef'
Bundle 'Blackrush/vim-gocode'
filetype plugin indent on
let g:tex_flavor='latex'
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
"let g:neocomplcache_enable_at_startup = 1

"let g:clang_complete_copen=1
"let g:clang_periodic_quickfix=0
"let g:clang_snippets=1
"let g:clang_close_preview=1
"let g:clang_use_library=1

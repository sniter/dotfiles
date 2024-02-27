set nocompatible              " be iMproved, required
syntax enable
filetype plugin on

set path+=** " Improved search into subfolders
set wildmenu

" Ctags
command! MakeTags !ctags -R .
command! PyTags !ctags -R ctags -R --languages=Python .

" Autoocompletion
set omnifunc=syntaxcomplete#Complete
:inoremap ^] ^X^]
:inoremap ^F ^X^F
:inoremap ^D ^X^D
:inoremap ^L ^X^L
" Netrw
let g:netrw_banner=0
let g:netrw_liststyle= 3
let g:netrw_list_hide=netrw_gitignore#Hide()

" UI
"
colorscheme desert

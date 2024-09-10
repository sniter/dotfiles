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
" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
let s:opam_share_dir = system("opam config var share")
let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

let s:opam_configuration = {}

function! OpamConfOcpIndent()
  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
endfunction
let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

function! OpamConfOcpIndex()
  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
endfunction
let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

function! OpamConfMerlin()
  let l:dir = s:opam_share_dir . "/merlin/vim"
  execute "set rtp+=" . l:dir
endfunction
let s:opam_configuration['merlin'] = function('OpamConfMerlin')

let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
for tool in s:opam_packages
  " Respect package order (merlin should be after ocp-index)
  if count(s:opam_available_tools, tool) > 0
    call s:opam_configuration[tool]()
  endif
endfor
" ## end of OPAM user-setup addition for vim / base ## keep this line
" ## added by OPAM user-setup for vim / ocp-indent ## d980bc1437e6b2aed397437b332a1a2f ## you can edit, but keep this line
if count(s:opam_available_tools,"ocp-indent") == 0
  source "/Users/ilya/.opam/default/share/ocp-indent/vim/indent/ocaml.vim"
endif
" ## end of OPAM user-setup addition for vim / ocp-indent ## keep this line

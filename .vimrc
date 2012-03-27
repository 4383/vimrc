set nocompatible
filetype plugin on
syntax enable

set ignorecase
set ruler
set modeline

" Forcer à montrer la commande qu'on est en train de taper :
set showcmd

set expandtab
set smartindent
set shiftwidth=2
" colorscheme darkblue
colorscheme desert

" jamais de flash :
set vb t_vb=
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp
set fileencodings=utf-8,ucs-bom,default,latin1

" keep at least 5 lines above/below
set scrolloff=5

" 1000 undos
set undolevels=1000


" Pour transférer la ligne en cours dans un fichier temporaire
" qu'on relit dans un autre vim :
" Write
nmap ;w :. w! ~/.vimxfer<CR>
" Read
nmap ;r :r ~/.vimxfer<CR>
" Append 
nmap ;a :. w! >>~/.vimxfer<CR>

nmap <F5> Oecho "<pre>".var_export(<ESC>pA,true)."</pre>";<ESC>
nmap <F6> <ESC><ESC>ev?\$<RETURN>"ayA<RETURN><ESC>^i$this->Dump(<ESC>"apA);<ESC>

set tabstop=2
set nohlsearch
set autoindent
set number
set mouse=a

"########################################
"#
"# Mapper le NERDTree pour accès
"#
"########################################
nmap <silent> <c-n> :NERDTreeToggle<CR>

"########################################
"#
"# Mapper et configurer les ctags
"#
"########################################
let Tlist_Ctags_Cmd = "/usr/bin/ctags"
let Tlist_WinWidth = 50
map <F4> :TlistToggle<cr>
" highlight current line
"set cul
" adjust color
"hi CursorLine term=none cterm=none ctermbg=4

" Tell vim to remember certain things when we exit
"  '10 : marks will be remembered for up to 10 previously edited files
"  "100 : will save up to 100 lines for each register
"  :20 : up to 20 lines of command-line history will be remembered
"  % : saves and restores the buffer list
"  n... : where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

" when we reload, tell vim to restore the cursor to the saved position
augroup JumpCursorOnEdit
 au!
 autocmd BufReadPost *
 \ if expand("<afile>:p:h") !=? $TEMP |
 \ if line("'\"") > 1 && line("'\"") <= line("$") |
 \ let JumpCursorOnEdit_foo = line("'\"") |
 \ let b:doopenfold = 1 |
 \ if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
 \ let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
 \ let b:doopenfold = 2 |
 \ endif |
 \ exe JumpCursorOnEdit_foo |
 \ endif |
 \ endif
 " Need to postpone using "zv" until after reading the modelines.
 autocmd BufWinEnter *
 \ if exists("b:doopenfold") |
 \ exe "normal zv" |
 \ if(b:doopenfold > 1) |
 \ exe "+".1 |
 \ endif |
 \ unlet b:doopenfold |
 \ endif
 augroup END

set backspace=2

inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

autocmd BufNewFile  * silent! 0r ~/.vim/templates/%:e.tpl
autocmd BufNewFile  *.php call search('w', '', line("w$"))

let g:snips_author='Hervé Beraud'

" (!) Ultra important sinon *tous* les mappings sont désactivés :
set nopaste


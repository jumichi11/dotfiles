set noic
set nocompatible
set hidden
set number
set autoindent
set autoread
set showcmd
"クリップボードをWindowsと連携
set clipboard=unnamed
set incsearch
set display=lastline
set tabstop=4
set shiftwidth=4
set autoindent
set smartindent
set nowrap
set tags=$ROOT/tags
set fileencodings=
set fileencodings=cp932,sjis,utf-8
set fileformat=unix
"検索をファイルの先頭へループしない
set nowrapscan
"閉じ括弧が入力されたとき、対応する括弧を表示する
set showmatch
set mouse=a
if has('mac')
	set ttymouse=xterm2
endif
set term=xterm
set hlsearch
set path +=./**
set path +=~/*
set backspace=indent,eol,start
set cursorline
set nobackup
set noswapfile
set ignorecase
set timeoutlen=500
" ステータス行を表示(これをやらないと、1ウィンドウ1バッファだけのときに、ステータスラインが表示できない)
set laststatus=2
" Undo履歴をファイルに保存する
set undofile
syntax on

let mapleader = "\<Space>"

let $ROOT_2017RCV = "~/Develop/2017RCV/branch/AVR_Entry/trunk/src"
let $ROOT_2016RCV = "~/Develop/2016RCV/branch/AVR/Entry_MP/src""
let $ROOT_2016Bar = "~/Develop/2016RCV/branch/SLIM_BAR/SLIM_BAR_MP/src"
let $ROOT_2016Slim = "~/Develop/2016RCV/branch/SLIM_BAR/SLIM_BAR/src"

"AUDIO_PRINT文自動挿入
noremap <Leader>pc OAUDIO_PRINT(COMMAND, "");<ESC>0f"a
noremap <Leader>pd OAUDIO_PRINT_1DWORD(COMMAND, "%d", xxx);<ESC>0f"a
noremap <Leader>px OAUDIO_PRINT_1DWORD(COMMAND, "%x", xxx);<ESC>0f"a

noremap <Leader>w :w!<CR>
noremap <Leader>r :w!<CR>:QuickRun<CR>
noremap <Leader>q :qa!<CR>

"ag設定 検索バッファは保持する
"また、3つ上の階層まではショートカット一発で検索設定できるようにする
noremap <Leader>ag :Unite grep -no-quit -auto-resize -buffer-name=grep-buffer<CR>
noremap <Leader>ac :cd $ROOT/src<CR>:UniteWithCursorWord grep -no-quit -auto-resize -buffer-name=grep-buffer<CR>
noremap <Leader>a0 :cd %:p:h<CR>:UniteWithCursorWord grep -no-quit -auto-resize -buffer-name=grep-buffer<CR>./<CR>
noremap <Leader>a1 :cd %:p:h<CR>:UniteWithCursorWord grep -no-quit -auto-resize -buffer-name=grep-buffer<CR>./../<CR>
noremap <Leader>a2 :cd %:p:h<CR>:UniteWithCursorWord grep -no-quit -auto-resize -buffer-name=grep-buffer<CR>./../../<CR>
noremap <Leader>a3 :cd %:p:h<CR>:UniteWithCursorWord grep -no-quit -auto-resize -buffer-name=grep-buffer<CR>./../../../<CR>

noremap <Leader>bl :Unite bookmark -no-quit -auto-resize<CR>
noremap <Leader>bm :UniteBookmarkAdd<CR><CR><CR>

"カレントフォルダの移動
noremap <Leader>cd :cd %:p:h<CR>:pwd<CR>
noremap <Leader>0 ::pwd<CR>
noremap <Leader>1 :cd ..<CR>:pwd<CR>
noremap <Leader>2 :cd ../..<CR>:pwd<CR>
noremap <Leader>3 :cd ../../..<CR>:pwd<CR>
noremap <Leader>wk :cd ~/work<CR>

"ランダムにカラー変更
noremap <Leader>co :call SetBgColor()<CR>

"VimFiler起動
noremap <Leader>vf :VimFilerSplit .<CR>

"Unite系操作
noremap <Leader>fr :Unite file_mru -auto-resize<CR>
noremap <Leader>ff :Unite find -auto-resize -buffer-name=find-buffer<CR><CR>'*.[ch]'<CR>
"Document検索は検索開始ディレクトリは固定
noremap <Leader>fd :cd ~/Document<CR>:Unite find -auto-resize -default-action=start -buffer-name=doc-buffer<CR><CR>'*.*'<CR>
noremap <Leader>fb :UniteResume
noremap <Leader>fc :echo expand("%:p")<CR>
noremap <Leader>fe :cd %:p:h<CR>:!cygstart .<CR><CR>
noremap <Leader>fn :echo expand('%:p')<CR>
noremap <Leader>fa :cd ~/Document<CR>:Unite find -auto-resize -buffer-name=doc-buffer<CR><CR>'*.*'<CR>

"Helpを引く
noremap <Leader>hh :Unite help -no-quit -tab<CR>
noremap <Leader>hk :UniteWithCursorWord help -no-quit -tab<CR>

"quickhlハイライト操作
let g:quickhl_manual_enable_at_startup = 1
nmap <Space>m <Plug>(quickhl-manual-this)
xmap <Space>m <Plug>(quickhl-manual-this)
nmap <Space>M <Plug>(quickhl-manual-reset)
xmap <Space>M <Plug>(quickhl-manual-reset)

"svn操作
noremap <Leader>sp :cd %:p:h<CR>:!svn diff % > %.patch<CR>
noremap <Leader>sa :cd %:p:h<CR>:normal st<CR>:r!svn log -v<CR>
noremap <Leader>sl :call SvnLog()<CR>
noremap <Leader>sr :cd %:p:h<CR>:!svn revert %<CR>:e!<CR>

"各種計算
noremap <Leader>bc :r!bc<CR>

"Vimwiki
noremap <Leader>wb :VimwikiGoBackLink<CR>
noremap <Leader>wI :normal! i{{file:///C:/cygwin64/home/jkobayashi/vimwiki_html/images/#####.png}}<CR>
noremap <Leader>wp :call VimwikiHtmlPreview_()<CR>
noremap <Leader>wb :VimwikiGoBackLink<CR>

"クリップボード動作
vnoremap <Leader>pc :w !cat > /dev/clipboard<CR>
noremap <Leader>pp :r !cat /dev/clipboard<CR>

let g:vimwiki_dir_link = 'index'

function! VimwikiHtmlPreview_()
	let curr_file_path = expand("%:p")
	let html_path = substitute(curr_file_path, '\.wiki', '\.html', "g")
	let html_path = substitute(html_path, "vimwiki", "vimwiki_html", "g")
	echo html_path
	execute "!cygstart " . html_path
endfunction

"Vimwikiでvfile:でファイルを開く
function! VimwikiLinkHandler(link)
    " Use Vim to open external files with the 'vfile:' scheme.  E.g.:
    "   1) [[vfile:~/Code/PythonProject/abc123.py]]
    "   2) [[vfile:./|Wiki Home]]
    let link = a:link
    if link =~# '^vfile:'
        let link = link[1:]
    else
        return 0
    endif
    let link_infos = vimwiki#base#resolve_link(link)
    if link_infos.filename == ''
        echomsg 'Vimwiki Error: Unable to resolve link!'
        return 0
    else
        " exe 'tabnew ' . fnameescape(link_infos.filename)
        echomsg fnameescape(link_infos.filename)
        call system("cygstart ".fnameescape(link_infos.filename))
        return 1
    endif
endfunction

noremap @mk :cd %:p:h<CR>:make!<CR>
noremap @mm :Unite mark -no-quit -auto-resize<CR>
noremap @ne :NERDTreeToggle<CR>
noremap @pv :cd %:p:h<CR>:!cygstart "%:r.html"<CR>
noremap @qr :QuickRun<CR>
noremap @tb :normal V<CR>:Tab /\|<CR>
noremap @vs :VimShell<CR>
vnoremap @t= :S/\s+/ /g<CR>gv:Tab / /l0<CR>gv:Tab /\s*\zs=<CR>:normal gv=<CR>

" Tab /| で、自動補正を開始するためのスmpクリプト
noremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

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
" Tab /| で、自動補正を開始するためのスクリプト、ここまで

noremap G Gzz
noremap n nzz
noremap N Nzz
noremap * *zz
noremap [[ [[zz
noremap ]] ]]zz
noremap <C-u> <C-u>zz
noremap <C-d> <C-d>zz
noremap <silent><Esc><Esc> :nohlsearch<CR>

nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap sn gt
nnoremap sp gT
nnoremap sr <C-w>r
nnoremap s= <C-w>=
nnoremap sw <C-w>w
nnoremap so <C-w>_<C-w>|
nnoremap sO <C-w>=
nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>
nnoremap st :<C-u>tabnew<CR>
nnoremap sd :<C-u>tabnew<CR>:set filetype=drawit<CR>
nnoremap sc :<C-u>tabc<CR>
nnoremap sT :<C-u>Unite tab<CR>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>q!<CR>
nnoremap sb :<C-u>bd!<CR>

"windowを開くと外部からのファイル変更確認
augroup vimrc-checktime
  autocmd!
  autocmd WinEnter * checktime
augroup END

" unite.vim に action を追加する
" unite-action start
let start = {
      \ 'description' : 'start {word}',
      \ 'is_selectable' : 1,
      \ }
function! start.func(candidates)"{{{
  for l:candidate in a:candidates
    call system("cygstart ".l:candidate.action__path)
  endfor
endfunction"}}}
unlet start

" insert modeで開始
let g:unite_enable_start_insert = 0

" 大文字小文字を区別しない
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1

" unite grep に ag(The Silver Searcher) を使う
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif

" let g:extra_whitespace_ignored_filetypes = ['unite', 'calendar', 'drawit']
let g:better_whitespace_filetypes_blacklist=['unite', 'calendar', 'drawit']

inoreabbrev <expr> /** "/**<CR>TODO(no comment)<CR>@author ".expand('$USER')."<CR>@param TODO(no comment)<CR>@return TODO(no comment)<CR>/"

" "neocomplcache
" let g:neocomplcache_enable_at_startup = 1
" 起動時に有効化
let g:neocomplete#enable_at_startup = 1

function! IncludeGuard()
	let fl = getline(1)
	if fl =~ "^#if"
		return
	endif
	let gatename = substitute(toupper(expand("%:t")), '\.', '_', 'g')
	normal! gg
	execute "normal! i#ifndef " . "_" . gatename . "_"
	execute "normal! o#define " . "_" . gatename . "_"
	execute "normal! Go#endif /* " . "_" . gatename . "_ */"
endfunction

function! SvnLog()
	let _filename = expand('%')
	echo _filename
	tabnew
	execute "r!svn log -v ". _filename
	normal! gg
endfunction

augroup MY_AUTO_CMD
	autocmd!
	"asciidocファイル保存時、変換処理を起動する
	autocmd BufWritePost,FileWritePost *.asciidoc execute 'silent !asciidoc -a icons -b xhtml11 %:p'
	autocmd BufWritePost,FileWritePost *.asciidoc execute 'silent !cygstart %:r.html'
	autocmd BufWritePost,FileWritePost *.pu execute '!plantuml.sh %:p'
	autocmd BufWritePost,FileWritePost *.tc execute '!tcbmp.exe `cygpath -w %:p` `cygpath -w ./images/%:r.bmp`'
	autocmd BufWritePost,FileWritePost *.wiki execute 'Vimwiki2HTML'
	autocmd BufRead,BufNewFile *.diag           set filetype=blockdiag
	autocmd BufWritePost,FileWritePost *.diag execute '!blockdiag %'
	" autocmd BufWritePost,FileWritePost *.wiki execute 'VimwikiAll2HTML'
	"git
	autocmd FileType gitcommit setlocal fenc=utf-8
	autocmd FileType gitcommit setlocal ff=unix
	"vimwiki
	autocmd FileType vimwiki setlocal fenc=utf-8
	autocmd FileType vimwiki setlocal ff=unix
	"include guardの作成
	autocmd BufNewFile *.h call IncludeGuard()
	"_test.ファイルのテンプレート
	autocmd BufNewFile *_test.c r $VIM/testsuite
	"asciidocファイルのテンプレート
	autocmd BufNewFile *.asciidoc r ~/.asciidoc_templete
	"行末の空白削除
	" autocmd BufWritePost,FileWritePost *.[ch] execute 'FixWhitespace'
augroup END

"ctrlp キャッシュは削除しない
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'

"neosnippet
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable() <Bar><bar> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable() <Bar><bar> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" For snippet_complete marker.
if has('conceal')
	set conceallevel=2 concealcursor=i
endif

let &t_SI .= "\e[<r"
let &t_EI .= "\e[<s\e[<0t"
let &t_te .= "\e[<0t\e[<s"

"カーソル形状変更
"TeraTermで設定→その他の設定→制御シーケンス→カーソル形状/形状変更制御シーケンスをOnとすること
let &t_SI .= "\e[3 q"
let &t_EI .= "\e[1 q"

" " vim-indent-guides
" let g:indent_guides_enable_on_vim_startup=1
" let g:indent_guides_guide_size=1
" let g:indent_guides_auto_colors=0
" autocmd VimEnter,ColorScheme * :hi IndentGuidesOdd ctermbg=234
" autocmd VimEnter,ColorScheme * :hi IndentGuidesEven ctermbg=235

"NERDTreeの設定
" autocmd VimEnter * execute 'NERDTreeToggle'
"Tlistの設定
let Tlist_Auto_Open = 1
let Tlist_Show_One_File = 1
let Tlist_Use_Right_Window = 1
let Tlist_Exit_OnlyWindow = 1
"autocmd VimEnter * execute 'Tlist'

"clang_formtの設定
let g:clang_format#style_options = {
			\ "BasedOnStyle" : "Google",
			\ "BreakBeforeBraces" : "Linux"}
" autocmd BufWrite *.[ch] execute 'ClangFormat'
" autocmd BufWrite *.[ch] execute 'normal ggVG='
map @cl <Plug>(operator-clang-format)


"Ctags
let g:auto_ctags = 1

" vimを辞める時に自動保存
let g:session_autosave = 'yes'
" 引数なしでvimを起動した時にsession保存ディレクトリのdefault.vimを開く
" let g:session_autoload = 'yes'
" 10分間に1回自動保存
let g:session_autosave_periodic = 10

"vimwiki設定
let g:vimwiki_url_maxsave = 128
let g:vimwiki_html_header_numbering = 2

let g:airline_enable_branch = 0
let g:airline_section_b = "%t %M"
let g:airline_section_c = "%{fugitive#statusline()}"
let s:sep = " %{get(g:, 'airline_right_alt_sep', '')} "
let g:airline_section_x =
			\ "%{strlen(&fileformat)?&fileformat:''}".s:sep.
			\ "%{strlen(&fenc)?&fenc:&enc}".s:sep.
			\ "%{strlen(&filetype)?&filetype:'no ft'}"
let g:airline_section_y = '%3p%%'
let g:airline_section_z = get(g:, 'airline_linecolumn_prefix', '').'%3l:%-2v'
let g:airline#extensions#whitespace#enabled = 0
let g:airline_left_sep = ' '
let g:airline_right_sep = ' '

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath^=/home/jkobayashi/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin(expand('/home/jkobayashi/.cache/dein'))

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')

" Add or remove your plugins here:

call dein#add('Drawit')
call dein#add('Shougo/neocomplete.vim')
call dein#add('Shougo/neomru.vim')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/unite.vim')
call dein#add('Shougo/vimfiler.vim')
call dein#add('Shougo/vimproc.vim')
call dein#add('Shougo/vimshell.vim')
call dein#add('Shougo/unite-outline')
call dein#add('adinapoli/vim-markmultiple')
call dein#add('ag.vim')
call dein#add('aklt/plantuml-syntax')
call dein#add('aohta/blockdiag.vim')
call dein#add('bling/vim-airline')
" call dein#add('ciaranm/inkpot')
call dein#add('cohama/agit.vim')
" call dein#add('ctrlpvim/ctrlp.vim')
call dein#add('dagwieers/asciidoc-vim')
call dein#add('godlygeek/tabular')
" call dein#add('itchyny/calendar.vim')
call dein#add('junegunn/vim-easy-align')
call dein#add('kana/vim-operator-user')
call dein#add('kana/vim-smartchr')
call dein#add('kana/vim-smartinput')
" call dein#add('mattn/webapi-vim')
call dein#add('nathanaelkane/vim-indent-guides')
call dein#add('ngmy/vim-rubocop')
call dein#add('ntpeters/vim-better-whitespace')
call dein#add('othree/eregex.vim')
call dein#add('rhysd/vim-clang-format')
call dein#add('ruby-matchit')
" call dein#add('scrooloose/nerdtree')
call dein#add('scrooloose/syntastic')
call dein#add('soramugi/auto-ctags.vim')
call dein#add('t9md/vim-quickhl')
" call dein#add('thinca/vim-ref')
call dein#add('tomtom/tcomment_vim')
call dein#add('tpope/vim-dispatch')
call dein#add('tpope/vim-endwise.git')
call dein#add('tpope/vim-fugitive')
call dein#add('tpope/vim-markdown')
call dein#add('tpope/vim-surround')
call dein#add('tpope/vim-unimpaired')
call dein#add('vcscommand.vim')
call dein#add('vim-scripts/TagHighlight')
call dein#add('vim-scripts/a.vim')
call dein#add('vim-scripts/phd')
call dein#add('vim-scripts/taglist.vim')
call dein#add('vimwiki/vimwiki')
call dein#add('tsukkee/unite-help')
call dein#add('alpaca-tc/alpaca_tags')
call dein#add('xolox/vim-misc')
call dein#add('thinca/vim-quickrun')
call dein#add('vim-scripts/ifdef-highlighting')
call dein#add('xolox/vim-session', {
			\ 'depends': ['xolox/vim-misc']})

" Required:
call dein#end()

" Required:
filetype plugin indent on

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

set grepprg=grep\ -nH

let &t_Co=256
colorscheme jellybean_gui
syntax on

set t_ut=

"乱数生成
function! SetBgColor()
		execute 'colorscheme badwolf_gui'
	" let match_end = matchend(reltimestr(reltime()), '\d\+\.') + 1
	" let rand = reltimestr(reltime())[l:match_end : ] % (10 + 1)
	" if rand == 0
	" 	execute 'colorscheme inkpot_gui'
	" elseif rand == 1
	" 	execute 'colorscheme jellybean_gui'
	" elseif rand == 2
	" 	execute 'colorscheme Tomorrow-Night-Blue_gui'
	" elseif rand == 3
	" 	execute 'colorscheme atmo-dark-256_gui'
	" elseif rand == 4
	" 	execute 'colorscheme badwolf_gui'
	" else
	" 	execute 'colorscheme Tomorrow-Night-Blue_gui'
	" endif
endfunction



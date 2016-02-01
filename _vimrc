set noic
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
" set tags=./tags,../tags,../../tags,../../../tags,tags;
set tags=$AUDIO_ROOT/../../tags
set fileencodings=
set fileencodings=cp932,sjis,utf-8
set fileformat=unix
"検索をファイルの先頭へループしない
"(test)set nowrapscan
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
set noswapfile
set nobackup
set timeoutlen=500
" ステータス行を表示(これをやらないと、1ウィンドウ1バッファだけのときに、ステータスラインが表示できない)
set laststatus=2
" Undo履歴をファイルに保存する
set undofile
syntax on

noremap @ac OAUDIO_PRINT(COMMAND, "");<ESC>0f"a
noremap @ad OAUDIO_PRINT_1DWORD(COMMAND, "%d", xxx);<ESC>0f"a
noremap @ax OAUDIO_PRINT_1DWORD(COMMAND, "%x", xxx);<ESC>0f"a
noremap @ag :cd %:p:h<CR>:Unite grep -no-quit -auto-resize<CR>
noremap @bd :bd!<CR>
noremap @cd :cd %:p:h<CR>
noremap @dir :echo expand("%:p")<CR>
noremap @en :EvervimNotebookList<CR>
noremap @md :cd %:p:h<CR>:!cygstart .<CR><CR>
noremap @mk :!make<CR>
noremap @mk :cd %:p:h<CR>:make!<CR>
noremap @ne :NERDTreeToggle<CR>
noremap @pf :cd %:p:h<CR>:!svn diff % > %.patch<CR>
noremap @pv :cd %:p:h<CR>:!cygstart "%:r.html"<CR>
noremap @qr :QuickRun<CR>
noremap @sa :cd $AUDIO_ROOT<CR>:normal st<CR>:r!svn log -v<CR>
noremap @sl :call SvnLog()<CR>
noremap @sr :cd %:p:h<CR>:!svn revert %<CR>:e!<CR>
noremap @tb :normal V<CR>:Tab /\|<CR>
noremap @ub :Unite buffer -auto-resize<CR>
noremap @uc :cd %:p:h<CR>:Unite find -auto-resize -no-quit<CR><CR>'*.*'
noremap @uf :cd $AUDIO_ROOT/../../../..<CR>:Unite find -auto-resize -no-quit<CR><CR>'*.c'
noremap @ur :Unite file_mru -auto-resize<CR>
noremap @ut :cd %:p:h<CR>:e ./TestCode/%:r_test.c<CR>:cd %:p:h<CR>
noremap @vs :VimShell<CR>
noremap @wb :VimwikiGoBackLink<CR>
noremap @wk :cd ~/work<CR>
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

nnoremap @ud :<C-u>Unite
      \ -start-insert -default-action=vimfiler
      \ directory directory_mru directory_rec/async
      \ <CR>


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
nnoremap so <C-w>_<C-w>|
nnoremap sO <C-w>=
nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>
nnoremap st :<C-u>tabnew<CR>
nnoremap sd :<C-u>tabnew<CR>:set filetype=drawit<CR>
nnoremap sc :<C-u>tabc<CR>
nnoremap sT :<C-u>Unite tab<CR>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>
nnoremap sb :<C-u>Unite buffer_tab -buffer-name=file<CR>
nnoremap sB :<C-u>Unite buffer -buffer-name=file<CR>
nnoremap sd :<C-u>tabnew<CR>:set filetype=drawit<CR>

"windowを開くと外部からのファイル変更確認
augroup vimrc-checktime
  autocmd!
  autocmd WinEnter * checktime
augroup END

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

"neocomplcache
let g:neocomplcache_enable_at_startup = 1

"ctrlp キャッシュは削除しない
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'

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
"quickhl
nmap <Space>m <Plug>(quickhl-toggle)
xmap <Space>m <Plug>(quickhl-toggle)
nmap <Space>M <Plug>(quickhl-reset)
xmap <Space>M <Plug>(quickhl-reset)
nmap <Space>j <Plug>(quickhl-match)

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
let g:session_autoload = 'yes'
" 10分間に1回自動保存
let g:session_autosave_periodic = 10

"vimwiki設定
let g:vimwiki_url_maxsave = 128
let g:vimwiki_html_header_numbering = 2

"quickhl
nmap <Space>m <Plug>(quickhl-manual-this)
xmap <Space>m <Plug>(quickhl-manual-this)
nmap <Space>M <Plug>(quickhl-manual-reset)
xmap <Space>M <Plug>(quickhl-manual-reset)

nmap <Space>j <Plug>(quickhl-cword-toggle)
nmap <Space>] <Plug>(quickhl-tag-toggle)

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

" set omnifunc=OmniSharp#Complete
"
" "if !exists('g:neocomplcache_force_omni_patterns')
" "  let g:neocomplcache_force_omni_patterns = {}
" "endif
" "let g:neocomplcache_force_omni_patterns.cs = '[^.]\.\%(\u\{2,}\)\?'
"
" " OmniSharp won't work without this setting
" filetype plugin on
"
" "This is the default value, setting it isn't actually necessary
" let g:OmniSharp_host = "http://localhost:2000"
"
" "Set the type lookup function to use the preview window instead of the status line
" "let g:OmniSharp_typeLookupInPreview = 1
"
" "Timeout in seconds to wait for a response from the server
" let g:OmniSharp_timeout = 1
"
" "Showmatch significantly slows down omnicomplete
" "when the first match contains parentheses.
" set noshowmatch
"
" "Super tab settings - uncomment the next 4 lines
" "let g:SuperTabDefaultCompletionType = 'context'
" "let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
" "let g:SuperTabDefaultCompletionTypeDiscovery = ["&omnifunc:<c-x><c-o>","&completefunc:<c-x><c-n>"]
" "let g:SuperTabClosePreviewOnPopupClose = 1
"
" "don't autoselect first item in omnicomplete, show if only one item (for preview)
" "remove preview if you don't want to see any documentation whatsoever.
" set completeopt=longest,menuone,preview
" " Fetch full documentation during omnicomplete requests.
" " There is a performance penalty with this (especially on Mono)
" " By default, only Type/Method signatures are fetched. Full documentation can still be fetched when
" " you need it with the :OmniSharpDocumentation command.
" " let g:omnicomplete_fetch_documentation=1
"
" "Move the preview window (code documentation) to the bottom of the screen, so it doesn't move the code!
" "You might also want to look at the echodoc plugin
" set splitbelow
"
" " Get Code Issues and syntax errors
" let g:syntastic_cs_checkers = ['syntax', 'semantic', 'issues']
"
" augroup omnisharp_commands
" 	autocmd!
"
" 	"Set autocomplete function to OmniSharp (if not using YouCompleteMe completion plugin)
" 	autocmd FileType cs setlocal omnifunc=OmniSharp#Complete
"
" 	" Synchronous build (blocks Vim)
" 	"autocmd FileType cs nnoremap <F5> :wa!<cr>:OmniSharpBuild<cr>
" 	" Builds can also run asynchronously with vim-dispatch installed
" 	autocmd FileType cs nnoremap <leader>b :wa!<cr>:OmniSharpBuildAsync<cr>
" 	" automatic syntax check on events (TextChanged requires Vim 7.4)
" 	autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck
"
" 	" Automatically add new cs files to the nearest project on save
" 	autocmd BufWritePost *.cs call OmniSharp#AddToProject()
"
" 	"show type information automatically when the cursor stops moving
" 	autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()
"
" 	"The following commands are contextual, based on the current cursor position.
"
" 	autocmd FileType cs nnoremap gd :OmniSharpGotoDefinition<cr>
" 	autocmd FileType cs nnoremap <leader>fi :OmniSharpFindImplementations<cr>
" 	autocmd FileType cs nnoremap <leader>ft :OmniSharpFindType<cr>
" 	autocmd FileType cs nnoremap <leader>fs :OmniSharpFindSymbol<cr>
" 	autocmd FileType cs nnoremap <leader>fu :OmniSharpFindUsages<cr>
" 	autocmd FileType cs nnoremap <leader>fm :OmniSharpFindMembers<cr> "finds members in the current buffer
" 	" cursor can be anywhere on the line containing an issue
" 	autocmd FileType cs nnoremap <leader>x  :OmniSharpFixIssue<cr>
" 	autocmd FileType cs nnoremap <leader>fx :OmniSharpFixUsings<cr>
" 	autocmd FileType cs nnoremap <leader>tt :OmniSharpTypeLookup<cr>
" 	autocmd FileType cs nnoremap <leader>dc :OmniSharpDocumentation<cr>
" 	autocmd FileType cs nnoremap <C-K> :OmniSharpNavigateUp<cr> "navigate up by method/property/field
" 	autocmd FileType cs nnoremap <C-J> :OmniSharpNavigateDown<cr> "navigate down by method/property/field
"
" augroup END
"
"
" " this setting controls how long to wait (in ms) before fetching type / symbol information.
" set updatetime=500
" " Remove 'Press Enter to continue' message when type information is longer than one line.
" set cmdheight=2
"
" " Contextual code actions (requires CtrlP)
" nnoremap <leader><space> :OmniSharpGetCodeActions<cr>
" " Run code actions with text selected in visual mode to extract method
" vnoremap <leader><space> :call OmniSharp#GetCodeActions('visual')<cr>
"
" " rename with dialog
" nnoremap <leader>nm :OmniSharpRename<cr>
" nnoremap <F2> :OmniSharpRename<cr>
" " rename without dialog - with cursor on the symbol to rename... ':Rename newname'
" command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")
"
" " Force OmniSharp to reload the solution. Useful when switching branches etc.
" nnoremap <leader>rl :OmniSharpReloadSolution<cr>
" nnoremap <leader>cf :OmniSharpCodeFormat<cr>
" " Load the current .cs file to the nearest project
" nnoremap <leader>tp :OmniSharpAddToProject<cr>
"
" " (Experimental - uses vim-dispatch or vimproc plugin) - Start the omnisharp server for the current solution
" nnoremap <leader>ss :OmniSharpStartServer<cr>
" nnoremap <leader>sp :OmniSharpStopServer<cr>
"
" " Add syntax highlighting for types and interfaces
" nnoremap <leader>th :OmniSharpHighlightTypes<cr>
" "Don't ask to save when changing buffers (i.e. when jumping to a type definition)
set hidden

set nocompatible
filetype plugin indent off

if has('vim_starting')
	set runtimepath+=$VIMRUNTIME/bundle/neobundle.vim
endif

call neobundle#begin(expand('$VIMRUNTIME/bundle'))

NeoBundleFetch 'Shougo/neobundle.vim'

"以下は必要に応じて追加
NeoBundle 'Shougo/vimproc', {
			\ 'build' : {
			\ 'windows' : 'make -f make_mingw32.mak',
			\ 'cygwin' : 'make -f make_cygwin.mak',
			\ 'mac' : 'make -f make_mac.mak',
			\ 'unix' : 'make -f make_unix.mak',
			\ },
			\ }

" NeoBundleLazy 'nosami/Omnisharp', {
" 			\   'autoload': {'filetypes': ['cs']},
" 			\   'build': {
" 			\     'windows': 'MSBuild server/OmniSharp.sln',
" 			\     'cygwin': 'MSBuild server/OmniSharp.sln',
" 			\     'mac': 'xbuild server/OmniSharp.sln',
" 			\     'unix': 'xbuild server/OmniSharp.sln',
" 			\ }
" 			\ }
"OmniSharpに必要
NeoBundle 'scrooloose/syntastic'
NeoBundle 'tpope/vim-dispatch'

NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/neocomplcache'

NeoBundle 'scrooloose/nerdtree'

" 行末の半角スペースを可視化
" NeoBundle 'bronson/vim-trailing-whitespace'
NeoBundle 'ntpeters/vim-better-whitespace'

NeoBundle 't9md/vim-quickhl'
NeoBundle 'kana/vim-smartinput'
NeoBundle 'kana/vim-smartchr'
NeoBundle 'vim-scripts/TagHighlight'
NeoBundle 'vim-scripts/taglist.vim'
NeoBundle 'vim-scripts/a.vim'
NeoBundle 'othree/eregex.vim'
" NeoBundle 'osyo-manga/vim-over'
NeoBundle 'Shougo/vimproc.vim'
NeoBundle 'bling/vim-airline'
NeoBundle 'tpope/vim-surround'
" NeoBundle 'visualmark.vim'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'aklt/plantuml-syntax'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'rhysd/vim-clang-format'
NeoBundle 'kana/vim-operator-user'
NeoBundle 'soramugi/auto-ctags.vim'
NeoBundle 'vim-scripts/guicolorscheme.vim'
" NeoBundle 'altercation/vim-colors-solarized.vim'
NeoBundle 'tpope/vim-pathogen.vim'
NeoBundle 'Shougo/vimshell.vim'
" NeoBundle 'kakkyz81/evervim'
" NeoBundle 'ack.vim'
NeoBundle 'ag.vim'
" NeoBundle 'jacquesbh/vim-showmarks'
" NeoBundle 'kannokanno/previm'
NeoBundle 'adinapoli/vim-markmultiple'
NeoBundle 'dagwieers/asciidoc-vim'
" NeoBundle 'chikamichi/mediawiki.vim'
NeoBundle 'vcscommand.vim'
NeoBundle 'aohta/blockdiag.vim'
NeoBundle 'jellybeans.vim'
NeoBundle 'ciaranm/inkpot'
NeoBundle 'vim-scripts/phd'
" NeoBundle 'godlygeek/csapprox'
NeoBundle 'xolox/vim-session', {
            \ 'depends' : 'xolox/vim-misc',
          \ }
NeoBundle 'godlygeek/tabular'
NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'cohama/agit.vim'
NeoBundle 'vimwiki/vimwiki'
NeoBundle 'itchyny/calendar.vim'
NeoBundle 'tacroe/unite-mark'
" NeoBundle 'mattn/googletranslate-vim'
" NeoBundle 'translategoogle.vim'
" NeoBundle 'mattn/webapi-vim'                                " 翻訳プラグインに必要
" NeoBundle 'mattn/excitetranslate-vim'
"ruby関連
NeoBundle 'ngmy/vim-rubocop'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'ruby-matchit'
NeoBundle 'tpope/vim-endwise.git'
NeoBundle 'thinca/vim-ref'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'Drawit'
call neobundle#end()
filetype plugin indent on

NeoBundleCheck

set grepprg=grep\ -nH

let &t_Co=256
colorscheme jellybean_gui

set t_ut=

" test


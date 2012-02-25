"-------------------------------------------------------------------------------
" 基本設定 Basics
"-------------------------------------------------------------------------------
set nocompatible                 " vi互換を捨てる
set scrolloff=999                " スクロール時の余白確保
set textwidth=0                  " 一行に長い文章を書いていても自動折り返しをしない
set nowrap                       " 自動折り返しをしない
set nobackup                     " バックアップ取らない
set autoread                     " 他で書き換えられたら自動で読み直す
set noswapfile                   " スワップファイル作らない
set hidden                       " 編集中でも他のファイルを開けるようにする
set backspace=indent,eol,start   " バックスペースでなんでも消せるように
set formatoptions=lmoq           " テキスト整形オプション，マルチバイト系を追加
set vb t_vb=                     " ビープをならさない
set browsedir=buffer             " Exploreの初期ディレクトリ
set whichwrap=b,s,h,l,<,>,[,]    " カーソルを行頭、行末で止まらないようにする
set showcmd                      " コマンドをステータス行に表示
set showmode                     " 現在のモードを表示
set viminfo='50,<1000,s100,\"50  " viminfoファイルの設定
set modelines=0                  " モードラインは無効
set nowrap                       " 行を折り返さない

" ターミナルでマウスを使用できるようにする
set mouse=a
set guioptions& guioptions+=a
set ttymouse=xterm2

"ヤンクした文字は、システムのクリップボードに入れる"
set clipboard=unnamed
" 挿入モードでCtrl+kを押すとクリップボードの内容を貼り付けられるようにする "
imap <C-K>  <ESC>"*pa

" Reloadbleにするためにautocmdを自分用に用意
augroup Mine
  autocmd!
augroup END

" Ev/Rvでvimrcの編集と反映
command! Ev edit $MYVIMRC
command! Rv source $MYVIMRC
"-------------------------------------------------------------------------------
" ステータスライン StatusLine
"-------------------------------------------------------------------------------
set laststatus=2 " 常にステータスラインを表示

"ステータスラインに文字コードと改行文字を表示する
if winwidth(0) >= 120
  set statusline=%<[%n]%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%y\ %F%=[%{GetB()}]\ %l,%c%V%8P
else
  set statusline=%<[%n]%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%y\ %f%=[%{GetB()}]\ %l,%c%V%8P
endif

function! GetB()
  let c = matchstr(getline('.'), '.', col('.') - 1)
  let c = iconv(c, &enc, &fenc)
  return String2Hex(c)
endfunction
" help eval-examples
" The function Nr2Hex() returns the Hex string of a number.
func! Nr2Hex(nr)
  let n = a:nr
  let r = ""
  while n
    let r = '0123456789ABCDEF'[n % 16] . r
    let n = n / 16
  endwhile
  return r
endfunc
" The function String2Hex() converts each character in a string to a two
" character Hex string.
func! String2Hex(str)
  let out = ''
  let ix = 0
  while ix < strlen(a:str)
    let out = out . Nr2Hex(char2nr(a:str[ix]))
    let ix = ix + 1
  endwhile
  return out
endfunc
"-------------------------------------------------------------------------------
" 表示 Apperance
"-------------------------------------------------------------------------------
set showmatch         " 括弧の対応をハイライト
set number            " 行番号表示
set list              " 不可視文字表示
set listchars=tab:._,trail:_,extends:>,precedes:< " 不可視文字の表示形式
set display=uhex      " 印字不可能文字を16進数で表示

" 全角スペースの表示
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
match ZenkakuSpace /　/

" カレントウィンドウにのみ罫線を引く
autocmd Mine WinLeave * set nocursorline
autocmd Mine WinEnter,BufRead * set cursorline

:hi clear CursorLine
:hi CursorLine gui=underline
highlight CursorLine ctermbg=black guibg=black

" コマンド実行中は再描画しない
:set lazyredraw
" 高速ターミナル接続を行う
:set ttyfast

"-------------------------------------------------------------------------------
" インデント Indent
"-------------------------------------------------------------------------------
set autoindent   " 自動でインデント
set smartindent  " 新しい行を開始したときに、新しい行のインデントを現在行と同じ量にする。
set cindent      " Cプログラムファイルの自動インデントを始める

" softtabstopはTabキー押し下げ時の挿入される空白の量，0の場合はtabstopと同じ，BSにも影響する
set tabstop=2 shiftwidth=2 softtabstop=0

"-------------------------------------------------------------------------------
" 補完・履歴 Complete
"-------------------------------------------------------------------------------
set wildmenu               " コマンド補完を強化
set wildchar=<tab>         " コマンド補完を開始するキー
set wildmode=list:full     " リスト表示，最長マッチ
set history=1000           " コマンド・検索パターンの履歴数
set complete& complete+=k  " 補完に辞書ファイル追加

"-------------------------------------------------------------------------------
" 検索設定 Search
"-------------------------------------------------------------------------------
set wrapscan   " 最後まで検索したら先頭へ戻る
set ignorecase " 大文字小文字無視
set smartcase  " 検索文字列に大文字が含まれている場合は区別して検索する
set incsearch  " インクリメンタルサーチ
set hlsearch   " 検索文字をハイライト
"<C-[>の2回押しでハイライト消去
nmap <C-[><C-[> :nohlsearch<CR><ESC>

"選択した文字列を検索
vnoremap <silent> // y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>
"選択した文字列を置換
vnoremap /r "xy:%s/<C-R>=escape(@x, '\\/.*$^~[]')<CR>//gc<Left><Left><Left>
"s*置換後文字列/g<Cr>でカーソル下のキーワードを置換
nnoremap <expr> s* ':%substitute/\<' . expand('<cword>') . '\>/'

" Ctrl-iでヘルプ
nnoremap <C-i>  :<C-u>help<Space>
" カーソル下のキーワードをヘルプでひく
nnoremap <C-i><C-i> :<C-u>help<Space><C-r><C-w><Enter>

"-------------------------------------------------------------------------------
" 移動設定 Move
"-------------------------------------------------------------------------------

" 行頭、行末をterminalに合わせる
nmap <C-a> ^
nmap <C-e> $

" insert mode での移動
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-j> <DOWN>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

"フレームサイズを怠惰に変更する
map <kPlus> :resize +5<CR>
map! <kPlus> :resize +5<CR>
map <kMinus> :resize -5<CR>
map! <kMinus> :resize -5<CR>

" 前回終了したカーソル行に移動
autocmd Mine BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

" 対応する括弧に移動
nnoremap [ %
nnoremap ] %

" 矩形選択で自由に移動する
set virtualedit& virtualedit+=block

"ビジュアルモード時vで行末まで選択
vnoremap v $h

"-------------------------------------------------------------------------------
" FileType判定 FileType detection
"-------------------------------------------------------------------------------
autocmd Mine BufRead,BufNewFile *.mayaa  setf xml
autocmd Mine BufRead,BufNewFile *.dicon  setf xml
autocmd Mine BufRead,BufNewFile *.coffee setf coffee
autocmd Mine BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab

"-------------------------------------------------------------------------------
" エンコーディング関連 Encoding
"-------------------------------------------------------------------------------
set ffs=unix,dos,mac  " 改行文字
set encoding=utf-8    " デフォルトエンコーディング
" 日本語を含まない場合は fileencoding に encoding を使うようにする
function! AU_ReCheck_FENC()
  if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
    let &fileencoding=&encoding
  endif
endfunction
autocmd Mine BufReadPost * call AU_ReCheck_FENC()

" 改行コードの自動認識
set fileformats=unix,dos,mac
" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif

" 以下のファイルの時は文字コードをutf-8に設定
autocmd Mine FileType svn    :set fileencoding=utf-8
autocmd Mine FileType js     :set fileencoding=utf-8
autocmd Mine FileType css    :set fileencoding=utf-8
autocmd Mine FileType html   :set fileencoding=utf-8
autocmd Mine FileType xml    :set fileencoding=utf-8
autocmd Mine FileType java   :set fileencoding=utf-8
autocmd Mine FileType scala  :set fileencoding=utf-8
autocmd Mine FileType coffee  :set fileencoding=utf-8
" ワイルドカードで表示するときに優先度を低くする拡張子
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

" 指定文字コードで強制的にファイルを開く
command! Cp932 edit ++enc=cp932
command! Eucjp edit ++enc=euc-jp
command! Iso2022jp edit ++enc=iso-2022-jp
command! Utf8 edit ++enc=utf-8
command! Jis Iso2022jp
command! Sjis Cp932

"-------------------------------------------------------------------------------
" カラー関連 Colors
"-------------------------------------------------------------------------------
" ハイライト on
syntax enable

" ターミナルタイプによるカラー設定
if !has('gui_macvim')
  if &term =~ "xterm-debian" || &term =~ "xterm-xfree86" || &term =~ "xterm-256color"
   set t_Co=16
   set t_Sf=[3%dm
   set t_Sb=[4%dm
  elseif &term =~ "xterm-color"
   set t_Co=8
   set t_Sf=[3%dm
   set t_Sb=[4%dm
  endif

  " 補完候補の色づけ for vim7
  hi Pmenu ctermbg=white ctermfg=darkgray
  hi PmenuSel ctermbg=blue ctermfg=white
  hi PmenuSbar ctermbg=0 ctermfg=9
endif

"-------------------------------------------------------------------------------
" 編集関連 Edit
"-------------------------------------------------------------------------------

" insertモードを抜けるとIMEオフ
if has('gui_macvim')
  set noimdisableactivate
else
  set noimdisable
  set iminsert=0 imsearch=0
  set noimcmdline
  inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
endif

"  Insert mode中で単語単位/行単位の削除をアンドゥ可能にする
inoremap <C-u>  <C-g>u<C-u>
inoremap <C-w>  <C-g>u<C-w>

" 括弧を自動補完
vnoremap { "zdi^V{<C-R>z}<ESC>
vnoremap [ "zdi^V[<C-R>z]<ESC>
vnoremap ( "zdi^V(<C-R>z)<ESC>
vnoremap " "zdi^V"<C-R>z^V"<ESC>
vnoremap ' "zdi'<C-R>z'<ESC>

" 行末の空白を除去する
nnoremap <C-x> :%s/\s\+$//ge<CR>
" tabをスペースに変換する
nnoremap <C-z> * :%s/\t/  /ge<CR>

"-------------------------------------------------------------------------------
" Plugins
"-------------------------------------------------------------------------------
filetype plugin off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'altercation/vim-colors-solarized'
Bundle 'scrooloose/nerdtree'
Bundle 'ZoomWin'
Bundle 'tpope/vim-fugitive'
Bundle 'Shougo/vimproc'
Bundle 'Shougo/vimshell'
Bundle 'ujihisa/quickrun'
Bundle 'Shougo/unite.vim'
Bundle 'h1mesuke/unite-outline'
Bundle 'Shougo/neocomplcache'
Bundle 'vim-coffee-script'

" unite.vim {{{
" 起動時にインサートモードで開始
let g:unite_enable_start_insert = 1
let g:unite_winheight = 10
let g:unite_split_rule = "below"

" バッファ一覧
nnoremap <S-b> :<C-u>UniteWithBufferDir -buffer-name=buffer file<CR>
" ファイル一覧
nnoremap <S-f> :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <S-r> :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <S-m> :<C-u>Unite file_mru<CR>
" NERDTreeToggle
nnoremap <S-t> :NERDTreeToggle<CR>
" unite.vim上でのキーマッピング
autocmd Mine FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
  " 単語単位からパス単位で削除するように変更
  imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
  " ESCキーを2回押すと終了する
  nmap <silent><buffer> <ESC><ESC> q
  imap <silent><buffer> <ESC><ESC> <ESC>q
endfunction

nnoremap <silent> <C-o> :<C-u>Unite -buffer-name=outline  -winheight=90 -winwidth=90 outline<CR>
call unite#set_buffer_name_option('outline', 'ignorecase', 1)
call unite#set_buffer_name_option('outline', 'smartcase', 1)
"}}}

" neocomplcache.vim {{{
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : ''
    \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

" Enable omni completion.
autocmd Mine FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd Mine FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd Mine FileType java setlocal omnifunc=javacomplete#CompleteJava
autocmd Mine FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd Mine FileType actionscript setlocal omnifunc=actionscriptcomplete#CompleteAS
autocmd Mine FileType ruby setlocal omnifunc=rubycomplete#Complete
autocmd Mine FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd Mine FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" add ruby omnicompletion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
"}}}

filetype plugin indent on

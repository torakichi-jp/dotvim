"*******************************************************************************
"
" Vim Settings:
"
"*******************************************************************************

scriptencoding utf-8    " この設定ファイルの文字コード設定
set nocompatible        " vi非互換
set shellslash          " パス区切りを/にする

" switching variables
let s:is_gui = has('gui_running')
let s:is_windows = has('win32') || has('win64')
let s:is_unix = has('unix')

" directory name by OS kinds (.vim or vimfiles)
if s:is_windows
    let s:dotvimdir = expand('~/vimfiles')
elseif s:is_unix
    let s:dotvimdir = expand('~/.vim')
endif

" setting <leader> key
let g:mapleader=','

" initialize autocmd
augroup MyAutocmd
    autocmd!
augroup END


"*******************************************************************************
" Plugins:
"*******************************************************************************

" required
if has('vim_starting')
    let &runtimepath = &runtimepath . ',' . s:dotvimdir . '/bundle/neobundle.vim'
endif
call neobundle#rc(s:dotvimdir . '/bundle')

" bundles
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/vinarise'
NeoBundle 'thinca/vim-visualstar'
NeoBundle 'thinca/vim-tabrecent'
NeoBundle 'thinca/vim-qfreplace'
NeoBundle 'thinca/vim-ref'
NeoBundle 'thinca/vim-fontzoom'
NeoBundle 'thinca/vim-openbuf'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'thinca/vim-singleton'
NeoBundleLazy 'thinca/vim-vcs'
NeoBundle 'gregsexton/VimCalc'
NeoBundle 'mattn/calendar-vim'
NeoBundle 'mattn/wwwrenderer-vim'
NeoBundle 'mattn/webapi-vim'
NeoBundleLazy 'mattn/zencoding-vim'
NeoBundle 'tyru/vim-altercmd'
NeoBundle 'tyru/restart.vim'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'tyru/open-browser-github.vim'
NeoBundle 'tyru/winmove.vim'
NeoBundle 'tyru/emap.vim'
NeoBundle 'chrismetcalf/vim-taglist'
NeoBundle 'taku-o/vim-toggle'
NeoBundle 'taku-o/vim-batch-source'
NeoBundle 'kana/vim-tabpagecd'
NeoBundle 'kana/vim-niceblock'
NeoBundle 'kana/vim-submode'
NeoBundle 'dannyob/quickfixstatus'
NeoBundle 'deris/vim-rengbang'
NeoBundle 'deris/vim-operator-rengbang', {
    \ 'depends' : [
    \   'deris/vim-rengbang',
    \   'kana/vim-operator-user',
    \ ]
\ }
NeoBundle 'jceb/vim-hier'
NeoBundle 'ujihisa/neco-look'
NeoBundleLazy 'ujihisa/quicklearn'
NeoBundle 'tpope/vim-capslock'
NeoBundle 't9md/vim-quickhl'
NeoBundle 't9md/vim-textmanip'
NeoBundle 'fuenor/qfixhowm'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundleLazy 'Lokaltog/vim-powerline'
NeoBundle 'h1mesuke/vim-alignta'
NeoBundle 'basyura/TweetVim'
NeoBundle 'basyura/twibill.vim'
NeoBundle 'basyura/bitly.vim'
NeoBundle 'mattn/favstar-vim'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'rhysd/accelerated-jk'
"NeoBundleLazy 'tpope/vim-surround'
"NeoBundleLazy 't9md/vim-surround_custom_mapping', '', '', {
"       \ 'depends' : 'vim-surround',
"       \ 'autoload' : {
"           \ 'mappings' : [
"               \ ['n', '<Plug>Dsurround'], ['n', '<Plug>Csurround'],
"               \ ['n', '<Plug>Ysurround'], ['n', '<Plug>YSurround']
"           \ ]}}

" from vim.org
NeoBundle 'Colour-Sampler-Pack'
NeoBundle 'SingleCompile'
NeoBundle 'ack.vim'
NeoBundle 'sudo.vim'
NeoBundleLazy 'colorsel.vim'
NeoBundleLazy 'vimwiki'
NeoBundleLazy 'CSApprox'

" textobj
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'kana/vim-textobj-line'
NeoBundle 'kana/vim-textobj-underscore'
NeoBundle 'kana/vim-textobj-indent'
NeoBundle 'kana/vim-textobj-syntax'
NeoBundle 'kana/vim-textobj-fold'
NeoBundle 'kana/vim-textobj-function'
NeoBundle 'kana/vim-textobj-entire'
NeoBundle 'thinca/vim-textobj-comment'
NeoBundle 'thinca/vim-textobj-plugins'
NeoBundle 'h1mesuke/textobj-wiw'
NeoBundle 'deris/vim-textobj-enclosedsyntax'
NeoBundle 'https://bitbucket.org/anyakichi/vim-textobj-xbrackets'

" unite, matchers, and sources
NeoBundle 'Shougo/unite.vim'
NeoBundle 'basyura/unite-matcher-file-name'
NeoBundle 'natsumesou/unite-flexmatcher'
NeoBundle 'Shougo/unite-session'
NeoBundle 'thinca/vim-unite-history'
NeoBundle 'h1mesuke/unite-outline'
NeoBundle 'tsukkee/unite-tag'
NeoBundle 'tsukkee/unite-help'
NeoBundle 'tacroe/unite-mark'
NeoBundle 'sgur/unite-qf'
NeoBundle 'choplin/unite-vim_hacks'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'osyo-manga/unite-qfixhowm'
NeoBundle 'kannokanno/unite-todo'
NeoBundleLazy 'kmnk/vim-unite-svn'
NeoBundleLazy 'Shougo/unite-build'
NeoBundleLazy 'Shougo/unite-ssh'

" operator
NeoBundle 'kana/vim-operator-user'
NeoBundle 'kana/vim-operator-replace'
NeoBundle 'tyru/operator-camelize.vim'
NeoBundle 'tyru/operator-reverse.vim'
NeoBundle 'emonkak/vim-operator-sort'

" helps
NeoBundle 'vim-jp/vimdoc-ja'
NeoBundle 'mattn/learn-vimscript'


" Installation check.
NeoBundleCheck

" required
filetype plugin indent on

" enable syntax
if &t_Co > 1
    syntax enable
endif


"*******************************************************************************
" Plugin Settings:
"*******************************************************************************

" Vimスクリプトのシンタックスフォールディング設定
" foldmethod=syntaxでないと意味なし
" augroup: a
" function: f
" lua: l
" perl: p
" ruby: r
" python: P
" tcl: t
" mzscheme: m
let g:vimsyn_folding = 'af'

" GetLatestVimPlugin.vimを無効にする
let g:loaded_getscriptPlugin = 1
" netrw.vimを無効にする
let g:loaded_netrwPlugin = 1

" Vim with singleton
call singleton#enable()

" vimproc
" TODO: windowsでのビルドもできるようにする
let s:bundle = neobundle#get('vimproc')
function! s:bundle.hooks.on_source(bundle)
    if !has('win64') && !has('win32')
        call neobundle#config('vimproc', {
            \ 'build' : {
            \       'windows' : 'make -f make_mingw32.mak',
            \       'cygwin' : 'make -f make_cygwin.mak',
            \       'mac' : 'make -f make_mac.mak',
            \       'unix' : 'make -f make_unix.mak',
            \ }
        \ })
    endif
endfunction

" NERD_commenter
let s:bundle = neobundle#get('nerdcommenter')
function! s:bundle.hooks.on_source(bundle)
    let g:NERDCreateDefaultMappings = 0
    let g:NERDSpaceDelims = 0
endfunction

" neocomplete
let g:neocomplete#enable_at_startup = 1
let s:bundle = neobundle#get('neocomplete.vim')
function! s:bundle.hooks.on_source(bundle)
    let g:neocomplete#enable_auto_select = 1
    "let g:neocomplete#disable_auto_complete = 1
endfunction

" powerline
if s:is_gui
    NeoBundleSource vim-powerline
    let g:Powerline_symbols = 'compatible'
    let g:Powerline_stl_path_style = 'relative'
    let g:Powerline_mode_n = ' N '
    let g:Powerline_mode_i = 'Insert'
    let g:Powerline_mode_R = 'Replace'
    let g:Powerline_mode_v = 'Visual'
    let g:Powerline_mode_V = 'V-Line'
    let g:Powerline_mode_cv = 'V-Block'
    let g:Powerline_mode_s = 'Select'
    let g:Powerline_mode_S = 'S-Line'
    let g:Powerline_mode_cs = 'S-Block'
endif

" vimfiler
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_safe_mode_by_default = 0

" Unite設定
let g:unite_winheight = 10
let g:unite_enable_start_insert = 0

" unite-menu
if !exists('g:unite_source_menu_menus')
    let g:unite_source_menu_menus = {}
endif

" メニューにエンコーディング項目を追加
let g:unite_source_menu_menus.encoding = {
    \'description' : 'Encoding',
\ }
let g:unite_source_menu_menus.encoding.command_candidates = [
    \ ['UTF-8',     'Utf8'],
    \ ['SHIFT-JIS', 'Sjis'],
    \ ['EUC-JP',        'Euc'],
    \ ['JIS',       'Jis'],
    \ ['Unicode', 'Utf16'],
    \ ['UCS-2',     'Utf16be'],
\ ]

" メニューにコマンドショートカット項目を登録
let g:unite_source_menu_menus.shortcut = {
    \ 'description' : 'Command Shortcut',
\ }
let g:unite_source_menu_menus.shortcut.command_candidates = [
    \ ['VimShell',              'VimShell'],
    \ ['VimShellPop',               'VimShellPop'],
    \ ['NeoBundleInstall',      'NeoBundleInstall'],
    \ ['NeoBundleUpdate',           'NeoBundleUpdate'],
    \ ['NeoBundleSource',           'NeoBundleSource'],
    \ ['NeoBundleClean',            'NeoBundleClean'],
    \ ['NeoBundleDocs',         'NeoBundleDocs'],
    \ ['Scratch',                   'Scratch'],
    \ ['MoveWin',                   'MoveWin'],
    \ ['Unite-Beautiful-Attack',    'Unite -auto-preview colorscheme'],
\ ]

" メニューにリファレンスを登録
let g:unite_source_menu_menus.reference = {
    \ 'description' : 'Reference',
\ }
" リファレンスメニューに登録するコマンド
let g:unite_source_menu_menus.reference.command_candidates = [
    \ ['En-Jp Dictionary',      'call feedkeys('':Ref webdict ej '')'],
    \ ['Jp-En Dictionary',      'call feedkeys('':Ref webdict je '')'],
    \ ['pydoc',                 'call feedkeys('':Ref pydoc '')'],
    \ ['Wikipedia',             'call feedkeys('':Ref webdict wiki '')'],
    \ ['Thesaurus',             'call feedkeys('':Ref webdict thesaurus '')'],
    \ ['Boost.MPL Ref',         'OpenBrowser http://www.boost.org/doc/libs/release/libs/mpl/doc/refmanual/refmanual_toc.html'],
    \ ['C++ Libraery Reference',    'OpenBrowser https://sites.google.com/site/cpprefjp/reference/'],
\ ]

" Ref
let g:ref_use_vimproc = 1
let s:lynx = 'C:/Program Files (x86)/Lynx for Win32/lynx.exe'
let s:cfg  = 'C:/Program Files (x86)/Lynx for Win32/lynx.cfg'
let g:ref_lynx_cmd = s:lynx.' -cfg='.s:cfg.' -dump -nonumbers %s'
let g:ref_alc_cmd = s:lynx.' -cfg='.s:cfg.' -dump %s'
unlet s:lynx
unlet s:cfg

" webdictサイトの設定
let g:ref_source_webdict_sites = {
    \ 'je'          : {'url': 'http://dictionary.infoseek.ne.jp/jeword/%s',},
    \ 'ej'          : {'url': 'http://dictionary.infoseek.ne.jp/ejword/%s',},
    \ 'wiki'            : {'url': 'http://ja.wikipedia.org/wiki/%s',},
    \ 'alc'         : {'url': 'http://eow.alc.co.jp/search?q=%s',},
    \ 'weblio'      : {'url': 'http://www.weblio.jp/content/%s',},
    \ 'thesaurus'       : {'url': 'http://thesaurus.weblio.jp/content/%s',},
    \ 'wiktionary'  : {'url': 'http://ja.wiktionary.org/wiki/%s',},
\ }

" 各サイトのフィルタ設定
function! s:SetWebDictsFilter()
    let ref_webdict_filtering_lines = [
        \ ['je',            15],
        \ ['ej',            15],
        \ ['wiki',          17],
        \ ['alc',           38],
        \ ['weblio',        17],
        \ ['thesaurus',     28],
        \ ['wiktionary',    17],
    \ ]

    for item in ref_webdict_filtering_lines
        let g:ref_source_webdict_sites[item[0]].filtering_lines = item[1]
        function! g:ref_source_webdict_sites[item[0]].filter(output) dict
            return join(split(a:output, "\n")[self.filtering_lines :], "\n")
        endfunction
    endfor
endfunction
call <SID>SetWebDictsFilter()
delfunction s:SetWebDictsFilter

" デフォルトサイト
let g:ref_source_webdict_sites.default = 'ej'

" QFixHowm
let mygrep = 'grep'

"indent-guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_color_change_percent = 10
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2

" EasyMotion
let g:EasyMotion_leader_key = '\'
let g:EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyz0123456789'
let g:EasyMotion_do_shade = 0

" openuri
let openuri_cmd = '!start "rundll32.exe" url.dll,FileProtocolHandler %s'

" ShowMarksでハイライトするマーク指定
let g:showmarks_include = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ<>'
" プラグインでマップされちゃうのでautocmdで定義
autocmd MyAutocmd VimEnter * nmap m [Mark]

" QFixHowmのメニューバーを表示しない
" （_gvimrcでplugin内に表示）
let g:qfixmemo_menubar = 0
let g:MyGrep_MenuBar = 0

" 開始時の行末空白ハイライトの自動表示あり
"let g:auto_trailing_whitespace_enable = 1
" 行末空白ハイライトをシンプルに
"let g:auto_trailing_whitespace_simple = 1

" TagList
let Tlist_Compact_Format = 1        "空白行などを表示しない
let Tlist_Enable_Fold_Column = 0    "折りたたみ列を表示しない
let Tlist_Exit_OnlyWindow = 1       "タグリストウィンドウのみになったら終了
let Tlist_Sort_Type = 'name'        "タグを名前順にソートする

" submode
let g:submode_timeout=0     " サブモードでのタイムアウトなし

" vim-toggle
let g:toggle_pairs = {
    \ 'and' : 'or',
    \ 'or' : 'and',
\ }

" foldCC
let g:foldCCtext_tail = 'v:foldend-v:foldstart+1'

" accelerated-smooth-scroll
"let g:ac_smooth_scroll_no_default_key_mappings = 1
"let g:ac_smooth_scroll_du_sleep_time_msec = 1
"let g:ac_smooth_scroll_fb_sleep_time_msec = 1

unlet s:bundle

"*******************************************************************************
" Option Settings:
"*******************************************************************************

" マウスの挙動をWindowsの動作にする
behave mswin

" カラースキーム
colorscheme blued

" 無名レジスタの代わりにクリップボードを使う
"set clipboard& clipboard+=unnamed

set columns=99                  " 列数(_gvimrcで再設定してる)
set lines=36                    " 行数(_gvimrcで再設定してる)
set number                      " 行番号表示
"set relativenumber             " 相対行番号表示
set ruler                       " ルーラー表示
set title                       " タイトルを表示
set showcmd                     " 入力中コマンドの表示
set hidden                      " バッファ更新を破棄しない
set confirm                     " エラーにせず確認ダイアログを出す
set backspace=indent,eol,start  " Backspaceの挙動
set cursorline                  " 現在行をハイライト
set display=lastline            " 最後の行をできるだけ表示する
set cmdheight=2                 " コマンドライン行数
set noequalalways               " ウィンドウの自動サイズ調整をしない
set wrap                        " 右端で折り返し
set textwidth=0                 " テキスト幅
set laststatus=2                " 常にステータス行を表示
set showtabline=2               " タブ行を常に表示
set autoindent                  " 自動インデント
set switchbuf=split,newtab      " バッファの切り替えオプション
set tabline=%!MakeTabLine()     " タブ行の表示設定
set helpheight=0                " ヘルプの最小高
set helplang=ja                 " 日本語ヘルプ
set pumheight=10                " ポップアップメニューの最大高
set previewheight=5             " プレビューウィンドウの高さ
set shortmess& shortmess+=I     " 起動時のメッセージなし
"set showbreak=>\               " 折り返し行頭の文字列（最後の空白に注意）
"set cpoptions+=n               " 折り返し行を行番号列から表示
set cmdwinheight=5              " コマンドラインウィンドウの高さ
set noshowmatch                 " 対応括弧にジャンプしない
set virtualedit+=block          " ビジュアル矩形モードで仮想編集
set cinoptions=:0,l1,g0,m1      " C/C++インデントオプション
set matchpairs& matchpairs+=<:> " 括弧ペアに<>を加える
set winaltkeys=no               " メニューのためにAltキーを使わない
set path+=;/                    " 親ディレクトリも辿る
set tags+=./tags;,./**/tags     " タグファイル検索パス
"set complete-=i                " インクルードファイルを補完検索対象から除外
set completeopt=menu,preview,longest    " 補完オプション
set wildmenu                    " 拡張コマンドライン補完を有効
set wildmode=longest,full       " コマンドライン補完最長一致
set viminfo& viminfo+=/0        " 検索履歴をviminfoに記録しない
"set lazyredraw                 " マクロ実行中の画面再描画なし
set nostartofline               " 縦移動で、できるだけ列を維持する
set timeout                     " マップ、キーコードで一定時間待つ
set timeoutlen=3000             " マップ、キーコードの待ち時間(ms)
set selectmode=                 " セレクトモードを使わない
set sidescroll=1                " 水平スクロールの刻み幅
set sidescrolloff=1             " 水平スクロールでカーソル周辺の表示文字数
set list                        " 不可視文字の表示設定
set listchars=tab:>-,trail:_,extends:>,precedes:<

" tab, indent option
set tabstop=4           " タブ幅
set expandtab           " タブ展開する
set shiftwidth=4        " インデント幅
set softtabstop=4       " <Tab>や<BS>を入力したときの移動幅

" searching option
set incsearch           " インクリメンタルサーチを有効
set nohlsearch          " 検索ハイライト無効
set ignorecase          " 大文字小文字を無視
set smartcase           " 大文字が含まれるときのみ無視しない
set wrapscan            " 最後まで行ったら最初に戻る
set grepprg=grep\ -nH   " grepプログラム
"set grepprg=ack\ -H    " grepにackを使う
set gdefault            " 候補を全部置換する

" folding option
set foldenable          " 折りたたみを有効に
set foldcolumn=2        " 折りたたみ列数
set foldmethod=manual   " 手動で折りたたみ

" タイトル行の表示設定
"set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:p:~:h\")})%)%(\ %a%)%(\ -\ %{v:servername}%)

if has('mouse')
    set mouse=a
endif

" backup option
set backup                              " バックアップする
"set updatecount=0                      " スワップファイルなし
let &backupdir = s:dotvimdir . '/.backup'  " バックアップを作成するディレクトリ
set undofile                            " アンドゥファイルを作成する
let &undodir = s:dotvimdir . '/.undo'      " アンドゥファイルを作成するディレクトリ
" バックアップディレクトリがなかったら作成する
if &backupdir!=#'' && !isdirectory(&backupdir)
    call mkdir(&backupdir)
endif
" スワップファイルを作成するディレクトリ
let &directory=&backupdir
" アンドゥファイルディレクトリがなかったら作成する
if &undodir!=#'' && !isdirectory(&undodir)
    call mkdir(&undodir)
endif

" capslock.vim
" capslockモード中なら表示を追加
"set statusline^=%{exists('*CapsLockStatusline')?CapsLockStatusline():''}

" 全角スペースの表示
" TODO: あとでmatchadd()を使うように修正する
"function! HighlightZenkakuSpace()
"   hi ZenkakuSpace cterm=underline ctermfg=red gui=underline guifg=red
"endfunction
"augroup ZenkakuSpace
"   autocmd!
"   autocmd ColorScheme * call HighlightZenkakuSpace()
"   autocmd VimEnter,BufWinEnter,WinEnter * match ZenkakuSpace /　/
"augroup END
"call HighlightZenkakuSpace()

"c, cpp, idlにdoxygenハイライトを設定する
let g:load_doxygen_syntax = 1
let g:doxygen_enhanced_color = 1

" VimScriptの行連結バックスラッシュをインデントしない
let g:vim_indent_cont = 0

" %による移動強化
runtime macros/matchit.vim

" タブページの表示行設定
function! MakeTabLine()
    " TODO: coding here at tabline view setting.
    let titles = map(range(1, tabpagenr('$')), 's:TabPageLabel(v:val)')
    let sep = ' '       " タブ間の区切り
    let tabpages = join(titles, sep) . sep . '%#TabLineFill#%T'
    let info = ''   "好きな情報を入れる

    " カレントディレクトリ
    let info .= fnamemodify(getcwd(), ':~') . ' '

    return tabpages . '%=' . info   " タブリストを左に、情報を右に表示
endfunction
" 各タブの表示設定
function! s:TabPageLabel(n)
    " t:title と言う変数があったらそれを使う
    let title = gettabvar(a:n, 'title')
    if title !=# ''
        return title . ' %#TabLineFill#'
    else
        " タブページ内のバッファのリスト
        let bufnrs = tabpagebuflist(a:n)

        " カレントタブページかどうかでハイライトを切り替える
        let hi = a:n is tabpagenr() ? '%#TabLineSel#' : '%#TabLine#'

        " バッファが複数あったらバッファ数を表示
        let no = len(bufnrs)
        if no is 1
            let no = ""
        endif
        " タブページ内に変更ありのバッファがあったら '+' を付ける
        let mod = len(filter(copy(bufnrs), 'getbufvar(v:val, ''&modified'')')) ? '+' : ''
        let sp = (no . mod) ==# "" ? "" : ' '  " 隙間空ける

        " カレントバッファを取得
        let curbufnr = bufnrs[tabpagewinnr(a:n) - 1]  " tabpagewinnr() は 1 origin
        let curbufname = bufname(curbufnr)

        " b:title という変数があったらそれを使う
        let title = getbufvar(curbufnr, 'title')
        if !empty(title)
            let fname = title
        elseif empty(curbufname)
            " バッファタイプによって名前を変える
            if &buftype ==# 'nofile'
                let fname = '[下書き]'
            elseif &buftype ==# 'quickfix'
                let fname = '[Quickfix]'
            else
                let fname = '[無名]'
            endif
        else
            "let fname = pathshorten(curbufname)
            let fname = fnamemodify(curbufname, ':t')
            if &buftype ==# 'help'
                let fname = fname . ' [ヘルプ]'
            endif
        endif
    endif

    let labeltext = no . mod . sp . fname
    let label = '%' . a:n . 'T' . hi . ' ' . labeltext . '%T'
    "let closelabel = '%' . a:n . 'X x %X'      " 閉じるラベル

    "return label . closelabel . '%#TabLineFill#'
    return label . ' %#TabLineFill#'
endfunction


"*******************************************************************************
" User Commands:
"*******************************************************************************
" NormalモードマッピングとVisualモードマッピングを一度に定義する
command! -bar -nargs=+ NXmap call s:NXmap(<q-args>, 0)
command! -bar -nargs=+ NXnoremap call s:NXmap(<q-args>, 1)
function! s:NXmap(args, noremaped)
    let remap_str = a:noremaped ? 'nore' : ""
    execute 'n' . remap_str . 'map ' . a:args
    execute 'x' . remap_str . 'map ' . a:args
endfunction

" セッション保存してリスタート
command! -bar RestartWithSession
    \ let g:restart_sessionoptions = 'blank,curdir,folds,help,localoptions,tabpages'
    \ | Restart

" タブページの移動
command! -bar TabMoveNext
    \ execute 'tabmove' tabpagenr() % tabpagenr('$')
command! -bar TabMovePrev
    \ execute 'tabmove' (tabpagenr('$') + tabpagenr() - 2) % tabpagenr('$')

" エンコーディングを変えて開き直す
command! -bang -bar -nargs=? -complete=file Utf8
                            \ edit<bang> ++enc=utf-8 <args>
command! -bang -bar -nargs=? -complete=file Cp932
                            \ edit<bang> ++enc=cp932 <args>
command! -bang -bar -nargs=? -complete=file Euc
                            \ edit<bang> ++enc=euc-jp <args>
command! -bang -bar -nargs=? -complete=file Iso2022jp
                            \ edit<bang> ++enc=iso-2022-jp <args>
command! -bang -bar -nargs=? -complete=file Utf16
                            \ edit<bang> ++enc=ucs-2le <args>
command! -bang -bar -nargs=? -complete=file Utf16be
                            \ edit<bang> ++enc=ucs-2 <args>

" 別名
command! -bang -bar -nargs=? -complete=file Jis
                            \ Iso2022jp<bang> <args>
command! -bang -bar -nargs=? -complete=file Sjis
                            \ Cp932<bang> <args>
command! -bang -bar -nargs=? -complete=file Unicode
                            \ Utf16<bang> <args>

" Google検索
command! -nargs=? GoogleSearch call s:GoogleSearch(<q-args>)
function! s:GoogleSearch(word) "{{{
    let cmd = 'rundll32 url.dll,FileProtocolHandler'
    let search_engine = 'https://www.google.co.jp/#q='
    exe 'VimProcBang ' . cmd . " '" . search_engine . a:word . "'"
endfunction "}}}

" Explorer
command! -nargs=? -complete=dir Explorer call s:Explorer(<q-args>)
function! s:Explorer(dir)
    let l:dir = a:dir
    if a:dir == ''
        let l:dir = '.'
    endif
    execute 'VimProcBang rundll32 url.dll,FileProtocolHandler ' . l:dir
endfunction

" Diff
command! -nargs=? -complete=file Diff
    \ if '<args>'=='' |
        \ browse vertical diffsplit |
    \ else |
        \ vertical diffsplit <args> |
    \ endif

" DiffOrig
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
          \ | wincmd p | diffthis
endif

" Capture :mapとかのメッセージをキャプチャ
command! -nargs=+ -complete=command Capture call s:CmdCapture(<q-args>)
function! s:CmdCapture(args) "{{{
    " コマンドのリダイレクト
    redir => result
    silent execute a:args
    redir END

    " 特別にオプションを設定して別ウィンドウに表示
    new
    setlocal bufhidden=unload
    setlocal nobuflisted
    setlocal buftype=nofile
    setlocal noswapfile
    let b:title = '[Capture: ' . a:args . ']'
    "silent file `='[Capture ('' . a:args . '')]'`
    silent put =result
    1,2delete _
    " qでウィンドウを閉じられるようにする
    nnoremap <buffer> <silent> q :<C-u>close<CR>
endfunction "}}}


"-------------------------------------------------------------------------------
" Functions:
"-------------------------------------------------------------------------------

" Comment or uncomment lines from mark a to mark b.
function! s:CommentMark(docomment, a, b)
    if !exists('b:comment')
        "let b:comment = CommentStr() . ' '
        let b:comment = CommentStr()
    endif
    if a:docomment
        exe "normal! '" . a:a . "_\<C-V>'" . a:b . 'I' . b:comment
    else
        exe "'".a:a.",'".a:b . 's/^\(\s*\)' . escape(b:comment,'/') . '/\1/e'
    endif
endfunction

" Comment lines in marks set by g@ operator.
function! s:DoCommentOp(type)
    call s:CommentMark(1, '[', ']')
endfunction

" Uncomment lines in marks set by g@ operator.
function! s:UnCommentOp(type)
    call s:CommentMark(0, '[', ']')
endfunction

" Return string used to comment line for current filetype.
function! s:CommentStr()
    if &ft == 'cpp' || &ft == 'java' || &ft == 'javascript'
        return '//'
    elseif &ft == 'vim'
        return '"'
    elseif &ft == 'python' || &ft == 'perl' || &ft == 'sh' || &ft == 'R' || &ft == 'ruby'
        return '#'
    elseif &ft == 'lisp'
        return ';'
    endif
    return ''
endfunction

" カーソル下の単語を取得
function! GetCursorWord(pat) "{{{
    let line = getline('.')
    let pos = col('.')
    let s = 0
    while s < pos
        let [s, e] = [match(line, a:pat, s), matchend(line, a:pat, s)]
        if s < 0
            break
        elseif s < pos && pos <= e
            return line[s : e - 1]
        endif
        let s += 1
    endwhile
    return ''
endfunction "}}}

" ビジュアルモードで選択されていたテキストを取得
function! GetSelectedWord() "{{{
    let save_z = getreg('z', 1)
    let save_z_type = getregtype('z')

    try
        normal! gv"zy
        return @z
    finally
        call setreg('z', save_z, save_z_type)
    endtry
endfunction "}}}


"******************************************************************************
" Autocommands:
"******************************************************************************

augroup MyAutocmd

    " プログラムソースなら81文字目に線を引く
    autocmd FileType c,cpp,vim,python,ruby,perl,cs,java setlocal colorcolumn=81

    " （ヘルプとかを）qで終了
    autocmd FileType help,ref-* nnoremap <buffer> <silent> q :<C-u>close<CR>

    " コマンドラインウィンドウ用設定
    " 挿入モードではじめる
    autocmd CmdwinEnter * startinsert
    " qで終了する
    autocmd CmdwinEnter * nnoremap <buffer> <silent> q :<C-u>quit<CR>

    " 前回のカーソル位置を復元
    autocmd BufReadPost *
        \ if line('''"') > 1 && line('''"') <= line('$') |
            \ execute 'normal! g`"' |
        \ endif

    " 起動時にファイル引数なしならスクラッチバッファを開く
    "autocmd VimEnter *
    "    \ redir => mes |
    "    \ args |
    "    \ redir END |
    "    \ if empty(mes) |
    "        \ drop Scratch |
    "    \ endif |
    "    \ unlet mes

augroup END


"*******************************************************************************
" AlterCommands:
"*******************************************************************************
"設定ファイル内でAlterCommandを使うためにロード
call altercmd#load()

AlterCommand u[nite] Unite
AlterCommand maps Unite -resume mapping
AlterCommand out[put] Unite -resume output
AlterCommand rest[art] RestartWithSession
AlterCommand cap[ture] Capture
AlterCommand cdc[urrent] CdCurrent
AlterCommand ack Ack
AlterCommand ct[ags] !ctags -R


"*******************************************************************************
" Key Mappings:
"*******************************************************************************

" 無効にしておく
nnoremap Q <Nop>
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>

" prefix
nmap <Space> [Space]
nnoremap [Space] <Nop>
nmap [Space]<Space> [WSpace]
nnoremap [WSpace] <Nop>
nnoremap <C-x> <Nop>

" j, kで表示行移動（gj, gkと入れ替え）
nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)
nnoremap gj j
nnoremap gk k

" すべて選択
nnoremap ga ggVG

" grep
nnoremap gr :<C-u>lgrep <C-r><C-w> *
xnoremap gr :<C-u>lgrep <C-r>=GetSelectedWord()<CR> *

" Google検索
nnoremap <silent> gs :<C-u>GoogleSearch <C-r>=GetCursorWord('[a-zA-Z]*')<CR><CR>
xnoremap <silent> gs :<C-u>GoogleSearch <C-r>=GetSelectedWord()<CR><CR>

" quickhl
NXmap gh <Plug>(quickhl-toggle)
NXmap gH <Plug>(quickhl-reset)
nmap gm <Plug>(quickhl-match)

" 単語を数える :%substitute/\<word\>/&/gn
nnoremap gw :<C-u>%substitute/\<<C-r><C-w>\>/&/gn<CR>

" URLオープン
nnoremap gx :<C-u>call openuri#cursorline()

" YをDなどと同じような動作にする
nnoremap Y y$

" Visualモードでの連続貼り付け
xnoremap p "0p<CR>

" インデント
nnoremap < <<
nnoremap > >>

" インデント後もビジュアルモードを維持
xnoremap < <gv
xnoremap > >gv

" 前後の関数の始め／終わりに移動
NXnoremap ]{ ]m
NXnoremap ]} ]M
NXnoremap [{ [m
NXnoremap [} [m

" 単語移動
" TODO: 自作する？
nmap w <Plug>(textobj-wiw-n)
nmap b <Plug>(textobj-wiw-p)
nmap e <Plug>(textobj-wiw-N)
nmap ge <Plug>(textobj-wiw-P)

" クリップボードレジスタ
noremap <C-a> "*

" toggle.vim
nmap <C-c> <Plug>ToggleN
imap <C-c> <Plug>ToggleI
vmap <C-c> <Plug>ToggleV

" vim-fontzoom
let g:fontzoom_no_default_key_mappings = 1
call submode#enter_with('fontzoom', 'n', '', '<C-z>', '<Nop>')
call submode#map('fontzoom', 'n', 'r', '+', '<Plug>(fontzoom-larger)')
call submode#map('fontzoom', 'n', 'r', '-', '<Plug>(fontzoom-smaller)')

" 数値増減
nnoremap + <C-a>
nnoremap - <C-x>

" cwordでヘルプを引く
nnoremap <silent> <F1> :<C-u>help <C-r><C-w><CR>
xnoremap <silent> <F1> :<C-u>help <C-r>=GetSelectedWord()<CR>

" バッファのファイルがある場所をカレントディレクトリにする
nnoremap <F2> :<C-u>cd %:p:h<Bar>pwd<CR>

" タグリスト
nnoremap <silent> <F4> :<C-u>TlistToggle<CR>

" make
nnoremap <F7> :<C-u>lmake<CR>

" カウント指定があれば<CR>で行移動
" なければ再描画＆検索ハイライトオフ
noremap <silent> <CR> :<C-u>call <SID>CrExec()<CR>
function! s:CrExec()
    if v:count == 0
        redraw!
        Nohlsearch
    else
        execute 'normal! ' . string(v:count) . 'G'
    endif
    return ""
endfunction

" operator
xmap P <Plug>(operator-replace)
xmap O <Plug>(operator-reverse-lines)
xmap R <Plug>(operator-reverse-text)
xmap C <Plug>(operator-camelize)
xmap D <Plug>(operator-decamelize)
xmap T <Plug>(operator-camelize-toggle)
xmap S <Plug>(operator-sort)

" マーク関連
nnoremap [Mark] <Nop>
nmap m [Mark]
" ms{char}でマーク（通常のmと同じ）＆ShowMarksオン
nnoremap <silent> [Mark]s
    \ :<C-u>execute 'normal! m' . nr2char(getchar())<bar>ShowMarksOn<CR>
" マーク位置へジャンプ(Find mark)
nnoremap [Mark]f `
" マーク行へジャンプ(Go to mark)
nnoremap [Mark]g '
" 別ウィンドウを開いてマーク行へジャンプ
nnoremap <silent> [Mark]w :<C-u>split +execute\ "normal!\ '".nr2char(getchar())<CR>
" 次のマークを置く
nnoremap <silent> [Mark]m :<C-u>ShowMarksPlaceMark<CR>
" ShowMarks切り替え(Toggle)
nnoremap <silent> [Mark]t :<C-u>ShowMarksToggle<CR>
" ShowMarksオン(On)
nnoremap <silent> [Mark]o :<C-u>ShowMarksOn<CR>:echo 'ShowMarks On'<CR>
" マークを隠す(Hide)
nnoremap <silent> [Mark]h :<C-u>ShowMarksHideAll<CR>:echo 'ShowMarks Off'<CR>
" 現在行のマークをクリア(Clear)
nnoremap <silent> [Mark]c :<C-u>ShowMarksClearMark<CR>
" 全マークをクリア(clear All)
nnoremap <silent> [Mark]a :<C-u>ShowMarksClearAll<CR>
" マークリスト(Unite mark)
nnoremap <silent> [Mark]l :<C-u>:Unite -auto-preview mark<CR>
nnoremap [Mark]j ]`
nnoremap [Mark]k [`
" TODO: mn, mp で（アルファベット順に）次のマークに移動するコードを書きたい
" TODO: mcでマークを1行目に移動するのではなく、ちゃんと消したい
" TODO: つーかShowMarksを自分用に書き直す？

" NERD_Commenter
nmap <Leader>cc <Plug>NERDCommenterAlignLeft
xmap <Leader>c <Plug>NERDCommenterComment
nmap <Leader>C <Plug>NERDCommenterToEOL
xmap <Leader>C <Plug>NERDCommenterAlignLeft
nmap <Leader>u <Plug>NERDCommenterUncomment
xmap <Leader>u <Plug>NERDCommenterUncomment
nmap <Leader>xm <Plug>NERDCommenterMinimal
xmap <Leader>xm <Plug>NERDCommenterMinimal
nmap <Leader>xs <Plug>NERDCommenterSexy
xmap <Leader>xs <Plug>NERDCommenterSexy
nmap <Leader>xa <Plug>NERDCommenterAltDelims

" ウィンドウ関連
nnoremap <C-Down>   <C-w>j
nnoremap <C-Up>     <C-w>k
nnoremap <C-Left>   <C-w>h
nnoremap <C-Right>  <C-w>l

" タブページ用マップ
nnoremap [Tab] <Nop>
nmap t [Tab]
nnoremap            [Tab]l  gt
nnoremap            [Tab]h  gT
nnoremap            [Tab]e  :<C-u>tabedit<Space>
nnoremap <silent>   [Tab]n  :<C-u>tabedit<CR>
nnoremap <silent>   [Tab]q  :<C-u>tabclose<CR>
nnoremap <silent>   [Tab]c  :<C-u>tabclose<CR>
nnoremap <silent>   [Tab]o  :<C-u>tabonly<CR>
nnoremap <silent>   [Tab]t  :<C-u>tab stag <C-r><C-w><CR>
nnoremap <silent>   [Tab]r  :<C-u>TabRecent<CR>
nnoremap            [Tab]w  <C-w>T
nnoremap <silent>   [Tab]L  :<C-u>TabMoveNext<CR>
nnoremap <silent>   [Tab]H  :<C-u>TabMovePrev<CR>
nnoremap            [Tab]1  1gt
nnoremap            [Tab]2  2gt
nnoremap            [Tab]3  3gt
nnoremap            [Tab]4  4gt
nnoremap            [Tab]5  5gt
nnoremap            [Tab]6  6gt
nnoremap            [Tab]7  7gt
nnoremap            [Tab]8  8gt
nnoremap            [Tab]9  9gt

" タグサーチ
nnoremap [Tag] <Nop>
nmap <C-t> [Tag]
nnoremap [Tag]j g<C-]>
nmap [Tag]<C-j> [Tag]j
nnoremap [Tag]t <C-t>
nmap [Tag]<C-t> [Tag]t
nnoremap [Tag]n :<C-u>tnext<CR>
nmap [Tag]<C-n> [Tag]n
nnoremap [Tag]p :<C-u>tprevious<CR>
nmap [Tag]<C-p> [Tag]p

" 起動時設定を開く
nnoremap <silent> [Space]v :<C-u>edit $MYVIMRC<CR>
nnoremap <silent> [Space]gv :<C-u>edit $MYGVIMRC<CR>

" 現在のバッファを読み込み
nnoremap [Space]<CR> :<C-u>source %<CR>

" オプション表示
nnoremap <C-s> :<C-u>ShowOption<Space>
command! -nargs=1 -complete=option ShowOption
    \ call s:ShowOption(<q-args>)
function! s:ShowOption(opt)
    if !empty(a:opt)
        execute 'verb set ' . a:opt . '?'
    endif
endfunction

" オプション切り替え
nnoremap [Toggle] <Nop>
nmap T [Toggle]
nnoremap [Toggle]w :<C-u>call <SID>ToggleLocalOption('wrap')<CR>
nmap [Toggle]W [Toggle]w
nnoremap [Toggle]l :<C-u>call <SID>ToggleLocalOption('list')<CR>
nmap [Toggle]L [Toggle]l
nnoremap [Toggle]h :<C-u>call <SID>ToggleLocalOption('hlsearch')<CR>
nmap [Toggle]H [Toggle]h
nnoremap [Toggle]n :<C-u>call <SID>ToggleLocalOption('number')<CR>
nmap [Toggle]N [Toggle]n
nnoremap [Toggle]r :<C-u>call <SID>ToggleLocalOption('relativenumber')<CR>
nmap [Toggle]R [Toggle]r
nnoremap [Toggle]c :<C-u>call <SID>ToggleLocalOption('ignorecase')<CR>
nmap [Toggle]C [Toggle]c
nnoremap [Toggle]e :<C-u>call <SID>ToggleLocalOption('expandtab')<CR>
nmap [Toggle]E [Toggle]e
nnoremap [Toggle]i :<C-u>call <SID>ToggleLocalOption('insertmode')<CR>
nmap [Toggle]I [Toggle]i
nnoremap [Toggle]f :<C-u>call <SID>ToggleFolding()<CR>
nmap [Toggle]F [Toggle]f

" タブ展開切り替え
nnoremap <silent> [Toggle]t :<C-u>setlocal expandtab! \| %retab!<CR>
nmap [Toggle]T [Toggle]t

" オプションの切り替えとその表示
function! s:ToggleLocalOption(opt)
    if exists('&' . a:opt)
        " トグルしてその値を表示
        execute 'setlocal ' . a:opt . '! | setlocal ' . a:opt . '?'
        return eval('&' . a:opt)
    else
        echo a:opt . ' というオプションは存在しません'
        return 0
    endif
endfunction

" フォールディング切り替え
nnoremap zi :<C-u>call <SID>ToggleFolding()<CR>
function! s:ToggleFolding()
    if s:ToggleLocalOption('foldenable')
        setlocal foldcolumn=5
    else
        setlocal foldcolumn=0
    endif
endfunction

" vimfiler
nnoremap <silent> [Space]e :<C-u>VimFilerBufferDir
    \ -buffer-name=explorer -toggle -split -horizontal -no-quit -winheight=10<CR>
autocmd MyAutocmd FileType vimfiler call <SID>VimFilerSettings()
function! s:VimFilerSettings()
    " qとQのキーマップ入れ替え
    " （qでバッファに残さないように終了する）
    "nmap <buffer> q <Plug>(vimfiler_exit)
    "nmap <buffer> Q <Plug>(vimfiler_hide)
endfunction

" Ref
nnoremap [Ref] <Nop>
nmap [Space]r [Ref]
nnoremap [Ref]e :<C-u>Ref webdict ej <C-r><C-w>
nnoremap [Ref]j :<C-u>Ref webdict je <C-r><C-w>
nnoremap [Ref]a :<C-u>Ref webdict alc <C-r><C-w>
nnoremap [Ref]t :<C-u>Ref webdict thesaurus <C-r><C-w>

" Unite関連
nnoremap <silent> [Space]f :<C-u>UniteWithBufferDir -buffer-name=files file file/new<CR>
nnoremap <silent> [Space]m :<C-u>Unite -buffer-name=files file_mru bookmark<CR>
nnoremap <silent> [Space]b :<C-u>Unite -buffer-name=buffers buffer_tab<CR>
nnoremap <silent> [Space]/ :<C-u>Unite -buffer-name=search -start-insert line/fast<CR>
nnoremap <silent> [Space]g/ :<C-u>Unite -buffer-name=search -start-insert line_migemo<CR>
nnoremap <silent> [Space]* :<C-u>UniteWithCursorWord -buffer-name=search line/fast<CR>
nnoremap <silent> [Space]h :<C-u>UniteWithInput -buffer-name=help -resume help<CR>
nnoremap <silent> [Space]q :<C-u>Unite -no-quit qf<CR>
nnoremap <silent> [Space]j :<C-u>Unite change jump<CR>
nnoremap <silent> [Space]x :<C-u>Unite file_point<CR>
nnoremap <silent> [Space]t :<C-u>Unite -buffer-name=tag tag tag/include<CR>
nnoremap <silent> [Space]y :<C-u>Unite history/yank<CR>

nnoremap [Unite] <Nop>
nmap [Space]u   [Unite]
nmap U          [Unite]
nnoremap <silent> [Unite]f :<C-u>UniteWithBufferDir -buffer-name=files file_rec file/new<CR>
nnoremap <silent> [Unite]m :<C-u>Unite -buffer-name=marks -auto-preview mark<CR>
nnoremap <silent> [Unite]r :<C-u>Unite -buffer-name=registers register<CR>
nnoremap <silent> [Unite]b :<C-u>Unite -buffer-name=buffers buffer<CR>
nnoremap <silent> [Unite]a :<C-u>UniteBookmarkAdd<CR>
nnoremap <silent> [Unite]o :<C-u>Unite -auto-preview outline<CR>
nnoremap <silent> [Unite]g :<C-u>Unite -buffer-name=search -no-quit -resume grep<CR>
nnoremap <silent> [Unite]v :<C-u>Unite -auto-preview colorscheme<CR>
nnoremap <silent> [Unite]c :<C-u>Unite history/command command<CR>
nnoremap <silent> [Unite]q :<C-u>Unite qfixhowm<CR>

" textmanip
" 選択したテキストの移動
xmap <C-j> <Plug>(textmanip-move-down)
xmap <C-k> <Plug>(textmanip-move-up)
xmap <C-h> <Plug>(textmanip-move-left)
xmap <C-l> <Plug>(textmanip-move-right)
" 行の複製
NXmap <M-d> <Plug>(textmanip-duplicate-down)
NXmap <M-u> <Plug>(textmanip-duplicate-up)

" winmove.vim
let g:winmove_no_default_keymappings = 1
call submode#enter_with('winmove', 'n', '', '<C-w>m', '<Nop>')
call submode#map('winmove', 'n', 'r', 'j', '<Plug>(winmove-down)')
call submode#map('winmove', 'n', 'r', 'k', '<Plug>(winmove-up)')
call submode#map('winmove', 'n', 'r', 'h', '<Plug>(winmove-left)')
call submode#map('winmove', 'n', 'r', 'l', '<Plug>(winmove-right)')

" ウィンドウサイズ変更
call submode#enter_with('winsize', 'n', '', '<C-w>+', '<C-w>+')
call submode#enter_with('winsize', 'n', '', '<C-w>-', '<C-w>-')
call submode#enter_with('winsize', 'n', '', '<C-w>>', '<C-w>>')
call submode#enter_with('winsize', 'n', '', '<C-w><', '<C-w><')
call submode#map('winsize', 'n', '', '>', '<C-w>>')
call submode#map('winsize', 'n', '', '<', '<C-w><')
call submode#map('winsize', 'n', '', '+', '<C-w>+')
call submode#map('winsize', 'n', '', '-', '<C-w>-')
call submode#map('winsize', 'n', '', '_', '<C-w>_')

" Ref
nnoremap <silent> <expr> K
    \ ':Ref webdict alc ' . GetCursorWord('[a-zA-Z]*') . '<CR>'


"-------------------------------------------------------------------------------
" 挿入モードキーマップ
"-------------------------------------------------------------------------------

inoremap <expr> <CR> pumvisible() ? neocomplete#smart_close_popup() : '<CR>'
inoremap <expr> <C-y> neocomplete#close_popup()
inoremap <expr> <C-e> neocomplete#cancel_popup()
inoremap <expr> <C-g> neocomplete#undo_completion()

" IME切り替え
if s:is_windows
    inoremap <C-@> <C-^>
elseif s:is_unix
    inoremap <C-@> <C-Space>
endif

" capslock
imap <C-l> <C-o><Plug>CapsLockToggle
cmap <C-l> <Plug>CapsLockToggle
" TODO: ステータスラインで状態表示


"-------------------------------------------------------------------------------
" コマンドラインキーマップ
"-------------------------------------------------------------------------------

cnoremap <C-n> <Down>
cnoremap <C-p> <Up>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-k> <C-\>e getcmdpos() == 1 ? "" : getcmdline()[:getcmdpos()-2]<CR>
cnoremap <C-y> <C-r>"
" 単語境界入力
cnoremap <C-t> \<\><Left><Left>
" 置換
cnoremap <C-s> :%substitute/
" 検索パターン入力中の特定の文字のエスケープ
" <C-v>に続ければそのまま入力
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'
cnoremap <expr> [ match(getcmdtype(), '[/?]') != -1 ? '\[' : '['


"-------------------------------------------------------------------------------
" テキストオブジェクト
"-------------------------------------------------------------------------------

" <angle>
onoremap aa  a>
xnoremap aa  a>
onoremap ia  i>
xnoremap ia  i>

" [rectangle]
onoremap ar  a]
xnoremap ar  a]
onoremap ir  i]
xnoremap ir  i]

" (bracket)
onoremap ab  a)
xnoremap ab  a)
onoremap ib  i)
xnoremap ib  i)

" {Bracket}
onoremap aB  a}
xnoremap aB  a}
onoremap iB  i}
xnoremap iB  i}

" 'quote'
onoremap aq  a'
xnoremap aq  a'
onoremap iq  i'
xnoremap iq  i'

" "double quote"
onoremap ad  a"
xnoremap ad  a"
onoremap id  i"
xnoremap id  i"


"*******************************************************************************
" Abbreviates:
"*******************************************************************************

" 略記を展開する
function! s:AbbrevCommentLine(head, body)
    let till = 80   " 80行目まで
    let offset = 2  " 2文字分のオフセット
    let repeats = till / len(a:body) - virtcol('.') - (len(a:head) - 1) + offset
    return a:head . repeat(a:body, repeats)
endfunction

" 略記を定義する
function! s:AbbrevDef()
    " コメント文字の取得
    " 展開するときに定義されていないといけないので、b:で定義
    let b:head = s:CommentStr()
    if empty(b:head)
        return
    endif

    inoreabbrev <buffer> <expr> @= <SID>AbbrevCommentLine(b:head, '=')
    inoreabbrev <buffer> <expr> @- <SID>AbbrevCommentLine(b:head, '-')
    inoreabbrev <buffer> <expr> @+ <SID>AbbrevCommentLine(b:head, '+')
    inoreabbrev <buffer> <expr> @\| <SID>AbbrevCommentLine(b:head, '\|')
    inoreabbrev <buffer> <expr> @* <SID>AbbrevCommentLine(b:head, '*')
    inoreabbrev <buffer> <expr> @/ <SID>AbbrevCommentLine(b:head, '/')
    inoreabbrev <buffer> <expr> @# <SID>AbbrevCommentLine(b:head, '#')
    inoreabbrev <buffer> <expr> @> <SID>AbbrevCommentLine(b:head, '>')
    inoreabbrev <buffer> <expr> @< <SID>AbbrevCommentLine(b:head, '<')
    inoreabbrev <buffer> <expr> @x <SID>AbbrevCommentLine(b:head, 'x')
    inoreabbrev <buffer> <expr> @r <SID>AbbrevCommentLine(b:head, '<>')
endfunction

" ファイルタイプ設定時に略記定義
autocmd MyAutocmd FileType * call <SID>AbbrevDef()

" 単語境界挿入
cnoreabbrev @b \<\><Left><Left>
" $MYVIMRC,$MYGVIMRC
cnoreabbrev @v $MYVIMRC
cnoreabbrev @g $MYGVIMRC


"*******************************************************************************
" unlet variables.
"*******************************************************************************
unlet s:is_gui
unlet s:is_windows
unlet s:is_unix
unlet s:dotvimdir


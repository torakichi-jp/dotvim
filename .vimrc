" vim: set sw=4 ts=4 et fdm=marker:
"*******************************************************************************
"
" Vim Settings:
"
"*******************************************************************************

"===============================================================================
" Initializing: "{{{1
"===============================================================================

scriptencoding utf-8    " encoding of this script
set nocompatible        " Vi IMproved
set shellslash          " path delimiter is slash

" switching variables
let s:is_gui = has('gui_running')
let s:is_windows = has('win16') || has('win32') || has('win64')
let s:is_unix = has('unix')
let s:is_cygwin = has('win32unix')

" encoding "{{{
if has('vim_starting')
    if s:is_windows
        set termencoding=cp932
    endif
    "set encoding=utf-8      " internal encoding
endif
"}}}

" set <leader> key
let g:mapleader=','

" candidates of dotvimdir path ordered in priority
let s:dotvimdir_candidates = [
    \ expand('~/vimfiles'),
    \ expand('~/.vim'),
    \ expand('~/dotvim/vimfiles'),
    \ expand('~/dotvim/.vim'),
    \ expand('~/dotvim'),
\ ]

" path to .vim directory
function! s:get_dotvimdir_var()
    " return path that found first
    for dir in s:dotvimdir_candidates
        if isdirectory(l:dir)
            return l:dir
        endif
    endfor
    return ''
endfunction

" path to .gvimrc
function! s:get_gvimrc_var()
    if filereadable(expand('~/_gvimrc'))
        return expand('~_gvimrc')
    elseif filereadable(expand('~/.gvimrc'))
        return expand('~/.gvimrc')
    endif
    return ''
endfunction

if !exists('$DOTVIMDIR')
    let $DOTVIMDIR = s:get_dotvimdir_var()
endif

if !exists('$MYGVIMRC')
    let $MYGVIMRC = s:get_gvimrc_var()
endif

" syntax
syntax enable

" initialize autocmd
augroup MyAutocmd
    autocmd!
augroup END

" }}}
"===============================================================================
" Plugins: "{{{1
"===============================================================================

" disable filetypes temporarily
filetype off
filetype plugin indent off

" initialize neobundle
if has('vim_starting')
    let &runtimepath = &runtimepath . ',' . $DOTVIMDIR . '/bundle/neobundle.vim'
endif

"call neobundle#begin($DOTVIMDIR . '/bundle')
call neobundle#rc($DOTVIMDIR . '/bundle')

"-------------------------------------------------------------------------------
" Bundles: "{{{2
"-------------------------------------------------------------------------------

NeoBundleFetch 'Shougo/neobundle.vim', { 'stay_same' : 1 }
NeoBundle 'Shougo/neobundle-vim-recipes'
NeoBundle 'Shougo/vimproc.vim'
NeoBundle 'Shougo/vimshell', {
    \ 'lazy' : 1,
    \ 'autoload' : {
        \ 'commands' : [
            \ {
                \ 'name' : 'VimShell',
                \ 'complete' : 'customlist,vimshell#complete',
            \ },
        \ ],
        \ 'mappings' : ['<Plug>(vimshell_switch)'],
    \}
\}
NeoBundle 'yomi322/vim-gitcomplete', {
    \ 'lazy' : 1,
    \ 'autoload' : {
        \ 'filetype' : 'vimshell',
    \ }
\ }
NeoBundle 'Shougo/vimfiler', {
    \ 'lazy' : 1,
    \ 'depends' : 'Shougo/unite.vim',
    \ 'autoload' : {
        \ 'commands' : [
            \ { 'name' : 'VimFiler',
                \ 'complete' : 'customlist,vimfiler#complete' },
            \ { 'name' : 'VimFilerExplorer',
                \ 'complete' : 'customlist,vimfiler#complete' },
            \ { 'name' : 'VimFilerBufferDir',
                \ 'complete' : 'customlist,vimfiler#complete' },
        \ ],
        \ 'mappings' : ['<Plug>(vimfiler_switch)'],
        \ 'explorer' : 1,
    \ }
\ }
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/neocomplcache.vim', {
    \ 'lazy' : 1,
    \ 'autoload' : {
        \ 'commands' : 'NeoCompleCacheEnable',
    \ }
\ }
NeoBundle 'Shougo/neosnippet', {
    \ 'lazy' : 1,
    \ 'autoload' : {
        \ 'insert' : 1,
        \ 'filetype' : 'snippet',
        \ 'unite_sources' : [
            \ 'snippet', 'neosnippet/user', 'neosnippet/runtime'
        \ ],
    \ }
\ }
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/vinarise', {
    \ 'lazy' : 1,
    \ 'autoload' : { 'commands' : 'Vinarise' },
\ }
NeoBundle 'thinca/vim-visualstar'
NeoBundle 'thinca/vim-tabrecent'
NeoBundle 'thinca/vim-qfreplace'
NeoBundle 'thinca/vim-ref', {
    \ 'lazy' : 1,
    \ 'autoload' : {
        \ 'commands' : [
            \ {
                \ 'name' : 'Ref',
                \ 'complete' : 'customlist,ref#complate',
            \ },
        \ ],
    \ }
\ }
NeoBundle 'thinca/vim-fontzoom', {
    \ 'lazy' : 1,
    \ 'autoload' : {
        \ 'mappings' : [
            \ ['n', '<Plug>(fontzoom-larger)'],
            \ ['n', '<Plug>(fontzoom-smaller)'],
        \ ]
    \ }
\ }
NeoBundle 'thinca/vim-openbuf'
NeoBundle 'thinca/vim-quickrun', {
    \ 'lazy' : 1,
    \ 'autoload' : {
        \ 'mappings' : [['nxo', '<Plug>(quickrun)']],
        \ 'commands' : 'QuickRun',
    \ }
\ }
NeoBundle 'thinca/vim-editvar'
NeoBundle 'thinca/vim-localrc'
NeoBundleLazy 'thinca/vim-singleton'
NeoBundle 'koron/codic-vim'
NeoBundleLazy 'mattn/calendar-vim'
NeoBundle 'mattn/wwwrenderer-vim'
NeoBundle 'mattn/webapi-vim'
NeoBundleLazy 'mattn/zencoding-vim'
NeoBundle 'tyru/vim-altercmd'
NeoBundle 'tyru/restart.vim'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'tyru/open-browser-github.vim'
NeoBundle 'tyru/winmove.vim'
NeoBundle 'kien/ctrlp.vim'
"NeoBundle 'ynkdir/vim-guess'
NeoBundle 'sgur/ctrlp-extensions.vim'
NeoBundle 'chrismetcalf/vim-taglist'
NeoBundle 'taku-o/vim-toggle'
NeoBundle 'taku-o/vim-batch-source'
NeoBundle 'kana/vim-tabpagecd'
NeoBundle 'kana/vim-niceblock'
NeoBundle 'kana/vim-submode'
NeoBundle 'dannyob/quickfixstatus'
NeoBundle 'jceb/vim-hier'
NeoBundle 'deris/vim-rengbang'
NeoBundle 'osyo-manga/vim-anzu'
NeoBundle 'osyo-manga/vim-jplus'
NeoBundle 'osyo-manga/vim-over'
NeoBundle 'LeafCage/foldCC'
NeoBundle 'tpope/vim-capslock', {'lazy' : 1, 'autoload' : {'insert' : 1}}
NeoBundle 'tpope/vim-rails'
NeoBundle 'gregsexton/gitv'
NeoBundle 'gregsexton/VimCalc'
NeoBundle 't9md/vim-quickhl'
NeoBundle 'fuenor/qfixhowm'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'itchyny/landscape.vim'
NeoBundle 'itchyny/calendar.vim'
NeoBundle 'itchyny/thumbnail.vim'
NeoBundle 'h1mesuke/vim-alignta'
NeoBundle 'daisuzu/translategoogle.vim'
NeoBundle 'haya14busa/vim-migemo'
NeoBundle 'basyura/TweetVim', {
    \ 'lazy' : 1,
    \ 'depends' : [
        \ 'basyura/twibill.vim', 'tyru/open-browser.vim',
        \ 'basyura/bitly.vim', 'mattn/favstar-vim',
    \ ],
    \ 'autoload' : {
        \ 'commands' : [
            \ 'TweetVimHomeTimeline',
            \ 'TweetVimCommandSay',
            \ 'TweetVimSay',
        \ ]
    \ },
\ }
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'rhysd/accelerated-jk'
NeoBundle 'tanabe/ToggleCase-vim'
NeoBundle 'rking/ag.vim'
NeoBundle 'anyakichi/vim-surround', {
    \ 'lazy' : 1,
    \ 'autoload' : {
        \ 'mappings' : [
            \ ['n', '<Plug>Dsurround'], ['n', '<Plug>Csurround' ],
            \ ['n', '<Plug>Ysurround'], ['n', '<Plug>YSurround' ],
            \ ['n', '<Plug>Vsurround'], ['n', '<Plug>VSurround' ],
        \ ]
    \ }
\ }

NeoBundle 'Colour-Sampler-Pack'
NeoBundle 'sudo.vim'
NeoBundleLazy 'colorsel.vim'
NeoBundleLazy 'vimwiki'
NeoBundleLazy 'CSApprox'

" Ruby static code analyzer.
NeoBundleLazy 'ngmy/vim-rubocop', {
    \ 'autoload' : { 'filetypes' : ['ruby'] }
\ }
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-rvm'
NeoBundle 'tpope/vim-rake'
NeoBundle 'tpope/vim-bundler'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'ngmy/vim-rubocop'
NeoBundle 'nono/jquery.vim'
NeoBundle 'astashov/vim-ruby-debugger'
NeoBundle 'lucapette/vim-jquery-doc'
NeoBundle 'kchmck/vim-coffee-script'

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
" unite.vim 
NeoBundle 'Shougo/unite.vim', {
    \ 'lazy' : 1,
    \ 'autoload' : {
        \ 'commands' : [
            \ { 'name' : 'Unite', 'complete' : 'customlist,unite#complete_source' },
            \ 'UniteWithInput',
            \ 'UniteWithBufferDir',
            \ 'UniteWithCursorWord',
        \ ]
    \ }
\ }
NeoBundle 'basyura/unite-matcher-file-name'
NeoBundle 'Shougo/neomru.vim', {
    \ 'lazy' : 1,
    \ 'depends' : 'Shougo/unite.vim',
    \ 'autoload' : {
        \ 'unite_sources' : ['neomru/file', 'neomru/directory']
    \ }
\ }
NeoBundle 'Shougo/unite-session', {
    \ 'lazy' : 1,
    \ 'autoload' : {
        \ 'unite_sources' : 'session'
    \ }
\ }
NeoBundle 'thinca/vim-unite-history', {
    \ 'lazy' : 1,
    \ 'autoload' : {
        \ 'unite_sources' : ['history/command', 'history/search']
    \ }
\ }
NeoBundle 'h1mesuke/unite-outline', {
    \ 'lazy' : 1,
    \ 'autoload' : {
        \ 'unite_sources' : 'outline'
    \ }
\ }
NeoBundle 'tsukkee/unite-tag', {
    \ 'lazy' : 1,
    \ 'autoload' : {
        \ 'unite_sources' : 'tag'
    \ }
\ }
NeoBundle 'tsukkee/unite-help', {
    \ 'lazy' : 1,
    \ 'autoload' : {
        \ 'unite_sources' : 'help'
    \ }
\ }
NeoBundle 'tacroe/unite-mark', {
    \ 'lazy' : 1,
    \ 'autoload' : {
        \ 'unite_sources' : 'mark'
    \ }
\ }
NeoBundle 'sgur/unite-qf', {
    \ 'lazy' : 1,
    \ 'autoload' : {
        \ 'unite_sources' : 'qf'
    \ }
\ }
NeoBundle 'ujihisa/unite-colorscheme', {
    \ 'lazy' : 1,
    \ 'autoload' : {
        \ 'unite_sources' : 'colorscheme'
    \ }
\ }
NeoBundle 'osyo-manga/unite-qfixhowm', {
    \ 'lazy' : 1,
    \ 'autoload' : {
        \ 'unite_sources' : 'qfixhowm'
    \ }
\ }
NeoBundle 'kannokanno/unite-todo', {
    \ 'lazy' : 1,
    \ 'autoload' : {
        \ 'unite_sources' : 'todo'
    \ }
\ }
NeoBundle 'Shougo/unite-build', {
    \ 'lazy' : 1,
    \ 'autoload' : {
        \ 'unite_sources' : 'build'
    \ }
\ }
NeoBundle 'kmnk/vim-unite-giti', {
    \ 'lazy' : 1,
    \ 'autoload' : {
        \ 'unite_sources' : 'giti'
    \ }
\ }
NeoBundleLazy 'choplin/unite-vim_hacks'

NeoBundle 'kana/vim-operator-user'
NeoBundle 'kana/vim-operator-replace'
NeoBundle 'tyru/operator-camelize.vim'
NeoBundle 'tyru/operator-reverse.vim'
NeoBundle 'emonkak/vim-operator-sort'

NeoBundle 'vim-jp/vimdoc-ja'
NeoBundle 'mattn/learn-vimscript'

"2}}}
"-------------------------------------------------------------------------------
" Plugin Settings: "{{{
"-------------------------------------------------------------------------------

" disable GetLatestVimPlugin.vim
let g:loaded_getscriptPlugin = 1
" disable netrw.vim
let g:loaded_netrwPlugin = 1

" vimproc build setting
call neobundle#config(
    \ 'vimproc.vim', {
        \ 'build' : {
            \ 'cygwin'    : 'make -f make_cygwin.mak',
            \ 'mac'       : 'make -f make_mac.mak',
            \ 'unix'      : 'make -f make_unix.mak',
        \ }
    \ }
\ )
" if you use windows and that is not installed msvc, you must build manually
" $VCINSTALLDIR envvar have to declare in advance
if has('win64') && isdirectory($VCINSTALLDIR)
    call neobundle#config(
        \ 'vimproc.vim', {
            \ 'build' : {
                \ 'windows' : '"' . $VCINSTALLDIR . '/vcvarsall.bat" amd64 & ' .
                    \ 'nmake /f make_msvc64.mak',
            \ }
        \ }
    \ )
elseif has('win32') && isdirectory($VCINSTALLDIR)
    call neobundle#config(
        \ 'vimproc.vim', {
            \ 'build' : {
                \ 'windows' : '"' . $VCINSTALLDIR . '/vcvarsall.bat" x86 & ' .
                    \ 'nmake /f make_msvc32.mak',
            \ }
        \ }
    \ )
endif

" neocomplete
let g:neocomplete#enable_at_startup = 1
let s:hooks = neobundle#get_hooks('neocomplete.vim')
function! s:hooks.on_source(bundle)
    let g:neocomplete#enable_auto_select = 1
    let g:neocomplete#disable_auto_complete = 1
    let g:neocomplete#enable_fuzzy_completion = 0
    let g:neocomplete#enable_refresh_always = 0
    let g:neocomplete#auto_completion_start_length = 3
    let g:neocomplete#use_vimproc = 1
endfunction

" vimfiler
let s:hooks = neobundle#get_hooks('vimfiler')
function! s:hooks.on_source(bundle)
    let g:vimfiler_as_default_explorer = 1
    let g:vimfiler_safe_mode_by_default = 0
endfunction

" vimshell
let s:hooks = neobundle#get_hooks('vimshell')
function! s:hooks.on_source(bundle)
    let g:vimshell_user_prompt = 'fnamemodify(getcwd(), '':~'')'
    let g:vimshell_enable_smart_case = 1
    if s:is_windows
        " Display user name on Windows.
        let g:vimshell_prompt = $USERNAME."% "
    else
        " Display user name on Linux.
        let g:vimshell_prompt = $USER."% "
    endif
endfunction

" Unite
let s:hooks = neobundle#get_hooks('unite.vim')
function! s:hooks.on_source(bundle)
    let g:unite_winheight = 10
    let g:unite_enable_start_insert = 0
    let g:unite_force_overwrite_statusline = 0

    " unite-menu
    if !exists('g:unite_source_menu_menus')
        let g:unite_source_menu_menus = {}
    endif

    " add encoding items into unite-menu
    let g:unite_source_menu_menus.encoding = {
        \'description' : 'Encoding',
    \ }
    let g:unite_source_menu_menus.encoding.command_candidates = [
        \ ['UTF-8',     'Utf8'],
        \ ['SHIFT-JIS', 'Sjis'],
        \ ['EUC-JP',    'Euc'],
        \ ['JIS',       'Jis'],
        \ ['Unicode',   'Utf16'],
        \ ['UCS-2',     'Utf16be'],
    \ ]

endfunction

"quickrun
if has('win32') || has('win64')
    function! s:hook_quickrun_windows()
        let l:hook = {
            \    'name' : 'myHook',
            \    'kind' : 'hook',
            \}

        function! l:hook.init(session)
            set noshellslash
        endfunction

        function! l:hook.sweep()
            set shellslash
        endfunction

        call quickrun#module#register(l:hook)
        autocmd MyAutocmd FileType quickrun setl ff=dos

    endfunction

    let s:hooks = neobundle#get_hooks('vim-quickrun')
    function! s:hooks.on_source(bundle)
        call s:hook_quickrun_windows()
    endfunction
endif

" vim-ref
let s:hooks = neobundle#get_hooks('vim-ref')
function! s:hooks.on_source(bundle)
    let g:ref_use_vimproc = 1
    if s:is_windows
        "let g:ref_source_webdict_encoding = 'EUC-JP'
        let g:ref_source_webdict_encoding = 'UTF-8'
    endif

    " set webdict sites
    let g:ref_source_webdict_sites = {
        \ 'je'          : {'url': 'http://dictionary.infoseek.ne.jp/jeword/%s',},
        \ 'ej'          : {'url': 'http://dictionary.infoseek.ne.jp/ejword/%s',},
        \ 'wiki'        : {'url': 'http://ja.wikipedia.org/wiki/%s',},
        \ 'alc'         : {'url': 'http://eow.alc.co.jp/search?q=%s',},
        \ 'weblio'      : {'url': 'http://www.weblio.jp/content/%s',},
        \ 'thesaurus'   : {'url': 'http://thesaurus.weblio.jp/content/%s',},
        \ 'wiktionary'  : {'url': 'http://ja.wiktionary.org/wiki/%s',},
    \ }

    " set filter for each sites
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

    " default site of webdict
    let g:ref_source_webdict_sites.default = 'alc'
endfunction

" NERD_commenter
let s:hooks = neobundle#get_hooks('nerdcommenter')
function! s:hooks.on_source(bundle)
    let g:NERDCreateDefaultMappings = 0
    let g:NERDSpaceDelims = 0
endfunction

" ctrlp.vim
let s:hooks = neobundle#get_hooks('ctrlp.vim')
function! s:hooks.on_source(bundle)
    let g:ctrlp_use_migemo = 1
    let g:ctrlp_clear_cache_on_exit = 0
    let g:ctrlp_mruf_max = 500
    let g:ctrlp_jump_to_buffer = 2
    let g:ctrlp_extensions = ['cmdline', 'yankring', 'menu']
endfunction

" powerline
"if s:is_gui || !s:is_windows
"    NeoBundleSource vim-powerline
"    NeoBundleSource vim-powerline-unite-theme
"    " powerline settings is in dotvim/vimfiles/plugin/autoload/Powerline/
"endif
"let s:hooks = neobundle#get_hooks('vim-powerline')
"function! s:hooks.on_source(bundle)
"    let g:Powerline_colorscheme='my'
"    let g:Powerline_theme = 'unite_status'
"    let g:Powerline_symbols = 'fancy'
"    let g:Powerline_stl_path_style = 'filename'
"
"    let g:Powerline_mode_n = 'Normal'
"    let g:Powerline_mode_i = 'Insert'
"    let g:Powerline_mode_R = 'Replace'
"    let g:Powerline_mode_v = 'Visual'
"    let g:Powerline_mode_V = 'V-Line'
"    let g:Powerline_mode_cv = 'V-Block'
"    let g:Powerline_mode_s = 'Select'
"    let g:Powerline_mode_S = 'S-Line'
"    let g:Powerline_mode_cs = 'S-Block'
"endfunction

" lightline
let g:lightline = {
      \ 'colorscheme': 'landscape',
      \ 'component': {
      \   'readonly': '%{&readonly?"\u2b64":""}',
      \ },
      \ 'component_function': {
      \     'currentdir': 'MyCurrentDir'
      \ },
      \ 'tab_component_function': {
      \     'closetab': 'MyCloseTab'
      \ },
      \ 'separator': { 'left': "\u2b80", 'right': "\u2b82" },
      \ 'subseparator': { 'left': "\u2b81", 'right': "\u2b83" },
      \ 'tabline': {
      \     'left': [ [ 'tabs' ] ],
      \     'right': [ [ 'close' ], [ 'currentdir' ] ]
      \ },
\ }
" for windows CUI
if s:is_windows && !s:is_gui
    let g:lightline.separator = { 'left': '', 'right': '' }
    let g:lightline.subseparator = { 'left': '>', 'right': '<' }
    let g:lightline.component.readonly = '%{&readonly?"=":""}'
endif

function! MyCurrentDir()
    let cur_dir = fnamemodify(getcwd(), ':~')
    if strlen(cur_dir) > &columns / 2
        let cur_dir = '.../' . fnamemodify(cur_dir, ':t')
    endif
    return cur_dir
endfunction
function! MyCloseTab(n)
    return '%' . a:n . 'X X'
endfunction

" QFixHowm
let g:mygrep = 'grep'
let g:howm_fileencoding = 'utf-8'

"indentLine
let g:indentLine_color_term = 111
let g:indentLing_color_gui = '#708090'
let g:indentLine_char = '|'

" EasyMotion
let g:EasyMotion_leader_key = '\'
let g:EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyz0123456789'
let g:EasyMotion_do_shade = 0

" openuri
if s:is_windows
    let openuri_cmd = '!start "rundll32.exe" url.dll,FileProtocolHandler %s'
endif

" ShowMarksでハイライトするマーク指定
let g:showmarks_include = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ<>'
" プラグインでマップされちゃうのでautocmdで定義
autocmd MyAutocmd VimEnter * call s:init_marks()
function! s:init_marks()    "{{{
    " TODO: mn, mp で（アルファベット順に）次のマークに移動するコードを書きたい
    " TODO: mcでマークを1行目に移動するのではなく、ちゃんと消したい
    " TODO: つーかShowMarksを自分用に書き直す？
    nnoremap <Plug>[Mark] <Nop>
    nmap m <Plug>[Mark]
    " ms{char}でマーク（通常のmと同じ）＆ShowMarksオン
    nnoremap <silent> <Plug>[Mark]s
    \ :<C-u>execute 'normal! m' . nr2char(getchar())<bar>ShowMarksOn<CR>
    " マーク位置へジャンプ(Find mark)
    nnoremap <Plug>[Mark]f `
    " マーク行へジャンプ(Go to mark)
    nnoremap <Plug>[Mark]g '
    " 別ウィンドウを開いてマーク行へジャンプ
    nnoremap <silent> <Plug>[Mark]w :<C-u>split +execute\ "normal!\ '".nr2char(getchar())<CR>
    " 次のマークを置く
    nnoremap <silent> <Plug>[Mark]m :<C-u>ShowMarksPlaceMark<CR>
    " ShowMarks切り替え(Toggle)
    nnoremap <silent> <Plug>[Mark]t :<C-u>ShowMarksToggle<CR>
    " ShowMarksオン(On)
    nnoremap <silent> <Plug>[Mark]o :<C-u>ShowMarksOn<CR>:echo 'ShowMarks On'<CR>
    " マークを隠す(Hide)
    nnoremap <silent> <Plug>[Mark]h :<C-u>ShowMarksHideAll<CR>:echo 'ShowMarks Off'<CR>
    " 現在行のマークをクリア(Clear)
    nnoremap <silent> <Plug>[Mark]c :<C-u>ShowMarksClearMark<CR>
    " 全マークをクリア(clear All)
    nnoremap <silent> <Plug>[Mark]a :<C-u>ShowMarksClearAll<CR>
    " マークリスト(Unite mark)
    nnoremap <silent> <Plug>[Mark]l :<C-u>:Unite -auto-preview mark<CR>
    nnoremap <Plug>[Mark]j ]`
    nnoremap <Plug>[Mark]k [`
endfunction
"}}}

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

" }}}

"call neobundle#end()

" required!
filetype plugin indent on

" plugin installation check
NeoBundleCheck

" }}}
"===============================================================================
" Option Settings: "{{{1
"===============================================================================

" adjust 'runtimepath'
function! s:adjust_rtp(runtimepath, dotvimdir) "{{{
ruby << END
    DOTVIM_CANDIDATES = VIM::evaluate('s:dotvimdir_candidates').freeze

    class String
      def expand
        VIM::evaluate 'expand("' + self + '")'
      end

      def directory?
        VIM::evaluate('isdirectory("' + self + '")').to_i != 0
      end
    end

    def adjust_rtp(rtp, dotvim)
      # delimiter is slash instead of backslash
      # create list split by comma
      # expand path
      rtps = rtp.gsub(/\\+/, '/').split(/,+/).map { |path| path.expand }

      # delete path that is not directory or included candidates of dotvimdir
      rtps.delete_if do |path|
        not path.directory? or DOTVIM_CANDIDATES.include? path
      end

      # add dotvim dir and dotvim/after dir
      rtps.insert(0, dotvim) << dotvim + '/after'

      # delete duplication
      rtps.uniq!

      # join each path
      rtps.join(',')
    end

    # set local var of Vim
    rtp = adjust_rtp VIM::evaluate('a:runtimepath'), VIM::evaluate('a:dotvimdir')
    VIM::command 'let l:rtp = "' + rtp + '"'
END
    return l:rtp
endfunction "}}}
if has('vim_starting')
    let &runtimepath = s:adjust_rtp(&runtimepath, $DOTVIMDIR)
endif

" Syntax settings "{{{

" VimScript "{{{
" syntax folding setting
" foldmethod=syntaxでないと意味なし
" augroup: a
" function: f
" lua: l
" perl: p
" ruby: r
" python: P
" tcl: t
" mzscheme: m
let g:vimsyn_folding = 'aflprPm'

" no error
let g:vimsyn_noerror = 1

" 行連結バックスラッシュをインデントしない
" (インデントする幅の設定)
let g:vim_indent_cont = 0
"}}}

"c, cpp, idlにdoxygenハイライトを設定する
let g:load_doxygen_syntax = 1
let g:doxygen_enhanced_color = 1

"}}}

" mouse behaves windows
behave mswin

" colorscheme
set t_Co=256
if s:is_windows && !s:is_gui
    colorscheme default
else
    colorscheme landscape
endif

" normal options "{{{

" use clipboard instead of unnamed register
"set clipboard& clipboard+=unnamed

set number                      " show line numbers
"set relativenumber             " show relative line numbers
set ruler                       " show ruler
set notitle                     " show not title of after exited Vim
set showcmd                     " show inserting command
set hidden                      " hide buffer instead to remove buffer updating
set confirm                     " show confirm dialog instead of error
set backspace=indent,eol,start  " delete each of these characters for backspace
set cursorline                  " hilight line at current cursor
set display=lastline            " show lastline as much as possible
set cmdheight=2                 " set command line height
set noequalalways               " disable automatical adjust window size
set wrap                        " wrap line of right edge
set textwidth=0                 " text width
set laststatus=2                " show statusline always
set showtabline=2               " show tabline always
set autoindent                  " enable auto indent
set switchbuf=split,newtab      " switch buffer option
set tabline=%!MakeTabLine()     " tabline strings
set helpheight=0                " min height of help
set helplang=ja                 " help language is japanese
set pumheight=10                " max height of popup menu
set previewheight=5             " height of preview window
set shortmess& shortmess+=I     " no launch message
"set showbreak=>\               " line head of wrap (attention: last space)
"set cpoptions+=n               " use number column to start wrap line
set cmdwinheight=5              " height of cmdwindow
set showmatch                   " jump to match pair temporarily
set matchtime=0                 " times to jump match pair
set virtualedit+=block          " virtual edit for visual block mode only
set cinoptions=:0,l1,g0,m1      " C/C++ indent option
set matchpairs& matchpairs+=<:> " add pair that is <>
set winaltkeys=no               " not use alt keys for GUI menu
set path+=;/                    " file path follows parent directory
set tags+=./tags;,./**/tags     " search path of tag files
set complete-=it                " remove "include, tag" from candidates
set completeopt=menu            " option of completion
set showfulltag                 " show tag pattern when tag completion
set viminfo& viminfo+=/0        " not write searching history
set timeout                     " enable timeout of key mappings
set timeoutlen=3000             " wait time of key mappings(ms)
set selectmode=                 " not use select mode
set sidescroll=1                " step of horizontal scroll
set sidescrolloff=1             " offset around cursor in horizontal scroll

" keep column as much as possible in the vertical movement
" (<C-d>, <C-u>, and so on)
set nostartofline

" not redraw of no typing command (key macros and so on)
"set lazyredraw

" enable extend command line complete and setting
set wildmenu
set wildmode=longest,full

" non-printable character display settings
set list
if &encoding =~? 'utf-8\|utf8'
    let &listchars="tab:\u2192\ ,trail:_,extends:>,precedes:<"
else
    set listchars=tab:>\ ,trails:_,extends:>,precedes:<
endif

" width of number column
augroup MyAutocmd
    autocmd BufEnter,WinEnter,BufWinEnter * let &l:numberwidth = len(line("$")) + 2
augroup END

"}}}

" tab, indent option " {{{
set tabstop=4           " タブ幅
set expandtab           " タブ展開する
set shiftwidth=4        " インデント幅
set softtabstop=4       " <Tab>や<BS>を入力したときの移動幅
" }}}

" searching option " {{{
set incsearch           " インクリメンタルサーチを有効
set nohlsearch          " 検索ハイライト無効
set ignorecase          " 大文字小文字を無視
set smartcase           " 大文字が含まれるときのみ無視しない
set wrapscan            " 最後まで行ったら最初に戻る
set grepprg=grep\ -nH   " grepプログラム
"set grepprg=ack\ -H    " grepにackを使う
set gdefault            " 候補を全部置換する
" }}}

" folding option " {{{
set foldenable          " 折りたたみを有効に
set foldcolumn=0        " 折りたたみ列数
set foldmethod=marker   " 印で折りたたみ
set foldtext=foldCC#foldtext()
let g:foldCCtext_enable_autofdc_adjuster = 1
" }}}

" タイトル行の表示設定
"set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:p:~:h\")})%)%(\ %a%)%(\ -\ %{v:servername}%)

" use mouse
if has('mouse')
    set mouse=a
endif

" 透明度(Windows only)
if s:is_windows && s:is_gui
    autocmd MyAutocmd VimEnter * set transparency=220
endif

" backup option " {{{
set backup                                  " バックアップする
let &backupdir = $DOTVIMDIR . '/.backup'   " バックアップを作成するディレクトリ
set undofile                                " アンドゥファイルを作成する
let &undodir = $DOTVIMDIR . '/.undo'       " アンドゥファイルを作成するディレクトリ
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
" }}}

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

" matchit extension
runtime macros/matchit.vim

" tabline view setting
function! MakeTabLine() "{{{
    " TODO: coding here at tabline view setting.
    let titles = map(range(1, tabpagenr('$')), 's:TabPageLabel(v:val)')
    let sep = ' '   " separator of tab
    let tabpages = join(titles, sep) . sep . '%#TabLineFill#%T'
    let info = ''   " you can insert infomation at here

    " view current directory
    let cur_dir = fnamemodify(getcwd(), ':~')
    if strlen(cur_dir) > &columns / 2
        let cur_dir = '.../' . fnamemodify(cur_dir, ':t')
    endif
    let info .= cur_dir . ' '

     view git branch
    let branch_info = fugitive#head()
    if !empty(branch_info)
        let info .= '[' . branch_info . '] '
    endif

    return tabpages . '%=' . info   " タブリストを左に、情報を右に表示
endfunction "}}}

" each tab view setting
function! s:TabPageLabel(n) "{{{
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
endfunction "}}}

" }}}
"===============================================================================
" User Commands: "{{{1
"===============================================================================

" NormalモードマッピングとVisualモードマッピングを一度に定義する
command! -bar -nargs=+ NXmap call s:NXmap(<q-args>, 0)
command! -bar -nargs=+ NXnoremap call s:NXmap(<q-args>, 1)
function! s:NXmap(args, noremaped)
    let remap_str = a:noremaped ? 'nore' : ""
    execute 'n' . remap_str . 'map ' . a:args
    execute 'x' . remap_str . 'map ' . a:args
endfunction

let s:map_option_default = {
    \ 'remap' : 1,
    \ 'buffer' : 0,
    \ 'silent' : 0,
    \ 'script' : 0,
    \ 'expr' : 0,
    \ 'unique' : 0,
\ }
function! s:map(mode, cmd, option)
    " key map definition
endfunction
unlet s:map_option_default

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

" Explorer
command! -nargs=? -complete=dir Explorer call s:Explorer(<q-args>)
function! s:Explorer(dir)
    let l:dir = a:dir
    if a:dir == ''
        let l:dir = '.'
    endif
    if s:is_windows
        execute 'VimProcBang rundll32 url.dll,FileProtocolHandler ' . l:dir
    elseif s:is_unix
        execute 'VimProcBang nautilus ' . l:dir
    endif

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

" オプション表示
command! -nargs=1 -complete=option ShowOption call <SID>show_option(<q-args>)
function! s:show_option(opt) "{{{
    if !empty(a:opt)
        execute 'verb set ' . a:opt . '?'
    endif
endfunction "}}}


" 設定ファイル内でAlterCommandを使うためにロード
call altercmd#load()

" AlterCommands "{{{
AlterCommand ct[ags]        VimProcBang ctags -R --jcode=utf8
AlterCommand u[nite]        Unite
AlterCommand maps           Unite -resume mapping
AlterCommand out[put]       Unite -resume output
AlterCommand gitb           UniteWithBufferDir giti/branch
AlterCommand gitc           UniteWithBufferDir giti/config
AlterCommand gitl           UniteWithBufferDir giti/log
AlterCommand gitr           UniteWithBufferDir giti/remote
AlterCommand gits           UniteWithBufferDir giti/status
AlterCommand rest[art]      RestartWithSession
AlterCommand cap[ture]      Capture
AlterCommand cdc[urrent]    CdCurrent
AlterCommand bat[ch]        Batch
AlterCommand ack            Ack
AlterCommand t[ranslate]    ExciteTranslate
AlterCommand alc            Ref webdict alc
AlterCommand ej             Ref webdict ej
AlterCommand je             Ref webdict je
" }}}

" }}}
"===============================================================================
" Functions: "{{{1
"===============================================================================

" Return string used to comment line for current filetype.
function! s:comment_str() "{{{
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
endfunction "}}}

" get word under cursor
function! s:get_cursor_word(pat) "{{{
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

" get word selected on visual mode
function! s:get_selected_text() "{{{
    let save_z = getreg('z', 1)
    let save_z_type = getregtype('z')

    try
        normal! gv"zy
        return @z
    finally
        call setreg('z', save_z, save_z_type)
    endtry
endfunction "}}}


" }}}
"===============================================================================
" Autocommands: "{{{1
"===============================================================================

augroup MyAutocmd

    " 81文字目以降に線を引く
    "autocmd FileType * call <SID>set_colorcolumn(81)
    "autocmd VimResized * call <SID>set_colorcolumn(81)
    function! s:set_colorcolumn(line_col) "{{{
        if &wrap
            if &columns > a:line_col
                execute "setlocal colorcolumn=" . join(range(a:line_col, &columns), ',')
            else
                setlocal colorcolumn=
            endif
        else
            execute "setlocal colorcolumn=" . join(range(a:line_col, 9999), ',')
        endif
    endfunction "}}}

    " （ヘルプとかを）qで終了
    autocmd FileType help,ref-* nnoremap <buffer> <silent> q :<C-u>close<CR>

    " gitのコミットメッセージを編集する時は、バックアップファイルを作らない
    autocmd FileType gitcommit setlocal nobackup noundofile noswapfile

    " コマンドラインウィンドウ用設定
    " 挿入モードではじめる
    autocmd CmdwinEnter * startinsert
    " qで終了する
    autocmd CmdwinEnter * nnoremap <buffer> <silent> q :<C-u>close<CR>

    " 前回のカーソル位置を復元
    autocmd BufRead *
        \ if line('''"') > 1 && line('''"') <= line('$') |
            \ execute 'normal! g`"zz' |
        \ endif

    " 直前の検索パターンと'hlsearch'をバッファローカルにする
    autocmd WinLeave *
        \ let b:vimrc_pattern = @/
        \ | let b:vimrc_hlsearch = &hlsearch
    autocmd WinEnter *
        \ let @/ = get(b:, 'vimrc_pattern', @/)
        \ | let &l:hlsearch = get(b:, 'vimrc_hlsearch', &l:hlsearch)

    " 設定されていないことが多い部分の色設定 "{{{
    autocmd ColorScheme * call <SID>set_guicolor()
    function! s:set_guicolor()
        hi TabLine      guifg=#777798 guibg=#444477 gui=NONE
        hi TabLineFill  guifg=#666688 guibg=#CCCCFF
        hi TabLineSel   guifg=#CCCCFF guibg=#111155 gui=bold

        hi FoldColumn   guifg=#818698 guibg=#363946
        hi ColorColumn  guifg=NONE    guibg=#333366 gui=NONE
        hi CursorLine   guifg=NONE    guibg=NONE   gui=underline
        hi SpecialKey   guifg=#444466 guibg=NONE    gui=NONE
    endfunction "}}}

    " 起動時にファイル引数なしならスクラッチバッファを開く "{{{
    "autocmd VimEnter *
    "    \ redir => mes |
    "    \ args |
    "    \ redir END |
    "    \ if empty(mes) |
    "        \ drop Scratch |
    "    \ endif |
    "    \ unlet mes
    "}}}

augroup END


" }}}
"===============================================================================
" Key Mappings: "{{{1
"===============================================================================

" prefix "{{{
nmap        <Space>         [Space]
xmap        <Space>         [Space]
nnoremap    [Space]         <Nop>
xnoremap    [Space]         <Nop>
nmap        [Space]<Space>  [WSpace]
xmap        [Space]<Space>  [WSpace]
nnoremap    [WSpace]        <Nop>
xnoremap    [WSpace]        <Nop>
nnoremap    <C-x>           <Nop>
xnoremap    <C-x>           <Nop>
nnoremap    <C-g>           <Nop>
xnoremap    <C-g>           <Nop>
"}}}

" has disabled
nnoremap Q <Nop>
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>

" split window with cursor word on line number and
" move to center of window
nnoremap <C-w><S-f> <C-w>Fzz

" vertical split window with cursor word on line number and
" move to center of window (like <C-w>F)
nnoremap <C-w><S-v> <C-W>vgFzz

" open file with :browse
nnoremap <C-x><C-e> :<C-u>browse edit<CR>

" write file with :browse
nnoremap <C-x><C-w> :<C-u>browse write<CR>

" exit like emacs
nnoremap <C-x><C-c> ZQ

" filetype insertion
nnoremap <C-x><C-f> :<C-u>setfiletype<Space>

" show option
nnoremap <C-x><C-o> :<C-u>ShowOption<Space>

" switch buffer
nnoremap <C-x><C-n> :<C-u>bnext<CR>
nnoremap <C-x><C-p> :<C-u>bprevious<CR>

" j, k mappings "{{{
if !neobundle#is_sourced('accelerated-jk')
    " j, k moves for view line (chages from gj, gk)
    nnoremap j gj
    nnoremap k gk
endif
nnoremap gj j
nnoremap gk k
"}}}

" j, k mappings when loaded accelerated-jk "{{{
let s:hooks = neobundle#get_hooks('accelerated-jk')
function! s:hooks.on_source(bundle)
    nmap j <Plug>(accelerated_jk_gj)
    nmap k <Plug>(accelerated_jk_gk)
endfunction
"}}}

" if cursor line is at foldclosed, 'l' open folding
nnoremap <expr> l foldclosed('.') < 0 ? 'l' : 'zo'

" smart toggle folding
nnoremap <silent><C-\> :<C-u>call <SID>smart_foldcloser()<CR>
function! s:smart_foldcloser() "{{{
    if foldlevel('.') == 0
        normal! zM
    elseif foldclosed('.') == -1
        normal! zc
    else
        normal! zo
    endif
    "if foldlevel('.') == 0
    "    norm! zM
    "    return
    "endif

    "let foldc_lnum = foldclosed('.')
    "norm! zc
    "if foldc_lnum == -1
    "    return
    "endif

    "if foldclosed('.') != foldc_lnum
    "    return
    "endif
    "norm! zM
endfunction
"}}}

" anzu.vim
let g:anzu_search_limit = 500
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star-with-echo)
nmap # <Plug>(anzu-sharp-with-echo)

" set folding marker
nnoremap z[ A "{{{<ESC>
nnoremap z] A "}}}<ESC>

" move begin/end of line
nnoremap gh g0
xnoremap gh g0
onoremap gh 0
nnoremap gl g$
xnoremap gl g$
onoremap gl $

" all select
nnoremap ga ggVG

" clipboard register
nnoremap X "*
xnoremap X "*

" grep
nnoremap gr :<C-u>Ag <C-r><C-w> *
xnoremap gr :<C-u>Ag <C-r>=<SID>get_selected_text()<CR> *

" quickhl
NXmap gm <Plug>(quickhl-toggle)
NXmap gM <Plug>(quickhl-reset)
"nmap gm <Plug>(quickhl-match)

" count words (:%substitute/\<word\>/&/gn)
nnoremap gw :<C-u>call <SID>count_words('\<' . expand('<cword>' . '\>'))<CR>
xnoremap gw :<C-u>call <SID>count_words(<SID>get_selected_text())<CR>
function! s:count_words(word) "{{{
    execute 'silent! %substitute/' . a:word . '/&/gn'
    echohl Search
    echo a:word . ' : ' . v:statusmsg
    echohl None
endfunction "}}}

" OpenBrowser
nmap gx <Plug>(openbrowser-open)
xmap gx <Plug>(openbrowser-open)
nnoremap <silent> gs
    \ :<C-u>call openbrowser#smart_search(<SID>get_cursor_word('\v\w*'))<CR>
xnoremap <silent> gs
    \ :<C-u>call openbrowser#smart_search(<SID>get_selected_text())<CR>

" ToggleCase
nnoremap <silent> <C-g>c :<C-u>call ToggleCase()<CR>

" YをDなどと同じような動作にする
nnoremap Y y$

" Ref "{{{
nnoremap [Ref] <Nop>
nmap [Space]r [Ref]
nnoremap [Ref]e :<C-u>Ref webdict ej <C-r><C-w>
nnoremap [Ref]j :<C-u>Ref webdict je <C-r><C-w>
nnoremap [Ref]a :<C-u>Ref webdict alc <C-r><C-w>
nnoremap [Ref]t :<C-u>Ref webdict thesaurus <C-r><C-w>
nnoremap <silent> <expr> K
    \ ':<C-u>Ref webdict alc ' . <SID>get_cursor_word('\v[a-zA-Z]*') . '<CR>'
xnoremap <silent> <expr> K
    \ ':<C-u>Ref webdict alc ' . <SID>get_selected_text() . '<CR>'
"}}}

" Visualモードでの連続貼り付け
xnoremap p "0p<CR>

" indent useful
nnoremap < <<
nnoremap > >>

" keep visual mode after indented
xnoremap < <gv
xnoremap > >gv

" 前後の関数の始め／終わりに移動
NXnoremap ]{ ]m
NXnoremap ]} ]M
NXnoremap [{ [m
NXnoremap [} [m

" move words
" TODO: 自作する？
"nmap w <Plug>(textobj-wiw-n)
"nmap b <Plug>(textobj-wiw-p)
"nmap e <Plug>(textobj-wiw-N)
"nmap ge <Plug>(textobj-wiw-P)

" search <cword> with split window
nnoremap <C-w>*  <C-w>s*
nnoremap <C-w>#  <C-w>s#

" preview tags if it is more candidates
nnoremap <C-]> g<C-]>

" move to match pair
map <C-j> %

" <C-k> で <C-t> と逆の動作 (タグスタックの新しいエントリにジャンプ)
nnoremap <C-k>  :<C-u>tag<CR>
" ]t, [t でもタグを行き来する
nnoremap ]t  :<C-u>tag<CR>
nnoremap [t  :<C-u>pop<CR>

" increment/decrement number
nnoremap + <C-a>
nnoremap - <C-x>

" view the help for <cword>
nnoremap <silent> <F1> :<C-u>help <C-r><C-w><CR>
xnoremap <silent> <F1> :<C-u>help <C-r>=<SID>get_selected_text()<CR>

" change directory at the buffer file
nnoremap <F2> :<C-u>cd %:p:h<Bar>echo 'cd :' expand('%:p:h')<CR>

" view directory at the buffer file
nnoremap <F3> :<C-u>echohl StatusLine<Bar>echo expand('%:p:h')<Bar>echohl None<CR>

" taglist
nnoremap <silent> <F4> :<C-u>TlistToggle<CR>

" reload screen
nnoremap <F5> <C-l>

" go to line if count is exist
" else redraw screen
noremap <silent> <CR> :<C-u>call <SID>cr_behavior()<CR>
function! s:cr_behavior() "{{{
    if v:count == 0
        redraw!
        if exists(':Nohlsearch')
            Nohlsearch
        else
            nohlsearch
        endif
    else
        execute 'normal! ' . string(v:count) . 'Gzz'
    endif
    return ""
endfunction "}}}

" タブページ用マップ "{{{
nnoremap <Plug>[Tab] <Nop>
nmap t <Plug>[Tab]
nnoremap            <Plug>[Tab]l  gt
nnoremap            <Plug>[Tab]h  gT
nnoremap            <Plug>[Tab]e  :<C-u>tabedit<Space>
nnoremap <silent>   <Plug>[Tab]n  :<C-u>tabedit<CR>
nnoremap <silent>   <Plug>[Tab]q  :<C-u>tabclose<CR>
nnoremap <silent>   <Plug>[Tab]c  :<C-u>tabclose<CR>
nnoremap <silent>   <Plug>[Tab]o  :<C-u>tabonly<CR>
nnoremap <silent>   <Plug>[Tab]t  :<C-u>tab stag <C-r><C-w><CR>
nnoremap <silent>   <Plug>[Tab]r  :<C-u>TabRecent<CR>
nnoremap            <Plug>[Tab]w  <C-w>T
nnoremap <silent>   <Plug>[Tab]L  :<C-u>TabMoveNext<CR>
nnoremap <silent>   <Plug>[Tab]H  :<C-u>TabMovePrev<CR>
nnoremap            <Plug>[Tab]1  1gt
nnoremap            <Plug>[Tab]2  2gt
nnoremap            <Plug>[Tab]3  3gt
nnoremap            <Plug>[Tab]4  4gt
nnoremap            <Plug>[Tab]5  5gt
nnoremap            <Plug>[Tab]6  6gt
nnoremap            <Plug>[Tab]7  7gt
nnoremap            <Plug>[Tab]8  8gt
nnoremap            <Plug>[Tab]9  9gt
"}}}

" open .vimrc or .gvimrc
nnoremap <silent> [Space]v :<C-u>edit $MYVIMRC<CR>
nnoremap <silent> [Space]gv :<C-u>edit $MYGVIMRC<CR>

" source current buffer file
nnoremap [Space]<CR> :<C-u>source %<CR>

" toggle options "{{{
nnoremap [Toggle] <Nop>
nmap T [Toggle]
nnoremap [Toggle]w :<C-u>call <SID>toggle_local_option('wrap')<CR>
nmap [Toggle]W [Toggle]w
nnoremap [Toggle]l :<C-u>call <SID>toggle_local_option('list')<CR>
nmap [Toggle]L [Toggle]l
nnoremap [Toggle]h :<C-u>call <SID>toggle_local_option('hlsearch')<CR>
nmap [Toggle]H [Toggle]h
nnoremap [Toggle]n :<C-u>call <SID>toggle_local_option('number')<CR>
nmap [Toggle]N [Toggle]n
nnoremap [Toggle]r :<C-u>call <SID>toggle_local_option('relativenumber')<CR>
nmap [Toggle]R [Toggle]r
nnoremap [Toggle]c :<C-u>call <SID>toggle_local_option('ignorecase')<CR>
nmap [Toggle]C [Toggle]c
nnoremap [Toggle]e :<C-u>call <SID>toggle_local_option('expandtab')<CR>
nmap [Toggle]E [Toggle]e
nnoremap [Toggle]i :<C-u>call <SID>toggle_local_option('insertmode')<CR>
nmap [Toggle]I [Toggle]i
nnoremap [Toggle]f :<C-u>call <SID>toggle_folding()<CR>
nmap [Toggle]F [Toggle]f
"}}}

" toggle to expand tab
nnoremap <silent> [Toggle]t :<C-u>setlocal expandtab! \| %retab!<CR>
nmap [Toggle]T [Toggle]t

" toggle option and view it
function! s:toggle_local_option(opt) "{{{
    if exists('&' . a:opt)
        " トグルしてその値を表示
        execute 'setlocal ' . a:opt . '! | setlocal ' . a:opt . '?'
        return eval('&' . a:opt)
    else
        echo a:opt . ' というオプションは存在しません'
        return 0
    endif
endfunction "}}}

" surround.vim "{{{
let g:surround_no_mappings = 1
autocmd MyAutocmd  VimEnter,FileType * call s:define_surround_keymappings()

function! s:define_surround_keymappings()
  if !&l:modifiable
    silent! nunmap <buffer> ds
    silent! nunmap <buffer> cs
    silent! nunmap <buffer> ys
    silent! nunmap <buffer> yS
    silent! xunmap <buffer> s
    silent! xunmap <buffer> S
    silent! nunmap <buffer> yp
  else
    nmap <buffer> ds <Plug>Dsurround
    nmap <buffer> cs <Plug>Csurround
    nmap <buffer> ys <Plug>Ysurround
    nmap <buffer> yS <Plug>YSurround
    xmap <buffer> s <Plug>Vsurround
    xmap <buffer> S <Plug>VSurround
    nmap <buffer> yp <Plug>Ysurroundiw
  endif
endfunction "}}}

" jplus
nmap [Space]J <Plug>(jplus-input)
xmap [Space]J <Plug>(jplus-input)

" toggle.vim
nmap <C-a> <Plug>ToggleN
imap <C-a> <Plug>ToggleI
vmap <C-a> <Plug>ToggleV

" operator "{{{
xmap P <Plug>(operator-replace)
xmap O <Plug>(operator-reverse-lines)
xmap R <Plug>(operator-reverse-text)
xmap C <Plug>(operator-camelize)
xmap D <Plug>(operator-decamelize)
xmap T <Plug>(operator-camelize-toggle)
xmap S <Plug>(operator-sort)
"}}}

" vim-fontzoom "{{{
let g:fontzoom_no_default_key_mappings = 1
call submode#enter_with('fontzoom', 'n', '', 'ZF', '<Nop>')
call submode#map('fontzoom', 'n', 'r', 'k', '<Plug>(fontzoom-larger)')
call submode#map('fontzoom', 'n', 'r', 'j', '<Plug>(fontzoom-smaller)')
"}}}

" NERD_Commenter "{{{
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
"}}}

" vimfiler "{{{
nnoremap <silent> [Space]e :<C-u>VimFilerBufferDir
    \ -buffer-name=explorer -toggle -split -horizontal -no-quit -winheight=10<CR>
autocmd MyAutocmd FileType vimfiler call <SID>vim_filer_settings()
function! s:vim_filer_settings()
    " exchange keymaps for 'q' and 'Q'
    " ('q' quit vimfiler not to remain on buffer)
    "nmap <buffer> q <Plug>(vimfiler_exit)
    "nmap <buffer> Q <Plug>(vimfiler_hide)
endfunction
"}}}

" VimShell
nnoremap <silent> [Space]s :<C-u>VimShell<CR>

" Unite "{{{
nnoremap <silent> [Space]f :<C-u>UniteWithBufferDir -buffer-name=files file file/new<CR>
nnoremap <silent> [Space]m :<C-u>Unite -buffer-name=files neomru/file<CR>
nnoremap <silent> [Space]d :<C-u>Unite -buffer-name=files -default-action=lcd neomru/directory<CR>
nnoremap <silent> [Space]b :<C-u>Unite -buffer-name=buffers buffer<CR>
nnoremap <silent> [Space]/ :<C-u>Unite -buffer-name=search -start-insert line/fast<CR>
nnoremap <silent> [Space]* :<C-u>UniteWithCursorWord -buffer-name=search line/fast<CR>
nnoremap <silent> [Space]h :<C-u>UniteWithInput -buffer-name=help -resume help<CR>
nnoremap <silent> [Space]q :<C-u>Unite -no-quit qf<CR>
nnoremap <silent> [Space]o :<C-u>Unite -resume output<CR>
nnoremap <silent> [Space]j :<C-u>Unite change jump<CR>
nnoremap <silent> [Space]x :<C-u>Unite file_point<CR>
nnoremap <silent> [Space]t :<C-u>Unite -buffer-name=tabs tab:no_current<CR>
nnoremap <silent> [Space]y :<C-u>Unite history/yank<CR>
nnoremap <silent> [Space]] :<C-u>UniteWithCursorWord -buffer-name=tag tag tag/include<CR>
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
nnoremap <silent> [Unite]t :<C-u>UniteWithCursorWord -buffer-name=tag tag tag/include<CR>
"}}}

" neocomplete
nmap [Space]nc [Neocom]
nnoremap [Neocom]l :<C-u>NeoCompleteLock<CR>
nnoremap [Neocom]u :<C-u>NeoCompleteUnlock<CR>
inoremap <C-x><C-l> :<C-u>NeoCompleteLock<CR>
inoremap <C-x><C-u> :<C-u>NeoCompleteUnlock<CR>

" winmove.vim
let g:winmove_no_default_keymappings = 1
call submode#enter_with('winmove', 'n', '', '<C-w>m', '<Nop>')
call submode#map('winmove', 'n', 'r', 'j', '<Plug>(winmove-down)')
call submode#map('winmove', 'n', 'r', 'k', '<Plug>(winmove-up)')
call submode#map('winmove', 'n', 'r', 'h', '<Plug>(winmove-left)')
call submode#map('winmove', 'n', 'r', 'l', '<Plug>(winmove-right)')

" resize window
call submode#enter_with('winsize', 'n', '', '<C-w>+', '<C-w>+')
call submode#enter_with('winsize', 'n', '', '<C-w>-', '<C-w>-')
call submode#enter_with('winsize', 'n', '', '<C-w>>', '<C-w>>')
call submode#enter_with('winsize', 'n', '', '<C-w><', '<C-w><')
call submode#map('winsize', 'n', '', '>', '<C-w>>')
call submode#map('winsize', 'n', '', '<', '<C-w><')
call submode#map('winsize', 'n', '', '+', '<C-w>+')
call submode#map('winsize', 'n', '', '-', '<C-w>-')
call submode#map('winsize', 'n', '', '_', '<C-w>_')


"-------------------------------------------------------------------------------
" Insertmode Mappings:
"-------------------------------------------------------------------------------
" {{{

" 補完
inoremap <expr> <CR> pumvisible() ? neocomplete#close_popup() : '<CR>'
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

" }}}

"-------------------------------------------------------------------------------
" Commandline Mappings:
"-------------------------------------------------------------------------------
" {{{

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
cnoremap <C-s> %substitute/
" 検索パターン入力中の特定の文字のエスケープ
" <C-v>に続ければそのまま入力
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'
cnoremap <expr> [ match(getcmdtype(), '[/?]') != -1 ? '\[' : '['

" }}}

"-------------------------------------------------------------------------------
" Textobject Mappings:
"-------------------------------------------------------------------------------
" {{{

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
" }}}

" }}}
"===============================================================================
" Abbreviates: "{{{1
"===============================================================================

" 略記を展開する
function! s:abbrev_comment_line(head, body)
    let till = 80   " 80列目まで
    let offset = 2  " 2文字分のオフセット
    let repeats = till / len(a:body) - virtcol('.') - (len(a:head) - 1) + offset
    return a:head . repeat(a:body, repeats)
endfunction

" 略記を定義する
function! s:abbrev_def()
    " コメント文字の取得
    " 展開するときに定義されていないといけないので、b:で定義
    let b:head = <SID>comment_str()
    if empty(b:head)
        return
    endif

    inoreabbrev <buffer> <expr> @= <SID>abbrev_comment_line(b:head, '=')
    inoreabbrev <buffer> <expr> @- <SID>abbrev_comment_line(b:head, '-')
    inoreabbrev <buffer> <expr> @+ <SID>abbrev_comment_line(b:head, '+')
    inoreabbrev <buffer> <expr> @\| <SID>abbrev_comment_line(b:head, '|')
    inoreabbrev <buffer> <expr> @* <SID>abbrev_comment_line(b:head, '*')
    inoreabbrev <buffer> <expr> @/ <SID>abbrev_comment_line(b:head, '/')
    inoreabbrev <buffer> <expr> @# <SID>abbrev_comment_line(b:head, '#')
    inoreabbrev <buffer> <expr> @> <SID>abbrev_comment_line(b:head, '>')
    inoreabbrev <buffer> <expr> @< <SID>abbrev_comment_line(b:head, '<')
    inoreabbrev <buffer> <expr> @x <SID>abbrev_comment_line(b:head, 'x')
    inoreabbrev <buffer> <expr> @r <SID>abbrev_comment_line(b:head, '<>')
endfunction

" ファイルタイプ設定時に略記定義
autocmd MyAutocmd FileType * call <SID>abbrev_def()

" 単語境界挿入
cnoreabbrev @b \<\><Left><Left>
" $MYVIMRC,$MYGVIMRC
cnoreabbrev @v $MYVIMRC
cnoreabbrev @g $MYGVIMRC


" }}}
"===============================================================================
" Terminating: "{{{1
"===============================================================================

" remove variables
unlet s:hooks

" Filetype setting
filetype plugin indent on

" Plugin installation check
NeoBundleCheck

" }}}


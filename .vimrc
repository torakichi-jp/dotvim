" vim: set sw=4 ts=4 et fdm=marker:
set encoding=utf-8      " internal encoding
scriptencoding utf-8    " encoding of this script

"*******************************************************************************
"
" Vim Settings:
"
" Author: とらきち(torakichi)
"
"*******************************************************************************

"===============================================================================
" Initializing: "{{{1
"===============================================================================

" no setting for vim-tiny or vim-small
if !1 | finish | endif

" Vi-Improved
if &compatible
    set nocompatible
endif

" switching variables "{{{
let s:is_gui         = has('gui_running')
let s:is_windows     = has('win32') || has('win64')
let s:is_windows_cui = s:is_windows && !s:is_gui
let s:is_unix        = has('unix')
let s:is_cygwin      = has('win32unix')
let s:is_starting    = has('vim_starting')
"}}}

"set shellslash         " path separator is slash
                        " Note: set in Windows local vimrc

" set $DOTVIM : path to .vim directory "{{{
if !exists('$DOTVIM')
    function! s:get_dotvimdir_var()
        " candidates of dotvim path ordered in priority
        let s:dotvimdir_candidates = [
            \ '~/vimfiles',
            \ '~/.vim',
            \ '~/dotvim/vimfiles',
            \ '~/dotvim/.vim',
            \ '~/dotvim',
        \ ]

        " return path that found first
        for item in s:dotvimdir_candidates
            let dotvim = expand(item)
            if isdirectory(dotvim)
                return dotvim
            endif
        endfor

        " if not found, return home directory
        return expand('~')
    endfunction

    let $DOTVIM = s:get_dotvimdir_var()
    delfunction s:get_dotvimdir_var
endif "}}}

" set $MYGVIMRC : path to .gvimrc "{{{
if !exists('$MYGVIMRC')
    function! s:get_gvimrc_var()
        if filereadable(expand('~/_gvimrc'))
            return expand('~_gvimrc')
        elseif filereadable(expand('~/.gvimrc'))
            return expand('~/.gvimrc')
        endif
        return ''
    endfunction

    let $MYGVIMRC = s:get_gvimrc_var()
    delfunction s:get_gvimrc_var
endif "}}}

" syntax
syntax enable

" initialize autocmd
augroup MyAutocmd
    autocmd!
augroup END

"}}}1
"===============================================================================
" Functions: "{{{1
"===============================================================================

" check whether encoding is Unicode
function! s:is_unicode_encoding() "{{{
    return &encoding =~? '^utf-\=8$'
endfunction "}}}

" dict of comment heads
let s:comment_heads = {
    \ 'cpp' :           '//',
    \ 'cs' :            '//',
    \ 'java' :          '//',
    \ 'javascript' :    '//',
    \ 'vim' :           '"',
    \ 'python' :        '#',
    \ 'ruby' :          '#',
    \ 'perl' :          '#',
    \ 'sh' :            '#',
    \ 'make' :          '#',
    \ 'lua' :           '--',
    \ 'haskell' :       '-- ',
    \ 'lisp' :          ';',
\ }

" return comment head of filetype
function! s:get_comment_head(filetype) "{{{
    return get(s:comment_heads, a:filetype, '')
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


"}}}1
"===============================================================================
" Plugins: "{{{1
"===============================================================================

" disable filetype plugin temporarily
filetype off
filetype plugin indent off

" bundle directory
let s:bundle_dir = $DOTVIM . '/bundle'

" initialize neobundle
if s:is_starting
    let &runtimepath = &runtimepath . ',' . s:bundle_dir . '/neobundle.vim'
endif

" begin bundling
call neobundle#begin(s:bundle_dir)

"-------------------------------------------------------------------------------
" Bundles: "{{{2
"-------------------------------------------------------------------------------

NeoBundleFetch 'Shougo/neobundle.vim'
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
NeoBundle 'haya14busa/vim-asterisk'
NeoBundle 'haya14busa/incsearch.vim'
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
NeoBundle 'thinca/vim-quickrun', {
    \ 'lazy' : 1,
    \ 'autoload' : {
        \ 'mappings' : [['nxo', '<Plug>(quickrun']],
        \ 'commands' : 'QuickRun',
    \ }
\ }
NeoBundle 'rhysd/wandbox-vim'
NeoBundle 'thinca/vim-editvar'
NeoBundle 'koron/codic-vim'
NeoBundle 'rhysd/unite-codic.vim'
NeoBundleLazy 'mattn/calendar-vim'
NeoBundle 'mattn/wwwrenderer-vim'
NeoBundle 'mattn/webapi-vim'
NeoBundleLazy 'mattn/emmet-vim'
NeoBundleLazy 'mattn/benchvimrc-vim'
NeoBundle 'tyru/vim-altercmd'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'tyru/open-browser-github.vim'
NeoBundle 'tyru/winmove.vim'
NeoBundle 'chrismetcalf/vim-taglist'
NeoBundle 'taku-o/vim-toggle'
NeoBundle 'taku-o/vim-batch-source'
NeoBundle 'kana/vim-tabpagecd'
NeoBundle 'kana/vim-niceblock'
NeoBundle 'kana/vim-submode'
NeoBundle 'kana/vim-smartword'
NeoBundle 'dannyob/quickfixstatus'
NeoBundle 'cohama/vim-hier'
NeoBundle 'deris/vim-rengbang'
NeoBundle 'osyo-manga/vim-anzu'
NeoBundle 'osyo-manga/vim-jplus'
NeoBundle 'osyo-manga/vim-over'
NeoBundle 'osyo-manga/vim-cpp-syntax-reserved_identifiers'
NeoBundle 'LeafCage/foldCC'
NeoBundle 'gregsexton/gitv'
NeoBundle 'gregsexton/VimCalc'
NeoBundle 't9md/vim-quickhl'
NeoBundle 'fuenor/qfixhowm'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'easymotion/vim-easymotion'
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
NeoBundle 'itchyny/vim-highlighturl'
NeoBundle 'itchyny/vim-external'
NeoBundle 'itchyny/vim-autoft'

NeoBundle 'sudo.vim'
NeoBundleLazy 'vimwiki'

NeoBundle 'slim-template/vim-slim'

" Ruby static code analyzer.
"NeoBundleLazy 'ngmy/vim-rubocop', {
"    \ 'autoload' : { 'filetypes' : ['ruby'] }
"\ }
"NeoBundle 'vim-ruby/vim-ruby'
"NeoBundle 'tpope/vim-rails'
"NeoBundle 'tpope/vim-rvm'
"NeoBundle 'tpope/vim-rake'
"NeoBundle 'tpope/vim-bundler'
"NeoBundle 'tpope/vim-fugitive'
"NeoBundle 'ngmy/vim-rubocop'
"NeoBundle 'nono/jquery.vim'
"NeoBundle 'astashov/vim-ruby-debugger'
"NeoBundle 'lucapette/vim-jquery-doc'
"NeoBundle 'kchmck/vim-coffee-script'

" Haskell plugins
NeoBundle 'eagletmt/ghcmod-vim'
NeoBundle 'eagletmt/unite-haddock'
NeoBundle 'kana/vim-filetype-haskell'
NeoBundle 'dag/vim2hs'
NeoBundle 'ujihisa/neco-ghc'
NeoBundle 'ujihisa/ref-hoogle'

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
    \ 'on_source' : 'unite.vim'
\ }
NeoBundle 'Shougo/unite-session', {
    \ 'lazy' : 1,
    \ 'on_source' : 'unite.vim'
\ }
NeoBundle 'thinca/vim-unite-history', {
    \ 'lazy' : 1,
    \ 'on_source' : 'unite.vim'
\ }
NeoBundle 'Shougo/unite-outline', {
    \ 'lazy' : 1,
    \ 'on_source' : 'unite.vim'
\ }
NeoBundle 'tsukkee/unite-tag', {
    \ 'lazy' : 1,
    \ 'on_source' : 'unite.vim'
\ }
NeoBundle 'tsukkee/unite-help', {
    \ 'lazy' : 1,
    \ 'on_source' : 'unite.vim'
\ }
NeoBundle 'tacroe/unite-mark', {
    \ 'lazy' : 1,
    \ 'on_source' : 'unite.vim'
\ }
NeoBundle 'sgur/unite-qf', {
    \ 'lazy' : 1,
    \ 'on_source' : 'unite.vim'
\ }
NeoBundle 'ujihisa/unite-colorscheme', {
    \ 'lazy' : 1,
    \ 'on_source' : 'unite.vim'
\ }
NeoBundle 'osyo-manga/unite-qfixhowm', {
    \ 'lazy' : 1,
    \ 'on_source' : 'unite.vim'
\ }
NeoBundle 'kannokanno/unite-todo', {
    \ 'lazy' : 1,
    \ 'on_source' : 'unite.vim'
\ }
NeoBundle 'Shougo/unite-build', {
    \ 'lazy' : 1,
    \ 'on_source' : 'unite.vim'
\ }
NeoBundle 'kmnk/vim-unite-giti', {
    \ 'lazy' : 1,
    \ 'on_source' : 'unite.vim'
\ }

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
NeoBundle 'deris/vim-textobj-enclosedsyntax'
NeoBundle 'https://bitbucket.org/anyakichi/vim-textobj-xbrackets'

" operator
NeoBundle 'kana/vim-operator-user'
NeoBundle 'kana/vim-operator-replace'
NeoBundle 'tyru/operator-camelize.vim'
NeoBundle 'tyru/operator-reverse.vim'
NeoBundle 'emonkak/vim-operator-sort'
NeoBundle 'rhysd/vim-operator-surround'

" docs
NeoBundle 'vim-jp/vimdoc-ja'
NeoBundle 'mattn/learn-vimscript'

"}}}2
"-------------------------------------------------------------------------------
" Plugin Settings: "{{{2
"-------------------------------------------------------------------------------

" disable GetLatestVimPlugin.vim
let g:loaded_getscriptPlugin = 1
" disable netrw.vim
let g:loaded_netrwPlugin = 1

" vimproc build setting
" should build manually if using windows
call neobundle#config(
    \ 'vimproc.vim', {
        \ 'build' : {
            \ 'cygwin'    : 'make -f make_cygwin.mak',
            \ 'mac'       : 'make -f make_mac.mak',
            \ 'unix'      : 'make -f make_unix.mak',
        \ }
    \ }
\ )

" neocomplete
let g:neocomplete#enable_at_startup = 1
let s:hooks = neobundle#get_hooks('neocomplete.vim')
function! s:hooks.on_source(bundle)
    let g:neocomplete#enable_auto_select = 1
    "let g:neocomplete#disable_auto_complete = 1
    let g:neocomplete#enable_fuzzy_completion = 1
    let g:neocomplete#auto_completion_start_length = 3
    "let g:neocomplete#use_vimproc = 1
    let g:neocomplete#enable_insert_char_pre = 1
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

    " neomru
    "let g:unite#update_interval=60
    " ignore help files
    let helpfiledirs = [
        \ expand('$DOTVIM/bundle/') . '.*/doc',
        \ expand('$VIMRUNTIME/doc'),
        \ expand('$VIM/plugins/vimdoc-ja/doc'),
    \ ]
    if !&shellslash
        call map(helpfiledirs, 'substitute(v:val, ''\'', ''/'', ''g'')')
    endif
    call unite#custom#source('neomru/file', 'ignore_pattern',
        \ '\v(' . join(helpfiledirs, '|') . ')/.*\.(txt|jax)')

endfunction

"quickrun
if s:is_windows
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
    "let g:ref_use_vimproc = 1
    if s:is_windows
        let g:ref_source_webdict_encoding = 'UTF-8'
    endif

    " set webdict sites
    let g:ref_source_webdict_sites = {
        \ 'je'         : {'url': 'http://dictionary.infoseek.ne.jp/jeword/%s', 'line' : 24},
        \ 'ej'         : {'url': 'http://dictionary.infoseek.ne.jp/ejword/%s', 'line' : 19},
        \ 'wiki'       : {'url': 'http://ja.wikipedia.org/wiki/%s',            'line' : 3},
        \ 'alc'        : {'url': 'http://eow.alc.co.jp/search?q=%s',           'line' : 31},
        \ 'weblio'     : {'url': 'http://www.weblio.jp/content/%s',            'line' : 25},
        \ 'thesaurus'  : {'url': 'http://thesaurus.weblio.jp/content/%s',      'line' : 37},
        \ 'wiktionary' : {'url': 'http://ja.wiktionary.org/wiki/%s',           'line' : 3},
    \ }

    " set filter for each sites
    "function! s:SetWebDictsFilter()
        "let ref_webdict_filtering_lines = [
            "\ ['je',            15],
            "\ ['ej',            15],
            "\ ['wiki',          17],
            "\ ['alc',           25],
            "\ ['weblio',        17],
            "\ ['thesaurus',     28],
            "\ ['wiktionary',    17],
        "\ ]

        "for item in ref_webdict_filtering_lines
            "let g:ref_source_webdict_sites[item[0]].filtering_lines = item[1]
            "function! g:ref_source_webdict_sites[item[0]].filter(output) dict
                "return join(split(a:output, "\n")[self.filtering_lines :], "\n")
            "endfunction
        "endfor
    "endfunction
    "call s:SetWebDictsFilter()
    "delfunction s:SetWebDictsFilter

    " default site of webdict
    let g:ref_source_webdict_sites.default = 'alc'
endfunction

" NERD_commenter
let s:hooks = neobundle#get_hooks('nerdcommenter')
function! s:hooks.on_source(bundle)
    let g:NERDCreateDefaultMappings = 0
    let g:NERDSpaceDelims = 0
endfunction

" lightline.vim "{{{
let g:lightline = {
    \ 'colorscheme': 'landscape',
    \ 'component': {
        \ 'readonly': '%{&readonly?"\u2b64":""}',
    \ },
    \ 'component_function': {
        \ 'currentdir': 'MyCurrentDir'
    \ },
    \ 'tab_component_function': {
        \ 'closetab': 'MyCloseTab'
    \ },
    \ 'separator': {
        \ 'left': "\u2b80", 'right': "\u2b82"
    \ },
    \ 'subseparator': {
        \ 'left': "\u2b81", 'right': "\u2b83"
    \ },
    \ 'tabline': {
        \ 'left': [ [ 'tabs' ] ],
        \ 'right': [ [ 'close' ], [ 'currentdir' ] ]
    \ },
\ }

" when not Unicode, lightline disable
if !s:is_unicode_encoding()
    let g:lightline.enable = {
        \ 'statusline' : 0,
        \ 'tabline' : 0
    \ }
endif

let s:hooks = neobundle#get_hooks('lightline.vim')
function! s:hooks.on_source(bundle)
    " specially color setting
    let palette = g:lightline#colorscheme#landscape#palette
    let palette.inactive.middle = [['#121212', '#606060', 233, 241]]
    let palette.inactive.right = palette.normal.right
    let palette.inactive.left = palette.inactive.right[1 :]
endfunction

" for windows CUI
if s:is_windows_cui
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
"}}}

" QFixHowm
let g:mygrepprg = 'ag'
let g:howm_fileencoding = 'utf-8'
let g:qfixmemo_mapleader = 'g\'

"indentLine
let s:hooks = neobundle#get_hooks('indentLine')
function! s:hooks.on_source(bundle)
    let g:indentLine_noConcealCursor = 1
    let g:indentLine_fileTypeExclude = ['text', 'help']
    if s:is_windows_cui
        let g:indentLine_char = '|'
        let g:indentLine_color_term = 8
    endif
endfunction

" EasyMotion
let g:EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyz0123456789'
let g:EasyMotion_do_shade = 0
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_use_migemo = 1
let g:EasyMotion_smartcase = 1
let g:EasyMotion_disable_two_key_combo = 1
map <Leader>w <Plug>(easymotion-w)
map <Leader>W <Plug>(easymotion-W)
map <Leader>b <Plug>(easymotion-b)
map <Leader>B <Plug>(easymotion-B)
map <Leader>s <Plug>(easymotion-s)
map <Leader>f <Plug>(easymotion-fl)
map <Leader>t <Plug>(easymotion-tl)
map <Leader>F <Plug>(easymotion-Fl)
map <Leader>T <Plug>(easymotion-Tl)

" incsearch.vim
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" openuri
if s:is_windows
    let openuri_cmd = 'VimProcBang "rundll32.exe" url.dll,FileProtocolHandler %s'
endif

" ShowMarks {{{
" エラーが出るようになったので一時的に切る
let g:loaded_showmarks = 1
" ShowMarksでハイライトするマーク指定
let g:showmarks_include = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ<>'
" プラグインでマップされちゃうのでautocmdで定義
" エラーが出るようになったので一時的に切る
"autocmd MyAutocmd VimEnter * call s:init_marks()
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
"}}}

" QFixHowmのメニューバーを表示しない
" （_gvimrcでplugin内に表示）
let g:qfixmemo_menubar = 0
let g:MyGrep_MenuBar = 0

" TagList
let Tlist_Compact_Format = 1        "空白行などを表示しない
let Tlist_Enable_Fold_Column = 0    "折りたたみ列を表示しない
let Tlist_Exit_OnlyWindow = 1       "タグリストウィンドウのみになったら終了
let Tlist_Sort_Type = 'name'        "タグを名前順にソートする

" submode
let g:submode_timeout=0     " no timeout of submode

" vim-toggle
let g:toggle_pairs = {
    \ 'and' : 'or',
    \ 'or' : 'and',
\ }

" vim2hs
let g:haskell_conceal = 0

"}}}2

" end bundling
call neobundle#end()

" enable plugins loading
filetype plugin indent on

"}}}1
"===============================================================================
" Option Settings: "{{{1
"===============================================================================

" adjust 'runtimepath' "{{{
if s:is_starting
    " add $DOTVIM on head and $DOTVIM/after on tail
    let s:rtp = $DOTVIM . ',' . &runtimepath . ',' . $DOTVIM . '/after'
    let s:rtps = filter(split(s:rtp, ','), 'isdirectory(v:val)')
    if !empty(s:rtps)
        let &runtimepath = join(s:rtps, ',')
    endif
    unlet s:rtps
    unlet s:rtp
endif
"}}}

" Syntax settings "{{{

" VimScript "{{{
" syntax folding setting
" required foldmethod=syntax
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

" no indent backslash for VimScript
" (this is width of indentation)
let g:vim_indent_cont = 0
"}}}

" set highlight of doxygen for c, cpp, and idl
let g:load_doxygen_syntax = 1
let g:doxygen_enhanced_color = 1

"}}}

" mouse behaves Windows
behave mswin

" specially color setting "{{{
" to override by autocmd before colorscheme setting
autocmd MyAutocmd ColorScheme *
        \ if s:is_gui | call s:set_my_gui_color()
        \ | else | call s:set_my_cterm_color()
        \ | endif

" color for GUI
function! s:set_my_gui_color()
    hi TabLine      guifg=#777798 guibg=#444477 gui=NONE
    hi TabLineFill  guifg=#666688 guibg=#CCCCFF
    hi TabLineSel   guifg=#CCCCFF guibg=#111155 gui=bold
    hi FoldColumn   guifg=#818698 guibg=#363946
    hi Folded       guifg=#cccccc guibg=#333366
    hi ColorColumn  guifg=NONE    guibg=#333333 gui=NONE
    hi SpecialKey   guifg=#444466 guibg=NONE    gui=NONE
    hi NonText      guifg=#ffffff
    hi LineNr       guifg=#999999 guibg=#222222
    hi CursorLineNr guifg=#9999ff guibg=#444444
    hi Cursor       guifg=#000000 guibg=#ffffff gui=NONE
    hi PmenuSel     guifg=#000000 guibg=#00cccc
endfunction

" color for cterm
function! s:set_my_cterm_color()
    hi TabLine      ctermfg=Black   ctermbg=DarkGray cterm=NONE
    hi TabLineFill  ctermfg=Black   ctermbg=Gray     cterm=NONE
    hi TabLineSel   ctermfg=Gray    ctermbg=Black    cterm=underline
    hi NonText      ctermfg=White
    hi Cursor       ctermfg=White   ctermbg=Black
endfunction
"}}}

" colorscheme
set t_Co=256
if s:is_windows_cui
    colorscheme default
else
    try
        colorscheme landscape
    catch /^Vim(colorscheme):/
        colorscheme desert
    endtry
endif

" Cygwin settings "{{{
if s:is_cygwin
    " cursor shape
    let &t_ti .= "\e[1 q"  " put terminal in 'termcap' mode
    let &t_SI .= "\e[5 q"  " start insert mode (bar cursor shape)
    let &t_EI .= "\e[1 q"  " end insert mode (block cursor shape)
    let &t_te .= "\e[0 q"  " out of 'termcap' mode

    " deal with the problem of <Esc> key code sequence
    " see xterm-cursor-keys
    set ttimeout
    set ttimeoutlen=100
endif
"}}}

" general options "{{{

" terminal encoding
" set cp932 only when cmd.exe (or command.exe)
" Note: if not set on Windows, some external command was garbled.
" maybe caused by cmd.exe strange behavior.
if s:is_starting && s:is_windows
    if &shell =~? 'cmd.exe\|command.exe'
        set termencoding=cp932
    endif
endif

" file encoding list ordered in priority
set fileencodings=utf-8,cp932,euc-jp,ucs-2le,default,latin1

set number                      " show line numbers
"set ruler                      " show ruler
set showcmd                     " show inserted command
set wrap                        " wrap line of right edge
set display=lastline            " show lastline as much as possible
set laststatus=2                " show statusline always
set showtabline=2               " show tabline always
set textwidth=0                 " disable automaticaclly line break
set shortmess& shortmess+=I     " no launch message
set hidden                      " hide buffer instead to remove modified buffer
set confirm                     " show confirm dialog instead of error
set backspace=indent,eol,start  " can be deleted these characters for backspace
set cmdheight=2                 " command line height
set noequalalways               " disable automatical adjust window size
set autoindent                  " enable auto indent
set smartindent                 " enable smart indent
set cinoptions=:0,l1,g0,m1      " indent option for C/C++
set switchbuf=split,newtab      " switch buffer option
"set tabline=%!MakeTabLine()    " tabline string
set helpheight=0                " min height of help
set helplang=ja                 " help language priority
set pumheight=10                " max height of popup menu
set previewheight=5             " height of preview window
set cmdwinheight=5              " height of cmdwindow
set cpoptions& cpoptions+=n     " use number column for wrapped line
set showmatch                   " jump to match pair temporarily
set matchtime=1                 " time (0.1 sec) to jump match pair
set virtualedit=block           " virtual edit for visual block mode only
set matchpairs& matchpairs+=<:> " add pair <>
set winaltkeys=no               " not use Alt key for GUI menu
set path& path+=;/              " file path follows parent directory
set complete& complete-=t,i     " remove 'include, tag' from completion candidates
set completeopt=menuone,preview " option of completion
set showfulltag                 " show tag pattern when tag completion
set timeout                     " enable timeout of key mappings
set timeoutlen=3000             " wait time(ms) of key mappings
set selectmode=                 " not use select mode
set selection=inclusive         " last character of selection is included in operation
set scrolloff=0                 " offset around cursor in vertical scroll
set sidescroll=1                " step of horizontal scroll
set sidescrolloff=1             " offset around cursor in horizontal scroll
set colorcolumn=81              " highlight column at 81
set ambiwidth=double            " show wide character as twice as half character

 " highlight line at current cursor
let &cursorline = !s:is_windows_cui

" formatoptions setting
" when joining lines, don't insert a space between multi-byte characters
set formatoptions& formatoptions+=B
if v:version >= 704
    " when joining lines, remove a comment leader
    set formatoptions+=j
endif

" keep column as much as possible in the vertical movement
" (<C-d>, <C-u>, ...)
set nostartofline

" not redraw of no typing command (such as key macros)
"set lazyredraw

" enable extend command line complete and setting
set wildmenu
set wildmode=longest,full

" non-printable characters display settings
" when enable unicode, use unicode character
set list
if s:is_unicode_encoding()
    " tab: '￫   ', trailing space: '˽', extends: '»', precedes: '«'
    let &listchars="tab:\uffeb\ ,trail:\u02fd,extends:\u00bb,precedes:\u00ab"
else
    set listchars=tab:>\ ,trail:_,extends:>,precedes:<
endif

" width of number column
" and wrapped line head string which adjust according to numberwidth
" head: ' »»'
autocmd MyAutocmd BufEnter *
    \ let &l:numberwidth = len(line('$')) + 2
    \ | let &showbreak = "\u00bb\u00bb" . repeat(' ', len(line('$')))

"}}}

" tab, indent options " {{{
set tabstop=4           " tab width to display
set expandtab           " tab expanding
set shiftwidth=4        " indent width
set softtabstop=4       " width when enter <Tab> or <BS>
" }}}

" searching options " {{{
set incsearch           " enable incremental search
set hlsearch            " enable highlight the searched
nohlsearch              " turn off highlight temporarily
set ignorecase          " ignore case
set smartcase           " ignore case unless searching pattern include upper case
set wrapscan            " back for the first line when go to the end line
set grepprg=grep\ -nH   " grep command
" }}}

" folding options " {{{
set foldenable          " enable folding
set foldcolumn=0        " width of folding indicate column
set foldmethod=marker   " fold using marker
set foldlevelstart=99   " all folding is opened when opening new buffer
" folding line text
set foldtext=FoldCCtext()
"let g:foldCCtext_enable_autofdc_adjuster = 1
" }}}

" setting of title string
"set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:p:~:h\")})%)%(\ %a%)%(\ -\ %{v:servername}%)

" use mouse
if has('mouse')
    set mouse=a
endif

" transparency (kaoriya only) "{{{
" Note: must be autocmd
if exists('&transparency') && s:is_gui
    if s:is_windows
        augroup MyAutocmd
            autocmd GUIEnter * set transparency=225
            autocmd FocusGained * set transparency=225
            autocmd FocusLost * set transparency=180
        augroup END
    endif
endif
"}}}

" backup options " {{{
set writebackup                                 " create backup before file writing,
set nobackup                                    " but not keep
let &backupdir = '.,' . $DOTVIM . '/.backup'    " backup file directory list
set backupskip& backupskip+=*~                  " pattern list when not create backup
set undofile                                    " create undo file
if !isdirectory($DOTVIM . '/.backup')
    call mkdir($DOTVIM . '/.backup')            " create backup directory if not exist
endif

" undofile options
let &undodir = $DOTVIM . '/.undo'   " undo file directory
if !isdirectory(&undodir)
    call mkdir($DOTVIM . '/.undo')  " create undo file directory if not exist
endif
" }}}

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

    " view git branch
    "let branch_info = fugitive#head()
    "if !empty(branch_info)
    "    let info .= '[' . branch_info . '] '
    "endif

    return tabpages . '%=' . info   " view tab list at left, information at right
endfunction "}}}

" each tab view setting
function! s:TabPageLabel(n) "{{{
    " use t:title if exists
    let title = gettabvar(a:n, 'title')
    if title !=# ''
        return title . ' %#TabLineFill#'
    else
        " buffer list on tabpage
        let bufnrs = tabpagebuflist(a:n)

        " switch highlight whether current tabpage
        let hi = a:n is tabpagenr() ? '%#TabLineSel#' : '%#TabLine#'

        " view num buffers if exist multiple
        let no = len(bufnrs)
        if no is 1
            let no = ""
        endif
        " add '+' if exist modified buffer
        let mod = len(filter(copy(bufnrs), 'getbufvar(v:val, ''&modified'')')) ? '+' : ''
        let sp = (no . mod) ==# "" ? "" : ' '  " make gap

        " get current buffer
        let curbufnr = bufnrs[tabpagewinnr(a:n) - 1]  " tabpagewinnr() is 1 origin
        let curbufname = bufname(curbufnr)

        " use b:title if exists
        let title = getbufvar(curbufnr, 'title')
        if !empty(title)
            let fname = title
        elseif empty(curbufname)
            " change name by buffer type
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
    "let closelabel = '%' . a:n . 'X x %X'      " closing label

    "return label . closelabel . '%#TabLineFill#'
    return label . ' %#TabLineFill#'
endfunction "}}}

"}}}1
"===============================================================================
" User Commands: "{{{1
"===============================================================================

" help with tabpage
" with '!' force create tabpage
command! -bang -bar -nargs=? -complete=help Help
    \ call s:help_with_tabpage('help', <q-args>, <q-bang>)
" helpgrep (use location list) with tabpage
command! -bang -bar -nargs=? -complete=help HelpGrep
    \ call s:help_with_tabpage('lhelpgrep', <q-args>, <q-bang>)

function! s:help_with_tabpage(cmd, word, bang)
    " save the current tabpage
    let cur_tab_nr = tabpagenr()

    try
        if empty(a:bang)
            let tab_nr = s:search_help_tab()
            if tab_nr != 0
                " move to tabpage and open help there
                execute 'tabnext ' . string(tab_nr)
                execute 'help ' . a:word

                return
            endif
        endif

        " when not exist help or set bang, create tabpage and open help
        execute 'tab ' . a:cmd . ' ' . a:word
        return

    catch /^Vim(help):/
        " if error occured, back to the tabpage
        execute 'tabnext ' . string(cur_tab_nr)
        echoerr matchstr(v:exception, 'Vim(help):\zs.*$')
    endtry
endfunction

" search tabpage number which include help buffer
" return found first tabpage number
" or return 0 if not found
function! s:search_help_tab()
    " help buffer list
    let buflist = filter(range(bufnr('$') + 1),
        \ 'bufloaded(v:val) && getbufvar(v:val, ''&l:buftype'') == ''help''')

    if empty(buflist)
        return 0
    endif

    " search help buffer each tabpages
    for tab_nr in range(tabpagenr('$'))
        for buf_nr in tabpagebuflist(tab_nr + 1)
            if index(buflist, buf_nr) != -1
                return tab_nr + 1
            endif
        endfor
    endfor

    " should not reach
    return 0
endfunction

" reopen with change encoding
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

" aliases
command! -bang -bar -nargs=? -complete=file Jis
    \ Iso2022jp<bang> <args>
command! -bang -bar -nargs=? -complete=file Sjis
    \ Cp932<bang> <args>
command! -bang -bar -nargs=? -complete=file Unicode
    \ Utf16<bang> <args>

" external explorer
command! -nargs=? -complete=dir -complete=file Explorer
    \ call s:ex_explorer(<q-args>)
function! s:ex_explorer(path)
    " get readable path
    let l:path = s:conv_readable(!empty(a:path) ? a:path : '%')
    if empty(l:path)
        echoerr 'Explorer: "' . a:path . '" is not file or directory'
        return
    endif

    " dispatch explorer command by OS
    let explorer_cmd = ''
    if s:is_windows
        let explorer_cmd = 'explorer '
    elseif s:is_unix
        let explorer_cmd = 'nautilus '
    else
        echoerr 'Explorer: no explorer'
        return
    endif

    " add file select option
    if filereadable(l:path)
        if s:is_windows
            let explorer_cmd .= '/select,'
        endif
    endif

    " run command
    " use vimproc if exists
    if filereadable(s:bundle_dir . '/vimproc.vim/autoload/vimproc.vim')
        call vimproc#system(explorer_cmd . escape(l:path, '\'))
    else
        " surround path by double quotation
        if s:is_windows && &shell =~? 'cmd.exe\|command.exe'
            let l:path = '"' . l:path . '"'
        endif

        call system(explorer_cmd . l:path)
    endif
endfunction

" convert path to readable file or directory
" if path is invalid, return empty string
function! s:conv_readable(path)
    let l:path = fnamemodify(expand(a:path), ':p')

    if s:is_windows
        " use backslash instead of slash
        let l:path = substitute(l:path, '/', '\', 'g')
        " remove backslash at eol
        if (l:path[-1:] == '\')
            let l:path = l:path[:-2]
        endif
    endif

    " check whether readable and return
    return (filereadable(l:path) || isdirectory(l:path)) ? l:path : ''
endfunction

" Diff
command! -nargs=? -complete=file Diff
    \ if '<args>'=='' |
        \ browse vertical diffsplit |
    \ else |
        \ vertical diffsplit <args> |
    \ endif

" diff between loaded from this
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif

" capture the messages such as :messages
command! -nargs=+ -complete=command Capture call s:CmdCapture(<q-args>)
function! s:CmdCapture(args) "{{{
    " redirect of commands
    redir => result
    silent execute a:args
    redir END

    " view on the new buffer with set specially options
    new
    setlocal bufhidden=unload
    setlocal nobuflisted
    setlocal buftype=nofile
    setlocal noswapfile
    let b:title = '[Capture: ' . a:args . ']'
    "silent file `='[Capture ('' . a:args . '')]'`
    silent put =result
    1,2delete _
    " press q with close window
    nnoremap <buffer> <silent> q :<C-u>close<CR>
endfunction "}}}

" show the option
command! -nargs=1 -complete=option ShowOption call s:show_option(<q-args>)
function! s:show_option(opt) "{{{
    if !empty(a:opt)
        execute 'verb set ' . a:opt . '?'
    endif
endfunction "}}}


" load to use AlterCommand in this file
call altercmd#load()

" define AlterCommand "{{{
if exists(':AlterCommand')
    AlterCommand ct     VimProcBang ctags -R --jcode=utf8
    AlterCommand u      Unite
    AlterCommand maps   Unite -resume mapping
    AlterCommand out    Unite -resume output
    AlterCommand va     Unite -resume variable
    AlterCommand gitb   UniteWithBufferDir giti/branch
    AlterCommand gitc   UniteWithBufferDir giti/config
    AlterCommand gitl   UniteWithBufferDir giti/log
    AlterCommand gitr   UniteWithBufferDir giti/remote
    AlterCommand gits   UniteWithBufferDir giti/status
    AlterCommand cap    Capture
    AlterCommand bat    Batch
    AlterCommand ag     LAg
    AlterCommand tr     TranslateGoogle
    AlterCommand alc    Ref webdict alc
    AlterCommand ej     Ref webdict ej
    AlterCommand je     Ref webdict je
    AlterCommand h      Help
    AlterCommand hg     HelpGrep
    AlterCommand ind    IndentLinesReset
    AlterCommand no     nohlsearch
endif
" }}}

"}}}1
"===============================================================================
" Autocommands: "{{{1
"===============================================================================

augroup MyAutocmd

    " draw vertical line behind 81
    "autocmd FileType * call s:set_colorcolumn(81)
    "autocmd VimResized * call s:set_colorcolumn(81)
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

    " add path when cpp
    autocmd FileType cpp setlocal path+=/usr/include,/usr/local/include

    " close window with q
    autocmd FileType help,ref-*,qf nnoremap <buffer> <silent> q :<C-u>close<CR>

    " no backups when edit git commit message
    autocmd FileType gitcommit setlocal nobackup noundofile noswapfile

    " open as read-only if exist swapfile
    autocmd SwapExists * let v:swapchoice = 'o'

    " settings of cmdline window
    " start with insert mode
    autocmd CmdwinEnter * startinsert
    " terminate with q
    autocmd CmdwinEnter * nnoremap <buffer> <silent> q :<C-u>close<CR>

    " recover cursor position
    autocmd BufRead *
        \ if line('''"') > 1 && line('''"') <= line('$') |
            \ execute 'normal! g`"zz' |
        \ endif

    " do buffer local the previous search pattern and hightlight
    autocmd WinLeave *
        \ let b:prev_pattern = @/
        \ | let b:prev_hlsearch = &hlsearch
    autocmd WinEnter *
        \ let @/ = get(b:, 'prev_pattern', @/)
        \ | let &l:hlsearch = get(b:, 'prev_hlsearch', &l:hlsearch)
        \ | nohlsearch

augroup END


"}}}1
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
"}}}

" has disabled
nnoremap Q <Nop>
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>

" j, k mappings
nmap j <Plug>(accelerated_jk_gj)
xnoremap j gj
nmap k <Plug>(accelerated_jk_gk)
xnoremap k gk
nnoremap gj j
xnoremap gj j
nnoremap gk k
xnoremap gk k

" j, k move with display lines if not installed accelerated-jk
autocmd MyAutocmd VimEnter * call s:define_jk_mappings()
function! s:define_jk_mappings()
    if empty(mapcheck('<Plug>(accelerated_jk', 'n'))
        nnoremap j gj
        nnoremap k gk
    endif
endfunction


" if cursor line is at foldclosed, 'l' open folding
nnoremap <expr> l foldclosed('.') < 0 ? 'l' : 'zo'

" smart word moving
nmap w <Plug>(smartword-w)
nmap b <Plug>(smartword-b)
nmap e <Plug>(smartword-e)
nmap ge <Plug>(smartword-ge)

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
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)

" star with anzu
map * <Plug>(asterisk-*)<Plug>(anzu-update-search-status-with-echo)
map # <Plug>(asterisk-#)<Plug>(anzu-update-search-status-with-echo)
map g* <Plug>(asterisk-g*)<Plug>(anzu-update-search-status-with-echo)
map g# <Plug>(asterisk-g#)<Plug>(anzu-update-search-status-with-echo)
map z* <Plug>(asterisk-z*)<Plug>(anzu-update-search-status-with-echo)
map z# <Plug>(asterisk-z#)<Plug>(anzu-update-search-status-with-echo)
map gz* <Plug>(asterisk-gz*)<Plug>(anzu-update-search-status-with-echo)
map gz# <Plug>(asterisk-gz#)<Plug>(anzu-update-search-status-with-echo)

" go to begin/end of line
nnoremap gh g0
xnoremap gh g0
onoremap gh 0
nnoremap gl g$
xnoremap gl g$
onoremap gl $

" grep (use ag)
nnoremap gr :<C-u>LAg <C-r><C-w> *
xnoremap gr :<C-u>LAg <C-r>=<SID>get_selected_text()<CR> *

" quickhl
nmap gw <Plug>(quickhl-manual-this)
xmap gw <Plug>(quickhl-manual-this)
nmap gW <Plug>(quickhl-manual-reset)
xmap gW <Plug>(quickhl-manual-reset)

" OpenBrowser
nmap gx <Plug>(openbrowser-open)
xmap gx <Plug>(openbrowser-open)
nnoremap <silent> gs
    \ :<C-u>call openbrowser#smart_search(<SID>get_cursor_word('\v\w*'))<CR>
xnoremap <silent> gs
    \ :<C-u>call openbrowser#smart_search(<SID>get_selected_text())<CR>

" 'Y' is like 'D'
nnoremap Y y$

" Ref
nnoremap <silent> <expr> K
    \ ':<C-u>Ref webdict alc ' . <SID>get_cursor_word('\v[a-zA-Z]*') . '<CR>'
xnoremap <silent> <expr> K
    \ ':<C-u>Ref webdict alc ' . <SID>get_selected_text() . '<CR>'

" put text no change the latest yanked on visual mode
xnoremap p "0p<CR>

" keep visual mode after indented
xnoremap < <gv
xnoremap > >gv

" search <cword> with split window
nnoremap <C-w>*  <C-w>s*
nnoremap <C-w>#  <C-w>s#

" preview tags if it is more candidates
nnoremap <C-]> g<C-]>

" reverse <C-t> (jump to new entry of tagstack)
nnoremap g<C-t>  :<C-u>tag<CR>

" increment/decrement number
nnoremap + <C-a>
xnoremap + <C-a>
xnoremap g+ g<C-a>
nnoremap - <C-x>
xnoremap - <C-x>
xnoremap g- g<C-x>

" view the help for <cword>
nnoremap <silent> <F1> :<C-u>Help <C-r><C-w><CR>
xnoremap <silent> <F1> :<C-u>Help <C-r>=<SID>get_selected_text()<CR><CR>

" change directory at the buffer file
nnoremap <F2> :<C-u>cd %:p:h<Bar>echo 'cd :' expand('%:p:h')<CR>

" view directory at the buffer file
nnoremap <F3> :<C-u>echo expand('%:p:h')<CR>

" taglist
nnoremap <silent> <F4> :<C-u>TlistToggle<CR>

" quickrun
nmap <Leader>r <Plug>(quickrun)
xmap <Leader>r <Plug>(quickrun)

" go to specified line if count is exist
" else turn off search highlight temporarily
nnoremap <silent><expr> <CR> <SID>cr_behavior()
function! s:cr_behavior() "{{{
    if v:count == 0
        return ":\<C-u>nohlsearch\<CR>"
    else
        return ":\<C-u>normal! " . string(v:count) . "Gzz\<CR>"
    endif
    return ""
endfunction "}}}
" when in quickfix, use default behavior
autocmd MyAutocmd FileType qf nnoremap <buffer> <CR> <CR>

" tabpage "{{{
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
nnoremap <silent>   [Tab]L  :<C-u>tabmove +1<CR>
nnoremap <silent>   [Tab]H  :<C-u>tabmove -1<CR>
nnoremap            [Tab]1  1gt
nnoremap            [Tab]2  2gt
nnoremap            [Tab]3  3gt
nnoremap            [Tab]4  4gt
nnoremap            [Tab]5  5gt
nnoremap            [Tab]6  6gt
nnoremap            [Tab]7  7gt
nnoremap            [Tab]8  8gt
nnoremap            [Tab]9  9gt
"}}}

" open .vimrc or .gvimrc
nnoremap <silent> [Space]v :<C-u>edit $MYVIMRC<CR>
nnoremap <silent> [Space]gv :<C-u>edit $MYGVIMRC<CR>

" source current buffer file
nnoremap <silent> [Space]<CR> :<C-u>echo 'sourcing...'<bar>so %<bar>do FileType<CR>

" source selected
xnoremap <silent> [Space]<CR> :QuickRun vim >null -runner/vimscript<CR>

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
    \ -buffer-name=explorer -parent -force-quit -explorer<CR>
autocmd MyAutocmd FileType vimfiler call s:vim_filer_settings()
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
nnoremap <silent> [Space]q :<C-u>Unite -no-quit qf<CR>
nnoremap <silent> [Space]o :<C-u>Unite -resume outline<CR>
nnoremap <silent> [Space]j :<C-u>Unite change jump<CR>
nnoremap <silent> [Space]x :<C-u>Unite file_point<CR>
nnoremap <silent> [Space]t :<C-u>Unite -buffer-name=tabs tab:no_current<CR>
nnoremap <silent> [Space]y :<C-u>Unite history/yank<CR>
nnoremap <silent> [Space]] :<C-u>UniteWithCursorWord -buffer-name=tag tag tag/include<CR>
nnoremap [Unite] <Nop>
nmap [Space]u   [Unite]
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

" thumbnail.vim
nnoremap [Space]gt :<C-u>Thumbnail -here<CR>

" open external explorer
nnoremap [Space]ge :<C-u>Explorer<CR>

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
" Insertmode Mappings: "{{{
"-------------------------------------------------------------------------------

" completion
inoremap <expr> <C-n> neocomplete#start_manual_complete()
inoremap <expr> <C-p> neocomplete#start_manual_complete()
inoremap <expr> <C-y> neocomplete#close_popup()
inoremap <expr> <C-e> neocomplete#cancel_popup()

" switch IME
if s:is_windows
    inoremap <C-@> <C-^>
elseif s:is_unix
    inoremap <C-@> <C-Space>
endif

" }}}
"-------------------------------------------------------------------------------
" Commandline Mappings: "{{{
"-------------------------------------------------------------------------------

" like emacs
cnoremap <C-n> <Down>
cnoremap <C-p> <Up>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-k> <C-\>e getcmdpos() == 1 ? "" : getcmdline()[:getcmdpos()-2]<CR>
cnoremap <C-y> <C-r>"

" }}}
"-------------------------------------------------------------------------------
" Textobject Mappings: "{{{
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

"}}}1
"===============================================================================
" Abbreviations: "{{{1
"===============================================================================

" abbreviation string of comment line
function! s:abbrev_comment_line(head, tail) "{{{
    let till = 80   " draw till 80 columns
    let cursor_offset = virtcol('.') - 1 - 2 " (-1):virtcol() returns as 1 base
                                             " (-2):abbrev string length
    let repeats = (till - cursor_offset - len(a:head)) / len(a:tail)
    return a:head . repeat(a:tail, repeats)
endfunction "}}}

" define the abbreviation
function! s:abbrev_def() "{{{
    " get the comment head
    " Note: should define when it expand, so defines as buffer variable
    let b:comment_head = s:get_comment_head(&l:filetype)
    if empty(b:comment_head)
        return
    endif

    " comment line compornent
    let line_compornents = {
        \ '@=' : '=',
        \ '@-' : '-',
        \ '@*' : '*',
        \ '@#' : '#',
        \ '@+' : '+',
        \ '@x' : 'x',
        \ '@~' : '~',
        \ '@_' : '_',
        \ '@v' : 'v',
        \ '@^' : '^',
        \ '@>' : '>',
        \ '@<' : '<',
        \ '@/' : '/',
        \ '@\' : '\',
        \ '@\|' : '\|',
        \ '@r' : '<>',
    \ }
    for abbrev in keys(line_compornents)
        let body = line_compornents[abbrev]
        let lval = '<buffer><expr> ' . abbrev . ' '
        let rval = '<SID>abbrev_comment_line(b:comment_head, ''' . body . ''')'
        execute 'inoreabbrev ' . lval . rval
    endfor

endfunction "}}}

" define abbreviations when filetype setting
autocmd MyAutocmd FileType * call s:abbrev_def()

"}}}1
"===============================================================================
" Terminating: "{{{1
"===============================================================================

" remove variables
unlet s:hooks

"}}}1


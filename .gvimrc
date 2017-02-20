"*******************************************************************************
"
" Vim Settings for GUI
"
"*******************************************************************************

scriptencoding utf-8

" init autocmd
augroup MyAutocmdGUI
    autocmd!
augroup END

" switching variables
let s:is_windows = has('win16') || has('win32') || has('win64')
let s:is_unix = has('unix')

"set guioptions=mgt              " gui menu, grayed menu, tearoff menu
"set guioptions=                 " no GUI options
set guioptions=r                " show right scroll bar always
set browsedir=buffer            " current directry when browsing
"set nohlsearch                  " no search highlight
set cursorline                  " highlight the current line
set title                       " show title
"set mousefocus                 " window focus with mouse
"set mousemodel=popup_setpos    " 右クリックでカーソル移動＆メニュー表示
set ambiwidth=double            " show wide character as twice as half character
if s:is_windows && has('directx')
    " use DirectX rendering
    set renderoptions=type:directx,renmode:5
endif

" メニューの表示切替
nnoremap <M-m> :<C-u>call <SID>toggle_menu()<CR>
function! s:toggle_menu()
    if empty(&guioptions)
        set guioptions=mgt
    else
        set guioptions=
    endif
endfunction

" カラースキーム
autocmd MyAutocmdGUI ColorScheme *
    \ if has('multi_byte_ime')
        \ | hi CursorIM guibg=#ff0000
    \ | endif

if neobundle#is_sourced('landscape.vim')
    colorscheme landscape
endif

" ビジュアルベル（使用しない）
set visualbell t_vb=

" 行数、列数、行間
" TODO: 環境に依存するので、ローカル設定ファイルに移動すべき？
set lines=36        " 行
set columns=99      " 列
set linespace=3     " 行間

" フォント設定
let fonts = []
if s:is_windows
    call add(fonts, 'Ricty_Diminished_for_Powerline:h12:cDEFAULT')
    call add(fonts, 'ＭＳ_ゴシック:h12:cDEFAULT')
elseif s:is_unix
    call add(fonts, "Ricty\ for\ Powerline\ 12")
    call add(fonts, "UbuntuMono\ 11")
endif
let &guifont=join(fonts, ",")
unlet fonts


"*******************************************************************************
" Key Mappings:
"*******************************************************************************

" 保存
"nnoremap <C-s> :<C-u>update<CR>

" GUIウィンドウ最大化・元に戻す
nnoremap <silent> <M-x> :<C-u>ScreenMode 4<CR>
nnoremap <silent> <M-r> :<C-u>Revert<CR>

" winmove.vim
let g:winmove_no_default_keymappings = 1
call submode#enter_with('winmove', 'n', '', '<C-w>m', '<Nop>')
call submode#map('winmove', 'n', 'r', 'j', '<Plug>(winmove-down)')
call submode#map('winmove', 'n', 'r', 'k', '<Plug>(winmove-up)')
call submode#map('winmove', 'n', 'r', 'h', '<Plug>(winmove-left)')
call submode#map('winmove', 'n', 'r', 'l', '<Plug>(winmove-right)')

"*******************************************************************************
" GUI Menus:
"*******************************************************************************

" QFixHowmのGUIメニュー項目を'Plugin'内に表示する
call QFixMemoMenubar("Plugin.QFixMemo(&M)","g,")
call QFixGrepMenubar("Plugin.QFixGrep(&G)","g,")


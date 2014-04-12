"*******************************************************************************
"
" Vim Settings for GUI
"
"*******************************************************************************

scriptencoding utf-8

" switching variables
let s:is_windows = has('win32') || has('win64')
let s:is_unix = has('unix')

"set guioptions=mgt              " gui menu, grayed menu, tearoff menu
set guioptions=                 " GUIオプションなし
set browsedir=buffer            " browse時のディレクトリをカレントバッファと同じに
set nohlsearch                  " 検索ハイライトなし
set cursorline                  " 現在行をハイライト
set title                       " タイトルを表示
"set mousefocus                 " マウス移動でウィンドウフォーカス
"set mousemodel=popup_setpos    " 右クリックでカーソル移動＆メニュー表示

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
colorscheme landscape

" ビジュアルベル（使用しない）
set visualbell t_vb=

" 行数、列数、行間、フォント
" TODO: 環境に依存するので、ローカル設定ファイルに移動すべき？
set lines=34        " 行
set columns=99      " 列
set linespace=0     " 行間
if s:is_windows
    let fonts = [
        \ "Ricty_Diminished_for_Powerline:h14:cDEFAULT",
        \ "ＭＳ_ゴシック:h12:cDEFAULT",
    \]
elseif s:is_unix
    let fonts = [
        \ "Ricty\ for\ Powerline\ 12",
        \ "UbuntuMono\ 11",
    \]
endif
let &guifont=join(fonts, ",")
unlet fonts


"*******************************************************************************
" Key Mappings:
"*******************************************************************************

" 保存
nnoremap <C-s> :<C-u>update<CR>

" GUIウィンドウ最大化・元に戻す
nnoremap <silent> <M-x> :<C-u>ScreenMode 4<CR>
nnoremap <silent> <M-r> :<C-u>Revert<CR>

"*******************************************************************************
" GUI Menus:
"*******************************************************************************

" QFixHowmのGUIメニュー項目を'Plugin'内に表示する
call QFixMemoMenubar("Plugin.QFixMemo(&M)","g,")
call QFixGrepMenubar("Plugin.QFixGrep(&G)","g,")

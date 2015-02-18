"*******************************************************************************
" local settings on Windows
"*******************************************************************************

scriptencoding utf-8    " encoding of this script

" ホームディレクトリ
if !exists('$HOME')
    let $HOME=$USERPROFILE
endif

" Visual Studio の最新版のパスを取得
let s:msvc_dirs = []
call add(s:msvc_dirs, 'C:/Program Files (x86)/Microsoft Visual Studio 12.0')
call add(s:msvc_dirs, 'C:/Program Files (x86)/Microsoft Visual Studio 11.0')
call add(s:msvc_dirs, 'C:/Program Files (x86)/Microsoft Visual Studio 10.0')
call add(s:msvc_dirs, 'C:/Program Files (x86)/Microsoft Visual Studio 9.0')
call add(s:msvc_dirs, 'C:/Program Files (x86)/Microsoft Visual Studio 8.0')

let s:msvc_latest = get(filter(copy(s:msvc_dirs), 'isdirectory(v:val)'), 0, '')

" Visual Studio の環境変数設定 "{{{
function! s:set_msvc_path(msvc_path)
    if !has_key(s:, "msvc_dirs") || !isdirectory(a:msvc_path)
        return
    endif

    let s:msvc_path = a:msvc_path
    let path = a:msvc_path

    let $VSINSTALLDIR=path
    let $VCINSTALLDIR=$VSINSTALLDIR."/VC"

    let $DevEnvDir=$VSINSTALLDIR."/Common7/IDE"
    let $PATH=$VSINSTALLDIR."/Common7/Tools;".$PATH
    let $PATH=$VCINSTALLDIR."/bin;".$PATH
    let $PATH=$DevEnvDir.";".$PATH

    let $INCLUDE=$VCINSTALLDIR."/include;".$INCLUDE
    let $INCLUDE='C:/Program Files (x86)/Microsoft SDKs/Windows/v7.1A/Include;'.$INCLUDE
    let $LIB=$VCINSTALLDIR."/lib;".$LIB
    let $LIB='C:/Program Files (x86)/Microsoft SDKs/Windows/v7.1A/Lib;'.$LIB
    let $LIBPATH=$LIB
endfunction "}}}
"call s:set_msvc_path(s:msvc_latest)

" MSBuildのパス追加
let $PATH.=';C:/Windows/Microsoft.NET/Framework/v4.0.30319/'

" インクルードディレクトリを(c,cppローカル)'path'に追加
" 空白はエスケープが必要
let s:msvc_include_path = substitute(s:msvc_latest, '\ ', '\\\ ', 'g') . '/VC/include/'
let s:winsdk_include_path = 'C:/Program\ Files\ (x86)/Microsoft\ SDKs/Windows/v7.1A/Include/'
let s:dxsdk_include_path = 'C:/Program\ Files\ (x86)/Microsoft\ DirectX\ SDK\ (June\ 2010)/Include/'

augroup IncDir "{{{
    autocmd!
    autocmd FileType c,cpp setlocal path<   " copy option to local from global
    autocmd FileType c,cpp let &l:path .= ',' . s:msvc_include_path
    autocmd FileType c,cpp let &l:path .= ',' . s:winsdk_include_path
    autocmd FileType c,cpp let &l:path .= ',' . s:dxsdk_include_path
augroup END "}}}


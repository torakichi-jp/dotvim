"*******************************************************************************
" local settings on Windows
"*******************************************************************************

scriptencoding utf-8    " encoding of this script

" ホームディレクトリ
if !exists('$HOME')
    let $HOME=$USERPROFILE
endif

" Git（MsysGit）のパス追加
let $PATH='C:\Program Files (x86)\Git\bin;'.$PATH
let $PATH='C:\Program Files (x86)\Git\cmd;'.$PATH

" Visual Studio の環境変数設定
let s:msvc_dirs = []
call add(s:msvc_dirs, "C:/Program\ Files\ (x86)/Microsoft\ Visual\ Studio\ 11.0")
call add(s:msvc_dirs, "C:/Program\ Files\ (x86)/Microsoft\ Visual\ Studio\ 10.0")
call add(s:msvc_dirs, "C:/Program\ Files\ (x86)/Microsoft\ Visual\ Studio\ 9.0")
call add(s:msvc_dirs, "C:/Program\ Files\ (x86)/Microsoft\ Visual\ Studio\ 8.0")

function! s:set_msvc_path(msvc_path)
    if has_key(s:, "msvc_path") || !isdirectory(a:msvc_path)
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
    let $INCLUDE='C:\Program Files\Microsoft SDKs\Windows\v6.0A\Include;'.$INCLUDE
    let $LIB=$VCINSTALLDIR."/LIB;".$LIB
    let $LIB='C:\Program Files\Microsoft SDKs\Windows\v6.0A\Lib;'.$LIB
    let $LIBPATH=$LIB
endfunction

call s:set_msvc_path(get(filter(copy(s:msvc_dirs), "isdirectory(v:val)"), 0, ""))

" MSBuildのパス追加
let $PATH.=';C:/Windows/Microsoft.NET/Framework/v4.0.30319/'

" インクルードディレクトリを(ローカルオプションの)pathに追加 " {{{
function s:add_path_local(path)
    let &l:path .= ',' . a:path
endfunction
let s:msvc_include_path = 'C:/Program\ Files\ (x86)/Microsoft\ Visual\ Studio\ 12.0/VC/include/'
let s:winsdk_include_path = 'C:/Program\ Files\ (x86)/Microsoft\ SDKs/Windows/v6.0/Include/'
let s:dxsdk_include_path = 'C:/Program\ Files\ (x86)/Microsoft\ DirectX\ SDK\ (June\ 2010)/Include/'

augroup IncDir
    autocmd!
    autocmd FileType c,cpp setlocal path<
    autocmd FileType c,cpp call s:add_path_local(s:msvc_include_path)
    autocmd FileType c,cpp call s:add_path_local(s:winsdk_include_path)
    autocmd FileType c,cpp call s:add_path_local(s:dxsdk_include_path)
augroup END
" }}}


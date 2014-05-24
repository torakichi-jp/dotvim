"*******************************************************************************
" ローカル設定 on Windows
"*******************************************************************************

" ホームディレクトリ
if !exists('$HOME')
    let $HOME=$USERPROFILE
endif

" Git（MsysGit）のパス追加
let $PATH='C:\Program Files (x86)\Git\bin;'.$PATH
let $PATH='C:\Program Files (x86)\Git\cmd;'.$PATH

" MinGWのパス追加
"let $PATH='C:\MinGW\bin;'.$PATH

" gnupackのパス追加
let $PATH.=';C:\gnupack\gnupack_basic-11.00\app\cygwin\cygwin\bin'

" インクルードディレクトリをpathに追加
augroup IncDir
    autocmd FileType c,cpp setlocal path+=C:/Program\\\ Files\\\ (x86)/Microsoft\\\ Visual\\\ Studio\\\ 9.0/VC/include/
    autocmd FileType c,cpp setlocal path+=C:/Program\\\ Files\\\ (x86)/Microsoft\\\ SDKs/Windows/v5.0/Include/
    autocmd FileType c,cpp setlocal path+=C:/Program\\\ Files\\\ (x86)/Microsoft\\\ DirectX\\\ SDK\\\ (June\\\ 2010)/Include/
augroup END

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


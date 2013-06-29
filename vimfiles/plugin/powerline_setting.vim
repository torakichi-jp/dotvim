if !neobundle#is_installed('vim-powerline')
    finish
endif

let s:hooks = neobundle#get_hooks('vim-powerline')
function! s:hooks.on_source(bundle)

    let g:Powerline_symbols = 'fancy'
    let g:Powerline_stl_path_style = 'filename'
    let g:Powerline_mode_n = 'Normal'
    let g:Powerline_mode_i = 'Insert'
    let g:Powerline_mode_R = 'Replace'
    let g:Powerline_mode_v = 'Visual'
    let g:Powerline_mode_V = 'V-Line'
    let g:Powerline_mode_cv = 'V-Block'
    let g:Powerline_mode_s = 'Select'
    let g:Powerline_mode_S = 'S-Line'
    let g:Powerline_mode_cs = 'S-Block'

    call Pl#Hi#Allocate({
      \ 'black'          : 16,
      \ 'white'          : 231,
      \
      \ 'darkestgreen'   : 22,
      \ 'darkgreen'      : 28,
      \
      \ 'darkestcyan'    : 21,
      \ 'mediumcyan'     : 117,
      \
      \ 'darkestblue'    : 24,
      \ 'darkblue'       : 31,
      \
      \ 'darkestred'     : 52,
      \ 'darkred'        : 88,
      \ 'mediumred'      : 124,
      \ 'brightred'      : 160,
      \ 'brightestred'   : 196,
      \
      \ 'darkestyellow'  : 59,
      \ 'darkyellow'     : 100,
      \ 'darkestpurple'  : 57,
      \ 'mediumpurple'   : 98,
      \ 'brightpurple'   : 189,
      \
      \ 'brightorange'   : 208,
      \ 'brightestorange': 214,
      \
      \ 'gray0'          : 233,
      \ 'gray1'          : 235,
      \ 'gray2'          : 236,
      \ 'gray3'          : 239,
      \ 'gray4'          : 240,
      \ 'gray5'          : 241,
      \ 'gray6'          : 244,
      \ 'gray7'          : 245,
      \ 'gray8'          : 247,
      \ 'gray9'          : 250,
      \ 'gray10'         : 252,
      \ })
    " 'n': normal mode
    " 'i': insert mode
    " 'v': visual mode
    " 'r': replace mode
    " 'N': not active
    let g:Powerline#Colorschemes#my#colorscheme = Pl#Colorscheme#Init([
      \ Pl#Hi#Segments(['SPLIT'], {
        \ 'n': ['white', 'gray2'],
        \ 'N': ['gray0', 'gray0'],
        \ }),
      \
      \ Pl#Hi#Segments(['mode_indicator', 'filename'], {
        \ 'i': ['white', 'darkestgreen', ['bold']],
        \ 'n': ['white', 'darkestcyan', ['bold']],
        \ 'v': ['white', 'darkestpurple', ['bold']],
        \ 'r': ['white', 'mediumred', ['bold']],
        \ 's': ['white', 'gray5', ['bold']],
        \ }),
      \
      \ Pl#Hi#Segments(['fileinfo'], {
        \ 'i': ['darkestgreen', 'white', ['bold']],
        \ 'n': ['darkestcyan', 'white', ['bold']],
        \ 'v': ['darkestpurple', 'white', ['bold']],
        \ 'r': ['mediumred', 'white', ['bold']],
        \ 'N': ['gray0', 'gray2', ['bold']],
        \ }),
      \
      \ Pl#Hi#Segments(['branch', 'scrollpercent', 'raw', 'filesize'], {
        \ 'n': ['gray2', 'gray7'],
        \ 'N': ['gray0', 'gray2'],
        \ }),
      \
      \ Pl#Hi#Segments(['fileinfo.filepath', 'status'], {
        \ 'n': ['black'],
        \ 'N': ['gray5'],
        \ }),
      \
      \ Pl#Hi#Segments(['static_str'], {
        \ 'n': ['white', 'gray4'],
        \ 'N': ['gray1', 'gray1'],
        \ }),
      \
      \ Pl#Hi#Segments(['fileinfo.flags'], {
        \ 'n': ['white'],
        \ 'N': ['gray4'],
        \ }),
      \
      \ Pl#Hi#Segments(['currenttag', 'fileformat', 'fileencoding', 'pwd', 'filetype', 'charcode', 'currhigroup'], {
        \ 'n': ['gray9', 'gray4'],
        \ }),
      \
      \ Pl#Hi#Segments(['lineinfo'], {
        \ 'n': ['gray2', 'gray10'],
        \ 'N': ['gray2', 'gray4'],
        \ }),
      \
      \ Pl#Hi#Segments(['errors'], {
        \ 'n': ['white', 'gray2'],
        \ }),
      \
      \ Pl#Hi#Segments(['lineinfo.line.tot'], {
        \ 'n': ['gray2'],
        \ 'N': ['gray2'],
        \ }),
      \
      \ Pl#Hi#Segments(['paste_indicator', 'ws_marker'], {
        \ 'n': ['white', 'brightred', ['bold']],
        \ }),
      \
      \ Pl#Hi#Segments(['gundo:static_str.name'], {
        \ 'n': ['white', 'mediumred', ['bold']],
        \ 'N': ['brightred', 'darkestred', ['bold']],
        \ }),
      \
      \ Pl#Hi#Segments(['gundo:static_str.buffer'], {
        \ 'n': ['white', 'darkred'],
        \ 'N': ['brightred', 'darkestred'],
        \ }),
      \
      \ Pl#Hi#Segments(['gundo:SPLIT'], {
        \ 'n': ['white', 'gray2'],
        \ 'N': ['white', 'gray0'],
        \ }),
      \ Pl#Hi#Segments(['ctrlp:focus', 'ctrlp:byfname'], {
        \ 'n': ['brightpurple', 'darkestpurple'],
        \ }),
      \
      \ Pl#Hi#Segments(['ctrlp:prev', 'ctrlp:next', 'ctrlp:pwd'], {
        \ 'n': ['white', 'mediumpurple'],
        \ }),
      \
      \ Pl#Hi#Segments(['ctrlp:item'], {
        \ 'n': ['darkestpurple', 'white', ['bold']],
        \ }),
      \
      \ Pl#Hi#Segments(['ctrlp:marked'], {
        \ 'n': ['brightestred', 'darkestpurple', ['bold']],
        \ }),
      \
      \ Pl#Hi#Segments(['ctrlp:count'], {
        \ 'n': ['darkestpurple', 'white'],
        \ }),
      \
      \ Pl#Hi#Segments(['ctrlp:SPLIT'], {
        \ 'n': ['white', 'darkestpurple'],
        \ }),
      \ ])
    let g:Powerline_colorscheme='my'
endfunction

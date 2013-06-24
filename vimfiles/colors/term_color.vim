let g:colors_name = expand('<sfile>>:t:r')
set background=dark
highlight clear

highlight LineNr        ctermfg=LightGreen  ctermbg=Black
highlight CursorLineNr  ctermfg=Magenta     ctermbg=Black       cterm=underline
highlight Normal        ctermfg=White       ctermbg=NONE
highlight CursorIM      ctermfg=Red
highlight ColorColumn                       ctermbg=DarkGray
highlight Pmenu         ctermfg=Black       ctermbg=Blue
highlight PmenuSel      ctermfg=White       ctermbg=DarkBlue    cterm=bold,underline
highlight PmenuSbar                         ctermbg=Black
highlight PmenuThumb                        ctermbg=LightGray
highlight TabLine       ctermfg=DarkGray    ctermbg=Black
highlight TabLineSel    ctermfg=White       ctermbg=DarkBlue    cterm=underline
highlight TabLineFill   ctermfg=DarkGray    ctermbg=Black
highlight Statusline                        ctermbg=DarkBlue    cterm=bold,underline
highlight StatuslineNC                      ctermbg=Gray        cterm=underline

highlight Comment       ctermfg=DarkGreen
highlight Constant      ctermfg=Red
highlight Statement     ctermfg=Cyan
highlight PreProc       ctermfg=Yellow
highlight String        ctermfg=Blue


" grayed vim color file
" Maintainer: Torakichi
" Version: 1.0
" Summary: Dark color, based on the 'lucius (dark)' color scheme.

hi clear
if exists("syntax_on")
	syntax reset
endif
let g:colors_name="grayed"

set background=dark

hi Normal			guifg=#CCCCFF		guibg=#333333
hi NonText			guifg=#FFFF00
hi Cursor			guifg=#333366		guibg=#F0F0F0
hi CursorIM			guifg=#FFFFFF		guibg=#AA0000
hi CursorLine							guibg=#484848
hi ErrorMsg			guifg=#FFFF00		guibg=#7F0000
hi Search			guifg=#CCFF99		guibg=#336699
hi StatusLine		guifg=#121212		guibg=#AAAACC		gui=bold,inverse
hi StatusLineNC		guifg=#565656		guibg=#8F8F8F
hi Visual			guibg=#000066

hi Normal           guifg=#e0e0e0           guibg=#202020
hi Normal           ctermfg=253             ctermbg=234

hi Comment          guifg=#606060                                   gui=none
hi Comment          ctermfg=240                                     cterm=none

hi Constant         guifg=#70c0d8                                   gui=none
hi Constant         ctermfg=74                                      cterm=none
hi ConstantBold     guifg=#70c0d8                                   gui=bold
hi ConstantBold     ctermfg=74                                      cterm=bold

hi Identifier       guifg=#86c6b6                                   gui=none
hi Identifier       ctermfg=116                                     cterm=none
hi IdentifierBold   guifg=#86c6b6                                   gui=bold
hi IdentifierBold   ctermfg=116                                     cterm=bold

hi Statement        guifg=#b3d38c                                   gui=none
hi Statement        ctermfg=150                                     cterm=none
hi StatementBold    guifg=#b3d38c                                   gui=bold
hi StatementBold    ctermfg=150                                     cterm=bold

hi PreProc          guifg=#e0e8b0                                   gui=none
hi PreProc          ctermfg=187                                     cterm=none
hi PreProcBold      guifg=#e0e8b0                                   gui=bold
hi PreProcBold      ctermfg=187                                     cterm=bold

hi Type             guifg=#90d0a0                                   gui=none
hi Type             ctermfg=115                                     cterm=none
hi TypeBold         guifg=#90d0a0                                   gui=bold
hi TypeBold         ctermfg=115                                     cterm=bold

hi Special          guifg=#b0a0c0                                   gui=none
hi Special          ctermfg=182                                     cterm=none
hi SpecialBold      guifg=#b0a0c0                                   gui=bold
hi SpecialBold      ctermfg=182                                     cterm=bold

" == Text Markup ==
" text that stands out, html links
hi Underlined       guifg=fg                                        gui=underline
hi Underlined       ctermfg=fg                                      cterm=underline
" any erroneous construct
hi Error            guifg=#e37170           guibg=#432323           gui=none
hi Error            ctermfg=167             ctermbg=236             cterm=none
" todo, fixme, note, xxx
hi Todo             guifg=#e0e090           guibg=NONE              gui=underline
hi Todo             ctermfg=186             ctermbg=NONE            cterm=underline
" match parenthesis, brackets
hi MatchParen       guifg=#00ff00           guibg=NONE              gui=bold
hi MatchParen       ctermfg=46              ctermbg=NONE            cterm=bold
" the '~' and '@' and showbreak, '>' double wide char doesn't fit on line
hi NonText          guifg=#404040                                   gui=none
hi NonText          ctermfg=238                                     cterm=none
" meta and special keys used with map, unprintable characters
hi SpecialKey       guifg=#405060
hi SpecialKey       ctermfg=239
" titles for output from :set all, :autocmd, etc
hi Title            guifg=#62bdde                                   gui=none
hi Title            ctermfg=74                                      cterm=none

" == Text Selection ==
" character under the cursor
hi Cursor           guifg=bg                guibg=#a3e3ed
hi Cursor           ctermfg=bg              ctermbg=153
" like cursor, but used when in IME mode
hi CursorIM         guifg=bg                guibg=#96cdcd
hi CursorIM         ctermfg=bg              ctermbg=116
" cursor column
hi CursorColumn     guifg=NONE              guibg=#404448           gui=none
hi CursorColumn     ctermfg=NONE            ctermbg=236             cterm=none
" cursor line/row
hi CursorLine       guifg=NONE              guibg=#404448           gui=none
hi CursorLine       ctermfg=NONE            ctermbg=236             cterm=none
" visual mode selection
hi Visual           guifg=NONE              guibg=#364458
hi Visual           ctermfg=NONE            ctermbg=24
" visual mode selection when vim is not owning the selection (x11 only)
hi VisualNOS        guifg=fg                                        gui=underline
hi VisualNOS        ctermfg=fg                                      cterm=underline
" highlight incremental search text; also highlight text replaced with :s///c
hi IncSearch        guifg=#66ffff                                   gui=reverse
hi IncSearch        ctermfg=87                                      cterm=reverse
" hlsearch (last search pattern), also used for quickfix
hi Search                                    guibg=#ffaa33          gui=none
hi Search                                    ctermbg=214            cterm=none

" == UI ==
" normal item in popup
hi Pmenu            guifg=#e0e0e0           guibg=#303840           gui=none
hi Pmenu            ctermfg=253             ctermbg=233             cterm=none
" selected item in popup
hi PmenuSel         guifg=#cae682           guibg=#505860           gui=none
hi PmenuSel         ctermfg=186             ctermbg=237             cterm=none
" scrollbar in popup
hi PMenuSbar                                guibg=#505860           gui=none
hi PMenuSbar                                ctermbg=59              cterm=none
" thumb of the scrollbar in the popup
hi PMenuThumb                               guibg=#808890           gui=none
hi PMenuThumb                               ctermbg=102             cterm=none
" status line for current window
hi StatusLine       guifg=#e0e0e0           guibg=#363946           gui=bold
hi StatusLine       ctermfg=254             ctermbg=237             cterm=bold
" status line for non-current windows
hi StatusLineNC     guifg=#767986           guibg=#363946           gui=none
hi StatusLineNC     ctermfg=244             ctermbg=237             cterm=none
" tab pages line, not active tab page label
hi TabLine          guifg=#b6bf98           guibg=#363946           gui=none
hi TabLine          ctermfg=244             ctermbg=236             cterm=none
" tab pages line, where there are no labels
hi TabLineFill      guifg=#cfcfaf           guibg=#363946           gui=none
hi TabLineFill      ctermfg=187             ctermbg=236             cterm=none
" tab pages line, active tab page label
hi TabLineSel       guifg=#efefef           guibg=#414658           gui=bold
hi TabLineSel       ctermfg=254             ctermbg=236             cterm=bold
" column separating vertically split windows
hi VertSplit        guifg=#777777           guibg=#363946           gui=none
hi VertSplit        ctermfg=243             ctermbg=237             cterm=none
" line used for closed folds
hi Folded           guifg=#d0e0f0           guibg=#202020           gui=none
hi Folded           ctermfg=117             ctermbg=235             cterm=none
" column on side used to indicated open and closed folds
hi FoldColumn       guifg=#c0c0d0           guibg=#363946           gui=none
hi FoldColumn       ctermfg=117             ctermbg=238             cterm=none

" == Spelling ==
" word not recognized
hi SpellBad         guisp=#ee0000                                   gui=undercurl
hi SpellBad                                 ctermbg=196             cterm=undercurl
" word not capitalized
hi SpellCap         guisp=#eeee00                                   gui=undercurl
hi SpellCap                                 ctermbg=226             cterm=undercurl
" rare word
hi SpellRare        guisp=#ffa500                                   gui=undercurl
hi SpellRare                                ctermbg=214             cterm=undercurl
" wrong spelling for selected region
hi SpellLocal       guisp=#ffa500                                   gui=undercurl
hi SpellLocal                               ctermbg=214             cterm=undercurl

" == Diff ==
" added line
hi DiffAdd          guifg=#80a090           guibg=#313c36           gui=none
hi DiffAdd          ctermfg=fg              ctermbg=22              cterm=none
" changed line
hi DiffChange       guifg=NONE              guibg=#4a343a           gui=none
hi DiffChange       ctermfg=fg              ctermbg=52              cterm=none
" deleted line
hi DiffDelete       guifg=#6c6661           guibg=#3c3631           gui=none
hi DiffDelete       ctermfg=fg              ctermbg=58              cterm=none
" changed text within line
hi DiffText         guifg=#f05060           guibg=#4a343a           gui=bold
hi DiffText         ctermfg=203             ctermbg=52              cterm=bold

" == Misc ==
" directory names and other special names in listings
hi Directory        guifg=#c0e0b0                                   gui=none
hi Directory        ctermfg=151                                     cterm=none
" error messages on the command line
hi ErrorMsg         guifg=#ee0000           guibg=NONE              gui=none
hi ErrorMsg         ctermfg=196             ctermbg=NONE            cterm=none
" columns where signs are displayed (used in IDEs)
hi SignColumn       guifg=#9fafaf           guibg=#181818           gui=none
hi SignColumn       ctermfg=145             ctermbg=233             cterm=none
" line numbers
hi LineNr           guifg=#818698           guibg=#363946
hi LineNr           ctermfg=245             ctermbg=237
" the 'more' prompt when output takes more than one line
hi MoreMsg          guifg=#2e8b57                                   gui=none
hi MoreMsg          ctermfg=29                                      cterm=none
" text showing what mode you are in
hi ModeMsg          guifg=#76d5f8           guibg=NONE              gui=none
hi ModeMsg          ctermfg=117             ctermbg=NONE            cterm=none
" the hit-enter prompt (show more output) and yes/no questions
hi Question         guifg=fg                                        gui=none
hi Question         ctermfg=fg                                      cterm=none
" warning messages
hi WarningMsg       guifg=#e5786d                                   gui=none
hi WarningMsg       ctermfg=173                                     cterm=none
" current match in the wildmenu completion
hi WildMenu         guifg=#cae682           guibg=#363946           gui=bold,underline
hi WildMenu         ctermfg=16              ctermbg=186             cterm=bold
" color column highlighting
hi ColorColumn      guifg=NONE              guibg=#403630           gui=none
hi ColorColumn      ctermfg=NONE            ctermbg=95              cterm=none
" left blank, hidden
hi Ignore           guifg=bg
hi Ignore           ctermfg=bg


hi Normal		guifg=#BBBBCC
hi CursorIM		guifg=#F8F8F8	guibg=#AA0000
hi CursorColumn	guifg=NONE		guibg=#2F2F2F
hi CursorLine	guifg=NONE		guibg=#282828
hi StatusLine	guifg=#CCCCCC	guibg=#000022	gui=bold
hi StatusLineNC	guifg=#333333	guibg=#666666
hi PmenuSel										gui=underline
hi Folded		guifg=#999999	guibg=#554455
hi TabLine		guifg=#404070	guibg=#666699
hi TabLineFill	guifg=#606060	guibg=#9999CC
hi TabLineSel	guifg=#CCCCCC	guibg=#333366	gui=bold
hi VertSplit	guifg=#303030	guibg=#101010
hi FoldColumn	guifg=#818698	guibg=#363946
hi Search						guibg=#666699

" TagList�J���[�ݒ�
hi MyTagListFileName	guifg=#66FF99		guibg=#333366
hi MyTagListTagName		guifg=#CCCCFF		guibg=#3300FF


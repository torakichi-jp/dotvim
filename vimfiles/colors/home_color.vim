" Vim Color Scheme

set background=dark
hi clear

if exists("syntax_on")
    syntax reset
endif

let g:colors_name = "home_color"

hi Normal			guifg=#AAAACC		guibg=#222244
hi NonText			guifg=#FFFFFF		guibg=#222244
hi Cursor			guifg=#282828		guibg=#F0F0F0
hi CursorIM			guifg=#F8F8F8		guibg=#AA0000
hi Directory		guifg=#8F9D6A		guibg=#141414
hi ErrorMsg			guifg=#FFFF00		guibg=#7F0000
hi VertSplit		guifg=#666699		guibg=#CCCCCC
hi Folded			guifg=#F9EE98		guibg=#393969
hi IncSearch		guifg=#CC0000		guibg=#FFFF00		gui=bold
hi LineNr			guifg=#7587A6		guibg=#000000
hi ModeMsg			guifg=#00FFFF		guibg=#00007F
hi MoreMsg			guifg=#BF2D34		guibg=#F9B022
hi Question			guifg=#7587A6		guibg=#0E2231
hi Search			guifg=#CCFF99		guibg=#336699
hi StatusLine		guifg=#333399		guibg=#CCCCFF		gui=bold,inverse,underline
hi StatusLineNC		guifg=#565656		guibg=#8F8F8F
hi Title			guifg=#CBC8CB		guibg=#0E2231
hi Visual			guifg=#0E2271		guibg=#8FA4EB
hi WarningMsg		guifg=#FFFF00		guibg=#000000
hi WildMenu			guifg=#AFC4DB		guibg=#0E2231
hi MatchParen		guifg=#00FFFF		guibg=#004080		gui=bold

"Syntax highlight groups

hi Comment			guifg=#669966
hi Constant			guifg=#E77E6E
hi String			guifg=#9933CC
hi Character		guifg=#E9C062
hi Number			guifg=#CC3366
hi Boolean			guifg=#CF6A4C
hi Float			guifg=#F05A73
hi Identifier		guifg=#35A7F6
hi Function			guifg=#FFAD51
hi Statement		guifg=#66CCFF
hi Conditional		guifg=#CC9966							gui=bold
hi Repeat			guifg=#CC66FF							gui=bold
hi Label			guifg=#E9C062
hi Operator			guifg=#FFB054							gui=bold
hi Keyword			guifg=#E9C062
hi Exception		guifg=#FF9D00							gui=bold
hi PreProc			guifg=#EEEE33
hi Include			guifg=#3399CC							gui=bold
hi Define			guifg=khaki1
hi Macro			guifg=#9B703F
hi PreCondit		guifg=khaki3
hi Type				guifg=#3366CC
hi StorageClass		guifg=#60CFBB							gui=bold
hi Structure		guifg=#009DFF							gui=NONE
hi Typedef			guifg=khaki3							gui=NONE
hi Special			guifg=#99FF99
hi SpecialChar		guifg=DarkGoldenrod
hi Tag				guifg=DarkKhaki
hi Delimiter		guifg=DarkGoldenrod
hi SpecialComment	guifg=cornsilk
hi Debug			guifg=brown
hi Underlined		guifg=#Cf6A4C
hi Ignore			guifg=#003050
hi Error			guifg=#FF9A4C		guibg=#420E09		gui=bold
hi Todo				guifg=#FFFF00		guibg=#000000		gui=bold
hi Pmenu			guifg=#9999CC		guibg=#202040
hi PmenuSel			guifg=#CCCCFF		guibg=#333399
hi PmenuSbar							guibg=#9999CC
hi PmenuThumb		guifg=#000000
hi SignColumn		guifg=#FFFFCC		guibg=#333333

hi TabLine			guifg=#777799		guibg=#444477		gui=NONE
hi TabLineFill		guifg=#666688		guibg=#CCCCFF
hi TabLineSel		guifg=#CCCCFF		guibg=#111155		gui=bold

hi FoldColumn		guifg=#818698		guibg=#363946
hi ColorColumn		guifg=NONE			guibg=#333366		gui=NONE
hi CursorLine		guifg=NONE			guibg=#101050		gui=NONE
hi SpecialKey		guifg=#444466		guibg=NONE			gui=NONE


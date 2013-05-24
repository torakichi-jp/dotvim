
" Highlight EOL whitespace, http://vim.wikia.com/wiki/Highlight_unwanted_spaces

if exists("g:loaded_auto_trailing_whitespace") && g:loaded_auto_trailing_whitespace
	finish
endif
let g:loaded_auto_trailing_whitespace = 1

" Run :FixWhitespace to remove end of line white space.
command! -range=% FixWhitespace call s:FixWhitespace(<line1>,<line2>)
function! s:FixWhitespace(line1,line2)
	let l:save_cursor = getpos(".")
	silent! execute ':' . a:line1 . ',' . a:line2 . 's/¥s¥+$//'
	call setpos('.', l:save_cursor)
endfunction

" シンプルな動作にするか設定
if !exists("g:auto_trailing_whitespace_simple")
	let g:auto_trailing_whitespace_simple = 0
endif

" 行末空白文字のハイライトをするfiletypeリスト
if !exists("g:auto_trailing_filetype_list")
	let g:auto_trailing_filetype_list =
		\ ["c", "cpp", "vim", "java", "javascript", "python", "ruby", "perl"]
endif

" 空白ハイライトグループ設定
"highlight ExtraWhitespace ctermbg=red guibg=red

" g:auto_railing_file_type_listで指定されたfiletypeなら1を返す
function! s:IsTrailingFileType()
	return !empty(&filetype) && match(g:auto_trailing_filetype_list, &filetype) >= 0
endfunction

function! s:ToggleWhiteSpaceMatch(mode)
	" 既にマッチが登録されていれば削除する
	if exists('w:match_id_extra_whitespace')
		call matchdelete(w:match_id_extra_whitespace)
		unlet w:match_id_extra_whitespace
	endif

	" 表示を許可するfiletypeでなければ戻る
	if !s:IsTrailingFileType()
		return
	endif

	if a:mode=='i'
		let pattern='¥s¥+¥%#¥@<!$'		" 挿入モードのパターン設定
	elseif a:mode=='n'
		let pattern='¥s¥+$'				" 通常モードのパターン設定
	endif

	" マッチを追加する
	let w:match_id_extra_whitespace = matchadd('ExtraWhitespace', pattern)
endfunction

function! s:EnableAutoTrailingWhitespace()
	augroup TrailingWhitespace
		autocmd!
		if g:auto_trailing_whitespace_simple == 0
			autocmd InsertLeave * call s:ToggleWhiteSpaceMatch('n')
			autocmd InsertEnter * call s:ToggleWhiteSpaceMatch('i')
		endif
		autocmd VimEnter,ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
		autocmd BufWinEnter,WinEnter * call s:ToggleWhiteSpaceMatch('n')
		autocmd FileType * call s:ToggleWhiteSpaceMatch('n')
	augroup END
	highlight ExtraWhitespace ctermbg=red guibg=red
endfunction

function! s:DisableAutoTrailingWhitespace()
	augroup! TrailingWhitespace
	highlight clear ExtraWhitespace
endfunction

" ハイライトするかどうかの設定
if !exists("g:auto_trailing_whitespace_enable")
	let g:auto_trailing_whitespace_enable = 0
endif

if g:auto_trailing_whitespace_enable
	call s:EnableAutoTrailingWhitespace()
endif

command! AutoTrailingWhitespaceEnable call s:EnableAutoTrailingWhitespace()
command! AutoTrailingWhitespaceDisable call s:DisableAutoTrailingWhitespace()


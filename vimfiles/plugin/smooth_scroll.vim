"******************************************************************************
"
" Smooth Scroll
"
" Mappings
"  <Plug>(smooth-scroll-ctrl-f)
"  <Plug>(smooth-scroll-ctrl-b)
"  <Plug>(smooth-scroll-ctrl-d)
"  <Plug>(smooth-scroll-ctrl-u)
"
" to allow smooth scrolling of the window. I find that quick changes of
" context don't allow my eyes to follow the action properly.
"
" The global variable g:scroll_factor changes the scroll speed.
"
"******************************************************************************

let g:scroll_factor = 5000
function! SmoothScroll(count, dir, windiv, factor)
	if &cursorline
		set nocursorline
		let cursorline_changed_flag=1
	else
		let cursorline_changed_flag=0
	end

	let wh=winheight(0)
	let i=0
	while i < wh / a:windiv
		let t1=reltime()
		let i = i + 1
		if a:dir=="d"
			if line('w0')==line('$')
				"normal L
				break
			endif
			exe "normal " . a:count . "\<C-e>"
		else
			if line('w0')==1
				"normal H
				break
			endif
			exe "normal " . a:count . "\<C-y>"
		end
		redraw
		while 1
			let t2=reltime(t1,reltime())
			if t2[1] * a:count > g:scroll_factor
				break
			endif
		endwhile
	endwhile

	if cursorline_changed_flag
		set cursorline
	end
endfunction

nnoremap <silent> <Plug>(smooth-scroll-ctrl-f)
\	:<C-u>call SmoothScroll(v:count1, "d",1, 1)<CR>
nnoremap <silent> <Plug>(smooth-scroll-ctrl-b)
\	:<C-u>call SmoothScroll(v:count1, "u",1, 1)<CR>
nnoremap <silent> <Plug>(smooth-scroll-ctrl-d)
\	:<C-u>call SmoothScroll(v:count1, "d",2, 2)<CR>
nnoremap <silent> <Plug>(smooth-scroll-ctrl-u)
\	:<C-u>call SmoothScroll(v:count1, "u",2, 2)<CR>


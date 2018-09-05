"------------------------------------------------------------------------------
" File: $HOME/.vimrc
" Author: Pavol Plaskon, pavol.plaskon@gmail.com
"
" Based on: https://github.com/s3rvac/dotfiles/blob/master/vim/.vimrc
"------------------------------------------------------------------------------
" Pathogen (http://www.vim.org/scripts/script.php?script_id=2332).
"------------------------------------------------------------------------------

filetype off " Pathogen needs to run before 'plugin on'.
call pathogen#infect()
call pathogen#helptags() " Generate helptags for everything in 'runtimepath'.
filetype plugin on

set nocompatible                " Disable vi compatibility.
set autowrite                   " Automatically save before :make :next etc.
set confirm                     " Ask to save file before operations like :q or :e fail.
set esckeys                     " Cursor keys in insert mode.
set lazyredraw                  " Don't redraw during complex operations (e.g. macros).
set magic                       " Use 'magic' patterns - extended regular expressions.
set matchpairs+=<:>             " Highlight angle brackets pairs < >.
set nojoinspaces                " Insert just one space joining lines with J.
set noshowmatch                 " Don't show matching brackets when typing them.
set nostartofline               " Keep the cursor in the current column with page cmds.
set path=.,,**                  " Search in dir of the current file, cwd, and subdirs.
set shortmess+=aIoOtT           " Abbreviation of messages (avoids 'hit enter ...').
set showcmd                     " Show (partial) command in the status line.
set showmode                    " Show the current mode.
set tabpagemax=100              " Maximum number of tabs to open by the -p argument.
set ttimeoutlen=0				" Lower the timeout when entering the normal mode from insert mode.
set ttyfast                     " Improves redrawing for newer computers.

set fileencodings=utf-8,latin2

" Backup and swap files.
set nobackup                    " Disable backup files.
set noswapfile                  " Disable swap files.
set nowritebackup               " Disable auto backup before overwriting a file.

" Code completion.
set completeopt=longest,menuone
" Do not search in included/imported files (it slows down completion, mostly
" on network filesystems).
set complete-=i
" Enable omni completion.
set omnifunc=syntaxcomplete#Complete

" History.
if has("autocmd")
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
endif

set history=1000        " Number of lines of command line history.
set viminfo='100,\"500,r/mnt,r~/mnt,r/media " Read/write a .viminfo file.
set viminfo+=h          " Do not store searches.

" Indention and formatting.
set autoindent          " Indent a new line according to the previous one.
set copyindent          " Copy (exact) indention from the previous line.
set nopreserveindent    " Do not try to preserve indention when indenting.
set nosmartindent       " Turn off smartindent.
set nocindent           " Turn off C-style indent.
set fo+=q               " Allow formatting of comments with "gq".
set fo-=r fo-=o         " Turn off automatic insertion of comment characters.
set fo+=j               " Remove a comment leader when joining comment lines.
filetype indent off     " Turn off indention by filetype.
" Override the previous settings for all file types (some filetype plugins set
" these options to different values, which is really annoying).
au FileType * set autoindent nosmartindent nocindent fo+=q fo-=r fo-=o fo+=j

" Line numbers.
set number                      " Show line numbers.
set relativenumber              " Show relative numbers instead of absolute ones.

" Searching.
set hlsearch                    " Highlight search matches.
set incsearch                   " Incremental search.
" Case-smart searching (make /-style searches case-sensitive only if there is
" a capital letter in the search expression).
set ignorecase
set smartcase

" Path/file/command completion.
set wildmenu
set wildchar=<Tab>
set wildmode=longest
set wildignore+=*.o,*.obj,*.pyc,*.aux,*.bbl,*.blg,.git,.svn,.hg

" Security.
set secure                      " Forbid loading of .vimrc under $PWD.
set nomodeline                  " Modelines have been a source of vulnerabilities.

" Splitting.
set splitright                  " Open new vertical panes in the right rather than left.
set splitbelow                  " Open new horizontal panes in the bottom rather than top.

" Statusline.
set laststatus=2        		" Always display a statusline.
set noruler            			" Since I'm using a statusline, disable ruler.
set statusline=%<%f             " Path to the file in the buffer.
set statusline+=\ %h%w%m%r%k    " Flags (e.g. [+], [RO]).
set statusline+=\ [%{(&fenc\ ==\"\"?&enc:&fenc).(&bomb?\",BOM\":\"\")},%{&ff}] " Encoding and line endings.
set statusline+=\ %y                         " File type.
set statusline+=\ [\%3.3b,0x\%02.2B,U+%04B]  " Codes of the character under cursor.
set statusline+=\ [%l/%L\ (%p%%),%v]         " Line and column numbers.

" Whitespace.
set tabstop=4                  " Number of spaces a tab counts for.
set shiftwidth=4               " Number of spaces to use for each step of indent.
set shiftround                 " Round indent to multiple of shiftwidth.
set noexpandtab                " Do not expand tab with spaces.

" Wrapping.
set wrap                " Enable text wrapping.
set linebreak           " Break after words only.
set display+=lastline   " Show as much as possible from the last shown line.
set textwidth=0         " Don't automatically wrap lines.
" Disable automatic wrapping for all files (some filetype plugins set this to
" a different value).
au FileType * set textwidth=0

" Allow arrows at the end/beginning of lines to move to the next/previous line.
set whichwrap+=<,>,[,]

" Suffixes that get lower priority when doing tab completion for filenames.
" These files are less likely to be edited.
set suffixes=.bak,~,.swp,.o,.info,.aux,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

" Colors.
color elflord
syntax on

hi StatusLine ctermbg=white ctermfg=235

hi Error ctermfg=white ctermbg=darkred

hi String ctermfg=202
hi Function ctermfg=lightblue
hi NonText guifg=#4a4a59

hi SpecialKey guifg=#4a4a59
hi RedundantWhitespace ctermbg=darkblue guibg=darkblue
hi SpacesTabsMixture guifg=red guibg=gray19

" Highlight match.
hi Search ctermbg=19 ctermfg=white
hi ErrorMsg ctermbg=darkgray
hi SpellBad ctermbg=53 ctermfg=white

" Highlight mixture of spaces and tabs.
" Highlight mixtures only when there are at least two successive spaces to
" prevent highlighting of false positives (e.g. in git diffs, which may begin
" with a space).
match SpacesTabsMixture /^  \+\t\+[\t ]*\|^\t\+  \+[\t ]*/

" shebang for a new python file
autocmd BufNewFile *.py 0put = \"#!/usr/bin/env python3\<nl>\"|$

" shebang for a new bash script
autocmd BufNewFile *.sh 0put = \"#!/bin/bash\<nl>\"|$

" \rl Toggle relative/absolute line numbers.
nnoremap <silent> <Leader>rl :set relativenumber!<CR>:set relativenumber?<CR>

" Show non-printable characters \l
nnoremap <Leader>l :set list!<CR>
" pretty special non-printable characters
" set listchars=tab:▸\ ,eol:¬

" Redundant white spaces match and remove.
match RedundantWhitespace '\s\+$'
nnoremap <silent> <Leader>rw :%s/\s\+$//e<CR>

" Reload .vimrc file, useful when opening new file from existing vim session
nnoremap <Leader>rv :so ~/.vimrc<CR>

" Switch to hex view and back.
nnoremap <Leader>h :%!xxd<CR>
nnoremap <Leader>hr :%!xxd -r<CR>

" <up> <down> recall commands whose beginnings match the current command-line.
" It's smarter then default <c-p> <c-n> behavior.
cnoremap <c-n>  <down>
cnoremap <c-p>  <up>

" I usually jump to the beginning of the first word, and 0 is faster.
nnoremap 0 ^
nnoremap ^ 0

" Opening files in tabs.
nnoremap <Leader>bash :tabe ~/.bashrc<CR>
nnoremap <Leader>vim :tabe ~/.vimrc<CR>

" Quickly add empty line. Number of lines may precede.
nnoremap [<space>  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[
nnoremap ]<space>  :<c-u>put =repeat(nr2char(10), v:count1)<cr>

" Make j and k move by virtual lines instead of physical lines, but only when
" not used in the count mode (e.g. 3j). This is great when 'wrap' and
" 'relativenumber' are used.
" Based on http://stackoverflow.com/a/21000307/2580955
" Taken from https://github.com/s3rvac/dotfiles/blob/master/vim/.vimrc
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" Join lines using Leader + J, because J is used for tabs switching.
noremap <Leader>j J

" Join lines without producing any spaces. It works like gJ, but does not keep
" the indentation whitespace.
" Based on http://vi.stackexchange.com/a/440.
function! s:JoinWithoutSpaces()
	normal! gJ
	" Remove any whitespace.
	if matchstr(getline('.'), '\%' . col('.') . 'c.') =~ '\s'
		normal! dw
	endif
endfunction
noremap <silent> <Leader>J :call <SID>JoinWithoutSpaces()<CR>

" Make Y yank everything from the cursor to the end of the line.
" This makes Y act more like C or D because by default, Y yanks the current
" line (i.e. the same as yy).
noremap Y y$

" Smart window switching with awareness of Tmux panes. Now, I can use Ctrl+hjkl
" in both Vim and Tmux (without using the prefix). Based on
" http://www.codeography.com/2013/06/19/navigating-vim-and-tmux-splits.
" Note: I do not use https://github.com/christoomey/vim-tmux-navigator because
"       it does not work when vim is run over ssh.
if exists('$TMUX')
	function! s:TmuxOrSplitSwitch(wincmd, tmuxdir)
		let previous_winnr = winnr()
		silent! execute 'wincmd ' . a:wincmd
		if previous_winnr == winnr()
			call system('tmux select-pane -' . a:tmuxdir)
			redraw!
		endif
	endfunction

	let previous_title = substitute(system("tmux display-message -p '#{pane_title}'"), '\n', '', '')
	let &t_ti = "\<Esc>]2;vim\<Esc>\\" . &t_ti
	let &t_te = "\<Esc>]2;" . previous_title . "\<Esc>\\" . &t_te

	nnoremap <silent> <C-h> :call <SID>TmuxOrSplitSwitch('h', 'L')<CR>
	nnoremap <silent> <C-j> :call <SID>TmuxOrSplitSwitch('j', 'D')<CR>
	nnoremap <silent> <C-k> :call <SID>TmuxOrSplitSwitch('k', 'U')<CR>
	nnoremap <silent> <C-l> :call <SID>TmuxOrSplitSwitch('l', 'R')<CR>
else
	noremap <C-h> <C-w>h
	noremap <C-j> <C-w>j
	noremap <C-k> <C-w>k
	noremap <C-l> <C-w>l
endif

" Graphical Vim.
if has('gui_running')
	" Font.
	set guifont=Monospace\ 11.5

	" GUI options:
	"  - aA: Enable autoselection.
	"  - c: Use console dialogs.
	"  - i: Use a Vim icon.
	" Menubar, toolbar, scrollbars etc. are disabled.
	set guioptions=aAci

	" Leave no pixels around the GVim window.
	set guiheadroom=0

	" Enable mouse usage.
	set mouse=a

	" Hide mouse cursor when editing.
	set mousehide

	" Disable cursor blinking.
	set guicursor=a:blinkon0

	" Colors
	color elflord
	hi Normal guifg=white guibg=black
else
	" Lower the timeout when entering normal mode from insert mode.
	set ttimeoutlen=0

	" Check for changes in files more often. This makes Vim in terminal behaves
	" more like GVim, although sadly not the same.
	augroup file_change_check
	au!
	au BufEnter * silent! checktime
	augroup end

	" Make some key combinations work when running Vim in Tmux.
	if exists('$TMUX')
		execute "set <xUp>=\e[1;*A"
		execute "set <xDown>=\e[1;*B"
		execute "set <xRight>=\e[1;*C"
		execute "set <xLeft>=\e[1;*D"
		execute "set <xHome>=\e[1;*H"
		execute "set <xEnd>=\e[1;*F"
		execute "set <Insert>=\e[2;*~"
		execute "set <Delete>=\e[3;*~"
		execute "set <PageUp>=\e[5;*~"
		execute "set <PageDown>=\e[6;*~"
		if exists('$MC_TMPDIR')
			" Running inside Midnight Commander.
			execute "set <F1>=\e[1;*P"
			execute "set <F2>=\e[1;*Q"
			execute "set <F3>=\e[1;*R"
			execute "set <F4>=\e[1;*S"
		else
			" Not running inside Midnight Commander.
			execute "set <xF1>=\e[1;*P"
			execute "set <xF2>=\e[1;*Q"
			execute "set <xF3>=\e[1;*R"
			execute "set <xF4>=\e[1;*S"
		endif
		execute "set <F5>=\e[15;*~"
		execute "set <F6>=\e[17;*~"
		execute "set <F7>=\e[18;*~"
		execute "set <F8>=\e[19;*~"
		execute "set <F9>=\e[20;*~"
		execute "set <F10>=\e[21;*~"
		execute "set <F11>=\e[23;*~"
		execute "set <F12>=\e[24;*~"
	endif
endif

" Open a link under the cursor in a web browser (similar to gx, but faster).
let s:web_browser_path='/usr/bin/firefox'
function! s:OpenLinkUnderCursor()
	let curr_line = getline('.')
	let link = matchstr(curr_line, '\(http\|https\|ftp\|file\)://[^ )"]*')
	if link != ''
		execute ':silent !' . s:web_browser_path . ' ' . '"' . link . '"'
	endif
endfunction
nnoremap <silent> gl :call <SID>OpenLinkUnderCursor()<CR>

" A text object for the entire file ("a file").
" Usage: yaf
onoremap af :<C-u>normal! ggVG<CR>

" Jump to the previous/next tab.
noremap <silent> J gT
noremap <silent> K gt

" use // to search for next occurrence of visually selected text
vnoremap // y/<C-R>"<CR>

" * also counts number of occurrences of string.
noremap * *<C-O>:%s///gn<CR>

" Stay in visual mode when indenting.
vnoremap < <gv
vnoremap > >gv

" Spell-check
set nospell
set spelllang=en,cs,sk

" F1: Toggle spell checker.
nnoremap <silent> <F1> :set spell!<CR>:set spell?<CR>

" Shift-F1: Toggle English/Slovak/Czech spell dictionary.
function! s:ToggleSpelllang()
	if &spelllang =~ 'en'
		set spelllang=sk
	elseif &spelllang =~ 'sk'
		set spelllang=cs
	elseif &spelllang =~ 'cs'
		set spelllang=en
	endif
	set spelllang?
endfunction
nnoremap <silent> <S-F1> :call <SID>ToggleSpelllang()<CR>

" Command mistypes.
nnoremap :E :e
nnoremap :Q :q

" Shift+F3: Toggle the display of colorcolumn.
function! s:ToggleColorColumn()
	if &colorcolumn > 0
		set colorcolumn=""
	elseif &textwidth > 0
		let &colorcolumn = &textwidth
	else
		set colorcolumn=80,100
	endif
endfunction
nnoremap <silent> <S-F3> :call <SID>ToggleColorColumn()<CR>

" F4: Toggle line wrapping.
nnoremap <silent> <F4> :set nowrap!<CR>:set nowrap?<CR>

" F8: Make.
" Executes :make and opens the quickfix window if there is an error.
nnoremap <F8> mp :echo 'Making...' <Bar> silent make <Bar> botright cw<CR><C-w><Up>

"------------------------------------------------------------------------------
" File-type specific settings and other autocommands.
"------------------------------------------------------------------------------

" C and C++
augroup c_cpp
au!
" Use the man ftplugin to display pages from manual.
au FileType c,cpp runtime ftplugin/man.vim
" Use <Leader>man to display manual pages for the function under cursor.
au FileType c,cpp nnoremap <buffer> <silent> <Leader>man :Man 3 <cword><CR>
" Allow "gq" on comments to work properly.
au FileType c,cpp setl comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,bO:///,O://
augroup end

" Python
augroup python
au!
" The following settings are based on these guidelines:
"  - python.org/dev/peps/pep-0008
au FileType python setl expandtab     " Use spaces instead of tabs.
au FileType python setl tabstop=4     " A tab counts for 4 spaces.
au FileType python setl softtabstop=4 " Causes backspace to delete 4 spaces.
au FileType python setl shiftwidth=4  " Shift by 4 spaces.

" Go to imports.
au FileType python nnoremap <buffer> <Leader>im /^\(from\\|import\) <CR>:nohlsearch<CR>:echo<CR>

"ALE plugin
au FileType python let b:ale_linters = {'python': ['flake8']}
au FileType python let b:ale_python_flake8_options = '--max-line-length=100'

" argwrap plugin
au FileType python let b:argwrap_tail_comma = 1

" vim-sort-motion plugin
"
" This is not bulletproff and deterministic in all cases. E.g. the following
" two blocks are not changed with 'i' option. Moreover, with 'ui', only one is
" kept. But in most (real use-case) this suffices.
"
" from aaa import x
" from AAA import x
" from aAa import x
"
" from AAA import x
" from aAa import x
" from aaa import x
let g:sort_motion = '_gs'

function! s:SortImportsCaseInsensitively()
	if getline('.') =~ '^import\|^from.*import'
		let g:sort_motion_flags = 'ui'
	else
		let g:sort_motion_flags = ''
	endif
	normal _gs
endfunction
nnoremap <silent> gs :call <SID>SortImportsCaseInsensitively()<CR>g@

augroup end

" Git commits.
augroup gitcommit
au!
au FileType gitcommit setl spell         " Enable spell checking.
au FileType gitcommit setl expandtab     " Use spaces instead of tabs.
au FileType gitcommit setl tabstop=4     " A tab counts for 4 spaces.
au FileType gitcommit setl softtabstop=4 " Causes backspace to delete 4 spaces.
au FileType gitcommit setl shiftwidth=4  " Shift by 4 spaces.
augroup end

" LaTeX
augroup latex
au!
au FileType tex,plaintex setl spell      " Enable spell checking.
" Compilation.
" This errorformat presumes that you are using `pdflatex -file-line-error`
" to compile .tex files.
au FileType tex,plaintex setl errorformat=%f:%l:\ %m
augroup end

" Haskell
augroup haskell
au!
au FileType haskell setl expandtab     " Use spaces instead of tabs.
au FileType haskell setl tabstop=4     " A tab counts for 4 spaces.
au FileType haskell setl softtabstop=4 " Causes backspace to delete 4 spaces.
au FileType haskell setl shiftwidth=4  " Shift by 4 spaces.
augroup end

" Markdown
augroup markdown
au!
au FileType markdown setl spell         " Enable spellchecking.
au FileType markdown setl expandtab     " Use spaces instead of tabs.
au FileType markdown setl tabstop=4     " Lists are indented with 4 spaces.
au FileType markdown setl softtabstop=4 " Causes backspace to delete 4 spaces.
au FileType markdown setl shiftwidth=4  " Shift by 4 spaces.
augroup end

"------------------------------------------------------------------------------
" Plugins.
"------------------------------------------------------------------------------

"-----------------------------------------
" Command-T: Fast file navigation for VIM.
"-----------------------------------------
hi CommandTHighlightColor guibg=darkblue guifg=white
let g:CommandTCancelMap = ['<ESC>', '<C-c>']
let g:CommandTHighlightColor='CommandTHighlightColor' " Custom highlight color.
let g:CommandTMatchWindowReverse=1 " Show the entries in reverse order.
let g:CommandTMaxCachedDirectories=0 " Do not limit caching.
let g:CommandTMaxFiles=10000
let g:CommandTMaxHeight=10 " Show at most 10 matches.
let g:CommandTSuppressMaxFilesWarning=1
let g:CommandTTraverseSCM='pwd' " Use Vim's present working directory as the root.



" -----------------------------------------------------
" targets.vim: Additional text objects.
" -----------------------------------------------------
" Prefer multiline targets around cursor over distant targets within cursor
" line. E.g. In the following example, when cursor is on 'a', `ci{` will affect
" the outer block, not {b, c} block.
" {
"  a, {b, c}
" }
let g:targets_seekRanges = 'cr cb cB lc ac Ac lr lb ar ab lB Ar aB Ab AB rr ll rb al rB Al bb aa bB Aa BB AA'

"-----------------------------
" UltiSnips: Snippets for Vim.
"-----------------------------
let g:UltiSnipsExpandTrigger='<Tab>'
let g:UltiSnipsJumpForwardTrigger='<Tab>'
let g:UltiSnipsJumpBackwardTrigger='<S-Tab>'

" -----------------------------------------------------
" vim-argwrap: wrap/unwrap function args, lists, etc.
" -----------------------------------------------------
nnoremap <silent> <Leader>wa :ArgWrap<CR>

" -----------------------------------------------------
" vim-mail-refs: Adding references when writing emails.
" -----------------------------------------------------
augroup vim_mail_refs
au!
au FileType mail nnoremap <buffer> <Leader>ar :AddMailRef<CR>
au FileType mail nnoremap <buffer> <Leader>aR :AddMailRefFromMenu<CR>
au FileType mail nnoremap <buffer> <Leader>fr :FixMailRefs<CR>
augroup end

" --------------------------------------------------------------
" vim-online-thesaurus: Looking up words in an online thesaurus.
" --------------------------------------------------------------
let g:online_thesaurus_map_keys = 0 " Disable default key maps.
nnoremap <Leader>ot :OnlineThesaurusCurrentWord<CR>

" --------------------------------------------------------------
" ALE: Asynchronous Lint Engine
"
let g:ale_enabled = 0
let b:ale_linters_explicit = 1
nnoremap <silent> <F9> :ALEToggle<CR> :echo "ALE enabled: " ale_enabled<CR>
nnoremap <silent> <S-F9> :ALENextWrap<CR>

" --------------------------------------------------------------
" NERDTree: File explorer
"
nnoremap <silent> <Leader>e :NERDTreeToggle<CR>

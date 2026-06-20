" ============================================================
" SECTION 0: BOOTSTRAP vim-plug
" ============================================================
let s:plug_path = expand('~/.vim/autoload/plug.vim')
if empty(glob(s:plug_path))
  silent execute '!curl -fLo ' . s:plug_path . ' --create-dirs '
        \ . 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ============================================================
" SECTION 1: OPTIONS
"   Core settings, leaders, options.
" ============================================================
let mapleader = ' '
let maplocalleader = ' '
let g:have_nerd_font = 0
set nocompatible              " behave like Vim, not vi
syntax enable                 " Vim's built-in syntax (kickstart uses treesitter)
filetype plugin indent on     " filetype detection + per-language indent
set number                    " line numbers
set mouse=a                   " mouse support (handy for resizing splits)
set noshowmode                " mode is shown in the statusline (lightline) instead
set clipboard=unnamed         " sync with the macOS system clipboard (needs +clipboard)
set breakindent               " wrapped lines keep their indent
set undofile                  " persistent undo across sessions
set ignorecase smartcase      " case-insensitive search unless a capital is used
set signcolumn=yes            " always show the sign column (no layout shift)
set updatetime=250            " faster CursorHold / diagnostics
set timeoutlen=300            " quicker which-key / mapped-sequence timeout
set splitright splitbelow     " new splits open to the right / below
set list                      " show invisible characters...
set listchars=tab:»\ ,trail:·,nbsp:␣
set incsearch hlsearch        " incremental + highlighted search
set cursorline                " highlight the current line
set scrolloff=10              " keep 10 lines of context around the cursor
set confirm                   " ask to save instead of failing on :q with changes
set tabstop=4 shiftwidth=4    " (vim-sleuth auto-detects per file)
set hidden                    " allow switching away from unsaved buffers
set termguicolors             " 24-bit color (needed for gruvbox)
set wildmenu                  " better command-line completion
set shortmess+=c

" Keep undo / swap / backup files out of your project directories by sending
" them to central folders under ~/.vim (created if missing). The trailing //
" makes Vim encode the full path in the filename to avoid collisions.
for s:dir in ['undo', 'swap', 'backup']
  if !isdirectory(expand('~/.vim/' . s:dir))
    call mkdir(expand('~/.vim/' . s:dir), 'p')
  endif
endfor
set undodir=~/.vim/undo//
set directory=~/.vim/swap//
set backupdir=~/.vim/backup//

" ============================================================
" SECTION 3: PLUGINS  (vim-plug)
" ============================================================
call plug#begin('~/.vim/plugged')

" --- UI / core UX -------------------------------------------------------
Plug 'morhetz/gruvbox'                     " colorscheme
Plug 'itchyny/lightline.vim'               " statusline
Plug 'airblade/vim-gitgutter'              " git signs + hunks
Plug 'tpope/vim-sleuth'                    " auto indent detect
Plug 'machakann/vim-highlightedyank'       " flash on yank
Plug 'liuchengxu/vim-which-key'            " popup of pending keys

" --- Editing / text objects --------------------------------------------
Plug 'tpope/vim-surround'                  " add/change/delete surroundings
Plug 'tpope/vim-repeat'                    " makes surround/etc repeatable with .
Plug 'tpope/vim-commentary'                " gc to toggle comments
Plug 'wellle/targets.vim'                  " richer a/i text objects

" --- Fuzzy finder -------------------------------------------------------
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }  " installs the fzf binary
Plug 'junegunn/fzf.vim'                    " :Files/:Rg/:Buffers etc

" --- File explorer ------------------------------------------------------
Plug 'preservim/nerdtree'                  " file tree on \

" --- LSP + completion + snippets ---------------------------------------
Plug 'prabirshrestha/vim-lsp'              " LSP client         (nvim-lspconfig)
Plug 'mattn/vim-lsp-settings'              " auto-install servers (mason.nvim)
Plug 'prabirshrestha/asyncomplete.vim'     " completion engine  (blink.cmp)
Plug 'prabirshrestha/asyncomplete-lsp.vim' " LSP completion source
Plug 'hrsh7th/vim-vsnip'                   " snippet engine     (LuaSnip)
Plug 'hrsh7th/vim-vsnip-integ'             " vsnip <-> LSP/asyncomplete glue

call plug#end()

" ============================================================
" SECTION 4: COLORSCHEME + STATUSLINE
" ============================================================
let g:gruvbox_contrast_dark = 'hard'       " 'hard' | 'medium' | 'soft'
let g:gruvbox_italicize_comments = 0
set background=dark
silent! colorscheme gruvbox

" lightline shows mode/file/git/etc; keep it simple and matched to gruvbox.
let g:lightline = { 'colorscheme': 'gruvbox' }

" ============================================================
" SECTION 2: KEYMAPS
"   Mirrors kickstart's SECTION 2. Buffer-local LSP maps live in SECTION 6.
" ============================================================

" Clear search highlight on <Esc> in normal mode.
nnoremap <silent> <Esc> :nohlsearch<CR>

" Window navigation with Ctrl + h/j/k/l 
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k

" Disable arrow keys in normal/visual mode to build hjkl muscle memory.
" Insert mode is left alone (arrows are useful there and drive the menu).
for s:key in ['<Up>', '<Down>', '<Left>', '<Right>']
  execute 'nnoremap ' . s:key . ' <Nop>'
  execute 'vnoremap ' . s:key . ' <Nop>'
endfor

" Highlight-on-yank: how long the flash lasts (ms).
let g:highlightedyank_highlight_duration = 200

" ============================================================
" SECTION 5: SEARCH & NAVIGATION (fzf)
" ============================================================
" NOTE: Vim :map commands do NOT allow trailing comments (the text would be
" typed into the command), so each mapping's purpose is described above it.
" sf=files  sg=grep  sw=grep word  sh=help  sk=keymaps  sc=commands
" s.=recent files  s/=lines in open buffers  sn=config files
nnoremap <leader>sf :Files<CR>
nnoremap <leader>sg :Rg<CR>
nnoremap <leader>sw :execute 'Rg ' . expand('<cword>')<CR>
nnoremap <leader>sh :Helptags<CR>
nnoremap <leader>sk :Maps<CR>
nnoremap <leader>sc :Commands<CR>
nnoremap <leader>s. :History<CR>
nnoremap <leader>s/ :Lines<CR>
nnoremap <leader>sn :execute 'Files ' . expand('~/.vim')<CR>
" fuzzy find within the current buffer
nnoremap <leader>/  :BLines<CR>
" find existing buffers
nnoremap <leader><leader> :Buffers<CR>

" File tree on \ — toggles NERDTree, mirroring the neo-tree reveal binding.
nnoremap <silent> \ :NERDTreeToggle<CR>
" Close the tree automatically after opening a file (matches the nvim tweak).
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeMinimalUI = 1

" ============================================================
" SECTION 6: LSP  (vim-lsp + vim-lsp-settings)
" ============================================================
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_signs_enabled = 1
let g:lsp_diagnostics_virtual_text_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1        " echo diagnostic under cursor
let g:lsp_document_highlight_enabled = 1     " highlight refs of word under cursor
let g:lsp_code_action_ui = 'float' " Show code actions (gra) in a popup menu instead of the default 'preview'

" Keep diagnostics informative but unobtrusive. vim-lsp's defaults link the
" diagnostic text groups to 'Error'/'Todo', which paint a heavy block over the
" code and make it hard to read. Instead use a subtle undercurl in the
" diagnostic color. Signs in the gutter
" and virtual text at the end of the line still show where problems are.
" Re-applied on ColorScheme so the colorscheme can't clobber it.
function! s:LspDiagnosticHighlights() abort
  highlight LspErrorHighlight       gui=undercurl cterm=undercurl guisp=#fb4934
  highlight LspWarningHighlight     gui=undercurl cterm=undercurl guisp=#fabd2f
  highlight LspInformationHighlight gui=undercurl cterm=undercurl guisp=#83a598
  highlight LspHintHighlight        gui=undercurl cterm=undercurl guisp=#8ec07c
endfunction
augroup lsp_diagnostic_highlights
  autocmd!
  autocmd ColorScheme * call s:LspDiagnosticHighlights()
augroup END
call s:LspDiagnosticHighlights()

" Buffer-local maps applied whenever an LSP attaches 
function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  nmap <buffer> grd <plug>(lsp-definition)
  nmap <buffer> grD <plug>(lsp-declaration)
  nmap <buffer> grr <plug>(lsp-references)
  nmap <buffer> gri <plug>(lsp-implementation)
  nmap <buffer> grt <plug>(lsp-type-definition)
  nmap <buffer> grn <plug>(lsp-rename)
  nmap <buffer> gra <plug>(lsp-code-action)
  nmap <buffer> gO  <plug>(lsp-document-symbol-search)
  nmap <buffer> gW  <plug>(lsp-workspace-symbol-search)
  nmap <buffer> K   <plug>(lsp-hover)
  nmap <buffer> [d  <plug>(lsp-previous-diagnostic)
  nmap <buffer> ]d  <plug>(lsp-next-diagnostic)
  nmap <buffer> <leader>f <plug>(lsp-document-format)
  vmap <buffer> <leader>f <plug>(lsp-document-format)
  nmap <buffer> <leader>q <plug>(lsp-document-diagnostics)
endfunction

augroup lsp_install
  autocmd!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" ============================================================
" SECTION 7: FORMAT ON SAVE
" ============================================================
augroup lsp_format_on_save
  autocmd!
  autocmd BufWritePre *.go,*.rs LspDocumentFormatSync
  autocmd BufWritePre *.go call execute('LspCodeActionSync source.organizeImports')
augroup END

" ============================================================
" SECTION 8: AUTOCOMPLETE 
"     - the top suggestion is PRESELECTED (highlighted, not yet inserted)
"     - <Tab> ACCEPTS the highlighted item (one press commits it)
"     - <Tab> also expands / jumps through snippet placeholders
"     - <C-n>/<C-p> (or arrows) pick a different item before accepting
"     - <Enter> is a real newline; it dismisses the menu without accepting
" ============================================================
let g:asyncomplete_auto_popup = 1
let g:asyncomplete_auto_completeopt = 0
set completeopt=menuone,noinsert

" NOTE: these use imap (recursive) on purpose so <Plug> snippet maps expand.
" Order matches blink: if the menu is open, Tab accepts; otherwise it drives
" snippet expansion/jumping; otherwise it's a literal Tab.
imap <expr> <Tab>
      \ pumvisible()        ? "\<C-y>" :
      \ vsnip#available(1)  ? "\<Plug>(vsnip-expand-or-jump)" : "\<Tab>"
imap <expr> <S-Tab>
      \ pumvisible()        ? "\<C-p>" :
      \ vsnip#jumpable(-1)  ? "\<Plug>(vsnip-jump-prev)" : "\<S-Tab>"

" Same Tab/S-Tab snippet navigation while a placeholder is selected (select mode).
smap <expr> <Tab>   vsnip#available(1) ? "\<Plug>(vsnip-expand-or-jump)" : "\<Tab>"
smap <expr> <S-Tab> vsnip#jumpable(-1) ? "\<Plug>(vsnip-jump-prev)" : "\<S-Tab>"

" Enter = newline; cancel the popup first so it does not accept a suggestion.
inoremap <expr> <CR> pumvisible() ? "\<C-e>\<CR>" : "\<CR>"

" Force the completion menu to (re)appear on demand.
imap <c-space> <Plug>(asyncomplete_force_refresh)

" ============================================================
" SECTION 9: WHICH-KEY
"   Press <space> and pause to see available leader mappings.
" ============================================================
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>
let g:which_key_map = {
      \ 's': { 'name': '+search' },
      \ 'f': 'format-buffer',
      \ 'q': 'diagnostics-list',
      \ '/': 'find-in-buffer',
      \ }
autocmd VimEnter * silent! call which_key#register('<Space>', 'g:which_key_map')

" vim: ts=2 sts=2 sw=2 et

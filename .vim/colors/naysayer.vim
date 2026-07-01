hi clear
if exists('syntax_on')
  syntax reset
endif
set background=dark
let g:colors_name = 'naysayer'

" ---------------------------------------------------------------------------
" Palette: name -> [guihex, cterm256]
" ---------------------------------------------------------------------------
let s:p = {}
let s:p.none     = ['NONE',    'NONE']
let s:p.bg       = ['#062625', '235']  " background / gutter
let s:p.text     = ['#d0b892', '180']  " text / variable / function
let s:p.white    = ['#ffffff', '231']  " keyword
let s:p.sel      = ['#0000ff', '21']   " selection
let s:p.linefg   = ['#126367', '23']   " line numbers / splits
let s:p.hl       = ['#0b3335', '236']  " cursorline / colorcolumn
let s:p.comment  = ['#53d549', '77']
let s:p.punct    = ['#8cde94', '114']  " punctuation / macro / type
let s:p.string   = ['#3ad0b5', '43']
let s:p.constant = ['#87ffde', '122']  " constant / number
let s:p.orange   = ['#fd971f', '208']
let s:p.red      = ['#f92672', '197']
let s:p.yellow   = ['#e6db74', '186']
let s:p.green    = ['#a6e22e', '148']
let s:p.blue     = ['#66d9ef', '81']
let s:p.cyan     = ['#a1efe4', '158']
let s:p.magenta  = ['#fd5ff0', '207']
let s:p.violet   = ['#ae81ff', '141']
let s:p.error    = ['#ff0000', '196']
let s:p.warning  = ['#ffaa00', '214']
let s:p.lfg      = ['#12251b', '235']  " lualine/statusline fg
let s:p.lbg      = ['#d3b58e', '180']  " lualine/statusline bg

" ---------------------------------------------------------------------------
" Helpers
" ---------------------------------------------------------------------------
function! s:h(group, fg, bg, ...) abort
  let l:attr = a:0 >= 1 ? a:1 : 'NONE'
  let l:sp   = a:0 >= 2 ? a:2 : 'none'
  let l:cmd  = 'highlight ' . a:group
  let l:cmd .= ' guifg='   . s:p[a:fg][0] . ' guibg='   . s:p[a:bg][0]
  let l:cmd .= ' ctermfg=' . s:p[a:fg][1] . ' ctermbg=' . s:p[a:bg][1]
  let l:cmd .= ' gui=' . l:attr . ' cterm=' . l:attr
  if l:sp !=# 'none'
    let l:cmd .= ' guisp=' . s:p[l:sp][0]
  endif
  execute l:cmd
endfunction

function! s:l(from, to) abort
  execute 'highlight! link ' . a:from . ' ' . a:to
endfunction

" ===========================================================================
" Editor / UI
" ===========================================================================
call s:h('Normal',       'text',   'bg')
call s:h('NormalNC',     'text',   'bg')
call s:h('Cursor',       'bg',     'white')
call s:l('lCursor',      'Cursor')
call s:l('TermCursor',   'Cursor')
call s:h('Visual',       'none',   'sel')
call s:l('VisualNOS',    'Visual')
call s:h('LineNr',       'linefg', 'bg')
call s:h('CursorLineNr', 'white',  'bg')
call s:h('CursorLine',   'none',   'hl')
call s:l('CursorColumn', 'CursorLine')
call s:h('ColorColumn',  'none',   'hl')
call s:h('SignColumn',   'linefg', 'bg')
call s:h('VertSplit',    'linefg', 'bg')
call s:h('WinSeparator', 'linefg', 'bg')
call s:h('MatchParen',   'white',  'sel')
call s:h('Folded',       'linefg', 'hl')
call s:h('FoldColumn',   'linefg', 'bg')
call s:h('Conceal',      'linefg', 'none')
call s:h('NonText',      'linefg', 'none')
call s:h('SpecialKey',   'linefg', 'none')
call s:h('Whitespace',   'linefg', 'none')
call s:h('EndOfBuffer',  'bg',     'bg')
call s:h('Directory',    'blue',   'none')
call s:h('Title',        'white',  'none')

" Popup menu
call s:h('Pmenu',        'text',   'hl')
call s:h('PmenuSel',     'bg',     'text')
call s:h('PmenuSbar',    'none',   'hl')
call s:h('PmenuThumb',   'none',   'linefg')
call s:l('WildMenu',     'PmenuSel')

" Search
call s:h('Search',       'bg',     'yellow')
call s:h('IncSearch',    'bg',     'orange')
call s:h('CurSearch',    'bg',     'orange')
call s:l('Substitute',   'Search')

" Status / tabs
call s:h('StatusLine',   'lfg',    'lbg')
call s:h('StatusLineNC', 'linefg', 'bg')
call s:h('TabLine',      'text',   'hl')
call s:h('TabLineSel',   'bg',     'text')
call s:h('TabLineFill',  'linefg', 'bg')

" Messages
call s:h('ModeMsg',      'comment', 'none')
call s:h('MoreMsg',      'comment', 'none')
call s:h('Question',     'constant','none')
call s:h('WarningMsg',   'warning', 'none')
call s:h('Error',        'error',   'none')
call s:l('ErrorMsg',     'Error')

" Spelling
call s:h('SpellBad',     'none', 'none', 'undercurl', 'error')
call s:h('SpellCap',     'none', 'none', 'undercurl', 'blue')
call s:h('SpellRare',    'none', 'none', 'undercurl', 'violet')
call s:h('SpellLocal',   'none', 'none', 'undercurl', 'cyan')

" ===========================================================================
" Syntax
" ===========================================================================
call s:h('Comment',      'comment', 'none')
call s:l('SpecialComment','Comment')
call s:h('Todo',         'warning', 'none', 'bold')

" Constants
call s:h('Constant',     'constant','none')
call s:h('String',       'string',  'none')
call s:l('Character',    'String')
call s:h('Number',       'constant','none')
call s:l('Float',        'Number')
call s:h('Boolean',      'constant','none')

" Identifiers / functions
call s:h('Identifier',   'text',    'none')
call s:h('Function',     'text',    'none')

" Statements / keywords
call s:h('Statement',    'white',   'none')
call s:h('Keyword',      'white',   'none')
call s:l('Conditional',  'Keyword')
call s:l('Repeat',       'Keyword')
call s:l('Label',        'Keyword')
call s:l('Exception',    'Keyword')
call s:h('Operator',     'punct',   'none')

" Preprocessor
call s:h('PreProc',      'punct',   'none')
call s:l('Include',      'PreProc')
call s:l('Define',       'PreProc')
call s:l('Macro',        'PreProc')
call s:l('PreCondit',    'PreProc')

" Types
call s:h('Type',         'punct',   'none')
call s:l('StorageClass', 'Type')
call s:l('Structure',    'Type')
call s:l('Typedef',      'Type')

" Special / punctuation
call s:h('Special',      'orange',  'none')
call s:l('SpecialChar',  'Special')
call s:l('Debug',        'Special')
call s:h('Delimiter',    'punct',   'none')
call s:h('Underlined',   'blue',    'none', 'underline')
call s:h('Ignore',       'bg',      'none')

" ===========================================================================
" Diff
" ===========================================================================
call s:h('DiffAdd',    'green',  'none')
call s:h('DiffChange', 'blue',   'none')
call s:h('DiffDelete', 'red',    'none')
call s:h('DiffText',   'yellow', 'none')
call s:l('Added',      'DiffAdd')
call s:l('Changed',    'DiffChange')
call s:l('Removed',    'DiffDelete')

" ===========================================================================
" Diagnostics (Neovim; harmless in classic Vim)
" ===========================================================================
call s:h('DiagnosticError', 'red',     'none')
call s:h('DiagnosticWarn',  'warning', 'none')
call s:h('DiagnosticInfo',  'blue',    'none')
call s:h('DiagnosticHint',  'cyan',    'none')

" ===========================================================================
" Rainbow delimiters
" ===========================================================================
call s:h('rainbowcol1', 'violet', 'none')
call s:h('rainbowcol2', 'blue',   'none')
call s:h('rainbowcol3', 'green',  'none')
call s:h('rainbowcol4', 'yellow', 'none')
call s:h('rainbowcol5', 'orange', 'none')
call s:h('rainbowcol6', 'red',    'none')

" ===========================================================================
" :terminal ANSI palette
" ===========================================================================
if has('terminal') || has('nvim')
  let g:terminal_ansi_colors = [
        \ '#062625', '#f92672', '#a6e22e', '#e6db74',
        \ '#66d9ef', '#fd5ff0', '#a1efe4', '#d0b892',
        \ '#126367', '#fd971f', '#8cde94', '#e6db74',
        \ '#66d9ef', '#ae81ff', '#87ffde', '#ffffff',
        \ ]
endif

" cleanup
delfunction s:h
delfunction s:l

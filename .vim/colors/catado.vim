hi clear
if exists('syntax_on')
  syntax reset
endif
let g:colors_name = 'catado'

" ---------------------------------------------------------------------------
" Palette: name -> [guihex, cterm256]
" ---------------------------------------------------------------------------
let s:p = {}
let s:p.none    = ['NONE',    'NONE']
let s:p.black   = ['#000000', '0']
let s:p.mainbg  = ['#181825', '233']
let s:p.gray1   = ['#080808', '232']
let s:p.gray2   = ['#191919', '234']
let s:p.gray3   = ['#2a2a2a', '235']
let s:p.gray4   = ['#444444', '238']
let s:p.gray5   = ['#555555', '240']
let s:p.gray6   = ['#7a7a7a', '243']
let s:p.gray7   = ['#aaaaaa', '248']
let s:p.gray8   = ['#cccccc', '252']
let s:p.gray9   = ['#dddddd', '253']
let s:p.orange  = ['#fab387', '216']
let s:p.yellow  = ['#f9e2af', '143']
let s:p.green   = ['#a6e3a1', '65']
let s:p.blue    = ['#89dceb', '103']
let s:p.red     = ['#f38ba8', '252']
let s:p.teal    = ['#94e2d5', '252']

let s:p.fn      = ['#ffffff', '252'] " white
let s:p.txt     = ['#ffffff', '252'] " white
let s:p.kw      = ['#aaaaaa', '65']  " gray
let s:p.pre     = ['#aaaaaa', '65']  " gray

let s:p.cnst    = ['#89b4fa', '66']  " blue
let s:p.id      = ['#a6e3a1', '252'] " green
let s:p.spcl    = ['#a6e3a1', '252'] " green

let s:p.sl      = ['#242424', '235']
let s:p.menu    = ['#191919', '234']
let s:p.ws      = ['#202020', '234']
let s:p.msg     = ['#deeeed', '195']

" ---------------------------------------------------------------------------
" Helpers
" ---------------------------------------------------------------------------
" s:h(group, fg, bg [, attr [, sp]])  -- fg/bg/sp are palette keys
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

" s:l(from, to)  -- link
function! s:l(from, to) abort
  execute 'highlight! link ' . a:from . ' ' . a:to
endfunction

" ===========================================================================
" Editor / UI
" ===========================================================================
call s:h('Normal',        'txt',  'mainbg')
call s:h('NormalNC',      'txt',  'mainbg')
call s:h('Cursor',        'mainbg', 'gray8')
call s:l('lCursor',       'Cursor')
call s:l('TermCursor',    'Cursor')
call s:h('CursorLine',    'none',   'gray2')
call s:l('CursorColumn',  'CursorLine')
call s:h('CursorLineNr',  'gray7',  'none')
call s:h('LineNr',        'gray4',  'none')
call s:h('SignColumn',    'gray4',  'mainbg')
call s:h('ColorColumn',   'none',   'gray1')
call s:h('Folded',        'gray4',  'gray1')
call s:h('FoldColumn',    'gray4',  'mainbg')
call s:h('Conceal',       'gray5',  'none')
call s:h('NonText',       'gray5',  'none')
call s:h('SpecialKey',    'gray4',  'none')
call s:h('Whitespace',    'ws',     'none')
call s:h('EndOfBuffer',   'mainbg', 'mainbg')
call s:h('Directory',     'gray5',  'none')
call s:h('Title',         'gray5',  'none')

" Splits / status / tabs
call s:h('VertSplit',     'gray4',  'mainbg')
call s:h('WinSeparator',  'gray4',  'mainbg')
call s:h('StatusLine',    'gray7',  'sl')
call s:h('StatusLineNC',  'gray4',  'gray1')
call s:h('TabLine',       'gray4',  'gray2')
call s:h('TabLineSel',    'gray1',  'gray8')
call s:h('TabLineFill',   'gray7',  'sl')

" Popup menu
call s:h('Pmenu',         'gray6',  'menu')
call s:h('PmenuSbar',     'gray3',  'gray3')
call s:h('PmenuThumb',    'gray5',  'gray5')
call s:h('PmenuSel',      'black',  'gray8')
call s:l('WildMenu',      'PmenuSel')

" Search / selection / matching
call s:h('Search',        'black',  'cnst')
call s:h('IncSearch',     'black',  'gray8')
call s:h('CurSearch',     'black',  'gray8')
call s:l('Substitute',    'Search')
call s:h('Visual',        'black',  'gray8')
call s:l('VisualNOS',     'Visual')
call s:h('MatchParen',    'gray8',  'cnst')

" Messages
call s:h('ModeMsg',       'msg', 'none')
call s:h('MoreMsg',       'msg', 'none')
call s:h('MsgArea',       'msg', 'none')
call s:h('Question',      'gray6',  'none')
call s:h('WarningMsg',    'orange', 'none')
call s:h('Error',         'red',    'none')
call s:l('ErrorMsg',      'Error')
call s:h('QuickFixLine',  'green',  'none')

" Spelling
call s:h('SpellBad',      'none', 'none', 'undercurl', 'red')
call s:h('SpellCap',      'none', 'none', 'undercurl', 'blue')
call s:h('SpellRare',     'none', 'none', 'undercurl', 'yellow')
call s:h('SpellLocal',    'none', 'none', 'undercurl', 'green')

" Syntax
call s:h('Comment',        'teal',    'none')
call s:h('SpecialComment', 'teal',    'none')
call s:h('Todo',           'orange',  'none')

" Constants
call s:h('Constant',       'cnst',  'none')
call s:l('Character',      'Constant')
call s:l('Number',         'Constant')
call s:l('Boolean',        'Constant')
call s:l('Float',          'Constant')

" Identifiers / functions
call s:h('Identifier',     'id',  'none')
call s:h('Function',       'fn',  'none')

" Statements / keywords
call s:h('Statement',      'kw',     'none')
call s:h('Keyword',        'kw',     'none')
call s:l('Conditional',    'Keyword')
call s:l('Repeat',         'Keyword')
call s:l('Label',          'Keyword')
call s:l('Exception',      'Keyword')

" Preprocessor
call s:h('PreProc',        'pre', 'none')
call s:l('Include',        'PreProc')
call s:l('Define',         'PreProc')
call s:l('Macro',          'PreProc')
call s:l('PreCondit',      'PreProc')

" Types
call s:h('Type',           'id',  'none')
call s:l('StorageClass',   'Type')
call s:l('Structure',      'Type')
call s:l('Typedef',        'Type')

" Special / punctuation
call s:h('Special',        'spcl',   'none')
call s:l('SpecialChar',    'Special')
call s:l('Debug',          'Special')
call s:h('Delimiter',      'gray6',  'none')
call s:h('Operator',       'gray6',  'none')
call s:h('Tag',            'gray5',  'none')
call s:h('Underlined',     'gray6',  'none', 'underline')
call s:h('Ignore',         'mainbg', 'none')

" Diff
call s:h('DiffAdd',      'green',  'none')
call s:h('DiffChange',   'yellow',  'none')
call s:h('DiffDelete',   'orange', 'none')
call s:h('DiffText',     'gray5',  'none')
call s:l('Added',        'DiffAdd')
call s:l('Changed',      'DiffChange')
call s:l('Removed',      'DiffDelete')

" netrw
call s:l('netrwDir',       'Directory')
call s:l('netrwClassify',  'Delimiter')
call s:l('netrwExe',       'DiffAdd')
call s:l('netrwSymLink',   'Special')

" :terminal ANSI palette
if has('terminal') || has('nvim')
  let g:terminal_ansi_colors = [
        \ '#080808', '#d70000', '#789978', '#abab77',
        \ '#7788aa', '#708090', '#708090', '#cccccc',
        \ '#444444', '#d70000', '#789978', '#abab77',
        \ '#7788aa', '#708090', '#deeeed', '#dddddd',
        \ ]
endif

" cleanup
delfunction s:h
delfunction s:l

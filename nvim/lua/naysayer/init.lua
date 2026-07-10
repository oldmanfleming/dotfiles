-- naysayer -- a dark green-blue colorscheme
-- Ported from ~/.vim/colors/naysayer.vim; after Nick Aversano's Emacs theme.

local M = {}

-- ---------------------------------------------------------------------------
-- Palette: name -> { gui, cterm }
-- ---------------------------------------------------------------------------
M.palette = {
  bg       = { gui = '#062625', cterm = 235 }, -- background / gutter
  text     = { gui = '#d0b892', cterm = 180 }, -- names: identifiers, calls, types, symbols
  white    = { gui = '#ffffff', cterm = 231 }, -- reserved words
  sel      = { gui = '#0000ff', cterm = 21 },  -- selection
  linefg   = { gui = '#126367', cterm = 23 },  -- line numbers / splits
  hl       = { gui = '#0b3335', cterm = 236 }, -- cursorline / colorcolumn
  comment  = { gui = '#53d549', cterm = 77 },
  builtin  = { gui = '#8cde94', cterm = 114 }, -- builtin types / directives / attributes
  string   = { gui = '#3ad0b5', cterm = 43 },
  constant = { gui = '#87ffde', cterm = 122 }, -- constant / number
  orange   = { gui = '#fd971f', cterm = 208 },
  red      = { gui = '#f92672', cterm = 197 },
  yellow   = { gui = '#e6db74', cterm = 186 },
  green    = { gui = '#a6e22e', cterm = 148 },
  blue     = { gui = '#66d9ef', cterm = 81 },
  cyan     = { gui = '#a1efe4', cterm = 158 },
  magenta  = { gui = '#fd5ff0', cterm = 207 },
  violet   = { gui = '#ae81ff', cterm = 141 },
  error    = { gui = '#ff0000', cterm = 196 },
  warning  = { gui = '#ffaa00', cterm = 214 },
  lfg      = { gui = '#12251b', cterm = 235 }, -- statusline fg
  lbg      = { gui = '#d3b58e', cterm = 180 }, -- statusline bg
}

local p = M.palette

-- ---------------------------------------------------------------------------
-- Helpers. A nil fg or bg means NONE.
-- ---------------------------------------------------------------------------
local function h(group, fg, bg, attrs, sp)
  local spec = {}
  if fg then
    spec.fg, spec.ctermfg = p[fg].gui, p[fg].cterm
  end
  if bg then
    spec.bg, spec.ctermbg = p[bg].gui, p[bg].cterm
  end
  if attrs then
    if type(attrs) == 'string' then
      attrs = { attrs }
    end
    spec.cterm = {}
    for _, a in ipairs(attrs) do
      spec[a] = true
      spec.cterm[a] = true
    end
  end
  if sp then
    spec.sp = p[sp].gui
  end
  vim.api.nvim_set_hl(0, group, spec)
end

local function l(from, to)
  vim.api.nvim_set_hl(0, from, { link = to })
end

function M.load()
  vim.cmd 'highlight clear'
  if vim.fn.exists 'syntax_on' == 1 then
    vim.cmd 'syntax reset'
  end
  vim.o.background = 'dark'
  vim.g.colors_name = 'naysayer'

  -- =========================================================================
  -- Editor / UI
  -- =========================================================================
  h('Normal', 'text', 'bg')
  h('NormalNC', 'text', 'bg')
  h('Cursor', 'bg', 'white')
  l('lCursor', 'Cursor')
  l('TermCursor', 'Cursor')
  h('Visual', nil, 'sel')
  l('VisualNOS', 'Visual')
  h('LineNr', 'linefg', 'bg')
  h('CursorLineNr', 'white', 'bg')
  h('CursorLine', nil, 'hl')
  l('CursorColumn', 'CursorLine')
  h('ColorColumn', nil, 'hl')
  h('SignColumn', 'linefg', 'bg')
  h('VertSplit', 'linefg', 'bg')
  h('WinSeparator', 'linefg', 'bg')
  h('MatchParen', 'white', 'sel')
  h('Folded', 'linefg', 'hl')
  h('FoldColumn', 'linefg', 'bg')
  h('Conceal', 'linefg', nil)
  h('NonText', 'linefg', nil)
  h('SpecialKey', 'linefg', nil)
  h('Whitespace', 'linefg', nil)
  h('EndOfBuffer', 'bg', 'bg')
  h('Directory', 'blue', nil)
  h('Title', 'white', nil)
  h('QuickFixLine', nil, 'hl')
  h('WinBar', 'text', 'bg')
  h('WinBarNC', 'linefg', 'bg')
  h('MsgSeparator', 'linefg', 'bg')

  -- Floating windows
  h('NormalFloat', 'text', 'hl')
  h('FloatBorder', 'linefg', 'hl')
  h('FloatTitle', 'white', 'hl')

  -- Popup menu
  h('Pmenu', 'text', 'hl')
  h('PmenuSel', 'bg', 'text')
  h('PmenuSbar', nil, 'hl')
  h('PmenuThumb', nil, 'linefg')
  h('PmenuMatch', 'blue', 'hl', 'bold')
  h('PmenuMatchSel', 'bg', 'text', 'bold')
  l('WildMenu', 'PmenuSel')

  -- Search
  h('Search', 'bg', 'yellow')
  h('IncSearch', 'bg', 'orange')
  h('CurSearch', 'bg', 'orange')
  l('Substitute', 'Search')

  -- Status / tabs
  h('StatusLine', 'lfg', 'lbg')
  h('StatusLineNC', 'linefg', 'bg')
  h('TabLine', 'text', 'hl')
  h('TabLineSel', 'bg', 'text')
  h('TabLineFill', 'linefg', 'bg')

  -- Messages
  h('ModeMsg', 'comment', nil)
  h('MoreMsg', 'comment', nil)
  h('Question', 'constant', nil)
  h('WarningMsg', 'warning', nil)
  h('Error', 'error', nil)
  l('ErrorMsg', 'Error')

  -- Spelling
  h('SpellBad', nil, nil, 'undercurl', 'error')
  h('SpellCap', nil, nil, 'undercurl', 'blue')
  h('SpellRare', nil, nil, 'undercurl', 'violet')
  h('SpellLocal', nil, nil, 'undercurl', 'cyan')

  -- =========================================================================
  -- Syntax
  -- =========================================================================
  h('Comment', 'comment', nil)
  l('SpecialComment', 'Comment')
  h('Todo', 'warning', nil, 'bold')

  -- Constants
  h('Constant', 'constant', nil)
  h('String', 'string', nil)
  l('Character', 'String')
  h('Number', 'constant', nil)
  l('Float', 'Number')
  h('Boolean', 'constant', nil)

  -- Identifiers / functions
  h('Identifier', 'text', nil)
  h('Function', 'text', nil)

  -- Statements / keywords
  h('Statement', 'white', nil)
  h('Keyword', 'white', nil)
  l('Conditional', 'Keyword')
  l('Repeat', 'Keyword')
  l('Label', 'Keyword')
  l('Exception', 'Keyword')
  h('Operator', 'text', nil)

  -- Preprocessor. Directives stay `builtin`; a macro name is a call, so it
  -- follows Function, matching @function.macro.
  h('PreProc', 'builtin', nil)
  l('Include', 'PreProc')
  l('Define', 'PreProc')
  l('PreCondit', 'PreProc')
  l('Macro', 'Function')

  -- Types. Legacy syntax cannot tell a named type from a builtin one, so it
  -- gets the same `text` that @type does; @type.builtin carries the green.
  h('Type', 'text', nil)
  l('StorageClass', 'Type')
  l('Structure', 'Type')
  l('Typedef', 'Type')

  -- Special / punctuation
  h('Special', 'orange', nil)
  l('SpecialChar', 'Special')
  l('Debug', 'Special')
  h('Delimiter', 'text', nil)
  h('Underlined', 'blue', nil, 'underline')
  h('Ignore', 'bg', nil)

  -- =========================================================================
  -- Diff
  -- =========================================================================
  h('DiffAdd', 'green', nil)
  h('DiffChange', 'blue', nil)
  h('DiffDelete', 'red', nil)
  h('DiffText', 'yellow', nil)
  l('Added', 'DiffAdd')
  l('Changed', 'DiffChange')
  l('Removed', 'DiffDelete')

  -- =========================================================================
  -- Diagnostics
  -- =========================================================================
  h('DiagnosticError', 'red', nil)
  h('DiagnosticWarn', 'warning', nil)
  h('DiagnosticInfo', 'blue', nil)
  h('DiagnosticHint', 'cyan', nil)
  h('DiagnosticOk', 'green', nil)

  for _, kind in ipairs { 'Error', 'Warn', 'Info', 'Hint', 'Ok' } do
    l('DiagnosticSign' .. kind, 'Diagnostic' .. kind)
    l('DiagnosticFloating' .. kind, 'Diagnostic' .. kind)
    l('DiagnosticVirtualText' .. kind, 'Diagnostic' .. kind)
    l('DiagnosticVirtualLines' .. kind, 'Diagnostic' .. kind)
  end

  h('DiagnosticUnderlineError', nil, nil, 'undercurl', 'red')
  h('DiagnosticUnderlineWarn', nil, nil, 'undercurl', 'warning')
  h('DiagnosticUnderlineInfo', nil, nil, 'undercurl', 'blue')
  h('DiagnosticUnderlineHint', nil, nil, 'undercurl', 'cyan')
  h('DiagnosticUnderlineOk', nil, nil, 'undercurl', 'green')
  h('DiagnosticUnnecessary', 'linefg', nil)
  h('DiagnosticDeprecated', nil, nil, 'strikethrough', 'red')

  -- =========================================================================
  -- LSP
  -- =========================================================================
  h('LspReferenceText', nil, 'hl')
  l('LspReferenceRead', 'LspReferenceText')
  l('LspReferenceWrite', 'LspReferenceText')
  h('LspInlayHint', 'linefg', 'hl')
  h('LspCodeLens', 'linefg', nil)
  h('LspSignatureActiveParameter', 'orange', nil, 'bold')

  -- =========================================================================
  -- Treesitter
  --
  -- Naysayer is deliberately flat, and the split is by what you can rename:
  --   text     names -- variables, calls, named types, enum variants, symbols
  --   white    reserved words
  --   builtin  things the compiler provides -- builtin types, directives,
  --            attributes
  --   constant / string / comment  as they say
  -- Keep it that way.
  -- =========================================================================
  l('@comment', 'Comment')
  l('@comment.documentation', 'Comment')
  l('@comment.todo', 'Todo')
  h('@comment.error', 'red', nil, 'bold')
  h('@comment.warning', 'warning', nil, 'bold')
  h('@comment.note', 'blue', nil, 'bold')

  l('@string', 'String')
  l('@string.documentation', 'String')
  l('@string.escape', 'Special')
  l('@string.regexp', 'Special')
  l('@string.special', 'Special')
  l('@string.special.url', 'Underlined')
  l('@character', 'Character')
  l('@character.special', 'Special')

  l('@number', 'Number')
  l('@number.float', 'Float')
  l('@boolean', 'Boolean')

  l('@constant', 'Constant')
  l('@constant.builtin', 'Constant')
  l('@constant.macro', 'PreProc')

  l('@variable', 'Identifier')
  l('@variable.builtin', 'Identifier')
  l('@variable.parameter', 'Identifier')
  l('@variable.parameter.builtin', 'Identifier')
  l('@variable.member', 'Identifier')
  l('@property', 'Identifier')
  l('@field', 'Identifier')

  l('@function', 'Function')
  l('@function.builtin', 'Function')
  l('@function.call', 'Function')
  l('@function.method', 'Function')
  l('@function.method.call', 'Function')
  -- A macro invocation is a call; attributes below stay `builtin` green.
  l('@function.macro', 'Function')
  l('@constructor', 'Function')

  l('@keyword', 'Keyword')
  l('@keyword.function', 'Keyword')
  l('@keyword.operator', 'Keyword')
  l('@keyword.return', 'Keyword')
  l('@keyword.conditional', 'Keyword')
  l('@keyword.conditional.ternary', 'Keyword')
  l('@keyword.repeat', 'Keyword')
  l('@keyword.import', 'Keyword')
  l('@keyword.exception', 'Keyword')
  l('@keyword.coroutine', 'Keyword')
  l('@keyword.debug', 'Keyword')
  l('@keyword.directive', 'Keyword')
  l('@keyword.directive.define', 'Keyword')
  l('@keyword.modifier', 'Keyword')
  l('@keyword.type', 'Keyword')
  l('@label', 'Label')

  l('@operator', 'Operator')
  l('@punctuation.delimiter', 'Delimiter')
  l('@punctuation.bracket', 'Delimiter')
  l('@punctuation.special', 'Special')

  -- Named types read as identifiers; only the language's own builtin types
  -- keep `builtin` green. `int` is captured as both @type and @type.builtin,
  -- and the later capture wins. A qualifier (C's `const`) is a reserved word.
  l('@type', 'Identifier')
  l('@type.definition', 'Identifier')
  h('@type.builtin', 'builtin', nil)
  l('@type.qualifier', 'Keyword')
  l('@attribute', 'PreProc')
  l('@attribute.builtin', 'PreProc')

  l('@module', 'Identifier')
  l('@module.builtin', 'Identifier')
  l('@namespace', 'Identifier')

  l('@tag', 'Keyword')
  l('@tag.builtin', 'Keyword')
  l('@tag.attribute', 'Identifier')
  l('@tag.delimiter', 'Delimiter')

  l('@diff.plus', 'DiffAdd')
  l('@diff.minus', 'DiffDelete')
  l('@diff.delta', 'DiffChange')

  -- Markup (markdown, help files, docstrings)
  h('@markup.strong', nil, nil, 'bold')
  h('@markup.italic', nil, nil, 'italic')
  h('@markup.strikethrough', nil, nil, 'strikethrough')
  h('@markup.underline', nil, nil, 'underline')
  h('@markup.heading', 'white', nil, 'bold')
  for i = 1, 6 do
    l('@markup.heading.' .. i, '@markup.heading')
  end
  l('@markup.quote', 'Comment')
  l('@markup.math', 'Constant')
  h('@markup.link', 'blue', nil)
  l('@markup.link.label', '@markup.link')
  l('@markup.link.url', 'Underlined')
  l('@markup.raw', 'String')
  l('@markup.raw.block', 'String')
  l('@markup.list', 'Delimiter')
  h('@markup.list.checked', 'green', nil)
  h('@markup.list.unchecked', 'linefg', nil)

  -- =========================================================================
  -- LSP semantic tokens
  -- =========================================================================
  vim.api.nvim_set_hl(0, '@lsp.type.comment', {})

  l('@lsp.type.class', 'Identifier')
  l('@lsp.type.decorator', 'PreProc')
  l('@lsp.type.enum', 'Identifier')
  -- Enum variants read as identifiers, not constants. Treesitter cannot tell
  -- them from real consts (both capture as @constant), but LSP servers can.
  l('@lsp.type.enumMember', 'Identifier')
  l('@lsp.type.function', 'Function')
  l('@lsp.type.interface', 'Identifier')
  l('@lsp.type.keyword', 'Keyword')
  l('@lsp.type.macro', 'Function')
  l('@lsp.type.method', 'Function')
  l('@lsp.type.modifier', 'Keyword')
  l('@lsp.type.namespace', 'Identifier')
  l('@lsp.type.number', 'Number')
  l('@lsp.type.operator', 'Operator')
  l('@lsp.type.parameter', 'Identifier')
  l('@lsp.type.property', 'Identifier')
  l('@lsp.type.string', 'String')
  l('@lsp.type.struct', 'Identifier')
  l('@lsp.type.type', 'Identifier')
  l('@lsp.type.typeParameter', 'Identifier')
  l('@lsp.type.variable', 'Identifier')

  -- Servers flag builtin types with the `defaultLibrary` modifier.
  l('@lsp.typemod.type.defaultLibrary', '@type.builtin')
  l('@lsp.typemod.class.defaultLibrary', '@type.builtin')

  -- =========================================================================
  -- mini.statusline
  --
  -- Its defaults link the mode sections to Cursor and the Diff* groups, which
  -- here are foreground-only -- half the modes would render with no
  -- background. Set them explicitly against the tan status bar.
  -- =========================================================================
  h('MiniStatuslineModeNormal', 'lfg', 'lbg', 'bold')
  h('MiniStatuslineModeInsert', 'lfg', 'blue', 'bold')
  h('MiniStatuslineModeVisual', 'lfg', 'green', 'bold')
  h('MiniStatuslineModeReplace', 'lfg', 'red', 'bold')
  h('MiniStatuslineModeCommand', 'lfg', 'yellow', 'bold')
  h('MiniStatuslineModeOther', 'lfg', 'cyan', 'bold')
  h('MiniStatuslineDevinfo', 'lfg', 'lbg')
  h('MiniStatuslineFilename', 'lfg', 'lbg')
  h('MiniStatuslineFileinfo', 'lfg', 'lbg')
  h('MiniStatuslineInactive', 'linefg', 'bg')

  -- =========================================================================
  -- Rainbow delimiters
  -- =========================================================================
  h('rainbowcol1', 'violet', nil)
  h('rainbowcol2', 'blue', nil)
  h('rainbowcol3', 'green', nil)
  h('rainbowcol4', 'yellow', nil)
  h('rainbowcol5', 'orange', nil)
  h('rainbowcol6', 'red', nil)

  -- =========================================================================
  -- :terminal ANSI palette
  --
  -- Neovim reads g:terminal_color_0..15; g:terminal_ansi_colors is Vim-only.
  -- =========================================================================
  local ansi = {
    p.bg.gui,     p.red.gui,    p.green.gui, p.yellow.gui,
    p.blue.gui,   p.magenta.gui, p.cyan.gui, p.text.gui,
    p.linefg.gui, p.orange.gui, p.builtin.gui, p.yellow.gui,
    p.blue.gui,   p.violet.gui, p.constant.gui, p.white.gui,
  }
  for i, color in ipairs(ansi) do
    vim.g['terminal_color_' .. (i - 1)] = color
  end
end

return M

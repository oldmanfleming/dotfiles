# Vim Cheatsheet  (leader = <Space>)

Press `q` to close this window.

## Navigation Motions
  h j k l      left / down / up / right
  w / W        next word / WORD (WORD = whitespace-delimited)
  e / E        end of word / WORD
  b / B        back a word / WORD
  0 / ^ / $    start of line / first non-blank / end of line
  gg / G       top / bottom of file
  {N}G         go to line N   (or :N)
  } / {        next / prev paragraph (blank-line delimited)
  ( / )        prev / next sentence
  % match      jump to matching () [] {}
  f{c} / F{c}  jump to next/prev {c} on the line
  t{c} / T{c}  jump up to (before) next/prev {c}
  ; / ,        repeat / reverse last f F t T
  * / #        search word under cursor fwd / back
  n / N        next / prev search match
  { C-d / C-u  half-page down / up }
  { C-f / C-b  full page down / up }
  H / M / L    top / middle / bottom of screen
  zz / zt / zb center / top / bottom the current line on screen

## Editing Operators  (operator + motion = act on that range)
  d{motion}    delete
  c{motion}    change (delete + insert)
  y{motion}    yank (copy)
  p / P        paste after / before
  >{motion}    indent
  <{motion}    dedent
  >> / <<      indent / dedent current line (doubled operator)
  ={motion}    auto-indent 
  gu / gU      lowercase / uppercase
  dd cc yy     act on the whole current line (doubled operator)
  D C Y        act from cursor to end of line
  x / X        delete char under / before cursor
  r{c} / R     replace one char / enter Replace mode
  ~            toggle case of char
  J            join line below onto this one
  u / C-r      undo / redo
  .            repeat the last change

## Text Objects  (use after an operator: di( ci" ya{ ...)
  iw / aw      inner / a word
  is / as      inner / a sentence
  ip / ap      inner / a paragraph
  i" i' i`     inside quotes
  a" a' a`     quotes + the quotes
  i( i[ i{     inside brackets
  a( a[ a{     brackets + the bracket
  it / at      inside / around an HTML/XML tag
  (richer arg & separator objects come from targets.vim)

## Insert-mode Entry
  i / a        insert before / after cursor
  I / A        insert at first non-blank / end of line
  o / O        open new line below / above
  s / S        substitute char / whole line
  Esc / C-[    leave insert mode

## Ex Commands  (type : then the command)
  :w           write (save)
  :w {file}    save as
  :q           quit
  :q!          quit without saving
  :wq  / :x    save and quit
  :wa          write all windows
  :qa          quit all windows
  :wqa         save and quit all
  :e {file}    edit a file
  :e!          reload current file, discard changes
  :{N}         jump to line N
  :$           jump to last line
  :sp / :vsp   horizontal / vertical split (optionally + {file})
  :clo         close current window
  :on          close all other windows
  :bn / :bp    next / previous buffer
  :bd          delete (close) buffer
  :ls          list buffers
  :noh         clear search highlight  (you also have <Esc>)
  :set {opt}   set option
  :set {opt}?  show an option's value
  :reg         list registers
  :marks       list marks
  :%!{cmd}     filter whole file through a shell command
  :r {file}    read file contents below cursor
  :r !{cmd}    read shell command output below cursor
  :so $MYVIMRC reload your vimrc

## Search & Replace  (substitute)
  :s/old/new/         replace first match on the current line
  :s/old/new/g        replace all matches on the current line
  :%s/old/new/g       replace all matches in the whole file
  :%s/old/new/gc      ... with confirm before each (y/n/a/q)
  :%s/old/new/gi      ... case-insensitive
  :'<,'>s/old/new/g   replace within a visual selection
  :g/pat/d            delete every line matching pat
  :v/pat/d            delete every line NOT matching pat
  :g/pat/normal {cmds}  run normal-mode cmds on matching lines

## Search & Navigation (fzf)
  <Space>sf    :Files          fuzzy-find files in the project
  <Space>sg    :Rg             ripgrep across files on disk
  <Space>sw    :Rg <cword>     ripgrep the word under the cursor
  <Space>sh    :Helptags       search Vim help tags
  <Space>sk    :Maps           search your keymaps
  <Space>sc    :Commands       search available commands
  <Space>s.    :History        recently opened files
  <Space>s/    :Lines          search lines across ALL open buffers
  <Space>sn    :Files ~/.vim   browse your config files
  <Space>/     :BLines         fuzzy-find within the current buffer
  <Space><Sp>  :Buffers        switch between open buffers
  <Space>?                     open this cheatsheet

## Windows & Buffers
  <C-h/j/k/l>                  move to window left/down/up/right
  <Esc>                        clear search highlight
  (splits open right & below; :q prompts to save; can leave unsaved buffers)

## LSP  (buffer-local; only where a server is attached)
  grd       definition
  grD       declaration
  grr       references
  gri       implementation
  grt       type definition
  grn       rename
  gra       code action
  gO        document symbols
  gW        workspace symbols
  K         hover docs
  [d        prev diagnostic
  ]d        next diagnostic
  <Space>f  format (normal/visual)
  <Space>q  document diagnostics list

## Editing & Text Objects
  cs"'         change surrounding " to '
  ds"          delete surrounding "
  ys<motion>X  add surrounding X around a motion
  S<X>         (visual) surround selection with X
  gc<motion>   toggle comment over a motion
  gcc          toggle comment on current line
  .            repeat last surround/commentary
  cia / dib    richer arg/pair text objects (targets.vim)

## Autocomplete & Snippets (insert mode)
  <Tab>        accept suggestion -> expand/jump snippet -> literal Tab
  <S-Tab>      previous suggestion -> jump back in snippet
  <C-n>/<C-p>  pick a different item before accepting
  <CR>         newline; dismisses menu WITHOUT accepting
  <C-Space>    force the completion menu to appear

## Format on Save
  *.go, *.rs   auto-formatted on write
  *.go         also runs source.organizeImports

## Handy Options
  clipboard=unnamed        yank/paste syncs with macOS clipboard
  ignorecase smartcase     case-insensitive unless you type a capital
  relativenumber           relative line numbers (5j, 3dd, ...)
  undofile                 undo history persists across sessions
  scrolloff=10             keep 10 lines of context around cursor
  list                     show tabs », trailing ·, nbsp ␣

## Training Wheels
  Arrow keys are disabled in normal & visual mode (use hjkl).
  They still work in insert mode and to drive the completion menu.

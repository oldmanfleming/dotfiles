# Neovim Cheatsheet  (leader = <Space>)

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
  %            jump to matching () [] {}
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
  (mini.ai adds: if/af function call, ia/aa argument, iq/aq any quote,
   ib/ab any bracket, i?/a? prompt for custom delimiters)
  ii / aa      same object, but the NEXT one ahead of the cursor

## File Tree  (neo-tree)
  \            reveal current file in the tree (opens it if closed)
  (below: keys that work INSIDE the tree window)
  <CR>         open file / expand-collapse dir
  <Space>      toggle expand/collapse the node
  l            focus the preview window
  P            toggle a floating preview of the node
  S / s        open in horizontal / vertical split
  t            open in a new tab
  a / A        add a file / add a directory
  r            rename the node          b   rename just the basename
  d            delete the node (confirms)
  c / m        copy / move the node (prompts for a destination)
  y / x / p    copy / cut to clipboard, then paste
  i            show file details
  C / z        close this node / close all nodes
  R            refresh the tree
  H            toggle showing hidden files (dotfiles)
  /            fuzzy filter the tree     f   filter on submit
  <BS>         move tree root up one directory
  .            make selected dir the new tree root
  [g / ]g      prev / next git-modified file
  o{c}         order by: oc created, od diagnostics, og git, om modified,
               on name, os size, ot type
  < / >        previous / next source (filesystem, buffers, git_status)
  q or \       close the tree
  ?            show neo-tree's own help
  (the tree also auto-closes as soon as you open a file)

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
  (inccommand=split previews every substitution live as you type)

## Search & Navigation (Telescope)
  <Space>sf    find_files              fuzzy-find files in the project
  <Space>sg    live_grep               ripgrep across files on disk
  <Space>sw    grep_string             ripgrep the word under the cursor
  <Space>sh    help_tags               search Neovim help tags
  <Space>sk    keymaps                 search your keymaps
  <Space>sc    commands                search available commands
  <Space>sd    diagnostics             all diagnostics in the workspace
  <Space>ss    builtin                 list every Telescope picker
  <Space>sr    resume                  reopen the last picker where you left it
  <Space>s.    oldfiles                recently opened files
  <Space>s/    live_grep (open bufs)   search lines across ALL open buffers
  <Space>sn    find_files ~/.config/nvim   browse your config files
  <Space>/     current_buffer_fuzzy_find   fuzzy-find within the current buffer
  <Space><Sp>  buffers                 switch between open buffers
  <Space>?                             open this cheatsheet
  (inside a picker: <C-/> in insert or ? in normal shows its keymaps)

## Windows & Buffers
  <C-h/j/k/l>                  move to window left/down/up/right
  <Esc>                        clear search highlight
  (splits open right & below; :q prompts to save; can leave unsaved buffers)

## LSP  (buffer-local; only where a server is attached)
  grd       definition            (Telescope picker)
  grD       declaration
  grr       references            (Telescope picker)
  gri       implementation        (Telescope picker)
  grt       type definition       (Telescope picker)
  grn       rename
  gra       code action           (normal + visual)
  gO        document symbols      (Telescope picker)
  gW        workspace symbols     (Telescope picker)
  K         hover docs
  [d        prev diagnostic       (opens a float with the message)
  ]d        next diagnostic       (opens a float with the message)
  <Space>f  format (normal/visual, via conform)
  <Space>q  diagnostics -> location list
  <Space>th toggle inlay hints    (where the server supports them)
  <C-t>     jump back after a goto
  (resting on a symbol highlights its other references in the buffer)

## Editing & Text Objects
  sa<motion>X  add surrounding X around a motion   (mini.surround)
  sd"          delete surrounding "
  sr"'         replace surrounding " with '
  sf" / sF"    find next / prev surrounding "
  sh"          highlight the surrounding "
  gc<motion>   toggle comment over a motion        (built-in)
  gcc          toggle comment on current line
  .            repeat last surround/comment
  NOTE: vim-surround's ys/cs/ds are sa/sr/sd here.

## Autocomplete & Snippets (insert mode)  -- blink.cmp
  <Tab>        accept the highlighted suggestion; otherwise a literal Tab
  <S-Tab>      jump back to the previous snippet placeholder
  <C-n>/<C-p>  pick a different item before accepting
  <Up>/<Down>  same (arrows still work in insert mode)
  <CR>         newline; dismisses menu WITHOUT accepting
  <C-Space>    open the menu, or show docs if it is already open
  <C-e>        hide the menu
  <C-k>        toggle the signature-help window
  (the top suggestion is preselected but not inserted until you accept)

## Format on Save  (conform.nvim)
  *.go         goimports then gofmt   (goimports also organizes imports)
  *.rs         rustfmt
  <Space>f     format any buffer on demand; falls back to the LSP formatter

## Plugin & Tool Management
  :Mason                        install / inspect language servers & tools
  :checkhealth                  diagnose a broken setup
  :lua vim.pack.update()        update plugins
  :lua vim.pack.update(nil, { offline = true })   inspect state, no fetch
  :TodoTelescope                find TODO/FIXME/NOTE comments
  (which-key pops up automatically when you pause after <Space>)

## Handy Options
  clipboard=unnamedplus    yank/paste syncs with macOS clipboard
  ignorecase smartcase     case-insensitive unless you type a capital
  relativenumber           relative line numbers (5j, 3dd, ...)
  undofile                 undo history persists across sessions
  scrolloff=10             keep 10 lines of context around cursor
  list                     show tabs », trailing ·, nbsp ␣
  inccommand=split         live preview of :s substitutions
  confirm                  :q on a dirty buffer prompts instead of failing

## Training Wheels
  Arrow keys are disabled in normal & visual mode (use hjkl).
  They still work in insert mode and to drive the completion menu.

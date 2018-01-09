---
layout: splash
permalink: /notes/vim_notes/
title: "Vim Notes"
excerpt: "Yes, this vim, legendary VIM Notes... Seee you soon, more or lesss"
toc: true
author_profile: false
---

# VIM CONFIG

## My plugins

### For conda envs:

cjrh/vim-conda

#### example of usage

```vim

#in vim
:CondaChangeEnv<ENTER>

#in ~/.config/nvim/init.vim
map <F4> :CondaChangeEnv<CR>
```

---

# FOR FUTURE ...

# VIM DISTROS

yavide (for c++ dev)
spf13-vim (allin?)


# Spf13-vim

```bash
curl http://j.mp/spf13-vim3 -L -o - | /bin/bash
```

during install, near the end had to give login/pass for github.

to run:

```bash
vim
```

# Yavide

to run it on ubuntu subsystem from windows, had to use xming server
then on ubuntu bash:
```bash
sudo apt-get update
sudo apt-get install build-essential vim-gnome python2.7 git libclang-dev
cd ~/ && git clone https://github.com/JBakamovic/yavide.git
cd yavide && ./install.sh 

export DISPLAY=:0

#vim is now installed with py3, have to use py2 build
sudo apt install vim-gtk3-py2 #to run it: vim.gtk3-py2
sudo update-alternatives --set vim /usr/bin/vim.gtk3-py2
sudo update-alternatives --set gvim /usr/bin/vim.gtk3-py2

#now check yavide
yavide
```

If not using gui, keystrokes like ctrl+s wont work for me, so to use commands manually, one has to lookup them:

```bash
cat /opt/yavide/config/after/plugin/keyboard.vim 
```

Here is yavide keymap, note that <CR> is "Enter" or <-' key:

```vim
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Project management
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap        <C-s>n              :YavideProjectNew<CR>|"                                         New project
nmap        <C-s>o              :YavideProjectOpen<CR>|"                                        Open project
nmap        <C-s>i              :YavideProjectImport<CR>|"                                      Import project
nmap        <C-s>c              :YavideProjectClose<CR>|"                                       Close project
nmap        <C-s>s              :YavideProjectSave<CR>|"                                        Save project
nmap        <C-s>d              :YavideProjectDelete<CR>|"                                      Delete project

" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Search tools
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap     <C-f>               :YavidePromptFind<CR>|"                                         Open find dialog
vnoremap    <C-f>               :YavidePromptFind<CR>
onoremap    <C-f>               <C-C>:YavidePromptFind<CR>
inoremap    <C-f>               <C-O>:YavidePromptFind<CR>
cnoremap    <C-f>               <C-C>:YavidePromptFind<CR>
noremap     <C-f>               :YavidePromptFindAndReplace<CR>|"                               Open find and replace dialog
vnoremap    <C-f>               :YavidePromptFindAndReplace<CR>
onoremap    <C-f>               <C-C>:YavidePromptFindAndReplace<CR>
inoremap    <C-f>               <C-O>:YavidePromptFindAndReplace<CR>
cnoremap    <C-f>               <C-C>:YavidePromptFindAndReplace<CR>

" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Buffer management
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap        <C-s>               <ESC>:YavideBufferSave<CR>|"                                    Save current buffer (normal mode)
imap        <C-s>               <ESC>:YavideBufferSave<CR>i|"                                   Save current buffer (insert mode)
nnoremap    <C-c>               :YavideBufferClose<CR>|"                                        Close current buffer
nnoremap    <C-M-c>             :YavideBufferCloseAllButCurrentOne<CR>|"                        Close all buffers but the current one
nnoremap    <C-c>a              :YavideBufferCloseAll<CR>|"                                     Close all buffers
map         <C-s-Tab>           :YavideBufferPrev<CR>|"                                         Go to previous buffer
map         <C-Tab>             :YavideBufferNext<CR>|"                                         Go to next buffer
nnoremap    <C-Down>            :YavideBufferScrollDown<CR>|"                                   Scroll buffer by one line (down)
nnoremap    <C-Up>              :YavideBufferScrollUp<CR>|"                                     Scroll buffer by one line (up)

" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Buffer editing
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap    <C-a>               ggVG|"                                                          Select all
vnoremap    <C-x>               "+x|"                                                           Cut
vnoremap    <C-c>               "+y|"                                                           Copy
map         <C-v>               "+gP|"                                                          Paste (with some black magic from https://github.com/vim/vim/blob/master/runtime/mswin.vim)
cmap        <C-v>               <C-R>+
exe         'inoremap <script>  <C-v> <C-G>u' . paste#paste_cmd['i']
exe         'vnoremap <script>  <C-v> '       . paste#paste_cmd['v']
nnoremap    <C-z>               u|"                                                             Undo
inoremap    <C-z>               <C-O>u
noremap     <C-R>               <C-R>|"                                                         Redo
inoremap    <C-R>               <C-O><C-R>
nnoremap    <CR>                :let @/ = ""<CR><CR>|"                                          Clear highlighted text occurences
nnoremap    <Tab>               >>|"                                                            Configure indent mechanism to act as in other editors
nnoremap    <S-Tab>             <<
inoremap    <S-Tab>             <C-D>
vnoremap    <Tab>               >gv
vnoremap    <S-Tab>             <gv

" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Source code navigation
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap        <F3>                :YavideSrcNavOpenFile<CR>|"                                     Open file under the cursor
imap        <F3>                <ESC>:YavideSrcNavOpenFile<CR>i|"
nmap        <F4>                :YavideSrcNavSwitchBetweenHeaderImpl<CR>|"                      Switch between header/source
imap        <F4>                <ESC>YavideSrcNavSwitchBetweenHeaderImpl<CR>i|"
nmap        <S-F4>              :YavideSrcNavSwitchBetweenHeaderImplVSplit<CR>|"                Switch between header/source in a vertical split
imap        <S-F4>              <ESC>:YavideSrcNavSwitchBetweenHeaderImplVSplit<CR>i|"
nmap        <F12>               :YavideSrcNavGoToDefinition<CR>|"                               Goto definition
imap        <F12>               :YavideSrcNavGoToDefinition<CR>|"
nmap        <C-LeftMouse>       :YavideSrcNavGoToDefinition<CR>|"
imap        <C-LeftMouse>       :YavideSrcNavGoToDefinition<CR>|"
nmap        <S-F12>             :vsp <CR>:YavideSrcNavGoToDefinition<CR>|"                      Goto definition in a vertical split
imap        <S-F12>             :vsp <CR>:YavideSrcNavGoToDefinition<CR>|"
nmap        <C-\>s              :YavideSrcNavFindAllReferences<CR>|"                            Find all references to the token under the cursor
nmap        <C-\>r              :YavideSrcNavRebuildIndex<CR>|"                                 Rebuild symbol database index for current project
nnoremap    <M-Left>            <C-O>"                                                          Jump back to previous cursor location
nnoremap    <M-Right>           <C-I>"                                                          Jump to next cursor location

" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Build process
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap        <F7>                :YavideBuildRun<CR>|"                                           Build project
imap        <F7>                <ESC>:w<CR>:YavideBuildRun<CR>|"

" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Static analysis
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap        <F5>                :YavideAnalyzerClangTidyBuf<CR>|"                               Run clang-tidy over current buffer (do not apply fixes)
imap        <F5>                <ESC>:YavideAnalyzerClangTidyBuf<CR>i|"
nmap        <S-F5>              :YavideAnalyzerClangTidyApplyFixesBuf<CR>|"                     Run clang-tidy over current buffer (apply fixes)
imap        <S-F5>              <ESC>:YavideAnalyzerClangTidyApplyFixesBuf<CR>i|"
```

---

# COMPILATION

## C++

:!gcc -o somename % && ./somename

# VIM KEYMAP

# Cut/Copy/Paste/Modify

## Cut/Delete
+ `dd` Delete current line
+ `#dd` Delete # lines
+ `dw` Delete current word
+ `d$` Delete to end of line
+ `D` Delete to end of line
+ `:#,&d` Delete from line # to &
+ `"[a-zA-Z0-9]dd` Delete line into register [a-zA-Z0-9]
+ `"+dd` Delete line into host clipboard

## Copy/Yank
+ `yy` Yank current line
+ `Y` Yank current line
+ `#yy` Yank # lines
+ `yw` Yank current word
+ `y$` Yank to end of line
+ `y^` Yank to beginning of line
+ `:#,&y` Yank from line # to &
+ `"[a-zA-Z0-9]yy` Yank line into register [a-zA-Z0-9]
+ `"+yy` Yank line into host clipboard

## Paste/Put
+ `p` Put current register at cursor
+ `P` Put current register before cursor
+ `"[a-zA-Z0-9]p` Put register [a-zA-Z0-9] at cursor
+ `"+p` Put text from clipboard at cursor
+ `]p` Put current register WRT indent

## Modify
+ `gUw` Switch case of word to CAPS
+ `guw` Switch case of word to lower
+ `~` Switch case of character under cursor
+ `g~w` Invert case on word
+ `r#` Replace character under cursor with #
+ `ce` Replace from cursor to end of word
+ `c$` Replace from cursor to end of line
+ `C` Replace from cursor to end of line
+ `c#w` Replace # words
+ `ci"` Replace between double quote pair
+ `ci'` Replace between single quote pair
+ `ci)` Replace between () pair
+ `ci]` Replace between [] pair
+ `ci}` Replace between {} pair
+ `ci>` Replace between <> pair
+ `cit` Replace beetween XML/HTML tag pair
+ `<ctrl> A` Increment number under cursor
+ `<ctrl> X` Decrement number under cursor
+ `x` Delete character under cursor
+ `X` Delete character before cursor
+ `>>` Indent entire line
+ `<<` Unindent entire line
+ `==` Autoindent entire line
+ `:reg` View contents of registers

# Code folding
+ `zo` Open fold
+ `zc` Close fold
+ `zr` Reduce fold level
+ `zm` Increase fold level
+ `zR` Reduce all folds
+ `zM` Increase all folds
+ `zj` Move to next fold downwards
+ `zk` Move to next fold upward
+ `zd` Delete fold
+ `zE` Delete all folds
+ `zf#j` Create fold of # lines below cursor
+ `:#,& fold` Create fold beetween line # and &
+ `zfap` Create fold of paragpraph
+ `zfa}` Create fold in {} brackets
+ `zfa)` Create fold in () brackets
+ `zfa]` Create fold in [] brackets
+ `zfa>` Create fold in <> brackets

# Search and Replace
+ `/#` Find # searching forward
+ `?#` Find # searching backward
+ `n` Continue search downwards
+ `N` Continue search upwards
+ `%` Move to matching bracket from under cursor
+ `:s/old/new/g` Substitude old for new on line with no prompt
+ `:#,&s/old/new/g` Substitude old for new on lines # to & with no prompt
+ `:%s/old/new/g` Globally substitude old for new with no prompt
+ `:%s/old/new/gc` Globally substitude old for new with prompt

# External Calls
+ `:! <command>` Execute an external command in the shell
+ `:r <file>` Insert the contents of file at cursor position
+ `:r !<command>` Insert ouptut of command at cursor position

# Tabs
+ `:tabnew` Open a new tab
+ `:tabe <file>` Open file in a new tab
+ `<ctrl> PgUp` Switch to tab on Right
+ `<ctrl> PgDn` Switch to tab on Left
+ `:tabdo <command>` Run command in all tabs

#Panes
+ `:vnew` Split window/pane vertically
+ `:new` Split window/pane horizontally
+ `<ctrl> W + H` Switch to pane to the left
+ `<ctrl> W + L` Switch to pane to the right
+ `<ctrl> W + J` Switch to pane to the below
+ `<ctrl> W + K` Switch to pane to the above
+ `<ctrl> W + _` Give all vertical space to current pane
+ `<ctrl> W + |` Give all horizontal space to current pane
+ `<ctrl> W + =` Evenly distribute space for all panes
+ `<ctrl> W + +` Increase current pane height
+ `<ctrl> W + -` Descrease current pane height
+ `<ctrl> W + >` Increase current pane width
+ `<ctrl> W + <` Descrease current pane width

# File
+ `:e <file>` Open file
+ `:enew` New file
+ `:w` Save current file
+ `:w <file>` Save current file as filename
+ `:wq` Save and quit
+ `:x` Save and quit
+ `:q` Quit
+ `:q!` Force quit
+ `:bd` Delete/close buffer
+ `:hardcopy` Print file

# Location
+ `<crtl> G` Show current position in file
+ `:f` Show line numbers
+ `m[a-zA-Z]` Place mark [a-zA-Z] at cursor
+ `` `[a-zA-Z]`` Goto mark [a-zA-Z]
+ `:marks` Show all marks

# Text Insertion
+ `i` Insert text before cursor
+ `I` Insert text at beginning of line
+ `R` Start overtype mode
+ `a` Insert text after cursor
+ `A` Insert text af end of line
+ `o` Open new line following current line
+ `O` Open new line before current line
+ `v` Switch to visual selection mode
+ `V` Switch to visual line selection mode
+ `<crtl> v` Switch to visual block selection mode

# Movement
+ `h` Move cursor left
+ `l` Move cursor right
+ `j` Move cursor down
+ `k` Move cursor up
+ `gj` Move cursor down one display line
+ `gk` Move cursor up one display line
+ `H` Move cursor to top of display
+ `M` Move cursor to middle of display
+ `L` Move cursor to bottom of display
+ `w` Move cursor forward to start of next word
+ `e` Move cursor to end of next word
+ `b` Move cursor backward one word
+ `)` Move cursor forward one sentence
+ `(` Move cursor backward one sentence
+ `0` Move cursor to start of line
+ `^` Move cursor to first character of line
+ `$` Move cursor to end of line
+ `<ctrl> F` Move cursor forward one screenful
+ `<ctrl> B` Move cursor backward one screenful
+ `<ctrl> U` Move cursor up half a screenful
+ `<ctrl> D` Move cursor down half a screenful
+ `gg` Move cursor to top of file
+ `G` Move cursor to bottom of file
+ `#G` Move cursor to line #
+ `#gg` Move cursor to line #
+ `f#` Move cursor forward to next character # on line
+ `F#` Move cursor backwards character # on line
+ `t#` Move cursor forward to character before the next character # on line
+ `T#` Move cursor backward to character after the next character # on line

# Macros
+ `q[a-zA-Z0-9]` Start recording macro into register [a-zA-Z0-9]
+ `q` End recording of current macro
+ `@[a-zA-Z0-9]` Playback macro from register [a-zA-Z0-9]
+ `n@[a-zA-Z0-9]` Playback macro from register [a-zA-Z0-9] n times

#Misc
+ `u` Undo
+ `U` Restore line
+ `<ctrl> r` Redo
+ `J` Join line below to current line
+ `.` Repeat last command
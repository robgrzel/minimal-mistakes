""""""""""""""""""""""""""""""""""""""""""""""""""""""
"dein Scripts-----------------------------
""""""""""""""""""""""""""""""""""""""""""""""""""""""

if &compatible
set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/dein')
  call dein#begin('~/dein')

  " Let dein manage dein
  " Required:
  call dein#add('~/dein/repos/github.com/Shougo/dein.vim')


  call dein#add('Shougo/vimproc.vim',{'build' : 'make'}) " Interactive command execution in Vim.
  call dein#add('Shougo/vimshell.vim')
  call dein#add('Shougo/deol.nvim') " Dark powered shell interface for NeoVim and Vim8.
  call dein#add('Shougo/unite.vim')
  call dein#add('Shougo/denite.nvim') " Replace, unite. Dark powered asynchronous unite all interfaces for Neovim/Vim8


  "Snippets
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')

  call dein#add('SirVer/ultisnips')
  call dein#add('honza/vim-snippets')
  call dein#add('roxma/nvim-completion-manager')

  call dein#add('Valloric/YouCompleteMe', {'build': './install.py --cs-completer --go-completer'})
  call dein#add('Shougo/javacomplete')
  call dein#add('artur-shaik/vim-javacomplete2')

  call dein#add('Shougo/deoplete.nvim') "Dark powered asynchronous completion framework for neovim/Vim8
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif
  call dein#add('zchee/deoplete-go')
  call dein#add('tweekmonster/deoplete-clang2')
  call dein#add('callmekohei/deoplete-fsharp')" F# support for Vim / Neovim using deopletefs
  call dein#add('Rip-Rip/clang_complete', {'build' : 'make install'})



  "Syntax
  call dein#add('osyo-manga/shabadou.vim') "Async syntax check plugin.
  call dein#add('osyo-manga/vim-watchdogs') "...
  call dein#add('jceb/vim-hier') "...
  call dein#add('dannyob/quickfixstatus') "...
  call dein#add('thinca/vim-quickrun', {'on_cmd': 'QuickRun'})
  call dein#add('thinca/vim-localrc') "...


  "Multi lang
  call deing#add('WolfgangMehner/vim-plugins') "Vim plug-ins which offer support for various programming languages.

  "Lua
  call dein#add('tbastos/vim-lua')"Improved Lua 5.3 syntax and indentation support for Vim


  "Linting
  call dein#add('dbakker/vim-lint')"...
  call dein#add('syngan/vim-vimlint')"lint for vim script...
  call dein#add('ynkdir/vim-vimlparser')"...

  "Debug
  call dein#add('huawenyu/neogdb.vim')
  call dein#add('yuratomo/dbg.vim', {'on_cmd': ['Dbg', 'DdgShell']})
  call dein#add('vim-scripts/Conque-GDB', {'on_cmd': ['ConqueTerm', 'ConqueTermSplit', 'ConqueTermVSplit', 'ConqueTermTab', 'ConqueGdb', 'ConqueGdbSplit', 'ConqueGdbVSplit', 'ConqueGdbTab', 'ConqueGdbExe', 'ConqueGdbBDelete', 'ConqueGdbCommand']})

  "Dafny
  call dein#add('mlr-msft/vim-loves-dafny') "a vim plugin for Dafny, a verified programming language. https://dafny.codeplex.com/

  "Python
  call dein#add('klen/python-mode')
  call dein#add('plytophogy/vim-virtualenv')
  call dein#add('Vimjas/vim-python-pep8-indent')
  call dein#add('lambdalisue/vim-cython-syntax')
  call dein#add('davidhalter/jedi-vim', {'lazy': 1, 'on_ft': ['python', 'cython', 'pyrex']})
  call dein#add('hynek/vim-python-pep8-indent')
  call dein#add('nvie/vim-flake8')
  call dein#add('tweekmonster/impsort.vim', {'on_ft': ['python','cython', 'pyrex']})

  "CMake"
  call dein#add('pboettch/vim-cmake-syntax')

  "C++
  call dein#add('vim-scripts/a.vim') "Alternate Files quickly (.c --> .h etc)
  call dein#add('dbgx/lldb.nvim') "Debugger integration with a focus on ease-of-use.
  call dein#add('vim-jp/vim-cpp')
  call dein#add('octol/vim-cpp-enhanced-highlight')
  call dein#add('lyuts/vim-rtags', {'on_ft': ['c', 'cpp', 'objc']})
  call dein#add('CoatiSoftware/vim-coati', {'on_ft': ['c', 'cpp', 'objc']})
  call dein#add('WolfgangMehner/c-support')

  "Bash
  call dein#add('WolfgangMehner/bash-support')

  "Matlab
  call dein#add('WolfgangMehner/matlab-support')

  "" LLVM:
  call dein#add('rhysd/vim-llvm')

  "" Binary:
  call dein#add('Shougo/vinarise.vim', {'on_cmd': 'Vinarise', 'hook_add': 'let g:vinarise_enable_auto_detect = 1'})

    "" Markdown:
  call dein#add('moorereason/vim-markdownfmt', {'on_ft': 'markdown'})
  call dein#add('rhysd/vim-gfm-syntax', {'on_ft': 'markdown'})

    "" Shell:
  call dein#add('chrisbra/vim-sh-indent')

  "Make
  call dein#add('neomake/neomake')"Asynchronous linting and make framework for Neovim/Vim

  "CODING
  call dein#add('Townk/vim-autoclose') "This plugin for Vim enable an auto-close chars feature for you. For instance if you type
                                       "...an '(', ``autoclose`` will automatically insert a ')' and put the cursor between than.

  "CSV
  call dein#add('chrisbra/csv.vim')

  "GIT
  call dein#add('tpope/vim-fugitive')
  call dein#add('junegunn/vim-github-dashboard.git')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('tyru/open-browser-github.vim', {'on_cmd': ['OpenGithubFile', 'OpenGithubIssue', 'OpenGithubPullReq']})

  "GUI
    call dein#add('Shougo/echodoc.vim')  " Print documents in echo area.
  call dein#add('Shougo/vimfiler.vim') " Powerful file explorer implemented by Vim script
  call dein#add('Shougo/neoyank.vim') "	Saves yank history includes unite.vim history/yank source.
    call dein#add('scrooloose/nerdtree',{ 'on':  'NERDTreeToggle' })
  call dein#add('scrooloose/syntastic') " Check your .vimrc for errors...
  call dein#add('tyru/open-browser.vim')


   "Commands
    call dein#add('haya14busa/dein-command.vim', {'on_cmd': 'Dein'})
    call dein#add('joonty/vim-do') "Run shell commands asynchronously and show the output in Vim when they finish

   "Comments
   call dein#add('scrooloose/nerdcommenter')
  call dein#add('tpope/vim-commentary') "commentary.vim: comment stuff out

  "Bars
  call dein#add('cocopon/vaffle.vim')
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')
    call dein#add('majutsushi/tagbar') " Vim plugin that displays tags in a window, ordered by scope
  call dein#add('ryanoasis/vim-devicons', {'hook_add': "let g:airline_powerline_fonts = 1"})

  "Cursos, etc..
  call dein#add('junegunn/vim-easy-align')
  call dein#add('terryma/vim-multiple-cursors')
  call dein#add('kana/vim-fakeclip') " Vim plugin: Provide pseudo "clipboard" registers
  call dein#add('tpope/vim-sleuth') "This plugin automatically adjusts 'shiftwidth' and 'expandtab' heuristically based on the current file...
  call dein#add('svermeulen/vim-easyclip')
  call dein#add('tpope/vim-repeat')

  "Images
  call dein#add('ashisha/image.vim')

  "Search, replace
  call dein#add('brooth/far.vim') "Find And Replace Vim plugin
  call dein#add('brooth/far.vim') "performing asynchronous search and replace operations on a set of files
  call dein#add('kien/ctrlp.vim') "Fuzzy file, buffer, mru, tag, etc finder
  call dein#add('vim-scripts/ctrlsf.vim') "An ack.vim alternative mimics Ctrl-Shift-F on Sublime Text 2 , :CtrlSF [pattern]

  "Vim help
  call dein#add('tweekmonster/helpful.vim') " Display vim version numbers in docs
  call dein#add('editorconfig/editorconfig-vim') "EditorConfig plugin for Vim http://editorconfig.org
  call dein#add('WolfgangMehner/vim-support')

  "Remote
  call dein#add('zenbro/mirror.vim') "Efficient way to edit remote files on multiple environments with Vim.
  call dein#add('Shougo/neossh.vim') "SSH interface for Vim plugins
  call dein#add('ujihisa/unite-ssh')
   call dein#add('ujihisa/vimshell-ssh')
  call dein#add('eiginn/netrw') "Mirror of Dr. Chip's netrw vim plugin for vundle


  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
call dein#install()
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""
"End dein Scripts-------------------------
""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""PLUGINS CONFIG"""""""""""""""""""""


"""""""""""""""""" Neomake
" When writing a buffer, and on normal mode changes (after 750ms).
call neomake#configure#automake('nw', 750)

"joonty/vim-do
let g:do_auto_show_process_window = 0
call do#ReloadOptions()

""Shougo config

" neosnippet
let g:neosnippet#enable_snipmate_compatibility = 1

"deoplete
let g:deoplete#enable_at_startup = 1

" vimfiler config
let g:vimfiler_as_default_explorer = 1 " run with :VimFiler

" echodoc.vim
set cmdheight=2 "  Otherwise, the -- INSERT -- mode text will overwrite echodoc's text.
let g:echodoc#enable_at_startup = 1

" Shougo/unite.vim

"" thinca/vim-quickrun
let g:quickrun_config = {}
let g:quickrun_config.haskell = {'command' : 'runhugs'}
" NOTES:
" Execute current buffer. :QuickRun
" Execute current buffer from line 3 to line 6.:3,6QuickRun
" Execute current buffer as perl program.	:QuickRun perl
" Execute one-liner program given from command-line.	:QuickRun ruby -src 'puts "Hello, world!"'

"" c-support

let g:C_UseTool_cmake    = 'yes'
let g:C_UseTool_doxygen  = 'yes'

" ####################################### user configs

""""""" General coding stuff """""""

filetype plugin indent on
syntax on
set relativenumber
set incsearch
set ignorecase
set smartcase
set nohlsearch

set backup
set backupdir=~/backup/vim/tmp/

""""""" Python stuff """""""
syntax enable
set number
set showmatch
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set autoindent
let python_highlight_all = 1
let g:python_host_prog  = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'

" Highlight 80th column
set colorcolumn=80
" Always show status bar
set laststatus=2
" Let plugins show effects after 500ms, not 4s
set updatetime=500


let g:gitgutter_max_signs = 10000  " default value

let g:clang_library_path='/usr/lib/llvm-3.8/lib'
let b:clang_user_options = '-std=c++11'
let g:clang_complete_auto = 1
let g:clang_complete_copen = 1

"colorscheme codedark

let g:airline#extensions#tabline#enabled = 1
let g:minimap_highlight='Visual'


"Syntax checking hacks for vim
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


" Terminel settings
let g:terminal_scrollback_buffer_size = 100000
let s:num = 0
"        black      red        green      yellow     blue       magenta    cyan       white
for s:color in [
    \ '#101112', '#b24e4e', '#9da45a', '#f0c674', '#5f819d', '#85678f', '#5e8d87', '#707880',
    \ '#373b41', '#cc6666', '#a0a85c', '#f0c674', '#81a2be', '#b294bb', '#8abeb7', '#c5c8c6',
    \ ]
let g:terminal_color_{s:num} = s:color
let s:num += 1
endfor




"At runtime
"autocmd VimEnter * NERDTree
autocmd VimEnter * TagbarToggle
autocmd VimEnter * VirtualEnvList
autocmd VimEnter * VimFilerExplorer

"NOTES:
":wincmd r to swap the two buffers but keep the window layout the same.
":wincmd w to move the cursor between the two windows/buffers.
":wincmd J to go from vertical to horizontal layout.
":wincmd H to go from horizontal to vertical layout.
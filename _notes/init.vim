""""""""""""""""""""""""""""""""""""""""""""""""""""""
"dein Scripts-----------------------------
""""""""""""""""""""""""""""""""""""""""""""""""""""""

if empty(glob('~/dein/repos/github.com/Shougo/dein.vim'
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

if &compatible
set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/dein'
  call dein#begin('~/dein'

  " Let dein manage dein
  " Required:
  Plug '~/dein/repos/github.com/Shougo/dein.vim'


  Plug 'Shougo/vimproc.vim',{'build' : 'make'} " Interactive command execution in Vim.
  Plug 'Shougo/vimshell.vim'
  Plug 'Shougo/deol.nvim' " Dark powered shell interface for NeoVim and Vim8.
  Plug 'Shougo/unite.vim'
  Plug 'Shougo/denite.nvim' " Replace, unite. Dark powered asynchronous unite all interfaces for Neovim/Vim8


  "Snippets
  Plug 'Shougo/neosnippet.vim'
  Plug 'Shougo/neosnippet-snippets'

  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
  Plug 'roxma/nvim-completion-manager'

  Plug 'Valloric/YouCompleteMe', {'build': './install.py --cs-completer --go-completer'}
  Plug 'Shougo/javacomplete'
  Plug 'artur-shaik/vim-javacomplete2'

  Plug 'Shougo/deoplete.nvim' "Dark powered asynchronous completion framework for neovim/Vim8
  if !has('nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
  endif
  Plug 'zchee/deoplete-go'
  Plug 'tweekmonster/deoplete-clang2'
  Plug 'callmekohei/deoplete-fsharp'" F# support for Vim / Neovim using deopletefs
  Plug 'Rip-Rip/clang_complete', {'build' : 'make install'}



  "Syntax
  Plug 'osyo-manga/shabadou.vim' "Async syntax check plugin.
  Plug 'osyo-manga/vim-watchdogs' "...
  Plug 'jceb/vim-hier' "...
  Plug 'dannyob/quickfixstatus' "...
  Plug 'thinca/vim-quickrun', {'on_cmd': 'QuickRun'}
  Plug 'thinca/vim-localrc' "...


  "Multi lang
  call deing#add('WolfgangMehner/vim-plugins' "Vim plug-ins which offer support for various programming languages.

  "Lua
  Plug 'tbastos/vim-lua'"Improved Lua 5.3 syntax and indentation support for Vim


  "Linting
  Plug 'dbakker/vim-lint'"...
  Plug 'syngan/vim-vimlint'"lint for vim script...
  Plug 'ynkdir/vim-vimlparser'"...

  "Debug
  Plug 'huawenyu/neogdb.vim'
  Plug 'yuratomo/dbg.vim', {'on_cmd': ['Dbg', 'DdgShell']}
  Plug 'vim-scripts/Conque-GDB', {'on_cmd': ['ConqueTerm', 'ConqueTermSplit', 'ConqueTermVSplit', 'ConqueTermTab', 'ConqueGdb', 'ConqueGdbSplit', 'ConqueGdbVSplit', 'ConqueGdbTab', 'ConqueGdbExe', 'ConqueGdbBDelete', 'ConqueGdbCommand']}

  "Dafny
  Plug 'mlr-msft/vim-loves-dafny' "a vim plugin for Dafny, a verified programming language. https://dafny.codeplex.com/

  "Python
  Plug 'klen/python-mode'
  Plug 'plytophogy/vim-virtualenv'
  Plug 'Vimjas/vim-python-pep8-indent'
  Plug 'lambdalisue/vim-cython-syntax'
  Plug 'davidhalter/jedi-vim', {'lazy': 1, 'on_ft': ['python', 'cython', 'pyrex']}
  Plug 'hynek/vim-python-pep8-indent'
  Plug 'nvie/vim-flake8'
  Plug 'tweekmonster/impsort.vim', {'on_ft': ['python','cython', 'pyrex']}

  "CMake"
  Plug 'pboettch/vim-cmake-syntax'

  "C++
  Plug 'vim-scripts/a.vim' "Alternate Files quickly (.c --> .h etc
  Plug 'dbgx/lldb.nvim' "Debugger integration with a focus on ease-of-use.
  Plug 'vim-jp/vim-cpp'
  Plug 'octol/vim-cpp-enhanced-highlight'
  Plug 'lyuts/vim-rtags', {'on_ft': ['c', 'cpp', 'objc']}
  Plug 'CoatiSoftware/vim-coati', {'on_ft': ['c', 'cpp', 'objc']}
  Plug 'WolfgangMehner/c-support'

  "Bash
  Plug 'WolfgangMehner/bash-support'

  "Matlab
  Plug 'WolfgangMehner/matlab-support'

  "" LLVM:
  Plug 'rhysd/vim-llvm'

  "" Binary:
  Plug 'Shougo/vinarise.vim', {'on_cmd': 'Vinarise', 'hook_add': 'let g:vinarise_enable_auto_detect = 1'}

    "" Markdown:
  Plug 'moorereason/vim-markdownfmt', {'on_ft': 'markdown'}
  Plug 'rhysd/vim-gfm-syntax', {'on_ft': 'markdown'}

    "" Shell:
  Plug 'chrisbra/vim-sh-indent'

  "Make
  Plug 'neomake/neomake'"Asynchronous linting and make framework for Neovim/Vim

  "CODING
  Plug 'Townk/vim-autoclose' "This plugin for Vim enable an auto-close chars feature for you. For instance if you type
                                       "...an '(', ``autoclose`` will automatically insert a '' and put the cursor between than.

  "CSV
  Plug 'chrisbra/csv.vim'

  "GIT
  Plug 'tpope/vim-fugitive'
  Plug 'junegunn/vim-github-dashboard.git'
  Plug 'airblade/vim-gitgutter'
  Plug 'tyru/open-browser-github.vim', {'on_cmd': ['OpenGithubFile', 'OpenGithubIssue', 'OpenGithubPullReq']}

  "GUI
    Plug 'Shougo/echodoc.vim'  " Print documents in echo area.
  Plug 'Shougo/vimfiler.vim' " Powerful file explorer implemented by Vim script
  Plug 'Shougo/neoyank.vim' "	Saves yank history includes unite.vim history/yank source.
    Plug 'scrooloose/nerdtree',{ 'on':  'NERDTreeToggle' }
  Plug 'scrooloose/syntastic' " Check your .vimrc for errors...
  Plug 'tyru/open-browser.vim'


   "Commands
    Plug 'haya14busa/dein-command.vim', {'on_cmd': 'Dein'}
    Plug 'joonty/vim-do' "Run shell commands asynchronously and show the output in Vim when they finish

   "Comments
   Plug 'scrooloose/nerdcommenter'
  Plug 'tpope/vim-commentary' "commentary.vim: comment stuff out

  "Bars
  Plug 'cocopon/vaffle.vim'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
    Plug 'majutsushi/tagbar' " Vim plugin that displays tags in a window, ordered by scope
  Plug 'ryanoasis/vim-devicons', {'hook_add': "let g:airline_powerline_fonts = 1"}

  "Cursos, etc..
  Plug 'junegunn/vim-easy-align'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'kana/vim-fakeclip' " Vim plugin: Provide pseudo "clipboard" registers
  Plug 'tpope/vim-sleuth' "This plugin automatically adjusts 'shiftwidth' and 'expandtab' heuristically based on the current file...
  Plug 'svermeulen/vim-easyclip'
  Plug 'tpope/vim-repeat'

  "Images
  Plug 'ashisha/image.vim'

  "Search, replace
  Plug 'brooth/far.vim' "Find And Replace Vim plugin
  Plug 'kien/ctrlp.vim' "Fuzzy file, buffer, mru, tag, etc finder
  Plug 'vim-scripts/ctrlsf.vim' "An ack.vim alternative mimics Ctrl-Shift-F on Sublime Text 2 , :CtrlSF [pattern]

  "Vim help
  Plug 'tweekmonster/helpful.vim' " Display vim version numbers in docs
  Plug 'editorconfig/editorconfig-vim' "EditorConfig plugin for Vim http://editorconfig.org
  Plug 'WolfgangMehner/vim-support'

  "Remote
  Plug 'zenbro/mirror.vim' "Efficient way to edit remote files on multiple environments with Vim.
  Plug 'Shougo/neossh.vim' "SSH interface for Vim plugins
  Plug 'ujihisa/unite-ssh'
   Plug 'ujihisa/vimshell-ssh'
  Plug 'eiginn/netrw' "Mirror of Dr. Chip's netrw vim plugin for vundle


  " Required:
  call dein#end(
  call dein#save_state(
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install(
call dein#install(
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""
"End dein Scripts-------------------------
""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""PLUGINS CONFIG"""""""""""""""""""""


"""""""""""""""""" Neomake
" When writing a buffer, and on normal mode changes (after 750ms.
call neomake#configure#automake('nw', 750

"joonty/vim-do
let g:do_auto_show_process_window = 0
call do#ReloadOptions(

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
set statusline+=%{SyntasticStatuslineFlag(}
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
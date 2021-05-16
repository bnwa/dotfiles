" In Insert mode: Use the appropriate number of spaces to insert a
" <Tab>.  Spaces are used in indents with the '>' and '<' commands and
" when 'autoindent' is on.
set expandtab

" By default, apply the /g flag to global substititions
set gdefault

" Show status line when split
set laststatus=2

" Display this characters before and after a text cutoff
set listchars+=precedes:«,extends:»

" Index line numbering relative to the current line,
" but always show the absolute number on the current line
set number relativenumber

" Don't prompt for <ENTER> from completion menu
set shortmess+=c

" Number of spaces to use for each step of (auto)indent.
set shiftwidth=2

" Number of columns in a <tab> used in editing operations
set softtabstop=2

" Don't hold entire buffer in memory
set noswapfile

" Number of columns in a <tab> for a read buffer
set tabstop=2

" Enable 24-bit true color support
set termguicolors

" Don't source these patterns for completion
set wildignore+=*/node_modules/*,*/.git

" Don't wrap lines that exceed pane length
set nowrap

" Don't write backups
set nowritebackup

" Lower time in ms to wait to evoke plugins
set updatetime=100

" Don't flash screen where there'd be an error bell
set novisualbell

" Markdown
autocmd BufReadPre *.md Goyo

" JSON(c)
autocmd FileType tsconfig.json setlocal syntax=jsonc

"Terminal
autocmd TermOpen * setlocal nonumber norelativenumber

"CSS
autocmd FileType css setlocal iskeyword+=-

" Fish shell
autocmd FileType *.fish setlocal tabstop=4
autocmd FileType *.fish setlocal softtabstop=4
autocmd FileType *.fish setlocal shiftwidth=4

" vim-plug -- auto install if missing and load plugins
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin( stdpath('data') . '/plugged' )
Plug 'ayu-theme/ayu-vim'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'junegunn/goyo.vim', { 'for': 'markdown' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'markonm/traces.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'yuezk/vim-js'
Plug 'neoclide/jsonc.vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'uiiaoo/java-syntax.vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'jsit/toast.vim'
call plug#end()

set background=light
" Set color scheme
"colorscheme ayu
"colorscheme dracula
colorscheme toast

" Ayu color scheme opt
let ayucolor="light"


" CtrlP
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" Set leader prefix
let mapleader=","

" Mappings
nnoremap j gj
nnoremap k gk

" Set terminal to normal mode
tnoremap <leader>l <C-\><C-n>

" Re-load nvim config
nnoremap <leader>r :source $MYVIMRC<CR>

" Cease highlighting search matches
nnoremap <leader>k :nohlsearch<CR>

" Simplify pane switching
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" coc.nvim -- Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" coc.nvim -- Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" coc.nvim -- GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" coc.nvim -- Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>

" coc.nvim -- Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>

" coc.nvim -- Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>

" coc.nvim -- Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>

" coc.nvim -- Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>

" coc.nvim -- Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>

" coc.nvim -- Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>

" coc.nvim -- Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" coc.nvim -- Show types
nnoremap <silent> <space>d  :call CocAction("doHover")<CR>
nnoremap <silent> <leader>~ :call ToggleDynamicTheme()<CR>

function ToggleDynamicTheme()
    let l:current = g:colors_name

    if l:current == "ayu"
      if g:ayucolor == "light"
        let g:ayucolor = "dark"
        set background=dark
      else
        let g:ayucolor = "light"
        set background=light
      endif
    elseif l:current == "toast"
      if &background == "light"
        set background=dark
      else
        set background=light
      endif
    else
      echo "Current theme '" . l:current . "' isn't dynamic"
    endif
endfunction

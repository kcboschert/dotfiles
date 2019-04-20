autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

call plug#begin("~/.config/nvim/plugged")
  " file explorer
  Plug 'preservim/nerdtree'
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'ryanoasis/vim-devicons'
  Plug 'jlanzarotta/bufexplorer'
  Plug 'uzxmx/vim-widgets'

  " file finder
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

  " code completion / intellisense
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'fatih/vim-go', {'do': ':GoInstallBinaries'}

  " syntax highlighting
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

  " status line
  Plug 'itchyny/lightline.vim'

  " testing
  Plug 'preservim/vimux'
  Plug 'janko-m/vim-test'

  " general
  Plug 'sainnhe/gruvbox-material'
  Plug 'arcticicestudio/nord-vim'
  Plug 'airblade/vim-gitgutter'  " Show git diff via Vim sign column.
  Plug 'pgr0ss/vim-github-url'
  Plug 'tomtom/tcomment_vim'
  Plug 'tpope/vim-dispatch'
  Plug 'tpope/vim-fugitive'
  Plug 'tweekmonster/wstrip.vim' " Strip whitespace from changes lines
  Plug 'tpope/vim-repeat'        " Allow plugins to use `.`-repeating
  Plug 'tpope/vim-surround'
  Plug 'dewyze/vim-tada'         " Todo organizer
call plug#end()

" colorscheme stuff
if has('termguicolors')
  set termguicolors
endif
set background=dark
" Available values: 'hard', 'medium'(default), 'soft', place before 'colorscheme' call
let g:gruvbox_material_background = 'soft'
let g:gruvbox_material_better_performance = 1
" colorscheme gruvbox-material
colorscheme nord

set backspace=indent,eol,start
set cmdheight=2 " Give more space for displaying messages.
set complete-=t " Don't use tags for autocomplete
set mouse=
set encoding=utf-8 " Set internal encoding of vim, not needed on neovim, since coc.nvim using some unicode characters in the file autoload/float.vim
set hidden " TextEdit might fail if hidden is not set.
set hlsearch
set incsearch
set nobackup " Some servers have issues with backup files, see #649.
set nowritebackup " Some servers have issues with backup files, see #649.
set number
set ruler
set showmatch
set shortmess+=c " Don't pass messages to |ins-completion-menu|.
set textwidth=0 nosmartindent tabstop=2 shiftwidth=2 softtabstop=2 expandtab
set wrap
set ignorecase
set smartcase
set updatetime=300 " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable delays and poor user experience.

" flip up/down navigation so j and k navigate around display lines, making
" wrapped line navigation more intuitive
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" automatically strip trailing whitespace on changed lines
let g:wstrip_auto = 1

" NERDTree
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1 " hide helper
let g:NERDTreeIgnore=['^node_modules$', '\.pyc$', '\.o$', '\.class$', '\.lo$', '\.meta$', 'tmp']
let g:NERDTreeStatusline = '' " set to empty to use lightline
" NERDTree
map <silent> <LocalLeader>nt :NERDTreeToggle<CR>
map <silent> <LocalLeader>nr :NERDTree<CR>
map <silent> <LocalLeader>nf :NERDTreeFind<CR>

" NERDTree Syntax Highlight
" " Enables folder icon highlighting using exact match
let g:NERDTreeHighlightFolders = 1 
" " Highlights the folder name
let g:NERDTreeHighlightFoldersFullName = 1 
" " Color customization
let s:brown = "905532"
let s:aqua =  "3AFFDB"
let s:blue = "689FB6"
let s:darkBlue = "44788E"
let s:purple = "834F79"
let s:lightPurple = "834F79"
let s:red = "AE403F"
let s:beige = "F5C06F"
let s:yellow = "F09F17"
let s:orange = "D4843E"
let s:darkOrange = "F16529"
let s:pink = "CB6F6F"
let s:salmon = "EE6E73"
let s:green = "8FAA54"
let s:lightGreen = "31B53E"
let s:white = "FFFFFF"
let s:rspec_red = 'FE405F'
let s:git_orange = 'F54D27'
" " This line is needed to avoid error
let g:NERDTreeExtensionHighlightColor = {} 
" " Sets the color of css files to blue
let g:NERDTreeExtensionHighlightColor['css'] = s:blue 
" " This line is needed to avoid error
let g:NERDTreeExactMatchHighlightColor = {} 
" " Sets the color for .gitignore files
let g:NERDTreeExactMatchHighlightColor['.gitignore'] = s:git_orange 
" " This line is needed to avoid error
let g:NERDTreePatternMatchHighlightColor = {} 
" " Sets the color for files ending with _spec.rb
let g:NERDTreePatternMatchHighlightColor['.*_spec\.rb$'] = s:rspec_red 
" " Sets the color for folders that did not match any rule
let g:WebDevIconsDefaultFolderSymbolColor = s:beige 
" " Sets the color for files that did not match any rule
let g:WebDevIconsDefaultFileSymbolColor = s:blue 

" NERDTree Git Plugin
let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

" " ALE (Asynchronous Lint Engine)
" let g:ale_enabled = 1                     " Enable linting by default
" let g:ale_fix_on_save = 0
" let g:ale_lint_on_insert_leave = 1        " Automatically lint when leaving insert mode
" let g:ale_lint_on_text_changed = 'normal' " Only lint while in normal mode
" let g:ale_set_signs = 1                   " Enable signs showing in the gutter to reduce interruptive visuals
" " let g:ale_sign_error = '❌'
" " let g:ale_sign_warning = '⚠️'
" let g:ale_fixers = {
"  \ 'javascript': ['eslint']
"  \ }

" Fugitive
nnoremap <leader>gg :silent Ggrep! <cword><CR>

" GitHubURL
map <silent> <LocalLeader>gh :GitHubURL<CR>

" TComment
map <silent> <LocalLeader>cc :TComment<CR>
map <silent> <LocalLeader>uc :TComment<CR>

" Fuzzy Finder
function! SmartFuzzy()
  let root = split(system('git rev-parse --show-toplevel'), '\n')
  if len(root) == 0 || v:shell_error
    Files
  else
    GFiles -co --exclude-standard -- . ':!:vendor/*'
  endif
endfunction

command! -nargs=* SmartFuzzy :call SmartFuzzy()
map <silent> <leader>ff :SmartFuzzy<CR>
map <silent> <leader>fg :GFiles<CR>
map <silent> <leader>fb :Buffers<CR>
map <silent> <leader>ft :Tags<CR>

let g:fzf_tags_command = 'ctags -R --exclude=".git\|.svn\|log\|tmp\|db\|pkg" --extra=+f --langmap=Lisp:+.clj'
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

" ======= BEGIN COC =======

let g:coc_node_path = trim(system('which node'))

let g:coc_global_extensions = [
      \ 'coc-sh',
      \ 'coc-docker',
      \ 'coc-go',
      \ 'coc-java',
      \ 'coc-json',
      \ 'coc-pyright',
      \ 'coc-solargraph',
      \ 'coc-sumneko-lua',
      \ 'coc-swagger',
      \ 'coc-tsserver',
      \ 'coc-vimlsp',
      \ 'coc-yaml',
      \ 'https://github.com/dgileadi/vscode-java-decompiler',
      \ ]

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif
set signcolumn=yes

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <C-x><C-z> coc#pum#visible() ? coc#pum#stop() : "\<C-x>\<C-z>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add `:Swagger` command for rendering
command -nargs=0 Swagger :CocCommand swagger.render

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
let g:lightline = {
      \ 'colorscheme': 'powerlineish',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ],
      \   'right': [['lineinfo'], ['percent'], ['filetype', 'fileformat', 'fileencoding']]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status'
      \ },
      \ }

" Use autocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" ======= END COC =======
"
" Vimux Plugin
let test#strategy = "vimux"
let test#custom_runners = {}
let test#python#runner = 'pytest'
" speed up java tests by using the Maven Daemon: https://github.com/apache/maven-mvnd
if executable("mvnd")
  let test#java#maventest#executable = 'mvnd'
endif
let test#java#maventest#options = '-DtrimStackTrace=false'

let nose_test = system('grep -q "nose" requirements.txt')
if v:shell_error == 0
  let test#python#runner = 'nose'
endif

if filereadable(expand('WORKSPACE'))
  let test#custom_runners['java'] = ['bazeltest']
  let test#java#runner = 'bazeltest'
  let g:test#java#bazeltest#test_executable = './bazel test'
  let g:test#java#bazeltest#file_pattern = '.*/test/.*\.java$'
endif

map <silent> <LocalLeader>ra :wa<CR> :TestSuite<CR>
map <silent> <LocalLeader>rb :wa<CR> :TestFile<CR>
map <silent> <LocalLeader>rf :wa<CR> :TestNearest<CR>
map <silent> <LocalLeader>rl :wa<CR> :TestLast<CR>

lua require('treesitter')

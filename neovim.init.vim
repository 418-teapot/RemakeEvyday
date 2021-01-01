"-----------------------自动下载 vim-plug 和相关插件----------------------------
if has('nvim')
    let g:plug_path = '~/.local/share/nvim/site/autoload/plug.vim'
    let g:download_path = stdpath('data').'/plugged'
else
    let g:plug_path = '~/.vim/autoload/plug.vim'
    let g:download_path = '~/.vim/plugged'
endif

if empty(glob(plug_path))
  silent !curl -fLo plug_path --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif
"-------------------------------------------------------------------------------


"---------------------------------插件管理--------------------------------------
call plug#begin(download_path)
" 快速对齐
Plug 'junegunn/vim-easy-align'
" 主题管理
Plug 'flazz/vim-colorschemes'
" gruvbox 主题
Plug 'morhetz/gruvbox'
" airline 行
Plug 'vim-airline/vim-airline'
" airline 主题
Plug 'vim-airline/vim-airline-themes'
" 快捷键导航
Plug 'liuchengxu/vim-which-key', {'on': ['WhichKey', 'WhichKey!']}
" 自动补全括号
Plug 'jiangmiao/auto-pairs'
" 快速包围
Plug 'tpope/vim-surround'
" 对齐线
Plug 'Yggdroot/indentLine'
" 自定义补全
Plug 'honza/vim-snippets'
" 文件搜索
Plug 'Yggdroot/LeaderF', {'do': ':LeaderfInstallCExtension'}
" Ranger 悬浮窗口
Plug 'kevinhwang91/rnvimr'
" coc.nvim 代码补全 LSP
Plug 'neoclide/coc.nvim', {'do': ':CocInstall coc-json coc-cmake coc-snippets'}
" 自动增量 ctags
Plug 'ludovicchabant/vim-gutentags'
" 异步运行
Plug 'skywind3000/asyncrun.vim'
call plug#end()
"-------------------------------------------------------------------------------


"---------------------------------基本设置--------------------------------------
" gruvbox 主题
colorscheme gruvbox
set background=dark
" 设置背景透明，与终端保持一致
hi Normal     ctermbg=NONE guibg=NONE
hi LineNr     ctermbg=NONE guibg=NONE
hi SignColumn ctermbg=NONE guibg=NONE
" 开启 truecolor 渲染
set termguicolors
set t_Co=256
" 显示行号
set number
set relativenumber
" 突出显示当前行
set cursorline
" 打开状态栏标尺
set ruler
" 高亮第81,121列
set colorcolumn=81,121
" 禁止 vi 兼容
set nocompatible
" 设置编码格式
set encoding=UTF-8
" 设置剪切板
set clipboard+=unnamedplus
" 当文件在外部被修改时，自动重载
set autoread
" 设置默认 << 和 >> 命令移动的宽度
set shiftwidth=4
" 设置默认 tap 长度
set tabstop=4
" 设置默认退格键最大删除长度
set softtabstop=4
" 将 tab 展开为空格
set expandtab
" 智能缩进
set smartindent
" 针对 c, cpp, js, ts 等语言特别设置
filetype indent on
autocmd FileType c,cpp,cc,javascript,typescript set sw=2 ts=2 sts=2
" 设置鼠标
set selection=exclusive
set selectmode=mouse,key
"-------------------------------------------------------------------------------


"---------------------------------插件设置--------------------------------------
"
"---------------------------------airline---------------------------------------
" 使用 powerline 字体
let g:airline_powerline_fonts=1
" 显示顶栏
let g:airline#extensions#tabline#enabled=1
" 设置主题
let g:airline_theme='molokai'

"---------------------------------AsyncRun--------------------------------------
" 自动打开窗口，高度为6
let g:asyncrun_open=6

"---------------------------------LeaderF---------------------------------------
" 显示隐藏文件
let g:Lf_ShowHidden=1

"---------------------------------gutentags-------------------------------------
" 设置 ctags 路径
set tags=./.tags;,.tags
" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'
" 添加 ctags 支持
let g:gutentags_modules = []
if executable('ctags')
   let g:gutentags_modules += ['ctags']
endif
" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
" 检测 ~/.cache/tags 不存在就新建
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif
"-------------------------------------------------------------------------------


"---------------------------------按键绑定--------------------------------------
let g:mapleader=" "
set timeoutlen=50
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
nnoremap <F10> :call asyncrun#quickfix_toggle(6)<CR>
"-------------------------------------------------------------------------------

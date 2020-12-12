"-------------------插件管理-------------------------
" 使用 vim
" call plug#begin('~/.vim/plugged')
" 使用 neovim
call plug#begin(stdpath('data').'/plugged')
" 快速对齐
Plug 'junegunn/vim-easy-align'
" 主题管理
Plug 'flazz/vim-colorschemes'
" Space Dark 主题
Plug 'liuchengxu/space-vim-dark'
" gruvbox 主题
Plug 'morhetz/gruvbox'
" airline 行
Plug 'vim-airline/vim-airline'
" airline 主题
Plug 'vim-airline/vim-airline-themes'
" 目录树
Plug 'preservim/nerdtree'
" coc.nvim 代码补全 LSP
Plug 'neoclide/coc.nvim'
" 自动增量 ctags
Plug 'ludovicchabant/vim-gutentags'
call plug#end()
"----------------------------------------------------

"-------------------主题设置-------------------------
" gruvbox 主题
colorscheme gruvbox
set background=dark

" space-vim-dark 主题
" colorscheme space-vim-dark
" 设置注释为灰色
" hi Comment guifg=#5C6370 ctermfg=59
" 背景黑色程度
"   Range:   233 (darkest) ~ 238 (lightest)
"   Default: 235
" let g:space_vim_dark_background = 237
" 如果想让背景透明，打开注释
" hi Normal     ctermbg=NONE guibg=NONE
" hi LineNr     ctermbg=NONE guibg=NONE
" hi SignColumn ctermbg=NONE guibg=NONE

" 开启 truecolor 渲染
set termguicolors
set t_Co=256   
" 设置 airline 主题
let g:airline_theme='molokai'
" 显示行号
set number
" 突出显示当前行
set cursorline
" 打开状态栏标尺
set ruler
" 高亮第81,121列
set colorcolumn=81,121
" 显示状态栏
set laststatus=2
" 当打开非文件时自动开启目录树
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") && v:this_session == "" | NERDTree | endif
" 目录树显示隐藏文件
let NERDTreeShowHidden=1
" 当关闭文件后左侧只有目录树时自动关闭 vim
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"----------------------------------------------------

"-------------------编辑设置-------------------------
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
" 设置 ctags 路径
" set tags=./.tags;,.tags
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
"----------------------------------------------------

"-------------------设置鼠标-------------------------
set mouse=a
set selection=exclusive
set selectmode=mouse,key
"----------------------------------------------------

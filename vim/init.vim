"-----------------------自动下载 vim-plug 和相关插件----------------------------
if has('nvim')
    let s:plug_path='~/.local/share/nvim/site/autoload/plug.vim'
    let s:download_path=stdpath('data').'/plugged'
else
    let s:plug_path='~/.vim/autoload/plug.vim'
    let s:download_path='~/.vim/plugged'
endif

if empty(glob(s:plug_path))
    let vimplug=system("curl -fLo " . s:plug_path . " --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim")
    echom vimplug
endif

augroup AutoUpdate
    autocmd!
    autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
        \| PlugInstall --sync | source $MYVIMRC
    \| endif
augroup END
"-------------------------------------------------------------------------------


"---------------------------------插件管理--------------------------------------
call plug#begin(s:download_path)
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
" 自动补全括号
Plug 'jiangmiao/auto-pairs'
" 快速包围
Plug 'tpope/vim-surround'
" 对齐线
Plug 'Yggdroot/indentLine'
" 自定义补全
Plug 'honza/vim-snippets'
" 文本对象
Plug 'kana/vim-textobj-user'
" 悬浮终端
Plug 'voldikss/vim-floaterm'
" 侧边显示 git 状态
Plug 'airblade/vim-gitgutter'
" 文件搜索
Plug 'Yggdroot/LeaderF', {'do': ':LeaderfInstallCExtension'}
" coc.nvim 代码补全 LSP
Plug 'neoclide/coc.nvim', {'do': ':CocInstall coc-json coc-cmake coc-snippets'}
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
augroup FileTab
    autocmd!
    autocmd FileType c,cpp,cc,javascript,typescript set sw=2 ts=2 sts=2
augroup END
" 设置鼠标
set selection=exclusive
set selectmode=mouse,key
" 设置快捷键响应延迟
set timeoutlen=500
" 设置 tags 路径
set tags=./.tags;,.tags

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

"---------------------------------Floaterm--------------------------------------
" 设置浮动窗口大小
let g:floaterm_width=0.8
" 当含有下列文件时，终端打开路径为工程根路径
let g:floaterm_rootmarkers=['.project', '.root', '.git', '.ccls']

"---------------------------------AsyncRun--------------------------------------
" 自动打开窗口，高度为6
let g:asyncrun_open=6

"---------------------------------LeaderF---------------------------------------
" 显示隐藏文件
let g:Lf_ShowHidden=1
" 启用悬浮窗口
let g:Lf_WindowPosition='popup'
let g:Lf_PreviewInPopup=1
" 自动生成 gtags 数据库
let g:Lf_GtagsAutoGenerate=1
" 设置项目根目录
let g:Lf_RootMarkers=['.git', '.root', '.ccls', '.project', '.hg', '.svn']
" 设置 gtags 对于原生支持的语言（C, C++, Java, PHP, Yacc, 汇编）使用内置 parser
" 其他语言使用 pygments 作为 parser
let g:Lf_Gtagslabel='native-pygments'

"-------------------------------------------------------------------------------


"---------------------------------按键绑定--------------------------------------
let g:mapleader="\<Space>"

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

let g:Lf_ShortcutF = "<leader>ff"
let g:Lf_ShortcutB = "<leader>fb"
nnoremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
nnoremap <leader>ft :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
nnoremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>
nnoremap <leader>fu :<C-U><C-R>=printf("Leaderf function %s", "")<CR><CR>
nnoremap <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
nnoremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
nnoremap <leader>fg :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>

nnoremap <leader>ar :<C-u>call asyncrun#quickfix_toggle(6)<CR>
nnoremap <leader>a, :<C-u>AsyncRun<Space>

let g:floaterm_keymap_toggle='<M-=>'
nnoremap <leader>rg :<C-u>FloatermNew ranger<CR>
tnoremap <leader>rg <C-\><C-n>:<C-u>FloatermKill ranger<CR>

nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)

nmap <silent> <leader>cd <Plug>(coc-definition)
nmap <silent> <leader>cr <Plug>(coc-references)
"-------------------------------------------------------------------------------

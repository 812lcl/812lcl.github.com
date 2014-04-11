---
layout: post
title: "Vim 基本配置"
date: 2014-04-05 21:44
comments: true
categories: Vim
tags: [vim, linux, 编辑器, 编程环境]
keywords: vim, linux, set
---
Vim是个强大的编辑器，在各种插件的辅助下甚至也能匹敌IDE，但也不能过分的依赖来各种插件，而忘记来Vim原本的功能与操作。Vim本身的功能很强大，学习曲线很曲折，需要我们慢慢的来学习，多多的使用。Vim自身有很多配置选项，可以在`~/.vimrc`中配置，从而方便我们操作。使用Vim也有一段时间来，也有了一套自己习惯好用的[配置](https://github.com/812lcl/dotfiles)，下面列出我的基本配置。

## General ##

一些基本配置

    syntax on                       " 关键字上色
    syntax enable                   " 语法高亮
    set nu                          " 显示行号
    set nocp                        " 不兼容vi
    set hidden                      " 允许不保存切换buffer
    set splitright                  " 新分割窗口在右边
    set splitbelow                  " 新分割窗口在下边
    set autoread                    " 文件在Vim之外修改过，自动重新读入
    set timeoutlen=350              " 等待时间,如<leader>键后的输入
    set helpheight=999              " 查看帮助文档全屏
    set scrolljump=3                " 当光标离开屏幕滑动行数
    set scrolloff=1                 " 保持在光标上下最少行数
    set showmatch                   " 短暂回显匹配括号
<!--more-->
    set hlsearch                    " 检索时高亮显示匹配项
    set incsearch                   " 边输入边搜索
    set ignorecase                  " 搜索忽略大小写
    set smartcase                   " 智能大小写搜索

    set wildmenu                    " 命令模式下补全以菜单形式显示
    set wildmode=list:longest,full  " 命令模式补全模式
    set foldenable                  " 启动折叠
    set foldmethod=marker           " 设置折叠模式
    set encoding=utf-8              " 编码，使汉语正常显示
    set termencoding=utf-8
    set fileencodings=utf-8,gb2312,gbk,gb18030

还有相关的编码问题可以参考[VIM文件编码识别与乱码处理](http://edyfox.codecarver.org/html/vim_fileencodings_detection.html)。

## Formatting ##

关于缩进

    set expandtab                   " tab=空格
    set tabstop=4                   " tab缩进4个空格
    set shiftwidth=4                " 自动缩进空格数
    set softtabstop=4               " 退格删除缩进
    set backspace=indent,start      " 退格可删除缩进和原有字符
    set autoindent                  " 与前一行同样等级缩进

当切割窗口显示多文件时，如果窗口大小改变，本来分布均匀的窗口不会重新调整大小，变得很难看，可以添加下面这条来配置自动调整大小。

    au VimResized * exe "normal! \<c-w>="

在粘贴时候，如果前边的行带有注释符号，如`#`、`//`、`"`等时，后边的行会自动加上注释符号，很是麻烦，下面可以配置不自动添加成注释。

    au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "no rm $"|endif|endif
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

## Key (re)Mappings ##

一些按键的重映射，很多用了真是让人上瘾，而且便捷很多，如`<Esc>`用`jj`来代替，还有一些常输错的一些命令的修正，如`Q`、`W`等。

    let mapleader=","           " 映射<leader>键到为,
    nmap j gj
    nmap k gk
    inoremap jj <ESC>
    nnoremap <silent> J :bp<CR>
    nnoremap <silent> K :bn<CR>
    noremap <silent><space> :set hls! hls?<CR>
    noremap <silent><Leader>s :set rnu! rnu?<CR>
    noremap <silent><Leader>l :set list! list?<CR>
    nnoremap <Leader>c @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

    " 更方便窗口间移动
    nnoremap <C-h> <C-w>h
    nnoremap <C-j> <C-w>j
    nnoremap <C-k> <C-w>k
    nnoremap <C-l> <C-w>l

    " 命令模式按键映射
    cnoremap <C-a> <Home>
    cnoremap <C-e> <End>
    cnoremap <C-p> <Up>
    cnoremap <C-n> <Down>

    " Tab操作
    nnoremap <Leader>tc :tabc<CR>
    nnoremap <Leader>tn :tabn<CR>
    nnoremap <Leader>tp :tabp<CR>
    nnoremap <Leader>te :tabe<Space>

    " 修正易错命令
    command -bang -nargs=* Q q<bang>
    command -bang -nargs=* Wa wa<bang>
    command -bang -nargs=* WA wa<bang>
    command -bang -nargs=* -complete=file W w<bang> <args>
    command -bang -nargs=* -complete=file Wq wq<bang> <args>
    command -bang -nargs=* -complete=file WQ wq<bang> <args>

## Vim UI ##

因为我主要在终端使用Vim，所以一些UI的配置是针对终端的。GUI的话基本相似，把`ctermbg`等换成`guibg`等就可以了。

    set t_Co=256                    " 终端显示256色
    set tabpagemax=15               " 最多15个Tab
    set showmode                    " 显示当前mode
    set cursorline                  " 高亮当前行
    set list                        " 显示特殊符号
    set listchars=tab:›\ ,trail:•,extends:#,nbsp:.

    hi clear SignColumn             " 标记列背景和主题背景匹配
    hi clear LineNr                 " 当前行列背景和主题背景匹配

    hi CursorLineNr ctermfg=red
    hi VertSplit ctermbg=Grey ctermfg=Grey cterm=none
    hi Visual ctermbg=81 ctermfg=black cterm=none
    hi Comment ctermfg=blue
    hi Statement ctermfg=cyan
    hi DiffAdd ctermbg=blue ctermfg=white
    hi DiffDelete ctermbg=green ctermfg=none
    hi DiffChange ctermbg=red ctermfg=White
    hi DiffText ctermbg=yellow ctermfg=black

    if has('cmdline_info')
        set showcmd                 " 右下角显示当前操作
        set ruler                   " 右下角显示状态说明
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " 设定格式
    endif

    if has('statusline')
        set laststatus=1
        set statusline=%<%f\                     " Filename
        set statusline+=%w%h%m%r                 " Options
        set statusline+=\ [%{&ff}/%Y]            " Filetype
        set statusline+=\ [%{getcwd()}]          " Current dir
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
    endif

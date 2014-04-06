---
layout: post
title: "Vim补全配置"
date: 2013-12-06 18:54
comments: true
categories: Vim
tags: [vim, linux, 编辑器, 编程环境]
keywords: vim, linux, omnicppcomplete, neocomplcache, youcompleteme, clang-complete, javacomplete
description: vim补全配置
---
vim已经自带了补全功能，通过几个补全插件可以使其补全发挥的更出色，以下主要介绍5种不同的补全，并不需要全部安装，根据需求选择安装，具体安装方法可以见[VIM插件配置续](http://812lcl.github.io/blog/2013/12/04/vimcha-jian-pei-zhi-xu/)或[Vim插件配置，比肩IDE](http://812lcl.github.io/blog/2013/10/24/vimcha-jian-pei-zhi-%2Cbi-jian-ide/)。

## 1. [javacomplete](https://github.com/vim-scripts/javacomplete)
这个是个java补全的插件，需要编译以下autoload目录下的Reflection.java，然后将编译生成的Reflection.class文件移动到主目录下即可。当然要实现补全功能，必须在vim中开启文件类型识别，不多述了。

另外Java补全，还可以使用[eclim](http://eclim.org/)。
<!--more-->

![javacomplete](http://pic002.cnblogs.com/images/2012/342823/2012041511171014.png)

## 2. [omnicppcomplete](https://github.com/vim-scripts/OmniCppComplete)
这个插件是用来补全C++的，需要ctags生成项目的tag文件并加载到当前vim中，然后可以根据`. -> ::`等符号自动补全，在之前的文章中也都介绍过了。
## 3. [neocomplcache](https://github.com/Shougo/neocomplcache.vim)
Original filename completion

![neocomplcache](https://github-camo.global.ssl.fastly.net/5c0c143ad7b1b39fb3a1ec5e2b39c315d6e70391/687474703a2f2f312e62702e626c6f6773706f742e636f6d2f5f63693279426e717a4a674d2f5444314f355f624f5132492f41414141414141414144452f7648663958675f6d7254492f73313630302f66696c656e616d655f636f6d706c6574652e706e67)

Omni completion

![neo](https://github-camo.global.ssl.fastly.net/9fc2701fcb8b4a54ab9e0d0ff2902b11aadb825f/687474703a2f2f322e62702e626c6f6773706f742e636f6d2f5f63693279426e717a4a674d2f54443150546f6c6b5442492f41414141414141414144552f6b6e4a33656e69754857492f73313630302f6f6d6e695f636f6d706c6574652e706e67)

这种补全我是作为`clang-complete`或`YouCompleteMe`的一种补充，对于
/nginx/tmux/shell/vimscript等文件，它都有默认的关键字支持，还有目录文件
补全，一边输入就会一边列出可以补全的项，而不用按<c-x><c-f>等命令来选择
不同的补全，可以使用<c-p>或<c-n>进行上下选择不同的补全，如果有supertab
插件更是如虎添翼了。

这是我在配合YCM的时候的配置，由YCM补全c、cpp、java、python的文件，其他文件的补全则由neocomplcache实现。配置文件查看[.vim](https://github.com/812lcl/.vim)。
```
let g:neocomplcache_enable_at_startup = 1
au Filetype c,cpp,java,python let g:neocomplcache_enable_at_startup = 0
set dict+=$HOME/.vim/static/dict_with_cases
let g:neocomplcache_dictionary_filetype_lists = {'_' : $HOME . "/.vim/static/english_dict"}
let g:neocomplcache_auto_completion_start_length = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_fuzzy_completion = 1               " 开启模糊匹配
let g:neocomplcache_fuzzy_completion_start_length = 3         " 3个字母后开启模糊匹配
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
```
在和clang-complete配合补全时，会有一些冲突，配置时需要配置时去除冲突。配置文件查看[vim_withoutYCM](https://github.com/812lcl/vim_withoutYCM)。
```
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

if !exists('g:neocomplcache_force_omni_patterns')
        let g:neocomplcache_force_omni_patterns = {}
endif
let g:neocomplcache_force_overwrite_completefunc = 1
let g:neocomplcache_force_omni_patterns.c =
                        \ '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_force_omni_patterns.cpp =
                        \ '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:neocomplcache_force_omni_patterns.objc =
                        \ '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_force_omni_patterns.objcpp =
                        \ '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:clang_complete_auto = 0
let g:clang_auto_select = 0
```
## 4. [clang-complete](https://github.com/vim-scripts/clang-complete)
这也是用于C/C++/Objective-C/Objective-C++的补全，它是利用clang自动分析当前项目，实现补全，比omnicppcoplete方便且高级多了，不需要每一次生成tag文件并加载了。这个插件需要系统安装了clang，对vim也有一定的要求，需要7.3以上且支持python。把需要的东西都安装好，将插件放入`~/.vim/bundle`目录下即可使用，并不需要在`.vimrc`中添加什么配置，很是方便。试用了下效果很不错，而且使用这个插件比YCM可是轻便多了，整个.vim目录也不过几MB而已，而且不用耗费心力配置。所以对YCM编译发憷的同志们使用这个插件也可满足了，只不过据说在工程文件太大的时候它比较慢。
## 5. [YouCompleteMe](https://github.com/Valloric/YouCompleteMe)

![YCM](https://github-camo.global.ssl.fastly.net/1f3f922431d5363224b20e99467ff28b04e810e2/687474703a2f2f692e696d6775722e636f6d2f304f50346f6f642e676966)

重头戏登场了，从名字来看就够霸气了，公认的补全神奇，只不过属于编译行插件，稍微麻烦一些，而且体积确实大了一些，编译完后这个插件就达到了七八十MB大小。不过补全效果最好，支持`C/C++/Objective-C/Objective-C++`的补全，还支持基于Jedi的Python补全和基于OmniSharp的C#补全，号称安了这个插件就不需要下面四个了

- clang_complete
- AutoComplPop
- Supertab
- neocomplcache

而且这插件和Syntastic和ultisnips的配合也都很好。而我最终选用这个插件是因为它支持模糊匹配功能，你只需要输入想要输入的单词的子序列即可匹配到，如你想匹配的名为`printf`，只需输入`ptf`即可。而且它还支持从一个变量跳转到它的声明或定义处的功能，都是很好用的，所以费了一番功夫编译好它还是值得的。

这个插件是需要`build-essential`、`camke`、`clang`、`python-dev`等很多支持的，还需要vim高于7.3.584。ubuntu用户需要重新编译安装更高版本的vim了，方法参见[compile Vim from source](https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source)，fedora用户就省事多了。具体编译和使用参看[项目主页](https://github.com/Valloric/YouCompleteMe)即可。

编译安装vim

1.安装依赖库
```
sudo apt-get install ctags cscope libncurses5-dev libgnome2-dev libgnomeui-dev \
                     libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
                     libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev ruby-dev mercurial
```
2.删除vim
```
sudo apt-get remove vim vim-runtime gvim vim-tiny vim-common vim-gui-common
```
3.编译安装vim
```
cd ~
hg clone https://code.google.com/p/vim/
cd vim
./configure --with-features=huge \
            --enable-rubyinterp \
            --enable-pythoninterp \
            --with-python-config-dir=/usr/lib/python2.7-config \
            --enable-perlinterp \
            --enable-gui=gtk2 --enable-cscope \
            --enable-luainterp \
            --prefix=/usr
make VIMRUNTIMEDIR=/usr/share/vim/vim74
sudo make install
```
4.设置vim为默认编辑器
```
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/vim 1
sudo update-alternatives --set editor /usr/bin/vim
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/vim 1
sudo update-alternatives --set vi /usr/bin/vim
```
看过好多博客写的YCM编译的教程，最后还是感觉项目主页上的原版安装教程最好，而且编译过程中可能出现各种问题，仔细阅读作者的教程，一切问题都可以解决。下面是安装编译YCM的步骤，包括几种不同的编译方法。

1.安装依赖软件
```
sudo apt-get install build-essential cmake python-dev clang llvm
```
2.安装YCM

在`~/.vimrc`中添加`"Bundle Valloric/YouCompleteMe"`，打开Vim，执行`:BundleInstall`命令，等待安装完毕。

3.编译YCM

编译根据系统clang和llvm的情况有所不同，分为几种情况。

- clang、llvm等级高于3.3

这种情况最简单，执行YouCompleteMe中自带的安装脚本即可。
```
cd ~/.vim/bundle/YouCompleteMe
./install.sh --clang-completer [--omnisharp-completer]
```
`--omnisharp-completer`是使YCM支持C#的补全，根据自己需要选择。

- 系统的clang等级高于3.3，手动编译
```
mkdir ~/ycm_build
cd ~/ycm_build
cmake -G "Unix Makefiles" -DUSE_SYSTEM_LIBCLANG=ON . ~/.vim/bundle/YouCompleteMe/cpp
make ycm_core
make ycm_support_libs
make
```
- 下载对应系统版本的clang+llvm的Pre-build Binaries包，[下载地址](http://llvm.org/releases/download.html#3.4)，编译。此时系统不必装clang和llvm，编译完成后，可删除Pre-build Binaries包。
```
mkdir ~/ycm_tmp
tar -zxvf clang+llvm-3.4.tar.gz -C ~/ycm_tmp/llvm
mkdir ~/ycm_build
cd ~/ycm_build
cmake -G "Unix Makefiles" -DPATH_TO_LLVM_ROOT=~/ycm_tmp/llvm . ~/.vim/bundle/YouCompleteMe/cpp
或者
cmake -G "Unix Makefiles" -DEXTERNAL_LIBCLANG_PATH=~/ycm_tmp/llvm/lib/libclang.so . ~/.vim/bundle/YouCompleteMe/cpp
make ycm_core
make ycm_support_libs
make
```
最后来说一说clang和llvm的编译安装，可以使用`apt-get`或`yum`等安装，但等级可能不满足，ubuntu库中clang的等级只到来3.2，fedora则比较高。所以有时候可能需要编译安装，或下载对应的Pre-build Binaries包。

[llvm.org](http://llvm.org/releases/download.html#3.4)如果有对应系统版本的Pre-build Binaries包，解压到`/usr/local`即可。

否则只好自己编译安装来，耗时比较长。
```
下载clang source code和LLVM source code
cd ~/ycm_tmp
tar -zxvf llvm-3.4.src.tar.gz -C llvm
tar -zxvf clang-3.4.src.tar.gz -C ./llvm/tools/clang
mkdir build
cd build
cmake ../llvm/CMAKElist.txt ../llvm
make
sudo make install
```
完成后，clang和llvm就已经安装好来，可以按照第一二种编译方法，编译YCM了。

因为YCM默认开启来syntastic功能，即静态预防检查，随着你的输入会刷新gutter，以显示错误或警告的signs。如果你还使用vim-gitgutter插件，则无法正常显示。这时我的做法是，关闭YouCompleteMe的syntastic，独立安装syntastic插件。

我的YCM配置如下
```
set completeopt=longest,menu					" 关掉补全时的预览窗口
let g:ycm_confirm_extra_conf = 0 				" 不用每次提示加载.ycm_extra_conf.py文件
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_show_diagnostics_ui = 0               " 关闭ycm的syntastic
let g:ycm_filetype_whitelist = {'c' : 1, 'cpp' : 1, 'java' : 1, 'python' : 1}
let g:ycm_complete_in_comments = 1 				" 评论中也应用补全
let g:ycm_min_num_of_chars_for_completion = 2 	" 两个字开始补全
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_key_invoke_completion = '<C-Space>'
let g:ycm_semantic_triggers =  {'c' : ['->', '.'], 'objc' : ['->', '.'], 'ocaml' : ['.', '#'], 'cpp,objcpp' : ['->', '.', '::'], 'php' : ['->', '::'], 'cs,java,javascript,vim,coffee,python,scala,go' : ['.'], 'ruby' : ['.', '::']}
nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
```

vim就先折腾到这了。

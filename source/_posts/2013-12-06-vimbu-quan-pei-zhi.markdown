---
layout: post
title: "VIM补全配置"
date: 2013-12-06 18:54
comments: true
categories: 磨刀利刃
tags: [vim, linux, 编辑器, 编程环境]
keywords: vim, linux, omnicppcomplete, neocomplcache, youcompleteme, clang-complete, javacomplete
description: vim补全配置
---
vim已经自带了补全功能，通过几个补全插件可以使其补全发挥的更出色，以下主要介绍5种不同的补全，并不需要全部安装，根据需求选择安装，具体安装方法可以见[VIM插件配置续](http://812lcl.github.io/blog/2013/12/04/vimcha-jian-pei-zhi-xu/)或[Vim插件配置，比肩IDE](http://812lcl.github.io/blog/2013/10/24/vimcha-jian-pei-zhi-%2Cbi-jian-ide/)。

## 1. [javacomplete](https://github.com/vim-scripts/javacomplete)
这个是个java补全的插件，需要编译以下autoload目录下的Reflection.java，
然后将编译生成的Reflection.class文件移动到主目录下即可。当然要实现补全功能，必须在vim中开启文件类型识别，不多述了。

另外Java补全，还可以使用[eclim](http://eclim.org/)。
<!--more-->

![javacomplete](http://pic002.cnblogs.com/images/2012/342823/2012041511171014.png)

## 2. [omnicppcomplete](https://github.com/vim-scripts/OmniCppComplete)
这个插件是用来补全C++的，需要ctags生成项目的tag文件并加载到当前vim中，
然后可以根据`. -> ::`等符号自动补全，在之前的文章中也都介绍过了。
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

这是我在配合YCM的时候的配置，由YCM补全c、cpp、java、python的文件，其他
文件的补全则由neocomplcache实现。
配置文件查看[.vim](https://github.com/812lcl/.vim)。
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
在和clang-complete配合补全时，会有一些冲突，配置时需要配置时去除冲突。
配置文件查看[vim_withoutYCM](https://github.com/812lcl/vim_withoutYCM)。
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
这也是用于C/C++/Objective-C/Objective-C++的补全，它是利用clang自动分析
当前项目，实现补全，比omnicppcoplete方便且高级多了，不需要每一次生成
tag文件并加载了。这个插件需要系统安装了clang，对vim也有一定的要求，需要
7.3以上且支持python。把需要的东西都安装好，将插件放入`~/.vim/bundle`
目录下即可使用，并不需要在`.vimrc`中添加什么配置，很是方便。试用了下
效果很不错，而且使用这个插件比YCM可是轻便多了，整个.vim目录也不过几MB
而已，而且不用耗费心力配置。所以对YCM编译发憷的同志们使用这个插件也可
满足了，只不过据说在工程文件太大的时候它比较慢。
## 5. [YouCompleteMe](https://github.com/Valloric/YouCompleteMe)
![YCM](https://github-camo.global.ssl.fastly.net/1f3f922431d5363224b20e99467ff28b04e810e2/687474703a2f2f692e696d6775722e636f6d2f304f50346f6f642e676966)

重头戏登场了，从名字来看就够霸气了，公认的补全神奇，只不过属于编译行
插件，稍微麻烦一些，而且体积确实大了一些，编译完后这个插件就达到了七八十MB大小。不过补全效果最好，支持`C/C++/Objective-C/Objective-C++`的补全
，还支持基于Jedi的Python补全和基于OmniSharp的C#补全，号称安了这个插件
就不需要下面四个了

- clang_complete
- AutoComplPop
- Supertab
- neocomplcache

而且这插件和Syntastic和ultisnips的配合也都很好。而我最终选用这个插件是
因为它支持模糊匹配功能，你只需要输入想要输入的单词的子序列即可匹配到，
如你想匹配的名为`printf`，只需输入`ptf`即可。而且它还支持从一个变量跳转
到它的声明或定义处的功能，都是很好用的，所以费了一番功夫编译好它还是
值得的。

这个插件是需要`build-essential`、`camke`、`clang`、`python-dev`等很多
支持的，还需要vim高于7.3.584。ubuntu用户需要重新编译安装更高版本的vim
了，方法参见[compile Vim from source](https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source)，fedor用户就省事多了。具体编译和使用参看[项目主页](https://github.com/Valloric/YouCompleteMe)即可。

看过好多博客写的YCM编译的教程，最后还是感觉项目主页上的原版安装教程最好
，所以我也就不过多介绍了，而且编译过程中可能出现各种问题，仔细阅读作者
的教程，一切问题都可以解决。

因为移植其他电脑，需要重新编译一遍，有时候费时费力，我就把编译好的一个
YouCompleteMe包存在我的`.vim/bundle`中了，把其他依赖工具包安装好了，
直接解压缩到bundle目录中即可使用YCM了，省心多了，可以参看我的
[.vim](https://github.com/812lcl/.vim)。

我的YCM配置如下
```
set completeopt=longest,menu                                        " 关掉补全时的预览窗口
let g:ycm_confirm_extra_conf = 0                                 " 不用每次提示加载.ycm_extra_conf.py文件
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_filetype_whitelist = {'c' : 1, 'cpp' : 1, 'java' : 1, 'python' : 1}
let g:ycm_complete_in_comments = 1                                 " 评论中也应用补全
let g:ycm_min_num_of_chars_for_completion = 1         " 一个字开始补全
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_key_invoke_completion = '<C-Space>'
let g:ycm_semantic_triggers =  {'c' : ['->', '.'], 'objc' : ['->', '.'], 'ocaml' : ['.', '#'], 'cpp,objcpp' : ['->', '.', '::'], 'php' : ['->', '::'], 'cs,java,javascript,vim,coffee,python,scala,go' : ['.'], 'ruby' : ['.', '::']}
nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
```

---
vim就先折腾到这了。

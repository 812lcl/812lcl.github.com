+++
title = "Vim插件配置，比肩IDE"
date = "2013-10-24"
comments = true
categories = ["Vim"]
tags = ["vim", "linux", "编辑器", "编程环境"]
description = ""
+++

<!-- toc -->
vim的强大是众所周知的，而且在linux里的普及也是其他编辑器无法比拟的。它默认的功能已经很高效方便了，但人们并不满足于此，各种各样的插件也使他的功能更加丰满，更加便捷，下面主要讲一下我的vim插件及配置过程。

现在有很多的vim插件管理插件，如bundle、pathogen。我并没有去使用它们，而是自己一点一点的配置完成，然后将其上传到Github，以后需要重新配置，clone下来即可，分分钟搞定，很方便，可以查看[我的GitHub](https://github.com/812lcl)。

<!--more-->

首先，vim一般是linux自带了，在/usr/share/vim文件夹中，可以将要安装的插件及说明文档等放置这个目录的相应位置。其中有连接指向/etc/vim，可修改/etc/vim中的vimrc配置文件对vim进行设置。但不推荐这样做，这样以后想删除哪个插件比较麻烦。一般的做法是在$HOME文件夹下建立一个.vim文件夹，自己的插件、说明文档、语法高亮、配色方案等可以放在这个文件夹中的相应位置，配置文件为$HOME/.vimrc。这样不影响其他用户的配置，而且自己想恢复原来的vim，删除.vimrc和.vim文件夹即可。

```
|- .vim
	└colors 	配色方案
	└plugin 	插件
	└doc 		说明文档
	└syntax 	语法高亮
	└after 	修正脚本
	└autoload 	自动加载
```
下面正式开始配置了，提到的插件插件可以到[vim online](http://www.vim.org/index.php)下载，下载好放入~/.vim/plugin即可。

## 1. ctags
这是很重要的一个插件，大多数linux发行版本默认安装了ctags，如果没有可如下安装

	$ sudo apt-get install ctags

或者下载源文件，编译安装
```
$ tar -xzvf ctags-5.6.tar.gz
$ cd ctags-5.6
$ make
$ sudo make install
```
有了ctags，可以生成标签文件，识别出程序中的函数定义调用关系，变量，宏定义等，看到一个函数调用时，只需按下"Ctrl+]"，就可以跳转到其定义的地方，然后可以按"Ctrl+T"调回调用处。而且，有些其他插件的实现是依赖ctags实现的，所以ctags还是很重要的。使用方法如下
```
cd 程序根目录
ctags -R 		//生成tags文件
vim 程序源文件
:set tags=程序根目录/tags
```
## 2. taglist
taglist是依赖ctags发挥作用的，查看源文件时，可以打开taglist，就可以清晰的看到该文件中的函数名、变量名、宏定义等。可以选择相应的名字，查看定义的位置。安装只需下载taglis.vim，置于~/.vim/plugin中，然后在~/.vimrc中添加如下两句
```
let Tlist_Show_One_File=1       "让taglist可以同时展示一个文件的函数列表
let Tlist_Exit_OnlyWindow=1     "当taglist是最后一个分割窗口时，自动退出vim
```
然后可以在vim中输入`:Tlist`查看效果了。
## 3. netrw和winmanager
netrw是自带一个插件，不需要自己安装了，作用是显示文件夹中的子文件夹和文件情况。当用vim打开一个文件夹时，就是netrw的功能，可以进而删除、创建、修改文件文件夹。配合taglist使用，可以使vim更像一个IDE，更方便查看源程序文件。而winmanager就是整合taglist和netrw窗口的。同样下载winmanager.vim，放在~/.vim/plugin中，然后在.vimrc中填入如下
```
let g:winManagerWindowLayout='FileExplorer|TagList'
let g:persistentBehaviour=0         "如果所有编辑文件都关闭了，退出vim
let g:winManagerWidth = 30          "窗口默认宽带        
let g:defaultExplorer=1
nmap <silent> <F8> :WMToggle<cr>
```
最后一句为设置快捷键，按F8或者`:WMToggle`即可打开两个窗口。
## 4. cscope
这又是个强大的工具，是和ctags有类似功能，但比ctags更加强大的工具，具有在整个工程文件中更强大的查找功能。

首先安装，仍可以使用apt-get

	sudo apt-get install cscope

在~/.vimrc中增加一句：

	:set cscopequickfix=s-,c-,d-,i-,t-,e-        " 使用QuickFix窗口来显示cscope查找结果

使用也是如ctags类似，先在工程根目录下生成一个cscope的数据库，要查找时，需要把cscope.out导入到vim中，然后可以进行各种查找。
```
cd 工作目录
cscope -Rbq
vim 工程文件
:cs add 工作目录/cscope.out 工程文件
:cs find c|d|e|f|g|i|s|t name
```
其中c、d、e等代表不同的查找类型
```
0 或 s	查找本 C 符号(可以跳过注释)
1 或 g	查找本定义
2 或 d	查找本函数调用的函数
3 或 c	查找调用本函数的函数
4 或 t	查找本字符串
6 或 e	查找本 egrep 模式
7 或 f	查找本文件
8 或 i	查找包含本文件的文件                        
```
查找后vim会自动跳到第一个符合的地方，如果不满意可以用`:cw`打开quickfix窗口，自己选择跳转位置。当然查找命令可能有些长，总去输入不太方便，可设置快捷键，在.vimrc中添加
```
" 按下面这种组合键有技巧,按了<C-_>后要马上按下一个键,否则屏幕一闪
" 就回到nomal状态了
" <C-_>s的按法是先按"Ctrl+Shift+-",然后很快再按"s"
nmap <C-_>s :cs find s <C-R>=expand("<cword>")<cr><cr> :cw<cr>
nmap <C-_>g :cs find g <C-R>=expand("<cword>")<cr><cr> :cw<cr>
nmap <C-_>c :cs find c <C-R>=expand("<cword>")<cr><cr> :cw<cr>
nmap <C-_>t :cs find t <C-R>=expand("<cword>")<cr><cr> :cw<cr>
nmap <C-_>e :cs find e <C-R>=expand("<cword>")<cr><cr> :cw<cr>
nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<cr><cr>
nmap <C-_>i :cs find i <C-R>=expand("<cfile>")<cr><cr> :cw<cr>
nmap <C-_>d :cs find d <C-R>=expand("<cword>")<cr><cr> :cw<cr>
```
好了，暂时就这些，cscope在大型工程中查找非常方便，但也需要慢慢学习适应使用。
## 5. quickfix
刚刚提到过quickfix窗口，可以显示查询结果，他也可以显示make的时候出现的错误列表，可以选择错误，找到出错位置，进而调试，这在IDE中是很常用的，vim也实现了。而且quickfix并不需要安装，是vim的标准插件，可以使用时，输入`:cw`即可。`:cn`和`:cp`是切换结果的命令，可以定义快捷键，在.vimrc中添加几句话。
```
nmap <F6> :cp<cr>
nmap <F7> :cn<cr>
```
可以试验一下功能，写一个简单的c程序，将其中几句话写成有错误的，写一个makefile文件，打开源文件，用`:make`进行编译，编译会报错。编译结束回到代码界面时输入`:cw`打开quickfix窗口，可以看到刚刚编译的几条错误，按F6或F7切换错误，回车可以到达错误所在的行，进行修改。
## 6. minibufexplorer
仍然是将下载的minibufexplorer.vim放入plugin中即可。

在编程的时候不可能永远只编辑一个文件,肯定会打开很多源文件进行编辑,如果每个文件都打开一个vim进行编辑的话那操作起来将很多麻烦,所以vim有buffer(缓冲区)的概念,当你只编辑一个buffer的时候MiniBufExplorer派不上用场,当你打开第二个buffer的时候,MiniBufExplorer窗口就自动弹出来了。列出了当前所有已经打开的buffer,当你把光标置于这个窗口时,有下面几个快捷键可以用:
```
<Tab>	向前循环切换到每个buffer名上
<S-Tab>	向后循环切换到每个buffer名上
<Enter>	在打开光标所在的buffer
d 		删除光标所在的buffer
```
在.vimrc中添加如下语句，进行一定的设置
```
let g:miniBufExplMapCTabSwitchBufs = 1      "启用以下两个功能：Ctrl+tab移到下一个buffer并在当前窗口打开；
                                            "Ctrl+Shift+tab移到上一个buffer并在当前窗口打开；ubuntu好像不支持
let g:miniBufExplMapWindowNavVim = 1        "可以用<C-h,j,k,l>切换到上下左右的窗口中
let g:miniBufExplMapWindowNavArrows = 1     "可用<C-箭头键>切换到上下左右窗口中
let g:miniBufExplModSelTarget = 1           "不在不可编辑内容的窗口（如TagList窗口）中打开选中的buffer
```
这样就很清晰的看到，当前打开了多少个文件，切换也很方便。
## 7. a.vim
这是一个很方便在源文件和头文件间进行切换的插件，下载好放入plugin中即可，命令如下：
```
:A	在新Buffer中切换到c/h文件
:AS	横向分割窗口并打开c/h文件
:AV	纵向分割窗口并打开c/h文件
:AT	新建一个标签页并打开c/h文件
```
还可以在.vimrc中添加快捷键设置

	nnoremap <silent> <F12> :A<CR>

之后按F12即可打开同名的头文件，再配合minibufexplorer，可以很好的进行切换。
## 8. Grep
cscope可以在工程中找到函数、变量等的调用、定义的地方，Grep则可以在全工程范围内，查找你想查找的任何东西。
```
:Grep		按照指定的规则在指定的文件中查找
:Rgrep		同上, 但是是递归的grep
:GrepBuffer	在所有打开的缓冲区中查找
:Bgrep		同上
:GrepArgs	在vim的argument filenames (:args)中查找
:Fgrep		运行fgrep
:Rfgrep		运行递归的fgrep
:Egrep		运行egrep
:Regrep		运行递归的egrep
:Agrep		运行agrep
:Ragrep		运行递归的agrep
```
使用方法如下
```
:Grep   [<grep_options>] [<search_pattern> [<file_name(s)>]]
:Rgrep  [<grep_options>] [<search_pattern> [<file_name(s)>]]
:Fgrep  [<grep_options>] [<search_pattern> [<file_name(s)>]]
:Rfgrep [<grep_options>] [<search_pattern> [<file_name(s)>]]
:Egrep  [<grep_options>] [<search_pattern> [<file_name(s)>]]
:Regrep [<grep_options>] [<search_pattern> [<file_name(s)>]]
:Agrep  [<grep_options>] [<search_pattern> [<file_name(s)>]]
:Ragrep [<grep_options>] [<search_pattern> [<file_name(s)>]]
:GrepBuffer [<grep_options>] [<search_pattern>]
:Bgrep [<grep_options>] [<search_pattern>]
:GrepArgs [<grep_options>] [<search_pattern>]
```
也可以输入:Grep之后一步一步输入要查找的内容、名字等，会有提示。
## 9.visualmark
这是一个书签，可以将你认为有问题的代码行标记高亮，多个书签键很方便的切换。但退出文件后，标签消失，调试程序时，标注关键代码很有帮助。
```
mm 		设定标签
F2 		正向切换
shift+F2 	反向切换
```
## 10. 补全功能
使用vs等IDE时，补全功能是很方便的，能使编写更加的高效。vim中也有补全功能，ctrl+p就可以补全，但不足以满足我们的要求，要像visual stdio那样补全，需要omnicppcoplete插件，如果你使用java编程，则需要javacomplete插件。

安装方法与之前稍有不同，需要下载omnicppcoplete和javacomplete的zip压缩包，解压到~/.vim文件夹下，然后javacomplete还需要执行如下命令
```
cd ~/.vim/autoload
javac Reflection.java
mv ~/.vim/autoload/Reflection.class ~
```
一切准备就绪，最后就是在.vimrc中添加相应的设置，开启补全功能
```
"-----------------------------------------------------------
"AutoComple
"-----------------------------------------------------------
filetype plugin on                  "开启文件类型识别功能
filetype plugin indent on           "打开文件类型检测, 加了这句才可以用智能补全
set completeopt=longest,menu        "关掉智能补全时的预览窗口
setlocal completefunc=javacomplete#CompleteParamsInfo
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType java set omnifunc=javacomplete#Complete
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
"-----------------------------------------------------------
"OmniCppComplete
"-----------------------------------------------------------
" 按下F4自动补全代码
imap <F4> <C-X><C-O>
" 按下F5根据头文件内关键字补全
imap <F5> <C-X><C-I>
let OmniCpp_MayCompleteDot = 1           " autocomplete with .
let OmniCpp_MayCompleteArrow = 1         " autocomplete with ->
let OmniCpp_MayCompleteScope = 1         " autocomplete with ::
let OmniCpp_SelectFirstItem = 2          " select first item (but don't insert)
let OmniCpp_NamespaceSearch = 2         " search namespaces in this and included file
let OmniCpp_ShowPrototypeInAbbr = 1     " show function prototype in popup window
let OmniCpp_GlobalScopeSearch=1         " enable the global scope search
let OmniCpp_DisplayMode=1               " Class scope completion mode: always show all members
let OmniCpp_ShowScopeInAbbr=1           " show scope in abbreviation and remove the last column
```
现在一切都设置好了，比如编写个a.java，输入Math.然后按`ctrl+x ctrl+o`就可以出现可以补全的选项了，我设置了F4和F5两个快捷键，不同的补全方式和操作如下：
```
Ctrl+P	向前切换成员
Ctrl+N	向后切换成员
Ctrl+E	表示退出下拉窗口, 并退回到原来录入的文字
Ctrl+Y	表示退出下拉窗口, 并接受当前选项

Ctrl+X Ctrl+L 	整行补全
Ctrl+X Ctrl+N	根据当前文件里关键字补全
Ctrl+X Ctrl+K	根据字典补全
Ctrl+X Ctrl+T	根据同义词字典补全
Ctrl+X Ctrl+I	根据头文件内关键字补全
Ctrl+X Ctrl+]	根据标签补全
Ctrl+X Ctrl+F	补全文件名
Ctrl+X Ctrl+D	补全宏定义
Ctrl+X Ctrl+V	补全vim命令
Ctrl+X Ctrl+U	用户自定义补全方式
Ctrl+X Ctrl+S	拼写建议
```
## 11. supertab
Tab键默认是根据之前输入补全，可以通过supertab插件，重定义Tab补全方式.vimrc中添加
```
let g:SuperTabRetainCompletionType=2                                
" 0 - 不记录上次的补全方式
" 1 - 记住上次的补全方式,直到用其他的补全命令改变它
" 2 - 记住上次的补全方式,直到按ESC退出插入模式为止
let g:SuperTabDefaultCompletionType="<C-X><C-O>"       
" 设置按下<Tab>后默认的补全方式, 默认是<C-P>
```
---
这些就是我使用的vim插件的配置过程，有个简单粗暴的方法即可完成上述配置
```
cd ~
git clone https://github.com/812lcl/vim.git
mv vim .vim
mv .vim/vimrc-lcl .vimrc
javac ~/.vim/autoload/Reflection.java
mv ~/.vim/autoload/Reflection.class ~
```

vim本身已经足够强大，这些插件是锦上添花。vim是需要不断的练习的，可以参考
[简明Vim练级攻略](http://coolshell.cn/articles/5426.html)。

这里是我自己整理的一个vim、bash、git的命令操作的查询表格[点击查看](http://pan.baidu.com/s/1rFcMP)

参考文章：

- [手把手教你把Vim改装成一个IDE编程环境](http://blog.csdn.net/wooin/article/details/1858917)

- [经典vim插件功能说明、安装方法和使用方法](http://blog.csdn.net/tge7618291/article/details/4216977)

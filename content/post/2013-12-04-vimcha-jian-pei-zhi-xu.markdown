+++
title = "Vim插件配置续"
date = "2013-12-04"
comments = true
categories = ["Vim"]
tags = ["vim", "linux", "编辑器", "编程环境"]
description = "vim插件配置，包括十几种好用高效的插件"
+++

<!-- toc -->
之前写过一篇[文章](http://812lcl.github.io/blog/2013/10/24/vim插件配置比肩ide/)，介绍了当时用的一些vim插件，不过前些日子[伯乐在线](http://blog.jobbole.com/)上的一篇文章，就又开始了我好几天的折腾，vim的折腾永无止境啊，有些大神配置文件竟然都写到了两千行，插件弄了几十个。我经过这第二阶段的折腾，最终定下来了两种方案，每种都是二十四五个插件的样子，一种是使用了YCM神级补全，另一种是采用clang-complete和neocomplcache补全的方案。YCM虽说是神级补全，但需要编译，而且体积庞大，有时候确实令人望而却步。有关不同的补全方案，我会另写一篇文章介绍，这里重要介绍一些我新增加的一些插件。
<!--more-->

## 1. [pathogen](https://github.com/tpope/vim-pathogen)
首先，我改变了插件的管理方式，以前只用了十个左右的插件，没想去用插件管理插件，但也发现想删除某个插件或使用某个插件时很不方便，最后还是选用了一个管理插件的工具`pathogen`。它可以使所有插件具有独立的目录，互不干扰，想删谁删谁，添加也很简单。安装该插件方法如下
```
cd ~/.vim
git clone git://github.com/tpope/vim-pathogen.git
mkdir bundle
```
然后再`.vimrc`中加入`execute pathogen#infect()`，这样就可以管理插件了。

安装插件
```
# git submodule add 插件GitHub仓库地址 bundle/插件文件夹
git submodule add https://github.com/Lokaltog/vim-easymotion.git bundle/easymotion
```
升级插件
```
cd ~/.vim/bundle/easymotion # 将 easymotion 替换为需要升级的插件名字
git pull origin master
```
升级所有插件
```
cd ~/.vim
git submodule foreach git pull origin master
```
删除插件
```
cd ~/.vim
rm -rf bundle/easymotion
git rm -rf bundle/easymotion
```
如果你将你的`.vim`仓库穿到GitHub上，可以很容易的在其他机器上恢复相同的配置，方法如下：
```
git clone http://github.com/username/dotvim.git ~/.vim
ln -s ~/.vim/vimrc ~/.vimrc
cd ~/.vim
git submodule init
git submodule update
```
如果你的整个`.vim`目录并不作为git仓库，也可以用pathogen管理插件，只需将插件下好，将其作为独立文件夹放入`~/.vim/bundle/`中即可。
## 2. [Easymotion](https://github.com/Lokaltog/vim-easymotion)
在vim原有功能中使用`f<char>`可以定位到一行中的某个字符，如fa可定位到本行光标后的第一个a字母，f2a则定位到第二个。但往往你并不知道要到的是第几个a，这时easymotion就是个很高效方便的插件了。只需敲击<leader><leader>fa，就可以定位光标之后的所有字母a（包括下边行内的a），所有的a都用字母代替，然后输入想跳到位置的字母即可。

<leader><leader>是easymotion默认的引导键，可以自定义，我将其定义为“f”，所以定位时只需按ff<char>即可。easymotion还支持配合w、e、t位置移动操作，可以调到光标之后的第几个词尾、词头等。更改默认引导键只需在`.vimrc`中加入下面这条语句：

`let g:EasyMotion_leader_key = 'f'`

![Easymotion](https://camo.githubusercontent.com/d5f800b9602faaeccc2738c302776a8a11797a0e/68747470733a2f2f662e636c6f75642e6769746875622e636f6d2f6173736574732f333739373036322f323033393335392f61386539333864362d383939662d313165332d383738392d3630303235656138333635362e676966)
## 3. [surround](https://github.com/tpope/vim-surround)
这个插件可以轻松的在单词或句子外增加、删除或替换如括号、引号，甚至HTML标签，功能也十分好用，尤其写HTML时。主要使用就是增加`ys`、删除`ds`、替换`cs`，有不同的扩展，而且在normal、insert和visual模式下都可以操作。例子如下，其中|代表光标位置。
```
Text              	Command     	New Text
---------------   	-------    	 	-----------
"Hello |world" 		cs"' 			'Hello world'
"Hello |world"   	cs"<q>     		<q>Hello world</q>
(123+4|56)/2      	cs)]       		[123+456]/2
(123+4|56)/2      	cs)[       		[ 123+456 ]/2
<div>foo|</div>   	cst<p>     		<p>foo</p>
fo|o!             	csw'       		'foo'!
fo|o!             	csW'       		'foo!'
```
```
Text              	Command      	New Text
---------------   	-------     	-----------
Hello w|orld!     	ysiw)        	Hello (world)!
Hello w|orld!     	csw)         	Hello (world)!
fo|o             	ysiwt<html> 	 <html>foo</html>
foo quu|x baz   	yss"         	"foo quux baz"
foo quu|x baz   	ySS"         	"
                                  	 foo quux baz
                               		"
```
```
Text              	Command      	New Text
---------------   	-------     	-----------
"|hello" 			ds" 			hello
```
在不同的模式下操作有所不同
```
normal模式
ds	删除surrounding
cs	替换surrounding
ys	添加surrounding
yS	添加、换行、缩进
yss	整行添加surrounding
ySs	整行添加换行缩进
```
```
visual模式
s	添加surrounding
S	添加、换行、缩进
```
```
insert模式
<C-s>	添加surrounding
<C-s><C-s>	添加、换行、缩进
```
## 4. [Matchit](https://github.com/vim-scripts/matchit.zip)
%跳转到下一个匹配符号如匹配括号，是 vim 原有功能，添加这个功能后，可以使用%跳转到匹配的HTML标签。

## 5. [Undotree](https://github.com/mbbill/undotree)
可视化撤销，可以看见你所做的改变，可视化的恢复到某一状态。`:UndotreeToggle`打开undo-tree面板，可以映射为其他按键，只需在`.vimrc`中添加

`nmap <silent> <Leader>u :UndotreeToggle<cr>`。

打开的面板中还可以看到每一步修改的前后对比，在面板中按？可获得快捷键帮助。面板效果如下：

![Undotree](https://camo.githubusercontent.com/56430626a5444ea2f0249d71f9288775277c7f5d/68747470733a2f2f73697465732e676f6f676c652e636f6d2f736974652f6d6262696c6c2f756e646f747265655f6e65772e706e67)

当前位置被标记为`>seq<`

下一变化被标记为`{seq}`，可以通过`:redo`或 `<ctrl-r>`跳到下一状态

最近的变化标记为`[seq]`

保存的变化被标记为s，最后被保存的变化被标记为大写S

vim 默认是不保存undo信息的，可以在`.vimrc`中添加语句实现退出编辑的文件，再打开仍可以undo。
```
if has('persistent_undo')
	set undofile
    set undodir=’~/.undo/’
endif
```
## 6. [Tagbar](https://github.com/majutsushi/tagbar)
也是大名鼎鼎，同Taglist差不多，但更适合于C++，可以显示类中的声明、定义等等。`:TagbarToggle`打开Tagbar窗口，映射快捷键

`nmap <silent> <Leader>t :TagbarToggle<cr>`
## 7. [NERDTree](https://github.com/scrooloose/nerdtree)
这个是比系统原代的netrw更好用的file explorer，可以以树形显示文件结构，但和winmanager有冲突，无法像netrw一样和谐地整合到winmanager中。在nerdtree的窗口中按？可显示快捷键操作。

`nmap <silent> <Leader>n :NERDTreeToggle<CR>`映射打开快捷键，根据自己喜欢设定。
## 8. [Nerdcommenter](https://github.com/scrooloose/nerdcommenter)
快速添加注释的插件，使用方法如下：
```
<Leader>cc 		最基本注释
<Leader>cu 		撤销注释
<Leader>cm 		多行注释
<Leader>cs 		性感的注释方式
```
只列出了几个常用的，具体效果你可以自己一试。
## 9. [Ultisnips](https://github.com/SirVer/ultisnips)
需要python的支持，很强大的代码补全插件，大大提高编写代码的速度。可以自己定义模板，在该插件目录下的`UltiSnips`目录中有各种语言的补全模板。默认使用tab键补全，因为与ycm有冲突，重新映射为<C-j>。

`let g:UltiSnipsExpandTrigger = "<c-j>"`

补全比如for循环的语句，可以通过<c-j>切换更该要修改的参数。
## 10. [Syntastic](https://github.com/scrooloose/syntastic)
语法检查的插件，可以查看当前代码的错误，无需等到编译出错后再来修改。
`:Errors`打开错误列表，`:lnext`和`lpre`切换下一个和前一个错误。
在`.vimrc`中添加以下语句，对其进行配置及快捷键映射：
```
let g:syntastic_che_on_open=1
let g:syntastic_auto_jump=1
let g:syntastic_error_symbol = 'e>'
let g:syntastic_warning_symbol = 'w>'
let g:syntastic_always_populate_loc_list=1
let g:syntastic_loc_list_height = 6
let g:syntastic_enable_highlighting = 0
nmap <Leader>e :Errors<cr>
nmap <Leader>c :lnext<cr>
nmap <Leader>z :lpre<cr>
```
![Syntastic](https://raw.github.com/scrooloose/syntastic/master/_assets/screenshot_1.png)
## 11. [Singlecompile](https://github.com/xuhdev/SingleCompile)
自动编译插件，支持多种语言的不同编译器，具体可查看[相关主页](http://www.topbug.net/SingleCompile/)。`:SCCompileRun`编译并运行当前文件，`:SCCompile`仅编译，`:SCViewResult`查看运行结果，就在当前窗口中显示，十分方便。映射快捷键

```
nmap <Leader>g :SCCompileRun<cr><cr><cr>
nmap <Leader>v :SCViewResult<cr>
```
## 12. [Gitgutter](https://github.com/airblade/vim-gitgutter)
![Gitgutter](https://raw.github.com/airblade/vim-gitgutter/master/screenshot.png)

显示当前文件中与git仓库提交的版本的变化，在最左侧以不同符号显示不同状态。可以在`.vimrc`中自己定义
```
let g:gitgutter_enabled = 1
let g:gitgutter_highlight_lines = 0
" let g:gitgutter_sign_added = 'xx'
" let g:gitgutter_sign_modified = 'yy'
" let g:gitgutter_sign_removed = 'zz'
" let g:gitgutter_sign_modified_removed = 'ww'
nmap gh <Plug>GitGutterNextHunk
nmap hg <Plug>GitGutterPrevHunk
```
其中我定义了`gh`跳到下一条变化之处，`hg`跳到上一条。
## 13. [fugitive](https://github.com/tpope/vim-fugitive)
这个插件使你可以在vim中执行git操作。
```
:Gstatus	git status
:Gcommit	git commit
:Gdiff		git diff
:Glog		git log
:Gread		git checkout file
:Gwrite		git add file
:Gmove		git mv
:Gremove	git rm
```
## 14. [CtrlP](https://github.com/kien/ctrlp.vim)
快速查找file、buffer、mru、tag的插件，由<c-p>快捷键呼出而得名，好像是sublime text2中的功能，很好用，有人就写了这么个插件，也确实很好用。

![CtrlP](https://github-camo.global.ssl.fastly.net/0a0b4c0d24a44d381cbad420ecb285abc2aaa4cb/687474703a2f2f692e696d6775722e636f6d2f7949796e722e706e67)

ctrl-p打开搜索框后即可搜索，有以下功能键：
```
<c-f> <c-b>		切换模式
<c-d>			切换按全路径或文件名查找
<c-r>			改变regexp模式
<c-j> <c-k>		下一个/上一个文件
<c-t>			新tab打开文件
<c-v> <c-x>		新split打开文件
<c-n> <c-p>		上一个或下一个查找
<c-y> 			创建新文件和他的父目录
<c-z>			标记文件
<c-o>			打开标记文件
```
可以在`.vimrc`中配置CtrlP显示的位置，显示条目，忽略搜索目录等等,就不一一说明了，可以点击[这里](http://kien.github.io/ctrlp.vim/)查看。
```
我的配置
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_open_multiple_files = 'v'         " <C-Z><C-O>时垂直分屏打开多个文件
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git)$',
  \ 'file': '\v\.(log|jpg|png|jpeg)$',
  \ }
let g:ctrlp_working_path_mode= 'ra'
let g:ctrlp_match_window_bottom= 1
let g:ctrlp_max_height= 10
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1
```
## 15. [unite](https://github.com/Shougo/unite.vim)
和CtrlP功能类似，也可以搜索文件、缓冲区等，我使用这个插件主要是它可以查询当前vim中的所有命令和按键映射等，命令多了，一时记不住可以查查看，很方便。

如果你在Unite窗口进入插入模式，光标将会移到该窗口的最上方，并显示“>”提示符。输入字符会搜索该列表--这里和FuzzyFinder相似。和常规vim一样，按<ESC>键可以退出插入模式回到命令模式，而且可以使用通配符*、|、!。

命令模式和插入模式都有相应的快捷键映射。比如在命令模式下，当光标在一个文件上，按下a，Unite会显示一个可以操作该文件命令的列表。这个命令列表被称为actions，这个列表可以像Unite其他部分一样被搜索和调用。

actions可以组合通配符。如果输入:Unite file, 然后按下*将会标记所有文件，再输入a将会列出所有actions，最后选择above，Unite将会打开所有被标记的文件。

可以映射快捷键调用，根据自己喜好，自行定义

`nnoremap <leader>f :Unite -start-insert file`

![unite](https://s3.amazonaws.com/github-csexton/unite-01.gif)

## 16. [delimitmate](https://github.com/Raimondi/delimitMate)
这个插件有人很讨厌，也有一些人会喜欢，我也还在试用，习惯。它能自动添加和删除匹配的括号、引号。大家选择性安装吧。

OK，先这么多了，准备下一篇文章写一下vim中各种强大的补全。而且提醒一下，vim本身功能已经很强大，虽然各种插件可以帮助你更高效，但不要离了他们就不会使用vim了，也不要太专注于各种插件，写的内容才是最主要的。推荐一篇文章[不要复杂化vim](http://www.kunli.info/2013/08/13/vim/)。

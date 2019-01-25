## bash命令
bash中的可执行命令分别三种：内建命令、系统命令和第三方工具命令。
内建命令是bash（或其它版本）工具集中的命令，一般也会有一个与之同名的系统命令，比如echo和/bin/echo，前者是内建，后者系统命令。
内建命令比系统命令更高的执行效率和优先度。
可以用`type -a [command]`来查看一个命令的属性。

## 快捷键

|按键|描述|
|----|----|
|Ctrl+C|结束当前任务|
|Ctrl+Z|暂停当前任务，并放到后台|
|Ctrl+S|停止屏幕输出|
|Ctrl+Q|恢复屏幕输出|
|Ctrl+L|清屏|
|Ctrl+A|移到行首|
|Ctrl+E|移到行尾end|
|Ctrl+U|删除光标右边所有|
|Ctrl+K|删除光标左边所有|
|Ctrl+N|下一条命令next|
|Ctrl+P|上一条命令pre|
|Ctrl+B|前移一个字符|
|Ctrl+F|后移一个字符|
|Alt+B|前移一个单词backword|
|Alt+F|后移一个单词forword|
鼠标左键拖拽选择，鼠标中键粘贴

## 变量
直接赋值和引用方式：
```
a="hello"
echo $a
```
利用系统命令给变量赋值：
```
echo $(pwd)
echo `pwd`   # 两者结果相同
```
## IO
### 标准IO
输出用`echo`，自带换行，参数`-n`可以不换行：
```
a="world"
echo "hello $a"    # hello world
echo -n $a         #world%
```
输入用`read`，参数`-p`可以指明提示字符串：
```
> read a b 
> 1 2
> echo $a
> 1
```
```
> read -p "input a number assign to a:" a
> hello
> echo $a
> hello
```
### 重定向
`>,<,>>,<<`
```
man ls > test.txt
:>test.txt  清空文件
| 批处理命令连接
; 串联
&& 前面成功则执行后面
|| 前面失败则执行后面
```
ps -A | grep python
```
## 数学运算
### $[]
```
a=1
b=2
echo $[1+2]      #3
echo $[a+b]      #3
echo $[$a+$b]    #3
```
### $(())
```
echo $((1+2))    #3
echo $((a+b))    #3
echo $(($a+$b))  #3
```
### expr `` 表达式计算工具
```
> expr 1 + 3     # 注意+两边有空格
> 4
> expr $a + $b
> 3
```

## 流程控制
一般不加分号，但是当多个语句写在一行时要加
### test，和 [ ] 相同，注意中括号和里面的语句之间有空格
```
test 1 = 1 || echo no     #（无），注意=两边有空格
test 1 = 2 || echo no     # no
[ 1 = 1 ] || echo no
[ 1 = 2 ] || echo no      # no
```
整数
| 选项 |  描述  |英文全称
|:------:|:------:|:------:
|-eq     |等于    |**equal**
| -gt    |大于    |**greater than**
|-lt     |小于    |**less than**
| -ne    |不等于  |**not equal**
| -ge    |大于等于|**greater or equal**
| -le    |小于等于|**less or equal**
字符串
|用法|描述|
|:--:|----|
|test str1 = str2|测试是否相等|
|test str1 != str2|测试是否不等|
|test str1 \\< str2|字典序str1是否在str2之后|
|test str1 \\> str2|字典序str1是否在str2之前|
|test str1|如果不为空返回1|
|test -n str1|如果不为空返回1|
|test -z str1|如果是空串，返回1|
文件
|选项|描述|
|:--:|----|
|d|是否为目录|
|f|是否为普通文件|
|x|是否有执行权限|
|r|是否有读权限|
|w|是否写读权限|
|e|是否存在|
|s|大小是否为0|
|c|是否为字符设备文件|
|b|是否为块设备文件|
|L|是否为符号链接|

逻辑操作
* -a 逻辑与
* -o 逻辑或
* !  逻辑非

### if ... ；then ... ；fi  （elif）
```
a=1
b=2
if test $a -lt $b
then
    echo "a<b"
else
    echo "a>=b"
fi
```
### case ... in ... ；esac
 ```
 a=1
case $a in 
    1) echo "yes";;
    2) echo "no"
esac
```
### while ...； do ... ；done
```
S=0
i=1
while [ $i -le 100 ]
do
    let sum+=$i
    let i++       #借助let实现自增...
done
echo $S
```
```
死循环
while :
do...
done
```
### for ... in ...; do ...; done
基本格式为
```
for 变量 in 取值列表
do
    操作
done
```
```
for i in 'Tom' 'Jerry' 'Pony'
do
    echo I am $i
done
#输出：
I am Tom
I am Jerry
I am Pony
```
```
S=0
for i in {1..100..2}
do
    let S+=$i     #此处必须用 S ，不能用 $S!!!why？？？
done
echo $S
```
### C式for循环
```
S=0
for ((i=1;i<=100;i=i+2))
do
    let S+=$i
done
echo $S
```

## 函数
基本格式：
```
function 函数名()
{
    ...;
    [return ...;]
}
```
调用：
functionname         #不加空格，直接函数名

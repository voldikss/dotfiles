# 学会使用命令帮助

```
man -k + [some keyword]
man + [command]
info + [command]
whatis + [command]
which + [command]
where + [command]
whereis + [command]
```

# 文件及目录管理

## 查找目录及文件：find/locate

`find ./ | wc -l`  查看当前目录下的文件个数（find ./ 输出当前目录下的所有文件，wc -l 统计行数）

`find ./ -name 'exam.md'` == `find ./ | grep 'exam.md'(实时查找）

`locate [string]`(数据库查找，需要`udpatedb`经常更新）

## 查看文件内容：cat/vim/head/tail/more/diff
`more` 按页显示
`la | more`

`head` 前几页
`head -10 .bashrc`

`tail` 后几页
`tail -5 .bashrc`
`tail -f test.log` 动态显示文本信息

## 查找文件内容：egrep
`egrep 'string' test.txt

## 文本处理 

## 磁盘管理

`df -h`

`du -sh` 查看当前目录所占空间

`tar -cvf` 打包

`tar -xvf` 解包

`gzip zip...` 压缩

`gunzip unzip bzip...`

## 进程管理工具

查询正在运行的进程
`ps -ef`

## 性能监控

## 网络工具

netstat

host

scp

## 用户管理工具

添加用户

`useradd -m username`
`passwd username`

删除用户

`userdel -r username`(加r为了一并删除目录

用户的组

`groups`

`usermod`

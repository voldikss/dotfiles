# Find

## 基本格式
`find [path] [option] [action]`

## 正则查找
`find . -regex ".*\(\.txt|\.pdf\)$"`

## 忽略大小写的正则
`find . -iregex`

## 否定查找
`find . ! -name "*.txt"`

## 查找并打印,其实不加print也会在终端打印出来

`find . ! -name "*.txt"`

## 指定搜索深度
`find . -maxdepth 1 `

## 指定类型：f文件/l符号连接/d目录
`find . -type d`

## 按时间搜索：单位是天，如果分钟则变为amin/mmin/cmin
atime 访问时间
mtime 修改时间
ctime 变化时间

`find . -atime 3 -type f`  最近第3天被访问过的文件
`find . -atime -3 -type f`  最近3天内被访问过的文件
`find . -atime +3 -type f`  最近3天前被访问过的文件

## 按大小搜索：k/G/M
`find . -size +2k`

## 按权限搜索：
`find . -type f -perm 777 `

## 按用户搜索：
`find . -user clouduan`

# 后续动作

## 删除
`find . -name "test.txt" -delete

## 执行命令
### 变更所有者
`find . -user root -exec chown clouduan {} \;`

### 拷贝
`find . -type f -mtime +10 -exec cp {} old_file \;`

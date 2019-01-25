

## 基本模式

`grep [parameter] [match_pattern] [query_scope]`

## 参数
-o 只输出匹配的文本行

-n 打印匹配的行号

-R 递归搜索

`grep -R -n ".class" .`

-i 忽略大小写

-l 只打印文件名

-e 匹配多个模式

`grep -e "string1" -e "string2" file`

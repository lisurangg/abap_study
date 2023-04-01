
*数字类型c为字符串类型，可输入汉字，符号。
*但是初始长度为space，需自行定义长度。
*write输出，如果要输出未被定义的数则需加'引号'，如果后面再带其他数，可在引号后面用逗号隔开。


data: stu_name  type c length 10."定义stu_name的数据类型为char，且长度为10个字符。
data: stu_id    type c length 20.  
data: stu_class type c length 20.

stu_name   = '于兰兰'.            "等于号后得加'引号'.
stu_id     = '20412130120'.
stu_class  = '国际经济与贸易'.

write:/'姓名:',stu_name.          "/为提行。
write:/'学号:',stu_id.
write:/'专业:',stu_class.
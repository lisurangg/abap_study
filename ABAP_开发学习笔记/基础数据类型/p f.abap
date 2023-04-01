
*abap数据类型 p 和 f。


*p数据类型为定点小数，如果没有通过decimals设定小数位数，则和i相同，可变长度为16。
*通过length来设定整数位长度，通过decimals来设定小数位数。
*如果超出设定位数则系统报错，不能运行。
*用斜杠提行需在斜杠后加,再加要输出的数。

data: num1 type p decimals 2."定义num1的数据类型为p，小数为两位。
num1 = '22.2'.                            "定义num1=22.2。
write:num1.                               "输出结果为'       22.20'。

data: num2 type p length 3 DECIMALS 1.    "定义num2的数据类型为p，小数为两位。
num2 = '222.2'.                           "定义num2=222.2。
write:/,num2.                             "输出结果为'222.2'



data: num3 type f.
num3 = '100.568'.
write:/,num3.
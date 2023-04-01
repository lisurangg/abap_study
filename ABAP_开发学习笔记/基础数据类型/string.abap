
*数据类型string为字符串类型（长度可变）



data: num1 type string.
num1 = '联系中'.
write: num1.                                                  "输出结果为'联系中'。

concatenate 'lion' 'hello' into num1.
write:/,num1.                                                 "输出结果为'lionhello'。

concatenate 'lion' 'hello' into num1 separated by '.....'.    "concatenate 'a' 'b' into c.将a与b链接到c中，
                                                              "concatenate 'a' 'b' into c separted by 'd'.将a与b通过'd'链接起来。
write:/,num1.                                                 "输出结果为'lion.....hello'.
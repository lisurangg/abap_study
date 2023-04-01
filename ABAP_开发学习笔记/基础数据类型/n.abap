
*数据类型n为数字文本。



data: num1 type n.               
num1 = '123'.
write:num1.                      "输出结果为'3'，长度不够时从右开始截取。

data: num2 type n length 4.
num2 = '123'.
write:/,num2.                    "输出结果为'0123'，当长度超出时，输出结果前会有0。

data: num3 type n length 3.
num3 = '999'.
num3 = num3 + 1.                 "此处+1未将1用引号引用，同样能识别。
write:/,num3.                    "输出结果为'000'。

data: num4 type n length 4.
num4 = '999'.
num4 = num4 + '1'.               "此处+1时将1用'1'来引用，效果同上。
write:/,num4.                    "输出结果为'1000'。

" 在子程序中使用的参数叫‘虚参’。perform利用using、chaing定义参数，且使用时要与子程序顺序一致，且参数可以使用abap的所有对象。
" 传递参数的方法。子程序用using和Charing语句传递参数。

" Call by value  是指使用using关键字传递参数时与value语句一起搭配使用
" FORM subr USING  ..VALUE(pi)[TYPE<t>|LIKE<f>].
" VALUE语句中虚参占用自己的单独内存。调用子程序是，实参值复制到虚参中，即使改变虚参值也不会影响实参值。
data:gv_val type c length 20 value'Call by value test'.
perform call_byvalue using gv_val.
form call_byvalue using value(p_val).                           "此处使用的p_val变量是局部变量（Local），且p_val是自己定义，可更改。
write p_val.
endform.

write gv_val.                                                    "此处再输出gv_val时显示statement is not accessible 语句不可访问。


" Call by Reference是指使用changing关键字传递参数时的情况，此时此时会修改传递到子程序的参数值。
" FORM subr CHANGING...  pi[TYPE<t>|LIKE<f>].
" 子参数没有自己的内存空间，只是在调用子程序期间占用实参的地址。即在调用subroutine的程序的内存地址（相同名字的变量）中进行工作。
data:gv_val1 type c length 30 value 'call by value test'.
write / gv_val1.                                                  "输出定义变量gv_val时指定的值。
perform call_byvref changing gv_val1.
write / gv_val1.                                                  "输出在调用佛尔吗语句后被修改的值。他们变量名相同。
form call_byvref changing p_val1.
    p_val1 = 'Value is changed'.
endform.

data:gv_val1 type c length 30 value 'call by value test'.
write / gv_val1.
perform call_byvref changing gv_val1.
form call_byvref changing p_val1.
    p_val1 = 'Value is changed'.
    write / gv_val1.                                          "此处吧write / gv_val1下移到form与endform之间同using一样时，并未报错。
endform.


" Call by Value and Result，介绍使用changing语句传递参数时与value语句搭配使用的情况。
" FORM subr CHANGING..VALUE(pi)[TYPE<t>|LIKE<f>].
" USING语句与VALUE语句一起搭配使用，则无法修改子程序中的实参值，但是CHANGING语句与VALUE语句一起配套使用时，当正常结束子程序时会修改实参值。
" !!!!此程序报错不能识别gv_sum！！！！！！！！！
data:gv_val2 type i value 2,
     gv_val3 type i value 3,
     gv_val4 type i.

perform sum_data using gv_val2 gv_val3 changing gv_sum.
write:/ 'Result is:',gv_sum.
form sum_data using value(p_val2)
                         (p_val3)
                changing value(p_sum).
p_sum = p_va2 + p_val3.
endform.
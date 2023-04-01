
" FORM语句内的虚参可以利用type与like语句定义所有abap数据类型。若不指定类型，则被定义为Generic类型，会继承实参的技术属性。此时实参应为可以用于数型转换的数据类型。
data:gv_val type c.
perform call_byvref changing gv_val.
form call_byvref changing p_val type i.
    p_val = 'value is changed'.
endform.
" 报错！！！！因为在perform中传递类型c的变量gv_val，而在form语句内指定参数类型位i，则会发生语法错误。
" 在perform中指定了什么参数在form也要指定相同的类型变量。

data:gv_val type d.
perform subr changing gv_val.
" 如上面语句，若传递了类型d的参数，则虚参的定义方法有下列三种方式。
" form surb changing p_val.使用Generic Type
" form subr changing p_val type d.使用与实参相同的数据类型
" form subr changing p_val like gv_val.使用与实参相同的数据类型
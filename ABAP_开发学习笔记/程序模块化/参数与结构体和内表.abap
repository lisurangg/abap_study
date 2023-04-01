
" 虚参可以使用所有abap数据类型，结构体也不例外
" 当结构体作为参数使用时，不仅能使用type、like语句定义，还可以使用structure语句定义结构体类型
" form subr using p_str structure str...
" form subr using p_str type str...
" form subr using like structure str...

data:begin of gs_str,
    col1 value 'a',
    col2 value 'b',
    end of gs_str.

perform write_data using gs_str.

form write_data using ps_str structure gs_str.
    write:ps_str-col1,ps_str-col2.
endform.



" 当子程序作为内表时也可以使用关键字using、changing。
" form subr changing ... <itab>[type<t>|like<f>]..

types:begin of t_str,
    col1 type c,
    col2 type i,
      end of t_str.

types:t_itab  type table of t_str.
data gs_str  type t_str.
data gt_itab type t_itab.

gs_str-col1 = 'b'.
gs_str-col2 = '2'.
append gs_str to gt_itab.

perform test_itab using gt_itab.

form test_itab using pt_itab type t_itab.

read table  pt_itab with key col1 = 'b' into gs_str.
if sy-subrc eq 0.
write:gs_str-col1,gs_str-col2.
ENDIF.
endform.




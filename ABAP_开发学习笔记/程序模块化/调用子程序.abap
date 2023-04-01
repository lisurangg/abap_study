
" 调用子程序的方法有intemal、extemal两种。通过perform语句不经能调用abap程序内部子程序，还可以调用其他程序的子程序。
" 调用内部子程序。
*&---------------------------------------------------------------------*
*& Report ZDEMO1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZDEMO1.

data:gv_val1(10) type c value 'enjoy',
     gv_val2(10) type c value 'abap',
     gv_val3(20) type c.

perform concate_string using gv_val1 gv_val2                         "调用了子程序
                          changing gv_val3.

form concate_string using value(p_val1) value(p_val2)  changing value(p_val3).   

CONCATENATE p_val1 p_val2 into p_val3 SEPARATED BY space.

perform write_data using p_val3.

endform .

form write_data using value(p_val).
  write:/ p_val.
  ENDFORM.



*abap语言可以调用其他程序的子程序，要利用if found语句检查是否存在该子程序。
 data:gv_first    type c value 'extermal',
      gv_second   type c value 'call',
      gv_result   type c.

perform concate_string(ZDEMO1) if found using gv_first gv_second changing gv_result.


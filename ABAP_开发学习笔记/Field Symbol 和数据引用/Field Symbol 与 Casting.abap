*当分配数据对象到 Field Symbol中时，利用Casting可以将所有类型的数据对象分配到 Field Symbol中
*隐式型变化（Implicit Casting）
*Field Symbol的数据类型定义为Full Type或者定义为基本数据类型 c,n,p,x,时，使用隐式型变化，
*即指定的 Field Symbol与数据对象类型不同时要使用CASTING语句分配值。

*---------------------------------------------------------------------*
*& Report ZDEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdemo.


TYPES:BEGIN OF gs_str,
        col1 TYPE char5,
        col2 TYPE char10,
        col3 TYPE char15,
      END OF gs_str.

DATA gv_addr(31) TYPE c VALUE 'china beijing twin building1'.

FIELD-SYMBOLS:<sf> TYPE gs_str.

ASSIGN gv_addr TO <sf> CASTING.

WRITE:<sf>-col1,<sf>-col2.                            "输出值为gv_addr，根据原结构的长度来输出，原结构有多长字符就输出多少。    
                                                       "如果结构数据类型与 FIeld Symbol的数据类型不同则会乱码或不输出



*显式变化，如果将上述改为
" field-symbols:<sf> type any  时会报错，
" 需要明确指定类型后使用assign语句
" assign addr to <sf> casting type line.
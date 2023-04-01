
*报表程序大致可分为如下所示三种结构。
*1、数据定义部分和查询选择画面 （ selection-screen ）
*2、直到运行时刻的触发事件
*3、显示数据的列表事件

*程序及数据定义
REPORT pgm_id
table:sflight.
data:1_carrid type sflight-carrid.
*SELECTION SCREEN
select-options:sel_carr for sflight-carrid.
prameters:p_carrd like sflight-carrid.

*事件
initialization.
at selection-screen."(output,on value request.)
start-of-selection.
*(select*from~或者 get<table>...)
end-of-selection.

*报表程序时间流程
top-of-page.
end-of-page.
at line-selection.
at pf<nn>.
at user-command.




*定义程序语句
" 定义程序的语句中存在report<程序名>基本结构的附加选项。
*1、指定程序 LIST Heading
" 决定在执行程序的报表画面上是否以程序名作为基本标题。
report z12_02 no standard page Heading.
write 'List Heading Test'.

*List-Size
" 指定输出报表的宽度。宽度设置成0或者删除Line-Size语句，则会使用标准宽度。
report z12_03 line-size 30.
write 'Line Size Test'.

*Message ID
" 定义abap程序中要使用的MESSAGE ID.
report z12_04 message-id <message-id>.





*DATA定义
" 定义程序中要使用的表及数据。复杂的程序一般包含与 include（程序名）top中。
report pgm_id
include pgm_idtop.
*tables:sflight.
*data:1_carrid type sflight-carrid.






*选择画面
" 选择画面提供如 input字段可以与用户相互作用的画面，在报表程序中选择画面最好包含在include程序名sel（或者top）中。选择画面不需要程序员定义，就会自动生成选择画面和逻辑。
select-options:sel_carr for sflight-carrid.
parameters:p_carr like sflight-carrid.
selection-screen begin of block bl1
with frame title text-010
selection-screen end of block bl1.

*1、parameters
" parameters 定义用户可以输入值的输入字段。用下面语句定义量。selection-screen不支持 data type f，因此此类型不能定义成参数。
" parameters <p> [(<length>)] <type> [<decimals>].
*---------------------------------------------------------------------*
*& Report ZDEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z12_01.
DATA:1_fname(20) TYPE c.
PARAMETERS:p1      DEFAULT 'a',
           p2      TYPE char10,
           p3      TYPE c LENGTH 3 DEFAULT '123',
           p4      TYPE p DECIMALS 2 DEFAULT '123.456789',
           p5      LIKE sflight-carrid,
           p6      MEMORY ID scl,
           p7      MATCHCODE OBJECT zcarrid,
           p8      MODIF ID mid,
           p9      NO-DISPLAY,
           p10     DEFAULT 'a'  LOWER CASE,
           p11     OBLIGATORY,
           p12     AS CHECKBOX,
           p13     RADIOBUTTON GROUP radi,
           p13_2   RADIOBUTTON GROUP radi,
           p14(10) VISIBLE LENGTH 3 DEFAULT '1234567890',
           p15     LIKE sflight-carrid VALUE CHECK,
           p16     LIKE (1_fname),
           p17     LIKE sflight-carrid AS LISTBOX VISIBLE LENGTH 3,
           p18     AS CHECKBOX USER-COMMAND abc.


*2、SELECT-OPTIONS是只能接收一个值的input字段，与之相反，SELECT-OPTIONS可以通过两个INPUT字段接受多种条件值。
" SELECT-OPTIONS始终要与FOR语句并行使用，此时FOR语句后面的值只能是以TABLES语句定义的表字段名或者是以DATA语句定义的变量。
" SELECT-OPTIONS <seltab> FOR <f>.
" SELECT-OPYIONS中可以输入Multiple Selection输入弹出窗口。在这里可以输入多个或者范围值。以这种方法构成SELECTION TABLE用在OPEN SQL的 WHERE条件中。
" SELECT*FROM SPFLI WHERE CARRID IN <seltab>.

tables:sflight.
data:gs_scarr type scarr.
data:gv_val   type char20.
select-options:s1 for sflight-carrid DEFAULT 'ac',
               s2 for gs_scarr-carrid DEFAULT 'aa*' option eq sign i.
               s3 for gv_val DEFAULT '111' to '999',
               s4 for gv_val DEFAULT 'zzz' to 'zzz' opyion bt sign.
               

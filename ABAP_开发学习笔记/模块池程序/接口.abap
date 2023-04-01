*接口的定义与实现（接口Interfaces）
*1、定义接口的语法格式
" INTERFACE intf.
"   DATA ...
"   CLASS-DATA ...
"   METHOD ...
"   ...
" EDNINTERFACE.
*在接口定义内部可以声明的成员与类中的成员相同

*2、实现接口
*接口没有自己的实例，因而不需要进行方法实现，其中方法的实现要通过具体的类进行
" CLASS class DEFINITION.
"   PUBLIC SECTION.
"     ...
"     INTERFACE: int1,int2.
"   ...
" ENDCLASS.
*在类定义中，接口的实现只能出现在共有部分，接口中定义的所有组件都将被添加为该类的公有成员。
*接口intf的成员在类内部实现过程中以名称intf~icomp的形式出现。在类的实现部分，必须包含所有的接口方法实现。
"CLASS class IMPLEMENTATION.
"    ...
"    METHOD intf1~imeth1.
"        ...
"    ENDMETHOD.
"    ...
"    METHOD intf2~imeth2.
"        ...
"    ENDMETHOD.
"   ...
"ENDCLASS.


*&---------------------------------------------------------------------*
*& Report ZDEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdemo.

*-----------------------------------------------------------------------*
*defining interface
INTERFACE status.     "定义接口
  METHODS write.      
ENDINTERFACE.

*-----------------------------------------------------------------------*
*class counter definition
CLASS counter DEFINITION.    "声明类counter
  PUBLIC SECTION.
    INTERFACES status.       "实现接口status在类counter中
    " 注意在类中实现接口时语法为interfaces，要加 's'!!!
    DATA count TYPE i.
    METHODS: incerment.      "声明counter中方法incerment
ENDCLASS.

*-----------------------------------------------------------------------*
*class counter implementation
CLASS counter IMPLEMENTATION.   "定义类counter中方法
  METHOD incerment.
    ADD 1 TO count.
  ENDMETHOD.
  METHOD status~write.          "定义status接口在counter类中的方法write
    WRITE: / 'count in counter :', count.
  ENDMETHOD.
ENDCLASS.

*-----------------------------------------------------------------------*
*class bicycle definition
CLASS bicycle DEFINITION.      "声明类 bicycle
  PUBLIC SECTION.
    INTERFACES status.         "实现接口status在类bicycle中
    DATA speed TYPE i.
    METHODS: drive.
ENDCLASS.

*-----------------------------------------------------------------------*
*class bicycle implementation
CLASS bicycle IMPLEMENTATION.    "定义类 bicycle中方法
  METHOD: drive.
    ADD 10 TO speed.
  ENDMETHOD.
  METHOD: status~write.          "定义status接口在bicycle类中的方法write
    WRITE: / 'speed of bicycle: ', speed.
  ENDMETHOD.
ENDCLASS.

DATA: count        TYPE REF TO counter,
      bike         TYPE REF TO bicycle,
      status       TYPE REF TO status,
      status_table TYPE TABLE OF REF TO status.

*-----------------------------------------------------------------------*
*start-of-selection
START-OF-SELECTION.
  CREATE OBJECT:count,bike.
  DO 5 TIMES.
    CALL METHOD: count->incerment,
                 bike->drive.
  ENDDO.
  APPEND count TO status_table.
  APPEND bike TO status_table.
  LOOP AT status_table INTO status.
    CALL METHOD status->write.     "调用status接口中的方法write
  ENDLOOP.
*输出 （count in counter： 5）（speed of bicycle： 50）
*此例中接口status的方法在两个类中的定义是输出两个类中各自的方法的值
*该例中包含两个完全无关的类bike和count，但实现了相同的接口status，
*因而都包含同样的方法write，该方法是在接口中定义的



*接口引用
*接口引用变量的定义与对象引用相似，通过TYPES 或DATA语句中的TYPE FER TO 选项进行：
" TYPES|DATA iref TYPE REF TO intf.
*其中intf是全局或程序中已经定义的接口
*通过成员访问运算符 '->'(iref->icomp)，接口引用可以访问当前访问指向对象的接口中的可见成员
*1、通过接口引用访问对象
*要访问一个对象，必须先声明一个基于该类的引用变量，如果该类为一个接口的实现，
* 
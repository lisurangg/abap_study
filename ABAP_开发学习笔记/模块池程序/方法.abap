*1、参数的定义和传递
*类方法的参数接口部分是在类声明部分通过METHOSDS语句定义，而且该接口不需要在类的实现部分再次出现。
" IMPORTING 指定一或多个传出参数
" EXPORTING 指定一或多个传入参数
" CHANGING  指定一或多个输入输出参数
" VALUE     指定参数传递形式，有值传递和引用传递两种形式
" TYPE      指定参数类型，每一个参数都必须有指定类型，与子程序指定参数类型相同
" OPTIONAL和DEFAULT 以定义的输入参数必须在调用时进行传递

*2、调用方法
*&---------------------------------------------------------------------*
*& Report ZDEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdemo.

CLASS vechicle DEFINITION.
  PUBLIC SECTION.
    METHODS: accelerate IMPORTING rate TYPE i,    "指定输入IMPORTING
      show_speed.
  PRIVATE SECTION.
    DATA speed TYPE i.
ENDCLASS.

*-----------------------------------------------------------------------*
*class vechicle implementation
*-----------------------------------------------------------------------*
CLASS vechicle IMPLEMENTATION.
  METHOD accelerate.
    speed = speed + rate.
  ENDMETHOD.
  METHOD show_speed.
    WRITE: / 'Speed:', speed.
  ENDMETHOD.
ENDCLASS.

DATA o_vechicle TYPE REF TO vechicle.

*-----------------------------------------------------------------------*
*start-of-selection
*-----------------------------------------------------------------------*
START-OF-SELECTION.
  CREATE OBJECT o_vechicle.
  CALL METHOD o_vechicle->accelerate EXPORTING rate = 2.   "指定输出EXPORTING
  CALL METHOD o_vechicle->accelerate EXPORTING rate = 2.
  CALL METHOD o_vechicle->show_speed.
*输出4.


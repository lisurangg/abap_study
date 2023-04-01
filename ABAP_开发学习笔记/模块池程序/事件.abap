*声明事件
" EVENTS|CLASS-EVENTS evt
    " EXPORTING ...VALUE(e1) TYPE type [optional]...

*触发事件
" RAISE EVENT eve EXPORTING ... e1 = f1...

*声明事件处理方法
" METHODS|CLASS-METHODS
    " meth FOR EVENT evt OF cif IMPORTING...e1...

*注册事件处理方法
" SET HANDLER ...h1 ...[FOR]...
*该语句将处理方法和相关的触发方法进行链接，语法和使用效果部分地取决与事件的类型，
*定义在类中的实例事件
*定义在接口中的实例事件
*定义在类中的静态事件
*定义在接口中的静态事件


*&---------------------------------------------------------------------*
*& Report ZDEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdemo.

*----------------------------------------------------------------------*
*class vechicle definition
CLASS vechicle DEFINITION INHERITING FROM object.          "声明基类 vechicle
  PUBLIC SECTION.
    EVENTS: too_fast.            "声明事件too_fast
    METHODS: accelerate,         "声明方法
      show_speed.
  PROTECTED SECTION.
    DATA speed TYPE i.           "定义属性
ENDCLASS.

*----------------------------------------------------------------------*
*class vechicle implementation
CLASS vechicle IMPLEMENTATION.     "定义基类vechicle
  METHOD accelerate.               "定义方法 accelerate
    speed = speed + 1.
    IF speed > 5.
      RAISE EVENT too_fast.        "设定条件 '如果speed大于5则触发事件too_fast'
      speed = 5.
    ENDIF.
  ENDMETHOD.
  METHOD show_speed.               "定义方法show_speed
    WRITE: / 'Speed: ', speed.
  ENDMETHOD.
ENDCLASS.

*----------------------------------------------------------------------*
*class handler definition.
CLASS handler DEFINITION.          "声明类handler
  PUBLIC SECTION.
    METHODS handle_excess FOR EVENT too_fast OF vechicle.   "声明事件too_fast的处理方法
*事件需要通过方法捕获事件并进行处理，同时也可为自身事件进行处理
ENDCLASS.

*----------------------------------------------------------------------*
*class hander implementation
CLASS handler IMPLEMENTATION.      "定义类handler
  METHOD handle_excess.            "定义事件too_fast触发之后的处理方法
    WRITE: / 'Speed can not be too fast.'.
  ENDMETHOD.
ENDCLASS.

DATA: o_vechicle TYPE REF TO vechicle,
      o_handler  TYPE REF TO handler.

*----------------------------------------------------------------------*
*start-of-selection
START-OF-SELECTION.
  CREATE OBJECT: o_vechicle, o_handler.
  SET HANDLER o_handler->handle_excess FOR ALL INSTANCES.    "为事件too_fast注册方法
*要使事件处理方法能对事件进行响应，必须在运行是为相关事件注册方法
*此处使用 'SET HANDLER ... h1 ... FOR ALL INSTANCES'语句使用 FOR ALL INSTACES附加项为处理器注册所有可以触发该事件的实例
  DO 11 TIMES.
    CALL METHOD o_vechicle->accelerate.
    CALL METHOD o_vechicle->show_speed.
" 输出结果：
" speed:  1
" speed:  2
" speed:  3
" speed:  4
" speed:  5
" speed can not be too fast.
" speed:  5
" speed can not be too fast.
" ...
" ...
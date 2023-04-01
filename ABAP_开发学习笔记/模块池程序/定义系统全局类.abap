
" DATA o_vehicle TYPE REF TO vehicle.
" CREATE OBJECT o_vehicle.
*该数据对象的类型定义为“指向一个类vehicle的对象指针
*TYPE REF TO 与 TYPE用法一致，可以用于指定任何当前可用的类
*包括程序中定义的局部类和ABAP全局类

*&---------------------------------------------------------------------*
*& Report ZDEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdemo.

DATA: o_vehicle TYPE REF TO z_cl_vehicle.

START-OF-SELECTION.
  CREATE OBJECT o_vehicle.    "创建对象 o_vehicle
  DO 5 TIMES.
    CALL METHOD o_vehicle->accelerate.  
  ENDDO.
  CALL METHOD o_vehicle->show_speed.
*输出结果为Speed： 5


*ABAP类定义之后，并没有实现任何功能，类似于数据类型的定义，
*实际应用则必须通过类的实例--对象来实现。
" 1）定义类的申明与实现方法；
" 2）使用 DATA语句中的 TYPE REF TO 选项参照类类型声明引用变量；
" 3）使用 CREATE OBJECT语句创建对象；
" 4）通过 '->'或 '=>'运算符访问对象或组件。

*1、对象创建与引用
" DATA o_vehicle TYPE REF TO vehicle.
" CREATE OBJECT o_vehicle.
*该数据对象的类型定义为“指向一个类vehicle的对象指针
*TYPE REF TO 与 TYPE用法一致，可以用于指定任何当前可用的类
*包括程序中定义的局部类和ABAP全局类

*2、访问对象组件
*对象创建后，可以通过指向它的指针（引用变量）对其进行操作。
*可以使用的对象组件一般为当前可见的属性和方法，通过引用变量后接运算符“->”访问对象组件
" oref->comp
*其中，oref代表引用类型变量，comp代表要访问的类成员， '->'为对象组件选择运算符，
*可以用于访问类中的实例组件和静态组件。
*静态组件还可不通过实例和引用变量进行，而是通过类名称本身本身使用类成员选择运算符 '=>'直接对类进行操作
" class=>comp

*&---------------------------------------------------------------------*
*& Report ZDEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdemo.

*-----------------------------------------------------------------------*
*class vechicle definition
*-----------------------------------------------------------------------*
CLASS vechicle DEFINITION.
  PUBLIC SECTION.
    DATA speed TYPE i.
    METHODS: accelerate,
      show_speed.
ENDCLASS.

*-----------------------------------------------------------------------*
*class vechicle implementation
*-----------------------------------------------------------------------*
CLASS vechicle IMPLEMENTATION.
  METHOD accelerate.
    speed = speed + 1.
  ENDMETHOD.
  METHOD show_speed.
    WRITE: / 'Speed:', speed.
  ENDMETHOD.
ENDCLASS.

DATA o_vehicle TYPE REF TO vechicle.

*-----------------------------------------------------------------------*
*start-of-selection
*-----------------------------------------------------------------------*
START-OF-SELECTION.
  CREATE OBJECT o_vehicle.
  DO 5 TIMES.
    CALL METHOD o_vehicle->accelerate.
  ENDDO.
  CALL METHOD o_vehicle->show_speed.

*-----------------------------------------------------------------------*
*释放内存
*-----------------------------------------------------------------------*
delete object o_vehicle.
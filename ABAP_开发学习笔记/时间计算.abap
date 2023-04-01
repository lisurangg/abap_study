
*&---------------------------------------------------------------------*
*& Report ZDEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdemo.

PARAMETERS:initial TYPE d.

DATA endda1 TYPE d.
endda1 = sy-datum.

TYPE-POOLS:p99sg.
DATA: days   TYPE i,
      weeks  TYPE i,
      months TYPE i,
      years  TYPE i.

DATA: month_tab TYPE STANDARD TABLE OF p99sg_month_tab_row.

CALL FUNCTION 'HR_99S_INTERVAL_BETWEEN_DATES'
  EXPORTING
    begda     = initial
    endda     = endda1
  IMPORTING
    days      = days
    c_weeks   = weeks
    c_months  = months
    c_years   = years
    month_tab = month_tab.

WRITE:/ days,weeks,months,years.
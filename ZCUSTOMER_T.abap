* Sistemdeki müşterileri görüntüleyen ve yeni müşteriler yaratan program yazılacak.
* Reuse ALV tipi kullanılacak.
* GUI status içerisinde müşteri yarat butonu kullanılacak. Popup bilgiler alınacak ve database kayıt atılacak.
* Aynı isme sahip müşteri yaratıldığında hata verilecek.
* Müşteri numarasını yaratmada number range kullanılacak.

* Oluşturduğum tablodaki alanlar:
*ZCUSTOMER_T
*KUNNR
*NAME
*SURNAME
*PHONE
*MAX_CARS
*-----------------------------------------------------------------------------------------------------------------

DATA: lt_customer TYPE TABLE OF zcustomer_t.
DATA: ls_layout TYPE slis_layout_alv.
DATA: lt_fieldcat TYPE slis_t_fieldcat_alv.

DATA: BEGIN OF gs_0100,
        kunnr    LIKE zcustomer_t-kunnr,
        name     LIKE zcustomer_t-name,
        surname  LIKE zcustomer_t-surname,
        phone    LIKE zcustomer_t-phone,
        max_cars LIKE zcustomer_t-max_cars,
      END OF gs_0100.




START-OF-SELECTION.
  PERFORM data_selection.
  PERFORM build_layout.
  PERFORM build_fieldcatalog.
  PERFORM display_alv.

*&———————————————————————
*& Form DATA_SELECTION
*&———————————————————————*
FORM data_selection .
  SELECT * FROM zcustomer_t INTO TABLE lt_customer.
ENDFORM.

*&———————————————————————
*& Form BUILD_LAYOUT
*&———————————————————————*
FORM build_layout.
  ls_layout-zebra = abap_true.
  ls_layout-colwidth_optimize = abap_true.
ENDFORM.

*&———————————————————————
*& Form BUILD_FIELDCATALOG
*&———————————————————————*
FORM build_fieldcatalog .
  DATA: ls_fieldcat LIKE LINE OF lt_fieldcat.
  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_program_name         = sy-repid
      "i_internal_tabname    = 'ZCUSTOMER_T'
      i_structure_name       = 'ZCUSTOMER_T'
    CHANGING
      ct_fieldcat            = lt_fieldcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.
ENDFORM.
*&———————————————————————
*& Form DISPLAY_ALV
*&———————————————————————*
FORM display_alv .
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program       = sy-repid
      i_callback_pf_status_set = 'SET_PF_STATUS'
      i_callback_user_command  = 'USER_COMMAND'
*     I_CALLBACK_TOP_OF_PAGE   = ' '
      "i_structure_name  = 'SPFLI'
      is_layout                = ls_layout
      it_fieldcat              = lt_fieldcat
    TABLES
      t_outtab                 = lt_customer
    EXCEPTIONS
      program_error            = 1
      OTHERS                   = 2.
ENDFORM.

FORM set_pf_status USING rt_extab TYPE slis_t_extab .       "#EC NEEDED

  SET PF-STATUS 'ZYI_STATUS2'.

ENDFORM.

FORM user_command USING r_ucomm LIKE sy-ucomm
                           rs_selfield TYPE slis_selfield.

  "MESSAGE |Tıklanan buton: { r_ucomm }| TYPE 'I'.

  CASE r_ucomm.
    WHEN 'ADD'.
      " Popup aç
      CALL SCREEN 0100 STARTING AT 10 5 ENDING AT 100 25.

      " Popup’tan dönünce listeyi tazele
      PERFORM data_selection.
      rs_selfield-refresh     = 'X'.
      rs_selfield-row_stable  = 'X'.
      rs_selfield-col_stable  = 'X'.

    WHEN OTHERS.
      " Diğer ALV işlemleri
  ENDCASE.
ENDFORM.

FORM save_customer.
  " Aynı isimli müşteri var mı kontrol et
  DATA lv_exists TYPE i.
  lv_exists = 0.

  SELECT COUNT(*) INTO lv_exists
    FROM zcustomer_t
    WHERE name = gs_0100-name
      AND surname = gs_0100-surname.

  IF lv_exists > 0.
    MESSAGE 'Bu isimde müşteri zaten mevcut!' TYPE 'E'.
    EXIT.
  ENDIF.

  " Number range ile KUNNR üret
  DATA lv_kunnr TYPE zcustomer_t-kunnr.
  CALL FUNCTION 'NUMBER_GET_NEXT'
    EXPORTING
      nr_range_nr = '01'
      object      = 'KUNNR'
    IMPORTING
      number      = lv_kunnr
    EXCEPTIONS
      OTHERS      = 1.

  IF sy-subrc <> 0.
    MESSAGE 'Numara üretilemedi' TYPE 'E'.
  ENDIF.

  " Kayıt için KUNNR set et
  gs_0100-kunnr = lv_kunnr.

  " Database'e kayıt
  INSERT zcustomer_t FROM gs_0100.
  COMMIT WORK.
  IF sy-subrc <> 0.
    MESSAGE e000(zmsg) WITH 'INSERT başarısız. SY-SUBRC=' sy-subrc.
  ELSE.
    MESSAGE s000(zmsg) WITH 'Kayıt başarılı:' gs_0100-name.
  ENDIF.

  PERFORM data_selection.
  PERFORM display_alv.

ENDFORM.

MODULE status_0100 OUTPUT.
  "CLEAR gs_0100.
ENDMODULE.

MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'SAVE'.
      PERFORM save_customer.
      LEAVE SCREEN.
    WHEN 'CANCEL' OR 'EXIT' OR 'BACK' OR 'CLOSE'.
      LEAVE TO SCREEN 0.
  ENDCASE.
ENDMODULE.

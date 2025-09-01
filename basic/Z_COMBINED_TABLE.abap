* İki farklı internal tablodaki verileri tek bir internal tabloda birleştireceğiz.
* Farklı iki veri kümesi (ALPHAS ve NUMS) içeren iki dahili tablo verilecektir.
* Internal tablo ALPHAS ve internal tablo NUMS'un her bir hücresinin değerlerini bir araya getiren kayıtları içeren bir internal tablo oluşturabilir miyiz?
* Örneğin COMBINED_DATA internal tablosunun ilk satırının ilk sütununun değeri "A1" olması gerekir.

" ALPHAS tablosu
TYPES: BEGIN OF alphatab_type,
        cola TYPE string,
        colb TYPE string,
        colc TYPE string,
       END OF alphatab_type.

TYPES: alphas TYPE STANDARD TABLE OF alphatab_type.  " alphatab_type: tek satır tipi, alphas: bu tip satırları tutan internal table

" NUMS tablosu
TYPES: BEGIN OF numtab_type,
        col1 TYPE string,
        col2 TYPE string,
        col3 TYPE string,
       END OF numtab_type.

TYPES: nums TYPE STANDARD TABLE OF numtab_type.

" COMBINED_DATA tablosu(alphas ve nums tablolarının birleşimi)
TYPES: BEGIN OF combined_data_type,
        colx TYPE string,
        coly TYPE string,
        colz TYPE string,
       END OF combined_data_type.

TYPES: combined_data TYPE STANDARD TABLE OF combined_data_type WITH EMPTY KEY.

" Veri tanımlamaları
DATA: lt_alphas TYPE alphas,          " internal table
      lt_nums TYPE nums,              " TYPE TABLE OF kullanmadık çünkü zaten TYPES kısmında tablo olarak oluşturduk
      lt_combined TYPE combined_data,
      ls_alpha TYPE alphatab_type,    " structure
      ls_num TYPE numtab_type,
      ls_combined TYPE combined_data_type.

" ALPHAS tablosuna veri ekleme
ls_alpha-cola = 'A'.
ls_alpha-colb = 'B'.
ls_alpha-colc = 'C'.
APPEND ls_alpha TO lt_alphas.

ls_alpha-cola = 'D'.
ls_alpha-colb = 'E'.
ls_alpha-colc = 'F'.
APPEND ls_alpha TO lt_alphas.

" NUMS tablosuna veri ekleme
ls_num-col1 = '1'.
ls_num-col2 = '2'.
ls_num-col3 = '3'.
APPEND ls_num TO lt_nums.

ls_num-col1 = '4'.
ls_num-col2 = '5'.
ls_num-col3 = '6'.
APPEND ls_num TO lt_nums.

" Birleştirme işlemi
LOOP AT lt_alphas INTO ls_alpha.
  READ TABLE lt_nums INTO ls_num INDEX sy-tabix.   " sy-tabix = LOOP AT döngüsünün mevcut satır numarası, bu sayede aynı sıra numaralı satırları eşleştiriliyor.
  IF sy-subrc = 0.
    ls_combined-colx = ls_alpha-cola && ls_num-col1.   " && : string birleştirme operatörü
    ls_combined-coly = ls_alpha-colb && ls_num-col2.
    ls_combined-colz = ls_alpha-colc && ls_num-col3.

    APPEND ls_combined TO lt_combined.
  ENDIF.
ENDLOOP.

LOOP AT lt_combined INTO ls_combined.
  WRITE: / ls_combined-colx, ls_combined-coly, ls_combined-colz.
ENDLOOP.

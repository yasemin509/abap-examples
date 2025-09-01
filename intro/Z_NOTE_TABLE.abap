* Vize ve final notu girebileceğimiz 2 değişkenimiz olacak. Program çalıştırıldığında vizenin %40’ı, finalin %60 alınarak öğrencinin geçme notu hesaplanacak. 
* Bu notun değerine göre de aşağıdaki gibi bir çıktı vermeli: 
* Notunuz: 60 [DC] - Başarısız 
* Harf eşleştirmesi için daha önce oluşturduğum ZNOT_TABLE tablosunu kullandım. Tablo; Harf_Notu, Not_Aralığı ve Derece alanlarını içermektedir.

PARAMETERS: p_vize TYPE p DECIMALS 2,
            p_final TYPE p DECIMALS 2.

DATA: lv_gecme_notu TYPE p DECIMALS 2,
      lv_harf_notu TYPE znot_table-harf_notu,
      lv_derece  TYPE znot_table-derece,
      lv_min     TYPE string,
      lv_max     TYPE string,
      lv_aralik  TYPE string.

DATA: lt_table TYPE TABLE OF znot_table,  " Tablo verilerini hafızaya almak için internal table tanımladık
      ls_table TYPE znot_table.

lv_gecme_notu =  p_vize * 40 / 100  + p_final * 60 / 100.

SELECT * FROM znot_table INTO TABLE lt_table.  " Tablodaki tüm kayıtları internal table'a aldık

LOOP AT lt_table INTO ls_table.
  SPLIT ls_table-not_araligi AT '-' INTO lv_min lv_max.  " Not aralığını min ve max olarak ayır

  IF lv_gecme_notu BETWEEN lv_min AND lv_max.   " geçme notunun tabloda hangi aralıkta olduğuna bakıp ona göre atama yapıyoruz
    lv_harf_notu   = ls_table-harf_notu.
    lv_derece = ls_table-derece.
    EXIT.
  ENDIF.
ENDLOOP.

WRITE: / 'Notunuz:', lv_gecme_notu, '[', lv_harf_notu, ']', '-', lv_derece.

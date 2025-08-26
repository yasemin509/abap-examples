* Seçim ekranına Parametre olarak eklenebilecek en uzun uzunlukta bir parametre ekleyin.
* Bu alana girilen değer:
* Kaç karakter olduğu ekrana basılacak.
* Tamamı büyük harfe çevrilerek ekrana basılacak.
* Tamamı küçük harfe çevrilerek ekrana basılacak.
* Her bir kelime bir satırda olacak şekilde ekrana basılacak (Her kelimenin kaç karakter olduğu da parantez içinde belirtilecek).
* 1-20 karakter arası yeşil, 20-40 karakter arası mavi 40+ karakter üstü olanlar ise kırmızı olarak ekrana basılacak.
*---------------------------------------------------------------------------------------------------------------------------------

PARAMETERS: p_text TYPE string OBLIGATORY .

DATA: lv_len TYPE i,
      lv_upper TYPE string,
      lv_lower TYPE string,
      lt_words TYPE STANDARD TABLE OF string,
      lv_word TYPE string,
      lv_sublen TYPE i.

lv_len = strlen( p_text ).
WRITE: lv_len, 'karakterden oluşmaktadır.'.

lv_upper = to_upper( p_text ).
WRITE: / 'UPPER CASE: ', lv_upper.

lv_lower = to_lower( p_text ).
WRITE: / 'LOWER CASE: ', lv_lower.

SPLIT p_text AT space INTO TABLE lt_words.
LOOP AT lt_words INTO lv_word.
  WRITE: / lv_word, '->', strlen( lv_word ).
ENDLOOP.

" 1–20 karakter arası yeşil
IF lv_len > 0.
  lv_sublen = lv_len. 
  IF lv_sublen > 20.
    lv_sublen = 20.
  ENDIF.

  FORMAT COLOR 5 INTENSIFIED ON.
  WRITE: / p_text(lv_sublen).  " 20 karakterden az bir değer girdiğimizde hata vermemesi için lv_sublen'e göre yazdırıyoruz.
  FORMAT RESET.  " renk ayarını sıfırlar, sonraki satır etkilenmez.
ENDIF.

" 21–40 karakter arası mavi
IF lv_len > 20.
  lv_sublen = lv_len - 20.  " 21. karakterden sonrasının uzunluğu
  IF lv_sublen > 20.  "eğer lv_sublen 20'den az ise o kadarını maviye boyar, 20'den çoksa maviye boyanacak kısmı 20'ye fixler.
    lv_sublen = 20.
  ENDIF.

  FORMAT COLOR 4 INTENSIFIED ON.
  WRITE: / p_text+20(lv_sublen).  " 21. karakterden başlayarak lv_sublen kadar karakter yazdırır.
  FORMAT RESET.
ENDIF.

" 41+ karakter kırmızı
IF lv_len > 40.
  lv_sublen = lv_len - 40.

  FORMAT COLOR 6 INTENSIFIED ON.
  WRITE: / p_text+40(lv_sublen).
  FORMAT RESET.
ENDIF.

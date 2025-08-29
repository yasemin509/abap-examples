* SFLIGHT tablosunu referans alarak ,her gün için kapasiteye göre doluluk oranı en yüksek havayolu şirketi ve uçuş numaralarını Write-List formatında yazdıran program yazınız.

" tablo bilgilerini tutacak bir structure tanımlıyoruz
TYPES: BEGIN OF ty_row,
  carrid TYPE sflight-carrid,  " Airline
  connid TYPE sflight-connid,  " Flight Number
  fldate TYPE sflight-fldate,  " Date
  ratio TYPE p DECIMALS 2,     " % doluluk oranı
  END OF ty_row.

DATA: lt_result TYPE STANDARD TABLE OF ty_row,  " sonuçları tutacak olan tablo
      ls_result TYPE ty_row,                    " tek bir satırı için değişken tanımlıyoruz
      lt_sflight TYPE STANDARD TABLE OF sflight,
      ls_sflight TYPE sflight.

SELECT carrid, connid, fldate, seatsocc, seatsmax
  FROM sflight
  WHERE seatsmax > 0
  ORDER BY fldate ASCENDING
  INTO CORRESPONDING FIELDS OF TABLE @lt_sflight.

LOOP AT lt_sflight INTO ls_sflight.
  ls_result-carrid = ls_sflight-carrid.
  ls_result-connid = ls_sflight-connid.
  ls_result-fldate = ls_sflight-fldate.
  ls_result-ratio = ls_sflight-seatsocc * 100 / ls_sflight-seatsmax.  " Doluluk oranı = (dolu koltuk / max koltuk) * 100

  APPEND ls_result TO lt_result.  " sonuçları tabloya ekliyoruz

ENDLOOP.

SORT lt_result BY fldate ASCENDING.    " Sonuçları önce tarihe göre sıralıyoruz
SORT lt_result BY fldate ASCENDING ratio DESCENDING.   " Aynı tarihler içinde doluluk oranına göre azalan sıralama yapıyoruz

DATA: lv_last_date TYPE sflight-fldate.  " Her tarih için sadece doluluk oranı en yüksek ilk satırı yazdırmak için değişken tanımlıyoruz
CLEAR lv_last_date.  " değişken null değerinde yani başlangıçta boş değer veriyoruz

LOOP AT lt_result INTO ls_result.
  IF ls_result-fldate <> lv_last_date.   " Eğer tarih bir önceki satırdan farklı ise, ilk satırı yazdırıyoruz. <> ifadesi “not equal to (!=)” anlamına gelir
    WRITE: / 'Tarih: ', ls_result-fldate,
             '  Şirket: ', ls_result-carrid,
             '  Uçuş: ', ls_result-connid,
             '  Doluluk %: ', ls_result-ratio.
    lv_last_date = ls_result-fldate.  " " Tarihi kaydediyoruz, böylece sonraki aynı tarihler atlanacak
  ENDIF.
ENDLOOP.

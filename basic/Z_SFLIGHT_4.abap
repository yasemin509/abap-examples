* SBOOK ve SFLIGHT tablosunu referans alarak ,
* Seçim ekranından tarih aralığı girildikten sonra, kapasite doluluk oranı yüzde 50'nin üstünde olan uçuşlar için
* sigara içme oranını havayolu şirketi ve uçuş numaralarıyla beraber Write-List formatında yazınız.

PARAMETERS: p_dt_low TYPE sflight-fldate OBLIGATORY,   " başlangıç tarihi
            p_dt_hg TYPE sflight-fldate OBLIGATORY.    " bitiş tarihi


TYPES: BEGIN OF ty_result,
        carrid TYPE sflight-carrid,  "Havayolu ID
        connid TYPE sflight-connid,  "Uçuş numarası
        fldate TYPE sflight-fldate,  "Uçuş tarihi
        ratio TYPE p DECIMALS 2,     "Doluluk oranı (%)
        smoker TYPE i,               "Sigara içen yolcu sayısı
      END OF ty_result.

DATA: lt_sflight TYPE STANDARD TABLE OF sflight,
      ls_sflight TYPE sflight,
      lt_result TYPE STANDARD TABLE OF ty_result,
      ls_result TYPE ty_result.

START-OF-SELECTION.

SELECT *
  FROM sflight
  INTO TABLE @lt_sflight
  WHERE fldate BETWEEN @p_dt_low AND @p_dt_hg   " seçilen tarih aralığındaki uçuşlar
  AND seatsmax > 0.

WRITE: / 'Bulunan uçuş sayısı:', LINES( lt_sflight ).


LOOP AT lt_sflight INTO ls_sflight.

  DATA(lv_ratio) = ( ls_sflight-seatsocc * 100 ) / ls_sflight-seatsmax.  " doluluk oranı hesaplaması

  IF lv_ratio > 50.   " doluluk oranı %50'nin üstünde olan uçuşlara bakıyoruz

    " SBOOK tablosundan id değerleri ve tarih aralığı SFLIGHT tablosuyla uyuşan ve sigara içen yolcuları seçiyoruz
    SELECT COUNT(*)
      FROM sbook
      WHERE carrid = @ls_sflight-carrid
      AND connid = @ls_sflight-connid
      AND fldate = @ls_sflight-fldate
      AND smoker = 'X'                  " sbook tablosunda bu şekilde işaretli sigara içenler
    INTO @DATA(lv_smokers).

    " değerleri sonuç satırlarına atıyoruz
    CLEAR ls_result.
    ls_result-carrid = ls_sflight-carrid.
    ls_result-connid = ls_sflight-connid.
    ls_result-fldate = ls_sflight-fldate.
    ls_result-ratio = lv_ratio.
    ls_result-smoker = lv_smokers.

    APPEND ls_result TO lt_result. " sonuç satırlarını sonuç tablosuna ekliyoruz

  ENDIF.

ENDLOOP.

" Sonuçları WRITE-LIST formatında ekrana yazdırıyoruz
ULINE.
WRITE: / 'Havayolu Şirketi', 20 'Uçuş No.', 38 'Tarih', 55 'Doluluk(%)', 70 'Sigara Kullanan Yolcu Sayısı'.
ULINE.

LOOP AT lt_result INTO ls_result.
  WRITE: / ls_result-carrid,
        20 ls_result-connid,
        35 ls_result-fldate,
        47 ls_result-ratio,
        70 ls_result-smoker.
ENDLOOP.

* SFLIGHT tablosuna göre business class kapasiteye göre doluluk oranı en yüksek havayolu şirketlerini sıralayarak Write-List formatında yazdıran programı yazınız.


TYPES: BEGIN OF ty_row,
  carrid TYPE sflight-carrid,
  connid TYPE sflight-connid,
  fldate TYPE sflight-fldate,
  ratio TYPE p DECIMALS 2,
  END OF ty_row.

DATA: lt_result TYPE STANDARD TABLE OF ty_row,
      ls_result TYPE ty_row,
      lt_sflight TYPE STANDARD TABLE OF sflight,
      ls_sflight TYPE sflight.

SELECT carrid, connid, fldate, seatsocc_b, seatsmax_b
  FROM sflight
  WHERE seatsmax_b > 0
  INTO CORRESPONDING FIELDS OF TABLE @lt_sflight.

LOOP AT lt_sflight INTO ls_sflight.
  ls_result-carrid = ls_sflight-carrid.
  ls_result-connid = ls_sflight-connid.
  ls_result-fldate = ls_sflight-fldate.
  ls_result-ratio = ls_sflight-seatsocc_b * 100 / ls_sflight-seatsmax_b.  " business class için doluluk oranı hesaplaması

  APPEND ls_result TO lt_result.

ENDLOOP.

SORT lt_result BY ratio DESCENDING.

WRITE: / 'Tarih', 15 'Şirket', 25 'Uçuş', 40 'Doluluk %'.  " değerler arasına boşluk ekleyerek yazdırır, daha nizami görünmesi için

LOOP AT lt_result INTO ls_result.
  WRITE: / '-------------------------------------------------'.
  WRITE: / ls_result-fldate, 15 ls_result-carrid, 25 ls_result-connid, 30 ls_result-ratio.
ENDLOOP.

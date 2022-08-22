-- Join
-- 일반적으로 여러 테이블을 기본키(PK)나 외래키(FK) 값의 관계에 의해 결합(Join)
-- INNER JOIN : 두 테이블에 모두 일치하는 행만 반환
-- OUTER JOIN : 동일한 값이 없는 행도 반환, LEFT/RIGHT/FULL
-- CROSS JOIN : 모든 데이터의 조합(경우의 수)

-- 실행
$ sqlite3 sample.sqlite3

-- Column 출력 설정
.headers on 
.mode column

-- playlist_track 테이블에 `A`라는 별칭을 부여하고 데이터를 출력하세요.
SELECT *
FROM playlist_track A
ORDER BY A.PlaylistId DESC
LIMIT 5;
-- PlaylistId  TrackId
-- ----------  -------
-- 18          597
-- 17          3290
-- 17          2096
-- 17          2095
-- 17          2094

-- tracks 테이블에 `B`라는 별칭을 부여하고 데이터를 출력하세요.
SELECT *
FROM tracks B
ORDER BY B.TrackId
LIMIT 5;
-- TrackId  Name                                     AlbumId  MediaTypeId  GenreId  Composer                                                      Milliseconds  Bytes     UnitPrice
-- -------  ---------------------------------------  -------  -----------  -------  ------------------------------------------------------------  ------------  --------  ---------
-- 1        For Those About To Rock (We Salute You)  1        1            1        Angus Young, Malcolm Young, Brian Johnson                     343719        11170334  0.99

-- 2        Balls to the Wall                        2        2            1                                                                      342562        5510424   0.99

-- 3        Fast As a Shark                          3        2            1        F. Baltes, S. Kaufman, U. Dirkscneider & W. Hoffman           230619        3990994   0.99

-- 4        Restless and Wild                        3        2            1        F. Baltes, R.A. Smith-Diesel, S. Kaufman, U. Dirkscneider &   252051        4331779   0.99
--                                                                                  W. Hoffman

-- 5        Princess of the Dawn                     3        2            1        Deaffy & R.A. Smith-Diesel                                    375418        6290521   0.99

-- 각 playlist_track 해당하는 track 데이터를 함께 출력하세요.
SELECT A.PlaylistID, B.Name
FROM playlist_track A INNER JOIN tracks B
	ON A.TrackID = B.TrackID
ORDER BY A.PlaylistId DESC
LIMIT 10;
-- PlaylistId  Name
-- ----------  -----------------------
-- 18          Now's The Time
-- 17          The Zoo
-- 17          Flying High Again
-- 17          Crazy Train
-- 17          I Don't Know
-- 17          Looks That Kill
-- 17          Live To Win
-- 17          Ace Of Spades
-- 17          Creeping Death
-- 17          For Whom The Bell Tolls

-- `PlaylistId`가 `10`인 track 데이터를 함께 출력하세요. 
SELECT A.PlaylistId, B.Name
FROM playlist_track A INNER JOIN tracks B
	ON A.TrackID = B.TrackID
WHERE A.PlaylistId = 10
ORDER BY B.Name DESC
LIMIT 5;
-- PlaylistId  Name
-- ----------  ------------------------
-- 10          Women's Appreciation
-- 10          White Rabbit
-- 10          Whatever the Case May Be
-- 10          What Kate Did
-- 10          War of the Gods, Pt. 2

-- tracks 테이블을 기준으로 tracks `Composer` 와 artists 테이블의 `Name`을 `INNER JOIN`해서 데이터를 출력하세요.
SELECT COUNT(*)
FROM tracks A INNER JOIN artists B
	ON A.Composer = B.Name;
-- COUNT(*)
-- --------
-- 402

-- tracks 테이블을 기준으로 tracks `Composer` 와 artists 테이블의 `Name`을 `LEFT JOIN`해서 데이터를 출력하세요.
SELECT COUNT(*)
FROM tracks A LEFT JOIN artists B
	ON A.Composer = B.Name;
-- COUNT(*)
-- --------
-- 3503

-- `INNER JOIN` 과 `LEFT JOIN` 행의 개수가 다른 이유를 작성하세요.
-- INNER JOIN은 동일한 값이 있는 행만을 반환하는 교집합이지만, 
-- LEFT JOIN은 OUTER JOIN의 한 종류로 동일한 값이 없는 데이터도 반환하는 합집합이다. 
-- 왼쪽 테이블을 기준으로 모든 행을 조회할 때 사용된다.

-- invoice_items 테이블의 데이터를 출력하세요.
SELECT InvoiceLineId, InvoiceId
FROM invoice_items
ORDER BY InvoiceId
LIMIT 5;
-- InvoiceLineId  InvoiceId
-- -------------  ---------
-- 1              1
-- 2              1
-- 3              2
-- 4              2
-- 5              2

-- invoices 테이블의 데이터를 출력하세요.
SELECT InvoiceId, CustomerId
FROM Invoices
ORDER BY InvoiceId
LIMIT 5;
-- InvoiceId  CustomerId
-- ---------  ----------
-- 1          2
-- 2          4
-- 3          8
-- 4          14
-- 5          23

-- 각 invoices_item에 해당하는 invoice 데이터를 함께 출력하세요.
SELECT A.invoiceLineId, B.InvoiceId
FROM invoice_items A INNER JOIN invoices B
	ON A.InvoiceId = B.InvoiceId
ORDER BY B.InvoiceId DESC
LIMIT 5;
-- InvoiceLineId  InvoiceId
-- -------------  ---------
-- 2240           412
-- 2226           411
-- 2227           411
-- 2228           411
-- 2229           411

-- 각 invoice에 해당하는 customer 데이터를 함께 출력하세요.
SELECT A.InvoiceId, B.CustomerId
FROM invoices A INNER JOIN customers B
	ON A.CustomerId = B.CustomerId
ORDER BY A.InvoiceId DESC
LIMIT 5;
-- InvoiceId  CustomerId
-- ---------  ----------
-- 412        58
-- 411        44
-- 410        35
-- 409        29
-- 408        25

-- 각 invoices_item(상품)을 포함하는 invoice(송장)와 해당 invoice를 받을 customer(고객) 데이터를 모두 함께 출력하세요.
SELECT A.InvoiceLineId, B.InvoiceId, C.CustomerId
FROM invoice_items A INNER JOIN invoices B
	ON A.InvoiceId = B.InvoiceId
	INNER JOIN customers C
	ON B.CustomerId = C.CustomerId
ORDER BY B.InvoiceId DESC
LIMIT 5;
-- InvoiceLineId  InvoiceId  CustomerId
-- -------------  ---------  ----------
-- 2240           412        58
-- 2226           411        44
-- 2227           411        44
-- 2228           411        44
-- 2229           411        44

-- 각 customer가 주문한 invoices_item의 개수를 출력하세요.
SELECT C.CustomerId, COUNT(*)
FROM invoice_items A INNER JOIN invoices B
	ON A.InvoiceId = B.InvoiceId
	INNER JOIN customers C
	ON B.CustomerId = C.CustomerId
GROUP BY C.CustomerId
ORDER BY C.CustomerId
LIMIT 5;
-- CustomerId  COUNT(*)
-- ----------  --------
-- 1           38
-- 2           38
-- 3           38
-- 4           38
-- 5           38

-- 각 artist명과 해당 artist가 발매한 album명을 출력하세요.
SELECT A.Name, B.Title
FROM artists A INNER JOIN albums B
	ON A.ArtistId = B.ArtistId
ORDER BY A.Name
LIMIT 5;
Name                                                        Title
----------------------------------------------------------  -------------------------------------
AC/DC                                                       For Those About To Rock We Salute You
AC/DC                                                       Let There Be Rock
Aaron Copland & London Symphony Orchestra                   A Copland Celebration, Vol. I
Aaron Goldberg                                              Worlds
Academy of St. Martin in the Fields & Sir Neville Marriner  The World of Classical Favourites

-- 각 invoiceId에 해당하는 Customer의 풀네임(이름+성)과 total 가격을 출력하세요.
SELECT A.FirstName || ' ' || A.LastName AS Name, B.total
FROM customers A INNER JOIN invoices B
	ON A.CustomerId = B.CustomerId
ORDER BY B.total DESC
LIMIT 5;
-- Name                Total
-- ------------------  -----
-- Helena Holy         25.86
-- Richard Cunningham  23.86
-- Ladislav Kovacs     21.86
-- Hugh O'Reilly       21.86
-- Astrid Gruber       18.86

-- 각 track명과 해당 track의 genre명, album명을 출력하세요.
SELECT A.Name 제목, B.Name 장르, C.Title 앨범
FROM tracks A INNER JOIN genres B
	ON A.GenreId = B.GenreId
	INNER JOIN albums C
	ON A.AlbumId = C.AlbumId
ORDER BY A.Name
LIMIT 5;
-- 제목                                                          장르                  앨범
-- ----------------------------------------------------------  ------------------  ------------------------------------------------------------
-- "40"                                                        Rock                War
-- "?"                                                         TV Shows            Lost, Season 2
-- "Eine Kleine Nachtmusik" Serenade In G, K. 525: I. Allegro  Classical           Sir Neville Marriner: A Celebration
-- #1 Zero                                                     Alternative & Punk  Out Of Exile
-- #9 Dream                                                    Pop                 Instant Karma: The Amnesty International Campaign to Save Darfur
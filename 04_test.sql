-- CASE
--   WHEN 조건식 THEN 식
--   WHEN 조건식 THEN 식
--   ELSE 식
-- END
-- 특정 상황에서 데이터를 변환하여 활용
-- ELSE를 생략하는 경우 NULL값이 지정됨

-- 서브쿼리
-- 특정한 값을 메인 쿼리에 반환하여 활용
-- 소괄호로 감싸서 사용
-- 메인 쿼리는 서브 쿼리의 칼럼을 이용할 수 없음
-- 단일행 서브쿼리 : 단일행 비교 연산자와 함께 사용(=, <, <=, >=, >, <>)
-- 다중행 서브쿼리 : 다중행 비교 연산자와 함께 사용(IN, EXISTS 등)
-- 다중컬럼 서브쿼리

-- 실행
$ sqlite3 sample.sqlite3

-- Column 출력 설정
.headers on 
.mode column

-- 모든 테이블의 이름을 출력하세요.
.tables

-- 모든 테이블의 데이터를 확인해보세요.
.schema 테이블명
-- Open Database로 테이블 데이터 확인

-- 앨범(albums) 테이블의 데이터를 출력하세요.
SELECT *
FROM albums
ORDER BY Title DESC
LIMIT 5;
-- AlbumId  Title                         ArtistId
-- -------  ----------------------------  --------
-- 208      [1997] Black Light Syndrome   136
-- 240      Zooropa                       150
-- 267      Worlds                        202
-- 334      Weill: The Seven Deadly Sins  264
-- 8        Warner 25 Anos                6

-- 고객(customers) 테이블의 행 개수를 출력하세요.
SELECT COUNT(*) AS '고객 수'
FROM customers;
-- 고객 수
-- ----
-- 59

-- 고객(customers) 테이블에서 고객이 사는 나라가 `USA`인 고객의 `FirstName`, `LastName`을 출력하세요.
SELECT FirstName, LastName
FROM customers
WHERE Country = 'USA';
-- FirstName  LastName
-- ---------  ----------
-- Frank      Harris
-- Jack       Smith
-- Michelle   Brooks
-- Tim        Goyer
-- Dan        Miller
-- Kathy      Chase
-- Heather    Leacock
-- John       Gordon
-- Frank      Ralston
-- Victor     Stevens
-- Richard    Cunningham
-- Patrick    Gray
-- Julia      Barnett

-- 송장(invoices) 테이블에서 `BillingPostalCode`가 `NULL` 이 아닌 행의 개수를 출력하세요.
SELECT COUNT(*) AS 송장수
FROM invoices
WHERE BillingPostalCode IS NOT NULL;
송장수
---
384

-- 송장(invoices) 테이블에서 `BillingState`가 `NULL` 인 데이터를 출력하세요.
SELECT *
FROM invoices
WHERE BillingState IS NULL
ORDER BY InvoiceDate DESC
LIMIT 5;
InvoiceId  CustomerId  InvoiceDate          BillingAddress                            BillingCity   BillingState  BillingCountry  BillingPostalCode  Total
---------  ----------  -------------------  ----------------------------------------  ------------  ------------  --------------  -----------------  -----
412        58          2013-12-22 00:00:00  12,Community Centre                       Delhi                       India           110017             1.99
411        44          2013-12-14 00:00:00  Porthaninkatu 9                           Helsinki                    Finland         00530              13.86
410        35          2013-12-09 00:00:00  Rua dos Campeoes Europeus de Viena, 4350  Porto                       Portugal                           8.91
404        6           2013-11-13 00:00:00  Rilska 3174/6                             Prague                      Czech Republic  14300              25.86
403        56          2013-11-08 00:00:00  307 Macacha Guemes                        Buenos Aires                Argentina       1106               8.91

-- 송장(invoices) 테이블에서 `InvoiceDate`의 년도가 `2013`인 행의 개수를 출력하세요.
SELECT COUNT(*)
FROM invoices
WHERE strftime('%Y', InvoiceDate) = '2013';
-- COUNT(*)
-- --------
-- 80
-- strftime 함수 : 날짜 및 시간 조회, 문자열 형식 지정 가능
-- strftime('형식 지정', 인수) 
-- %Y:년(4자리), %m:월(2자리), %d:일(2자리) 
-- %H:시(2자리), %M:분(2자리), %S:초(2자리)

-- 고객(customers) 테이블에서 `FirstName`이 `L` 로 시작하는 고객의 `CustomerId`, `FirstName`, `LastName`을 출력하세요.
SELECT CustomerID 고객ID, FirstName 이름, LastName 성
FROM customers
WHERE FirstName LIKE 'L%'
ORDER BY "고객ID" ASC;
-- 고객ID  이름        성
-- ----  --------  ---------
-- 1     Luis      Goncalves
-- 2     Leonie    Kohler
-- 45    Ladislav  Kovacs
-- 47    Lucas     Mancini
-- 57    Luis      Rojas

-- 고객(customers) 테이블에서 각 나라의 고객 수와 해당 나라 이름을 출력하세요.
SELECT COUNT(*) '고객 수', Country '나라'
FROM customers
GROUP BY Country
ORDER BY COUNT(*) DESC
LIMIT 5;
-- 고객 수  나라
-- ----  -------
-- 13    USA
-- 8     Canada
-- 5     France
-- 5     Brazil
-- 4     Germany

-- 앨범(albums) 테이블에서 가장 많은 앨범이 있는 Artist의 `ArtistId`와 `앨범 수`를 출력하세요.
SELECT ArtistId, COUNT(*) '앨범 수'
FROM albums
GROUP BY ArtistID
ORDER BY COUNT(*) DESC
LIMIT 1;
-- ArtistId  앨범 수
-- --------  ----
-- 90        21

-- 앨범(albums) 테이블에서 보유 앨범 수가 10개 이상인 Artist의 `ArtistId`와 `앨범 수` 출력하세요.
SELECT ArtistId, COUNT(*) '앨범 수'
FROM albums
GROUP BY ArtistID
HAVING COUNT(*) >= 10
ORDER BY "앨범 수" DESC;
-- ArtistId  앨범 수
-- --------  ----
-- 90        21
-- 22        14
-- 58        11
-- 50        10
-- 150       10

-- 고객(customers) 테이블에서 `State`가 존재하는 고객들을 `Country` 와 `State`를 기준으로 그룹화해서 각 그룹의 `고객 수`, `Country`, `State` 를 출력하세요.
SELECT COUNT(*) '고객 수', Country, State
FROM customers
WHERE State IS NOT NULL
GROUP BY Country, State
ORDER BY "고객 수" DESC, Country DESC
LIMIT 5;
-- 고객 수  Country  State
-- ----  -------  -----
-- 3     USA      CA
-- 3     Brazil   SP
-- 2     Canada   ON
-- 1     USA      WI
-- 1     USA      WA

-- 고객(customers) 테이블에서 `Fax` 가 `NULL`인 고객은 'X' NULL이 아닌 고객은 'O'로 `Fax 유/무` 컬럼에 표시하여 출력하세요.
SELECT
	CustomerId,
	CASE
		WHEN Fax IS NULL THEN 'X'
		ELSE 'O'
	END 'Fax 유/무'
FROM customers
ORDER BY CustomerId ASC
LIMIT 5;
-- CustomerId  Fax 유/무
-- ----------  -------
-- 1           O
-- 2           X
-- 3           X
-- 4           X
-- 5           O

-- 점원(employees) 테이블에서 `올해년도 - BirthDate 년도 + 1` 를 계산해서 `나이` 컬럼에 표시하여 출력하세요.
SELECT LastName, FirstName, cast(strftime('%Y', 'now') AS INTEGER) - cast(strftime('%Y', BirthDate) AS INTEGER) + 1 AS 나이
FROM employees
ORDER BY EmployeeId ASC;
-- LastName  FirstName  나이
-- --------  ---------  --
-- Adams     Andrew     61
-- Edwards   Nancy      65
-- Peacock   Jane       50
-- Park      Margaret   76
-- Johnson   Steve      58
-- Mitchell  Michael    50
-- King      Robert     53
-- Callahan  Laura      55
-- now : 현재 날짜 및 시간 조회
-- cast(인수 AS 데이터형) : 명시적 형 변환
-- strftime('형식 지정', 인수) : 날짜 및 시간 조회, 형식 지정

-- 가수(artists) 테이블에서 앨범(albums)의 개수가 가장 많은 가수의 `Name`을 출력하세요.
SELECT Name
FROM artists
WHERE ArtistId = (SELECT ArtistId FROM albums GROUP BY ArtistID ORDER BY COUNT(*) DESC LIMIT 1);
-- Name
-- -----------
-- Iron Maiden

-- 장르(genres) 테이블에서 음악(tracks)의 개수가 가장 적은 장르의 `Name`을 출력하세요.
SELECT Name
FROM genres
WHERE GenreId = (SELECT GenreId FROM tracks GROUP BY GenreId ORDER BY COUNT(*) ASC LIMIT 1);
-- Name
-- -----
-- Opera

-- 점원(employees) 테이블에서 직원 이름(이름+성)과 고용날짜(HireDate)를 이용하여 올해 기준 근속연수를 출력하세요.
SELECT FirstName || LastName AS 직원명, 
       cast(strftime('%Y', 'now') AS INTEGER) - cast(strftime('%Y', HireDate) AS INTEGER) AS 근속연수
FROM employees;
-- 직원명              근속연수
-- ---------------  ----
-- AndrewAdams      20
-- NancyEdwards     20
-- JanePeacock      20
-- MargaretPark     19
-- SteveJohnson     19
-- MichaelMitchell  19
-- RobertKing       18
-- LauraCallahan    18

-- 고객(customers) 테이블에서 지메일(gmail.com)을 사용하는 사람의 수와 아닌 사람의 수를 출력하세요.
SELECT 
	(SELECT COUNT(*) 'gmail user' FROM customers WHERE Email LIKE '%@gmail.com') 'gmail 유저',
	(SELECT COUNT(*) 'gmail user' FROM customers WHERE Email NOT LIKE '%@gmail.com') '그 외';
-- gmail 유저  그 외
-- --------  ---
-- 8         51

-- 점원(employees) 테이블에서 직함(Title)에 따라 Manager, Support Agent, Staff의 수를 각각 출력하세요.
SELECT 
  (SELECT COUNT(*) FROM employees WHERE Title LIKE '%Manager%') 'Manager',
  (SELECT COUNT(*) FROM employees WHERE Title LIKE '%Support Agent%') 'Support Agent',
  (SELECT COUNT(*) FROM employees WHERE Title LIKE '%Staff%') 'Staff';
-- Manager  Support Agent  Staff
-- -------  -------------  -----
-- 3        3              2
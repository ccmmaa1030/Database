-- 테이블 만들기
CREATE TABLE healthcare (
id PRIMARY KEY,
sido INTEGER NOT NULL,
gender INTEGER NOT NULL,
age INTEGER NOT NULL,
height INTEGER NOT NULL,
weight INTEGER NOT NULL,
waist REAL NOT NULL,
va_left REAL NOT NULL,
va_right REAL NOT NULL,
blood_pressure INTEGER NOT NULL,
smoking INTEGER NOT NULL,
is_drinking BOOLEAN NOT NULL
);

-- csv import 하기
.mode csv 
.import health.csv healthcare

-- 실행
$ sqlite3 healthcare.sqlite3

-- Column 출력 설정
.headers on 
.mode column

-- table 조회
.tables
-- healthcare

-- 스키마 조회
.schema healthcare
-- CREATE TABLE healthcare (
-- id PRIMARY KEY,        
-- sido INTEGER NOT NULL, 
-- gender INTEGER NOT NULL,
-- age INTEGER NOT NULL,  
-- height INTEGER NOT NULL,
-- weight INTEGER NOT NULL,
-- waist REAL NOT NULL,   
-- va_left REAL NOT NULL, 
-- va_right REAL NOT NULL,
-- blood_pressure INTEGER 
-- NOT NULL,
-- smoking INTEGER NOT NULL,
-- is_drinking BOOLEAN NOT NULL
-- );

SELECT COUNT(*) FROM healthcare;
-- COUNT(*)
-- --------
-- 1000000

SELECT COUNT(*) FROM healthcare WHERE age < 10;
-- COUNT(*)
-- --------
-- 156277

SELECT COUNT(*) FROM healthcare WHERE gender = 1;
-- COUNT(*)
-- --------
-- 510689

SELECT COUNT(*) FROM healthcare WHERE smoking = 3 and is_drinking = 1;
-- COUNT(*)
-- --------
-- 150361

SELECT COUNT(*) FROM healthcare WHERE va_left >= 2 and va_right >= 2;
-- COUNT(*)
-- --------
-- 2614

SELECT DISTINCT sido FROM healthcare;
-- sido
-- ----
-- 36
-- 27
-- 11
-- 31
-- 41
-- 44
-- 48
-- 30
-- 42
-- 43
-- 46
-- 28
-- 26
-- 47
-- 45
-- 29
-- 49

-- 자유롭게 조합해서 원하는 데이터를 출력해보세요.
SELECT COUNT(*) FROM healthcare WHERE va_left >= 2 and va_right >= 2 and height >= 180;
SELECT weight, gender FROM healthcare WHERE height >= 180 LIMIT 10;
SELECT COUNT(*) FROM healthcare WHERE weight >= 100 and gender = 2;
SELECT COUNT(*) FROM healthcare WHERE weight >= 100 and is_drinking = 1;
SELECT COUNT(*) FROM healthcare WHERE weight >= 100 and is_drinking = 1;
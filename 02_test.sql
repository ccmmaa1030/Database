-- 실행
$ sqlite3 healthcare.sqlite3

-- Column 출력 설정
.headers on 
.mode column

-- 추가되어 있는 모든 데이터의 수를 출력하시오.
SELECT COUNT(*) FROM healthcare;
-- COUNT(*)
-- --------
-- 1000000

-- 연령 코드(age)의 최대, 최소 값을 모두 출력하시오.
SELECT MAX(age), MIN(age) FROM healthcare;
-- MAX(age)  MIN(age)
-- --------  --------
-- 18        9

-- 신장(height)과 체중(weight)의 최대, 최소 값을 모두 출력하시오.
SELECT MAX(height), MIN(height), MAX(weight), MIN(weight) FROM healthcare;
-- MAX(height)  MIN(height)  MAX(weight)  MIN(weight)
-- -----------  -----------  -----------  -----------
-- 195          130          135          30

-- 신장(height)이 160 이상 170 이하인 사람은 몇 명인지 출력하시오.
SELECT COUNT(*) FROM healthcare WHERE height >= 160 and height <= 170;
-- COUNT(*)
-- --------
-- 516930

-- 음주(is_drinking)를 하는 사람(1)의 허리 둘레(waist)를 높은 순으로 5명 출력하시오. 
SELECT waist FROM healthcare WHERE is_drinking = 1 AND waist != '' ORDER BY waist DESC LIMIT 5;
-- waist
-- -----
-- 146.0
-- 142.0
-- 141.4
-- 140.0
-- 140.0
-- (공백값이 있기 때문에 WHERE 문에 waist가 공백이 아니라는 조건 추가)

-- 시력 양쪽(va_left, va_right)이 1.5 이상이면서 음주(is_drinking)를 하는 사람의 수를 출력하시오.
SELECT COUNT(*) FROM healthcare WHERE va_left >= 1.5 and va_right >= 1.5 and is_drinking = 1;
-- COUNT(*)
-- --------
-- 36697

-- 혈압(blood_pressure)이 정상 범위(120 미만)인 사람의 수를 출력하시오.
SELECT COUNT(*) FROM healthcare WHERE blood_pressure < 120;
-- AVG(waist)
-- ----------------
-- 85.8665098512525

-- 혈압(blood_pressure)이 140 이상인 사람들의 평균 허리둘레(waist)를 출력하시오.
SELECT AVG(waist) FROM healthcare WHERE blood_pressure >= 140;
-- AVG(height)       AVG(weight)
-- ----------------  ----------------
-- 167.452735422145  69.7131620222875

-- 키가 가장 큰 사람 중에 두번째로 무거운 사람의 id와 키(height), 몸무게(weight)를 출력하시오.
SELECT id, height, weight FROM healthcare WHERE height = (SELECT MAX(height) FROM healthcare) ORDER BY weight DESC LIMIT 1 OFFSET 1;
-- id      height  weight
-- ------  ------  ------
-- 836005  195     110
-- (WHERE 문에 heihgt가 최댓값이라는 조건 추가)
-- (ORDER BY 문으로 weight의 내림차순(무거움->가벼움)으로 정렬)
-- (LIMIT과 OFFSET을 통해 가장 무거운 사람을 제외한 한 사람(=두번째로 무거운 사람) 출력)

-- BMI가 30 이상인 사람의 수를 출력하시오.
SELECT COUNT(*) FROM healthcare WHERE weight/(height*height*0.0001) >= 30;
-- COUNT(*)
-- --------
-- 53121

-- 흡연(smoking)이 3인 사람의 BMI지수가 제일 높은 사람 순서대로 5명의 id와 BMI를 출력하시오.
SELECT id, weight/(height*height*0.0001) AS BMI FROM healthcare WHERE smoking = 3 ORDER BY BMI DESC LIMIT 5;
-- id      BMI
-- ------  ----------------
-- 231431  50.78125
-- 934714  49.9479708636837
-- 722707  48.828125
-- 947281  47.7502295684114
-- 948801  47.7502295684114

-- BMI 지수가 30 이상인 사람들의 혈압 평균을 출력하시오.
SELECT AVG(blood_pressure) FROM healthcare WHERE weight/(height*height*0.0001) >= 30;
-- AVG(blood_pressure)
-- -------------------
-- 130.711978313661

-- 신장(height)이 160 이상 170 미만(=160대)인 사람은 몇 명인지 출력하시오. (LIKE 사용)
SELECT COUNT(*) FROm healthcare WHERE height LIKE '16%';
-- COUNT(*)
-- --------
-- 364345

-- 10대 여자 키 평균을 출력하시오.
SELECT AVG(height) AS 여자_10대_키_평균 FROM healthcare WHERE age LIKE '1_%' and gender = 2; 
-- 여자_10대_키_평균
-- ----------------
-- 153.516996505081
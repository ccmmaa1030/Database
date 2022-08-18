-- 문자열 함수
-- SUBSTR(문자열, start, length) : 문자열 자르기
-- TRIM(문자열), LTRIM(문자열), RTRIM(문자열) : 문자열 공백 제거
-- LENGTH(문자열) : 문자열 길이
-- REPLACE(문자열, 패턴, 변경값) : 문자열에서 패턴 부분을 지정 값으로 변경
-- UPPER(문자열), LOWER(문자열) : 대소문자 변경
-- || : 문자열 합치기

-- 숫자 함수
-- ABS(숫자) : 절대값
-- SIGN(숫자) : 부호(양->1, 음->-1, 0->0)
-- MOD(숫자1, 숫자2) : 숫자1을 숫자2로 나눈 나머지
-- CEIL(숫자), FLOOR(숫자), ROUND(숫자) : 올림, 내림, 반올림
-- POWER(숫자1, 숫자2) : 숫자1의 숫자2 제곱
-- SQRT(숫자) : 제곱근

-- ALIAS
-- AS를 생략해서 공백으로 표현 가능
-- 별칭에 고백, 특수문자 등이 있는 경우 따옴표로 묶어서 표기

-- SELECT 문장 실행 순서
-- FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY -> LIMIT/OFFSET

-- 실행
$ sqlite3 healthcare.sqlite3

-- Column 출력 설정
.headers on 
.mode column

-- 흡연 여부(smoking)로 구분한 각 그룹의 컬렴명과 그룹의 사람의 수를 출력하시오.
SELECT smoking, COUNT(*)
FROM healthcare
WHERE smoking != ''
GROUP BY smoking;
-- smoking  COUNT(*)
-- -------  --------
-- 1        626138
-- 2        189808
-- 3        183711

-- 음주 여부(is_drinking)로 구분한 각 그룹의 컬렴명과 그룹의 사람의 수를 출력하시오.
SELECT is_drinking, COUNT(*)
FROM healthcare
WHERE is_drinking != ''
GROUP BY is_drinking;
-- is_drinking  COUNT(*)
-- -----------  --------
-- 0            415119
-- 1            584685

-- 음주 여부로 구분한 각 그룹에서 혈압(blood_pressure)이 200이상인 사람의 수를 출력하시오.
SELECT is_drinking, COUNT(*)
FROM healthcare
WHERE blood_pressure >= 200
GROUP BY is_drinking;
-- is_drinking  COUNT(*)
-- -----------  --------
-- 0            6064
-- 1            1770

-- 시도(sido)에 사는 사람의 수가 50000명 이상인 시도의 코드와 그 시도에 사는 사람의 수를 출력하시오.
SELECT sido, COUNT(*)
FROM healthcare
GROUP BY sido
HAVING COUNT(sido) >= 50000;
-- sido  COUNT(*)
-- ----  --------
-- 11    166231
-- 26    69025
-- 28    58345
-- 41    247369
-- 47    54438
-- 48    68530

-- 키(height)를 기준으로 구분하고, 각 키와 사람의 수를 출력하시오.
SELECT height, COUNT(*)
FROM healthcare
GROUP BY height
ORDER BY COUNT(height) DESC
LIMIT 5;
-- height  COUNT(*)
-- ------  --------
-- 160     184993
-- 155     181306
-- 165     179352
-- 170     152585
-- 150     128555

-- 키(height)와 몸무게(weight)를 기준으로 구분하고, 몸무게와, 키, 해당 그룹의 사람의 수를 출력하시오.
SELECT height, weight, COUNT(*)
FROM healthcare
GROUP BY height, weight
ORDER BY COUNT(height), COUNT(weight) DESC
LIMIT 5;
-- height  weight  COUNT(*)
-- ------  ------  --------
-- 155     55      45866
-- 160     60      42454
-- 165     65      40385
-- 155     50      38582
-- 160     55      38066

-- 음주여부에 따라 평균 허리둘레(waist)와 사람의 수를 출력하시오.
SELECT is_drinking, AVG(waist), COUNT(*)
FROM healthcare
WHERE is_drinking != ''
GROUP BY is_drinking;
-- is_drinking  AVG(waist)        COUNT(*)
-- -----------  ----------------  --------
-- 0            81.2128249971711  415119
-- 1            83.1541594191841  584685

-- 각 성별(gender)의 평균 왼쪽 시력(va_left)과 평균 오른쪽 시력(va_right)를 출력하시오.
SELECT gender, AVG(va_left) AS "평균 왼쪽 시력", AVG(va_right) AS "평균 오른쪽 시력"
FROM healthcare
GROUP BY gender;
-- gender  평균 왼쪽 시력           평균 오른쪽 시력
-- ------  -----------------  -----------------
-- 1       0.982933448735035  0.98803371523777
-- 2       0.880487563125815  0.879241116591859

-- 각 나이대(age)의 평균 키와 평균 몸무게를 출력하시오.
SELECT age, AVG(height) AS "평균 키", AVG(weight) AS "평균 몸무게"
FROM healthcare
GROUP BY age
HAVING AVG(height) >= 160 and AVG(weight) >= 60;
-- age  평균 키              평균 몸무게
-- ---  ----------------  ----------------
-- 9    165.66545300972   67.2402208898302
-- 10   164.119689244962  65.677140776194
-- 11   162.111550610398  63.9036737713782
-- 12   160.653006214415  62.5955563062588

-- 음주 여부(is_drinking)와 흡연 여부(smoking)에 따른 평균 BMI를 출력하시오.
SELECT is_drinking, smoking, AVG(weight/((height*0.01)*(height*0.01))) AS "평균 BMI"
FROM healthcare
GROUP BY is_drinking, smoking
HAVING is_drinking != '' AND smoking != '';
-- is_drinking  smoking  평균 BMI
-- -----------  -------  ----------------
-- 0            1        23.8724603942955
-- 0            2        24.6073677352564
-- 0            3        24.3193273448558
-- 1            1        23.9341328992508
-- 1            2        25.0333550564281
-- 1            3        24.6363247421328

-- 각 나이대와 음주 여부에 따른 평균 허리 둘레를 출력하시오.
SELECT age, is_drinking, AVG(waist)
FROM healthcare
WHERE age != '' AND is_drinking != ''
GROUP BY age, is_drinking;
-- age  is_drinking  AVG(waist)
-- ---  -----------  ----------------
-- 9    0            79.0651129572957
-- 9    1            82.3944884020281
-- 10   0            78.7903278338412
-- 10   1            82.3147617351521
-- 11   0            79.3419345330978
-- 11   1            82.5145923546893
-- 12   0            80.1595987097673
-- 12   1            83.1989927477841
-- 13   0            81.3082194595704
-- 13   1            84.0470103520199
-- 14   0            82.7257305357939
-- 14   1            85.1536900919478
-- 15   0            83.5688767134541
-- 15   1            85.9018309294874
-- 16   0            84.1275771311596
-- 16   1            86.2759195525917
-- 17   0            84.0633965068746
-- 17   1            85.8618807540552
-- 18   0            81.5982988842145
-- 18   1            84.8442132639792

-- 각 나이대의 평균 BMI를 출력하시오.
SELECT age, (weight/((height*0.01)*(height*0.01))) AS "평균 BMI"
FROM healthcare
WHERE age != ''
GROUP BY age;
-- age  평균 BMI
-- ---  ----------------
-- 9    22.0385674931129
-- 10   29.296875
-- 11   20.0
-- 12   22.8928199791883
-- 13   28.8888888888889
-- 14   20.0
-- 15   20.2020202020202
-- 16   22.8928199791883
-- 17   22.2222222222222
-- 18   22.0385674931129

-- 성별에 따른 평균 키, 평균 허리 둘레, 평균 BMI를 출력하시오.
SELECT gender, AVG(height), AVG(weight), AVG(weight/((height*0.01)*(height*0.01))) AS "평균 BMI"
FROM healthcare
WHERE gender != '' AND height != '' AND weight != ''
GROUP BY gender;
-- gender  AVG(height)       AVG(weight)       평균 BMI
-- ------  ----------------  ----------------  ----------------
-- 1       167.452735422145  69.7131620222875  24.8076921115717
-- 2       154.191945408953  56.1177758112938  23.6104764922507
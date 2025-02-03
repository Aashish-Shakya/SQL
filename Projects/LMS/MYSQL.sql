CREATE DATABASE college;


USE college;



CREATE TABLE student(
rollno INT PRIMARY KEY,
name VARCHAR(50),
marks INT NOT NULL,
grade VARCHAR(1),
city VARCHAR(20)
);

 


INSERT INTO student
(rollno, name, marks, grade, city)
VALUES
(101, "anil", 78, "C", "Pune"),
(102, "bhumika", 93, "A", "Mumbai"),
(103, "chetan", 85, "B", "Mumbai"),
(104, "dhruv", 96, "A", "Delhi"),
(105, "emanuel", 12, "F", "Delhi"),
(106, "farah", 82, "B", "Delhi");





SELECT * FROM student;





SELECT name, marks FROM student;

SELECT name, marks FROM student;


SELECT DISTINCT city FROM student;










-- ---------------- Where Clause -------------------------

SELECT * FROM student WHERE City = "Delhi";




SELECT * FROM student WHERE city = "Mumbai" ;




-- ---------------- Where Clause with AND, OR -------------------------


SELECT * 
FROM student 
WHERE marks BETWEEN 78 AND 82 
limit 1;



SELECT * 
FROM student 
WHERE marks > 80  OR city = "Mumbai" ;



-- --------------Where Clause with ARTHIMETIC OPERATOR----------------------------------


SELECT  AVG(marks) FROM student;
SELECT  sum(grade) FROM student;
SELECT  count(name)   FROM student ;



-- ORDER BY ASC DESC

SELECT * 
FROM student 
ORDER BY MARKS DESC ;


-- GROUP BY 


/*
WHERE  --> NO AGGREGATE
GROUP BY 
ORDER BY 
HAVING  -- AGGREGATE FN
*/

SELECT CITY 
FROM student
where city between "A" and "D";



SELECT grade, count(name) 
FROM student
GROUP BY grade;



-- where - rows
-- having - columns



SELECT city, count(name) 
FROM student
GROUP BY city
HAVING MAX(marks)>90;
 
 
 -- genreal order of clauses
 
SELECT city 
FROM student
WHERE GRADE = "A"
GROUP BY city
HAVING MAX(marks)>90
ORDER BY city ASC;
 
 
 -- SAFE MODE - PREVENT TO MAKE CHANES IN DB - SO TO UPDATE WE HAVE TO DISABE IT
 SET  SQL_SAFE_UPDATES =  0;
 
 
UPDATE student
SET grade = "O"
WHERE grade = "A";


SELECT * 
FROM student ;

UPDATE student
SET marks = 32
WHERE rollno = 105;

DELETE FROM student
WHERE marks < 33;
 
 
 
 -- PK and FK
 
 
CREATE TABLE dept(
id INT PRIMARY KEY,
name VARCHAR(50)
);

INSERT INTO DEPT
VALUES
(101, "ENGLISH"),
(102, "HINDI"),
(103, "COMPUTER");
 
 
CREATE TABLE teacher(
id INT PRIMARY KEY,
name VARCHAR(50) ,
dept_id INT,
FOREIGN KEY (dept_id) REFERENCES dept(id)

-- to make changes wheneer update in both tables
ON UPDATE CASCADE
ON DELETE CASCADE
);

INSERT INTO teacher
VALUES
(101, "ADAM" , 103),
(102, "EVE", 101 ),
(103, "CHOPPER", 102);
 
 
 select * from dept;
 select * from teacher;
 -- an example of cascading
 
 UPDATE dept
 SET id = 100
 WHERE id = 103;
 
 -- ALter queries --
 SELECT * FROM student;
 
 ALTER TABLE student 
 ADD COLUMN age INT;
 
 
 ALTER TABLE student
 DROP COLUMN age;
 
 
 ALTER TABLE student;
 
 
 
 -- TRUNCATE - ONLY DELETES DATA
 -- DROP - DELETE THE WHOLE TABLE
 
 TRUNCATE TABLE student;
 
 
 -- PQ --
 ALTER TABLE student
 CHANGE COLUMN name full_name VARCHAR(50) ;
 
 DELETE FROM student
WHERE marks < 80;


ALTER TABLE student
DROP COLUMN grades;

-- -------------------------------------------

select NAME, substring(name, 1,3) from students;
select replace("   this   sdfcsdv      is a   new phone    ", " ", ".") as name1;
SELECT NOW();
SELECT INSTR("Yahoo BabaBaba","oo") AS Name;

SELECT LOCATE("Y","Yahoo Baba Baba", 1) AS Name;


SELECT  CONCAT(SALARY, " ", COUNT(*)) FROM EMPLOYEEES
WHERE SALARY = (SELECT  MAX(SALARY) FROM EMPLOYEEES)
GROUP BY SALARY ;

SELECT ROUND(SUM(SALARY),1) FROM EMPLOYEEES;
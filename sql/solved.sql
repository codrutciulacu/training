-- Sa se creeze tabelele si legaturile dintre acestea conform modelului specificat

CREATE DATABASE TRAINING;
USE TRAINING;

CREATE TABLE SAL_GRADE (
	ID INT PRIMARY KEY,
	MIN_SAL NUMERIC(18, 0),
	MAX_SAL NUMERIC(18, 0)
);

CREATE TABLE FACULTY (
	FACULTY_ID INT PRIMARY KEY AUTO_INCREMENT,
	NAME VARCHAR(50) NOT NULL
);

CREATE TABLE DEPT (
	DEPT_NO INT PRIMARY KEY AUTO_INCREMENT,
	NAME VARCHAR(50) NOT NULL,
	LOCATION TEXT NULL
);

CREATE TABLE PERSON (
	CNP VARCHAR(13) PRIMARY KEY,
	NAME VARCHAR(100) NOT NULL,
	DOB DATE NOT NULL,
	GENDER VARCHAR(10) NOT NULL,
	BIRTH_PLACE TEXT
);

CREATE TABLE STUDENT (
	CNP VARCHAR(13) PRIMARY KEY,
	FACULTY_ID INT NOT NULL,
	STUDENT_ID INT NOT NULL,

	CONSTRAINT FK_CNP FOREIGN KEY (CNP)
		REFERENCES PERSON (CNP),
	CONSTRAINT FK_FACULTY FOREIGN KEY(FACULTY_ID)
		REFERENCES FACULTY(FACULTY_ID)
);

CREATE TABLE EMP (
	EMP_NO INT PRIMARY KEY AUTO_INCREMENT,
	CNP VARCHAR(13) NOT NULL,
	DEPT_NO INT NOT NULL,
	MANAGER INT NULL,
	EMP_DATE DATE NOT NULL,
	SAL NUMERIC(18, 2) NOT NULL,
	COM NUMERIC(18, 2) NULL,

	CONSTRAINT FK_MANAGER FOREIGN KEY (MANAGER)
		REFERENCES EMP (EMP_NO),
	CONSTRAINT FK_CNP2 FOREIGN KEY (CNP)
		REFERENCES PERSON(CNP),
	CONSTRAINT FK_DEPT FOREIGN KEY (DEPT_NO)
		REFERENCES DEPT(DEPT_NO)
);



-- Sa se adauge cate 5 intrari in fiecare tabela 

INSERT INTO FACULTY (NAME) VALUES ('ACS');
INSERT INTO FACULTY (NAME) VALUES ('FILS');
INSERT INTO FACULTY (NAME) VALUES ('ETTI');
INSERT INTO FACULTY (NAME) VALUES ('FIIR');
INSERT INTO FACULTY (NAME) VALUES ('Aerospatiala');

INSERT INTO DEPT (NAME, LOCATION) VALUES ('SALES', 'MALUL DUNARII');
INSERT INTO DEPT (NAME) VALUES ('IT');
INSERT INTO DEPT (NAME) VALUES ('PR');
INSERT INTO DEPT (NAME) VALUES ('HR');
INSERT INTO DEPT (NAME) VALUES ('Design');

INSERT INTO SAL_GRADE (ID, MIN_SAL, MAX_SAL) VALUES (1, 1000, 2000);
INSERT INTO SAL_GRADE (ID, MIN_SAL, MAX_SAL) VALUES (2, 2000.01, 5000.42);
INSERT INTO SAL_GRADE (ID, MIN_SAL, MAX_SAL) VALUES (3, 5000.68, 5000.77);
INSERT INTO SAL_GRADE (ID, MIN_SAL, MAX_SAL) VALUES (4, 5000.78, 500000);
INSERT INTO SAL_GRADE (ID, MIN_SAL, MAX_SAL) VALUES (5, 500000.01, 1000000);

INSERT INTO PERSON (CNP, NAME, DOB, GENDER, BIRTH_PLACE) VALUES
	('1000000000123', 'AUREL', STR_TO_DATE('01/01/1900', '%d/%m/%Y'), 'MALE', 'CANAL');
INSERT INTO PERSON (CNP, NAME, DOB, GENDER, BIRTH_PLACE) VALUES
	('2000000000523', 'GICA', STR_TO_DATE('01/01/1900', '%d/%m/%Y'), 'FEMALE', 'CANAL');
INSERT INTO PERSON (CNP, NAME, DOB, GENDER, BIRTH_PLACE) VALUES
	('1000000030113', 'BANEL', STR_TO_DATE('01/01/1900', '%d/%m/%Y'), 'MALE', 'CANAL');
INSERT INTO PERSON (CNP, NAME, DOB, GENDER, BIRTH_PLACE) VALUES
	('1000003000123', 'FAGURAS', STR_TO_DATE('01/01/1900', '%d/%m/%Y'), 'MALE', 'CANAL');
INSERT INTO PERSON (CNP, NAME, DOB, GENDER, BIRTH_PLACE) VALUES
	('2991027370012', 'ILEANA', STR_TO_DATE('01/10/1999', '%d/%m/%Y'), 'FEMALE', 'CANAL');

INSERT INTO STUDENT(CNP, FACULTY_ID, STUDENT_ID) VALUES ('1000000000123', 1, 1);
INSERT INTO STUDENT(CNP, FACULTY_ID, STUDENT_ID) VALUES ('2991027370012', 1, 2);
INSERT INTO STUDENT(CNP, FACULTY_ID, STUDENT_ID) VALUES ('1000000030113', 2, 3);
INSERT INTO STUDENT(CNP, FACULTY_ID, STUDENT_ID) VALUES ('1000003000123', 3, 4);
INSERT INTO STUDENT(CNP, FACULTY_ID, STUDENT_ID) VALUES ('2000000000523', 4, 5);

INSERT INTO EMP(CNP, DEPT_NO, MANAGER, EMP_DATE, SAL, COM)
	VALUES ('1000000000123', 1, NULL, STR_TO_DATE('30/12/1999', '%d/%m/%Y'), 15000, NULL);
INSERT INTO EMP(CNP, DEPT_NO, MANAGER, EMP_DATE, SAL, COM)
	VALUES ('2000000000523', 1, 1, STR_TO_DATE('30/12/2000', '%d/%m/%Y'), 1500, NULL);
INSERT INTO EMP(CNP, DEPT_NO, MANAGER, EMP_DATE, SAL, COM)
	VALUES ('1000000030113', 3, 1, STR_TO_DATE('30/12/2004', '%d/%m/%Y'), 3000, 11.02);
INSERT INTO EMP(CNP, DEPT_NO, MANAGER, EMP_DATE, SAL, COM)
	VALUES ('1000003000123', 4, 3, STR_TO_DATE('30/12/2020', '%d/%m/%Y'), 2000, 15.72);
INSERT INTO EMP(CNP, DEPT_NO, MANAGER, EMP_DATE, SAL, COM)
	VALUES ('2991027370012', 2, 2, STR_TO_DATE('15/04/2001', '%d/%m/%Y'), 1500, NULL);

-- Sa se afiseze toate intrarile din fiecare tabela

SELECT * FROM EMP;
SELECT * FROM PERSON;
SELECT * FROM SAL_GRADE;
SELECT * FROM STUDENT;
SELECT * FROM FACULTY;

-- Sa se afiseze toate persoanele de un anumit sex

SELECT *
FROM PERSON
WHERE GENDER LIKE 'MALE';

-- Sa se afiseze toti angajatii din departamentul cu id-ul 3

SELECT *
FROM EMP
WHERE DEPT_NO=3;

-- Nume ang - dept 3

SELECT NAME
FROM PERSON P
JOIN EMP E ON E.CNP=P.CNP
WHERE E.DEPT_NO=3;

-- Sa se actualizeze la alegere o intrare din orice tabela

UPDATE SAL_GRADE
SET MIN_SAL=999
WHERE ID=1;

-- Sa se stearga o intrare din tabela SAL_GRADE
-- DELETE FROM SAL_GRADE WHERE ID=5;

-- Sa se stearga tabela SAL_GRADE
-- DROP TABLE SAL_GRADE;

-- Sa se refaca tabela SAL_GRADE (copiati ce ati scris anterior)

-- Sa se gaseasca toti angajatii de sex feminin

SELECT NAME
FROM PERSON P
JOIN EMP E ON E.CNP=P.CNP
WHERE P.GENDER LIKE 'FEMALE';

-- Sa se gaseasca angajatii din departamentul cu numele 'IT'

SELECT *
FROM EMP E
JOIN DEPT D ON E.DEPT_NO=D.DEPT_NO
WHERE D.NAME LIKE 'IT';

SELECT *
FROM EMP
NATURAL JOIN DEPT
WHERE NAME LIKE 'IT';

-- Sa se gaseasca id-urile tuturor studentilor care sunt si angajati

SELECT STUDENT_ID
FROM STUDENT
NATURAL JOIN EMP;

-- Sa se gaseasca id-urile tuturor studentilor care sunt angajati in departamentul 'IT'

SELECT STUDENT_ID
FROM STUDENT S
JOIN EMP E ON E.CNP=S.CNP
JOIN DEPT D ON E.DEPT_NO=D.DEPT_NO
WHERE D.NAME LIKE 'IT';


-- Sa se gaseasca numarul total de persoane

SELECT COUNT(*)
FROM PERSON;

-- Sa se afiseze gradul salarial, valorile acestuia si salariul total  pentru fiecare angajat, luand in calcul si comisionul ordonati crescator dupa EMP_ID

SELECT 	G.ID AS 'ID',
	G.MIN_SAL,
	G.MAX_SAL,
	E.SAL + IFNULL(E.COM, 0) 'VENIT'
FROM 	EMP E
JOIN 	SAL_GRADE G ON	E.SAL+IFNULL(E.COM, 0)<MAX_SAL AND
			E.SAL+IFNULL(E.COM, 0)>MIN_SAL
ORDER BY E.EMP_NO ASC;

-- Gradul salarial al studentiilor din 'ACS'

SELECT	S.STUDENT_ID,
	G.ID
FROM STUDENT S
JOIN EMP E ON E.CNP = S.CNP
JOIN SAL_GRADE G ON	E.SAL < G.MAX_SAL AND
			E.SAL > G.MIN_SAL
JOIN FACULTY F ON F.FACULTY_ID=S.FACULTY_ID
WHERE F.FACULTY_ID LIKE 'ACS';

DROP DATABASE TRAINING;
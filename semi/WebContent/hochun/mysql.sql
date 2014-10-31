create table insa(
empno	int not null		auto_increment,
ename	varchar(10),
position	varchar(10),
dept		varchar(10),
hire_date	date ,
CONSTRAINT	pk_no PRIMARY KEY(empno)
);

INSERT INTO insa(ename, position, dept, hire_date) values ('홍길동', '대리',  '영업', sysdate());
INSERT INTO insa(ename, position, dept, hire_date) values( '임꺽정', '대리',  '영업', sysdate());
INSERT INTO insa(ename, position, dept, hire_date) values( '이순신', '주임',  '영업', '2014/10/10');
INSERT INTO insa(ename, position, dept, hire_date) values( '신돌석', '주임',  '기술', '2014/10/10');
INSERT INTO insa(ename, position, dept, hire_date) values( '장보고', '과장',  '기술', '2012/12/07' );
INSERT INTO insa(ename, position, dept, hire_date) values( '안창호', '과장',  '기획', '2012/12/07');
INSERT INTO insa(ename, position, dept, hire_date) values( '윤봉길', '부장',  '기획', '2007/12/17');

select * from insa;

create table sal_grade(
dept	varchar(10) not null,
d_code	int,
p_code	int,
sal			int
);
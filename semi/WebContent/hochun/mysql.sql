create table insa(
empno	int not null		auto_increment,
ename	varchar(10),
position	varchar(10),
dept		varchar(10),
hire_date	date ,
CONSTRAINT	pk_no PRIMARY KEY(empno)
);

INSERT INTO insa(ename, position, dept, hire_date) values ('ȫ�浿', '�븮',  '����', sysdate());
INSERT INTO insa(ename, position, dept, hire_date) values( '�Ӳ���', '�븮',  '����', sysdate());
INSERT INTO insa(ename, position, dept, hire_date) values( '�̼���', '����',  '����', '2014/10/10');
INSERT INTO insa(ename, position, dept, hire_date) values( '�ŵ���', '����',  '���', '2014/10/10');
INSERT INTO insa(ename, position, dept, hire_date) values( '�庸��', '����',  '���', '2012/12/07' );
INSERT INTO insa(ename, position, dept, hire_date) values( '��âȣ', '����',  '��ȹ', '2012/12/07');
INSERT INTO insa(ename, position, dept, hire_date) values( '������', '����',  '��ȹ', '2007/12/17');

select * from insa;

create table sal_grade(
dept	varchar(10) not null,
d_code	int,
p_code	int,
sal			int
);
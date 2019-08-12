create table [dep]
(
[deptno] int primary key,
[dname] char(10) not null
) 

create table [emp]
(
empno int primary key,
ename char(50) not null,
job char(20) not null,
mgr char(20),
sal int not null,
deptno int not null 
)

insert into [dep]
select 1,'��ҵ��' union
select 2,'���۲�' union
select 3,'������'

insert into [emp]
select 01,'jacky','clerk','tom',1000,1 union
select 02,'tom','clerk',null,2000,1 union
select 07,'biddy','clerk','tom',2000,1 union
select 03,'jenny','sales','pretty',600,2 union
select 04,'pretty','sales',null,800,2 union
select 05,'buddy','jishu','candy',1000,3 union
select 06,'canndy','jishu',null,1500,3

select * from [dep]
select * from [emp]
--1 �г� emp ���и����ŵĲ��źţ���߹��ʣ���͹���
select deptno as ���ź�,max(sal) as ��߹���,min(sal) as ��͹���
from [emp]
group by deptno

--2 �г� emp ���и����� job Ϊ'clerk'��Ա������͹��ʣ���߹���
select deptno as ���ź�, max(sal) as ��߹���, min(sal) as ��͹���
from [emp]
where job='clerk'
group by deptno

--3 ���� emp ����͹���С�� 1000 �Ĳ��ţ��г� job Ϊ'clerk'��Ա���Ĳ��źţ���͹��ʣ���߹���
select deptno as ���ź�, min(sal) as ��͹���, max(sal) as ��߹���
from [emp]
where sal<1000 and job='clerk'
group by deptno,job
 
--4 ���ݲ��ź��ɸ߶��ͣ������еͶ����г�ÿ��Ա�������������źţ�����
select ename as ����,deptno as ���ź�, sal as ����
from [emp]
order by deptno desc, sal asc

--5 �г�ÿ��Ա�������������������źţ�������
select b.ename as ����,b.job as ����, b.deptno as ���ź�,a.dname as ������
from [dep] as a
inner join [emp] as b
on a.deptno=b.deptno 

--6 �г� emp �й���Ϊ'clerk'��Ա�����������������źţ�������
select b.ename as ����,b.job as ����, b.deptno as ���ź�,a.dname as ������
from [dep] as a
inner join [emp] as b
on a.deptno=b.deptno 
where job='clerk'

--7���� emp���г����������й��ʸ��ڱ�����ƽ��ˮƽ��Ա���Ͳ��źţ������ź�����
select a.empno as Ա�����,a.sal as ����,a.deptno as ���ű�� 
from emp  a,
(select deptno,avg(sal) as asal 
from emp 
group by deptno) a1 
where a.deptno=a1.deptno and a.sal>a1.asal
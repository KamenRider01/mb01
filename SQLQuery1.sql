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
select 1,'事业部' union
select 2,'销售部' union
select 3,'技术部'

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
--1 列出 emp 表中各部门的部门号，最高工资，最低工资
select deptno as 部门号,max(sal) as 最高工资,min(sal) as 最低工资
from [emp]
group by deptno

--2 列出 emp 表中各部门 job 为'clerk'的员工的最低工资，最高工资
select deptno as 部门号, max(sal) as 最高工资, min(sal) as 最低工资
from [emp]
where job='clerk'
group by deptno

--3 对于 emp 中最低工资小于 1000 的部门，列出 job 为'clerk'的员工的部门号，最低工资，最高工资
select deptno as 部门号, min(sal) as 最低工资, max(sal) as 最高工资
from [emp]
where sal<1000 and job='clerk'
group by deptno,job
 
--4 根据部门号由高而低，工资有低而高列出每个员工的姓名，部门号，工资
select ename as 姓名,deptno as 部门号, sal as 工资
from [emp]
order by deptno desc, sal asc

--5 列出每个员工的姓名，工作，部门号，部门名
select b.ename as 姓名,b.job as 工作, b.deptno as 部门号,a.dname as 部门名
from [dep] as a
inner join [emp] as b
on a.deptno=b.deptno 

--6 列出 emp 中工作为'clerk'的员工的姓名工作，部门号，部门名
select b.ename as 姓名,b.job as 工作, b.deptno as 部门号,a.dname as 部门名
from [dep] as a
inner join [emp] as b
on a.deptno=b.deptno 
where job='clerk'

--7对于 emp，列出各个部门中工资高于本部门平均水平的员工和部门号，按部门号排序
select a.empno as 员工编号,a.sal as 工资,a.deptno as 部门编号 
from emp  a,
(select deptno,avg(sal) as asal 
from emp 
group by deptno) a1 
where a.deptno=a1.deptno and a.sal>a1.asal
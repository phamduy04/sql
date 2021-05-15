use master
go
create database de3
go
use de3
create table ton(
  mavt nchar(10) not null primary key,
  tenvt varchar(20) not null,
  soluongt int
)
create table nhap(
sohdn nchar(10) not null,
mavt nchar(10) not null,
soluongn int,
dongian money,
ngayn datetime,
constraint fk_nhap primary key(sohdn,mavt),
constraint fk_nhap_ton foreign key(mavt) references ton(mavt)
)
create table xuat(
sohdx nchar(10) not null,
mavt nchar(10) not null,
soluongx int,
dongianx money,
ngayx datetime,
constraint fk_xuat primary key(sohdx,mavt),
constraint fk_xuat_ton foreign key(mavt) references ton(mavt)
)


insert into nhap values(N'n1',N'T2',10,100,'12/9/2000')
insert into nhap values(N'n2',N'T3',20,200,'13/11/2001')
insert into nhap values (N'n3',N'T1',30,300,'15/9/2000')

insert into ton values(N'T1',N'TAO',10)
insert into ton values(N'T2',N'LE',120)
insert into ton values(N'T3',N'MIT',50)
insert into ton values(N'T4',N'HOA',130)


insert into xuat values(N'hdx1',N'T1',20,2000,'19/2/2010')
insert into xuat values(N'hdx2',N'T2',230,4000,'23/1/2014')
insert into xuat values(N'hdx3',N'T3',60,23000,'29/12/2017')

select*from nhap
select*from xuat
select*from ton
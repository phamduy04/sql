use master 
go 
create database de2
go 
use de2
create table nhaxuatban(
maxb nchar(10) not null primary key,
tenxb varchar(20) not null,
soluongxb int
)
create table tacgia(
 matg nchar(10) not null primary key,
 tentg varchar(20) not null,
)
create table sach(
 masach nchar(10) not null primary key,
 tensach varchar(20) not null,
 namxb datetime,
 soluong int,
 dongia money,
 matg nchar(10),
 maxb nchar(10),
 constraint fk_sach_nhaxuatban foreign key(maxb) references nhaxuatban(maxb),
 constraint fk_sach_tacgia foreign key( matg) references tacgia(matg)
)

insert into nhaxuatban values(N'a1',N'duy',10)
insert into nhaxuatban values(N'a2',N'huy',50)

insert into tacgia values(N'TG1',N'ABC')
insert into tacgia values(N'TG2',N'ABCD')

insert into sach values(N's1',N'ly','1/1/2000',10,1000,N'TG2',N'a1')
insert into sach values(N's2',N'toan','12/5/2001',16,12000,N'TG2',N'a2')
insert into sach values(N's3',N'sinh','10/10/2002',34,1500,N'TG1',N'a1')

select*from nhaxuatban
select*from tacgia
select*from sach

--cau2--
create view vw_cau2
as
select nhaxuatban.maxb,nhaxuatban.tenxb,
SUM(nhaxuatban.soluongxb) as 'tongsl',
SUM(sach.soluong*sach.dongia) as'tien sach'
from sach inner join nhaxuatban on nhaxuatban.maxb=sach.maxb
inner join tacgia on tacgia.matg=sach.matg
group by  nhaxuatban.maxb,nhaxuatban.tenxb
select*from vw_cau2

--cau 3--
create function fn_cau3(@tenxb varchar(20),@x datetime,@y datetime)
returns table
as
return(
 select sach.masach,sach.tensach,tacgia.tentg,sach.dongia 
 from sach inner join nhaxuatban on nhaxuatban.maxb=sach.maxb
 inner join tacgia on tacgia .matg=sach.matg
 where tenxb=@tenxb and namxb between @x and @y
)
select*from fn_cau3(N'duy','1/1/1999','10/12/2010')

--cau 4---
create function fn_cau4(@tentg varchar(20),@tenxb varchar(20))
returns table
as
return(
select sach.masach,sach.tensach,nhaxuatban.tenxb,sach.namxb,sach.soluong,sach.dongia,
SUM(sach.soluong*sach.dongia)as 'tien'
from sach inner join nhaxuatban on nhaxuatban.maxb=sach.maxb
inner join tacgia on tacgia.matg=sach.matg
where tentg=@tentg and tenxb=@tenxb
group by sach.masach,sach.tensach,nhaxuatban.tenxb,sach.namxb,sach.soluong,sach.dongia
)
select*from fn_cau4(N'ABC',N'duy')
use master
go
create database de4
go
use de4
go 
create table ton(
  mavt nchar(10) not null primary key,
  tenvt varchar(20) not null,
  soluongt int
)
create table nhap(
 sohdn nchar(10) not null primary key,
 mavt nchar(10),
 soluongn int,
 dongian money,
 ngayn datetime,
 constraint fk_nhap_ton foreign key(mavt) references ton(mavt)
)
create table xuat(
 sohdx nchar(10) not null primary key,
 mavt nchar(10),
 soluongx int,
 dongiax money,
 ngayx datetime,
 constraint fk_xuat_ton foreign key(mavt) references ton(mavt)
)

insert into ton values('t1',N'táo',100)
insert into ton values('t2',N'lê',200)
insert into ton values('t3',N'mít',300)
insert into ton values('t4',N'hoa',150)

insert into nhap values('n1','t1',13,1600,'20/10/2000')
insert into nhap values('n2','t2',16,1500,'18/6/2001')
insert into nhap values('n3','t3',13,1900,'8/7/2002')

insert into xuat values('x1','t1',100,1300,'29/5/2010')
insert into xuat values('x2','t2',170,2300,'9/10/2014')
insert into xuat values('x3','t3',160,4500,'23/9/2020')

select*from nhap
select*from xuat
select*from ton

--cau 2--
create function fn_cau2(@mavt nchar(10) ,@ngayn datetime)
returns table
as
return(
 select nhap.ngayn ,ton.mavt,ton.tenvt,
 SUM(nhap.soluongn*nhap.dongian)as 'tiennhap'
 from ton inner join nhap on nhap.mavt=ton.mavt
 where ton.mavt=@mavt and ngayn=@ngayn
  group by nhap.ngayn ,ton.mavt,ton.tenvt
)
select*from fn_cau2('t2','20/10/2000')

--cau 3--
create proc cau3(@sohnx nchar(10),@mavt nchar(10),@soluongx int,@dongiax money,@ngyx datetime)
as
begin
   declare @slt int
   set @slt=(select ton.soluongt from ton
              where ton.mavt=@mavt)
    if(@soluongx<=@slt)
    begin
       insert into xuat values(@sohnx,@mavt,@soluongx,@dongiax,@ngyx)
    end   
    else
     begin
         frint(N'so luong ton k du')
     end       
end

use master
go
create database dethu6
go
use dethu6
go 
create table vattu(
    mavt varchar(10) not null primary key,
    tenvt nvarchar(20) not null,
    dvtinh nvarchar(20),
    slcon int
)
create table hoadon(
  mahd varchar(10) not null primary key,
  ngaylap date,
  hotenkhach nvarchar(20) not null,
)
create table cthoadon(
     mahd varchar(10) not null,
        mavt varchar(10) not null,
     dongiaban money,
     slban int,
     constraint  fk_cthoadon primary key(mahd,mavt),
     constraint fk_cthoadon_vattu foreign key(mavt) references vattu (mavt),
     constraint fk_cthoadon_hoadon foreign key(mahd) references hoadon (mahd)
)

insert into vattu values('vt1',N'vattu1',N'cai',12)
insert into vattu values('vt2',N'vattu2',N'cai',37)
insert into vattu values('vt3',N'vattu3',N'cai',52)

insert into hoadon values('hd1','2000-07-14',N'a')
insert into hoadon values('hd2','2013-04-23',N'b')
insert into hoadon values('hd3','2016-10-19',N'c')

insert into cthoadon values('hd1','vt1',1000,16)
insert into cthoadon values('hd2','vt2',1040,13)
insert into cthoadon values('hd3','vt3',1230,37)
insert into cthoadon values('hd1','vt2',1410,84)
insert into cthoadon values('hd2','vt3',1820,19)

--hien thi--
select*from vattu
select*from hoadon
select*from cthoadon

--cau 2--
create function cau2(@ten nvarchar(20),@ngban date)
returns money
as
begin
  declare @tong money
   select @tong=SUM(cthoadon.dongiaban*cthoadon.slban)
      from cthoadon inner join vattu on vattu.mavt=cthoadon.mavt
                   inner join hoadon on hoadon.mahd=cthoadon.mahd
       where vattu.tenvt=@ten and hoadon.ngaylap=@ngban
       group by cthoadon.dongiaban,cthoadon.slban
       return @tong            
end

-- hien thi --
select dbo.cau2(N'vattu1','2000-07-14') as N'TONG TIEN BAN'

--cau 3--
create proc cau3(@thang int,@nam int)
as
begin
     declare @tong int
     select @tong=sum(cthoadon.slban)
           from cthoadon inner join hoadon on hoadon.mahd=cthoadon.mahd
           where MONTH(hoadon.ngaylap)=@thang and
                 YEAR(hoadon.ngaylap)=@nam
                 group by MONTH(hoadon.ngaylap),YEAR(hoadon.ngaylap)
           print(N'TONG SO LUONG VAT TU BAN TRONG')+cast(@thang as char(5)) 
             +(cast(@nam as char(10)))
           print N'LA:' +(cast(@tong as char(20)))               
  end
  
--hien thi--
execute cau3   07,2000
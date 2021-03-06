use master 
go
 create database qlsv
 go
 use qlsv 
 go
 create table gv (
   magv nvarchar(10) not null primary key,
   tengv varchar(20) not null,
   email nvarchar(20),
   phone nchar(10),
 )
  create table lop(
    malop nvarchar(10) not null primary key,
    tenlop varchar(20) not null,
    phong varchar(16),
    magv nvarchar(10),
    constraint fk_gv_lop foreign key(magv) references gv(magv)
 )
 create table sv(
   masv nchar(20) not null primary key,
   tensv nchar(30) not null,
   que nchar(20), 
   ngaysinh datetime,
   gioitinh nchar(10),
   malop nvarchar(10)
   constraint FK_lop_sv foreign key(malop) references lop(malop)
 )
---insert--
 insert into gv values('a1',N'minh','abc@gmail.com','0123')
 insert into gv values('a2',N'ngoan','abcd@gmail.com','012345')
 insert into gv values('a3',N'ngoc','abced@gmail.com','0145')
 
 insert into lop values('b1',N'ktpm3',N'may','a2')
  insert into lop values('b2',N'ktpm1',N'hoa','a1')
   insert into lop values('b3',N'ktpm2',N'sinh','a3')
   
 insert into sv values('01',N'duy',N'namdinh','04/11/2000',N'nu','b3')
insert into sv values('03',N'huy',N'haihau','04/12/2000',N'nam','b1')
insert into sv values('04',N'thai',N'namdinh','04/10/2000',N'nu','b2')   
   select* from gv
   select*from lop
   select*from sv
   --- danh sach sv hoc ktpm3---
  create view vw_dshvs
  as
    select masv,tensv
    from sv inner join lop on lop.malop=sv.malop
    where tenlop=N'ktpm3'
    select*from vw_dshvs
    
 --- danh sach sv nam cung co chu nhiem ngoan
  create view vw_dssv
  as
  select masv,tensv
    from sv inner join lop on lop.malop=sv.malop
    inner join gv on gv.magv=lop.magv
    where tengv=N'ngoan' 
    select*from vw_dssv  
  --- ds cac sque namdinh vaf so luong nu hoc lop ktpm3 
  create view vw_ds
  as 
  select que,COUNT(*)as 'tong nu' 
  from sv inner join lop on lop.malop=sv.malop
  where tenlop=N'ktpm3'
  group by que
select*from vw_ds

-- dua ra cac ten gv va sl sv  maf cac gv chu nhiem, lay cac hv co toing sv nu>= 1 sv
create view vw_dssinhvien
as
select tengv,COUNT(*) as 'tong'
from sv inner join lop on lop.malop=sv.malop
inner join gv on gv.magv=lop.magv
group by tengv
having count(*)>=1
select*from vw_dssinhvien

-- hãy viest hàm dưa ra danh sách các sv học lớp với ten lớp nhập từ bàn phím
create function fc_ds(@tenlop varchar(20)) 
returns @bangtable
(
    masv nchar(20),
    tensv nchar(30),
     que nchar(20),
       gioitinh nchar(10),
       tuoi int,  
)
as
 begin
 insert into @bang
 select masv,que,gioitinh,YEAR(getdate()).YEAR(ngaysinh)
 from sv inner join lop on lop.malop=sv.malop
 where tenlop=@tenlop
 end
 return
 select*from fc_ds('ktpm3')
 --viet thu tuc dem so sc hoc lop x va que y voi x,y nhap tu ban phim
 create function fc_demsv(@x nvarchar(20),@y nvarchar(20)
 returns int
 as
 delare @soluong int
 set @soluong=(select COUNT(*) from sv inner join lop on lop.malop=sv.malop
where que=@y and tenlop=@x)
return @soluong
end
select dbo fc_demsv(N'ktpm3',N'namdinh')


---viet thu tuc dem so sv co gv x va lop y voi x,y nhap tu ban phim
create function fc_demsosv(@x nvarchar(20),@y nvarchar(20)
returns int
as
begin
delare @soluong int
set @soluong=(select COUNT(*) as 'sl'
from sv inner join lop on lop.malop=sv.malop
inner join gv on gv.magv=lop.magv
where tengv=@x and tenlop=@y
return @soluong
end
select dbo fc_demsosv(N'ngoan',N'ktpm2')

 
 --viet thu tuc dem so sv hoc lop x co tuoi tu a den b , voi x, a,b nhap tu ban phim
 create function fn_demsv(@x  tenlop varchar(20) ,@a datetime,@b datetime)
 returns int
 as
 begin
 delare @soluong int
 set @soluong=(select COUNT(*) as 'sl'
 from sv inner join lop on lop.malop=sv.malop
 where 
 tenlop=@x and between @a and @b
 return @soluong
 end
 select dbo fn_demsv(N'ktpm3','1/1/1900','2/1/2017')
 
 ---- dua ra cacs lop va so luong sv co gioi tinh x dc nhap tu ban phim
 create function fn_thongtinsv (@x nchar(10)
 returns @bangtable
 (
 malop nvarchar(10),
    tenlop varchar(20),
  phong varchar(16),
    magv nvarchar(10),
     gioitinh nchar(10),
    )
    as
    begin
        insert into @bang
        select malop,tenlop,phong,magv,gioitinh,COUNT(*) as'sl'
        from sv inner join lop on lop.malop=sv.malop
        where gioitinh=@x
        return @bang
    end  
    
 select*from fn_thongtinsv('nam')
use master
go 
create database dethi19
go
use dethi19
go
create table khoa(
  makhoa varchar(20) not null primary key,
  tenkhoa nvarchar(20) not null,
  ngaythanhlap date
)
create table lop(
  malop varchar(20) not null primary key,
  tenlop nvarchar(20) not null,
  siso int,
   makhoa varchar(20),
   constraint fk_lop_khoa foreign key(makhoa)references khoa(makhoa)
)
create table sinhvien(
     masv varchar(20) not null primary key,
     hoten nvarchar(20)not null,
     ngaysinh date,
     malop varchar(20),
     constraint fk_sinhvien_lop foreign key(malop) references lop(malop)
)

insert into khoa values('khoa1',N'ab','2020-01-11')
insert into khoa values('khoa2',N'cd','2021-05-23')
insert into khoa values('khoa3',N'ef','2024-09-28')

insert into lop values('lop1',N'ktpm01',10,'khoa1')
insert into lop values('lop2',N'ktpm02',23,'khoa2')
insert into lop values('lop3',N'ktpm03',56,'khoa3')

insert into sinhvien values('sv1',N'thai','2000-12-04','lop1')
insert into sinhvien values('sv2',N'thin','2001-07-12','lop2')
insert into sinhvien values('sv3',N'duy','2000-11-04','lop3')
insert into sinhvien values('sv4',N'ngoan','2000-03-17','lop1')
insert into sinhvien values('sv5',N'binh','2001-08-24','lop3')

--hien thi--
select*from khoa
select*from lop
select*from sinhvien

--cau 2--
create function cau2(@tenkhoa nvarchar(20),@tenlop nvarchar(20))
returns @bang table(
                 masv varchar(20),
                 hoten nvarchar(20),
                 tuoi int
                 )
as
   begin
        insert into @bang  
                   select sinhvien.masv,sinhvien.hoten,YEAR(getdate())-YEAR(sinhvien.ngaysinh)
                      from sinhvien inner join lop on  lop.malop=sinhvien.malop
                                   inner join khoa on khoa.makhoa=lop.makhoa
                   where khoa.tenkhoa=@tenkhoa and lop.tenlop=@tenlop
          return                
    end         
    
--- hien thi--
select*from cau2(N'ab',N'ktpm01')  

--cau 3--
create proc cau3(@tenkhoa nvarchar(20),@x int)
as
   begin
         select lop.malop,lop.tenlop,lop.siso
          from lop inner join khoa on khoa.makhoa=lop.makhoa
              where khoa.tenkhoa=@tenkhoa and lop.siso>@x
    end   
    
---hien thi ---
execute cau3 N'ab',8         
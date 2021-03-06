use master
go
create database de19
go
use de19
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
    constraint fk_lop_khoa foreign key(makhoa) references khoa(makhoa)
)
create table sv(
   masv varchar(20) not null primary key,
   hoten nvarchar(20) not null,
   ngaysinh date,
   malop varchar(20),
   constraint fk_sv_lop foreign key(malop) references lop(malop)
)

insert into khoa values
('mk01',N'cntt','2020-07-19'),
('mk02',N'cnhoa','2017-05-23'),
('mk03',N'cokhi','2019-10-29')

insert into lop values
('mlop01','cntt03',80,'mk01'),
('mlop02','hoa02',77,'mk02'),
('mlop03','cokhi05',78,'mk03')

insert into sv values
('sv01',N'a','2000-03-10','mlop01'),
('sv02',N'b','2000-08-27','mlop02'),
('sv03',N'c','2001-03-10','mlop03'),
('sv04',N'd','2002-06-15','mlop01'),
('sv05',N'e','2001-09-19','mlop03')

---hiển thị---
select*from khoa
select*from lop
select*from sv

---câu 2--
create function cau2(@tenkhoa nvarchar(20),@tenlop nvarchar(20))
returns @bang table(
                    masv varchar(20),
                    hoten nvarchar(20),
                    tuoi int
                   )
 as                  
    begin
        insert into @bang
				  select sv.masv,sv.hoten,YEAR(getdate())-YEAR(sv.ngaysinh)
				   from sv inner join lop on lop.malop=sv.malop
							inner join khoa on  khoa.makhoa=lop.malop
				   where khoa.tenkhoa=@tenkhoa and lop.tenlop=@tenlop
         return               
    end
    
---hiển thị ---
select*from cau2(N'cokhi',N'cokhi05')  
 
---hiển thị--
create proc cau3(@tenkhoa nvarchar(20),@x int)
as  
   begin
       select malop ,tenlop,siso  
         from lop inner join khoa on khoa.makhoa=lop.makhoa
          where  khoa.tenkhoa=@tenkhoa and lop.siso>@x 
   end  
 
 ---hiển thị--
 execute cau3 N'cntt',100   
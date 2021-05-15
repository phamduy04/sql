use master
go
create database qlsinhvien_25
go 
use qlsinhvien_25
go
create table khoa(
   makhoa varchar(20) not null primary key,
   tenkhoa nvarchar(20) not null
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
    gioitinh bit,
     malop varchar(20),
    constraint fk_sv_lop foreign key(malop) references lop(malop)
     
)

insert into khoa values
('mk01',N'cntt'),
('mk02',N'cnhoa'),
('mk03',N'cokhi')
go
insert into lop values
('mlop1',N'ktpm01',40,'mk01'),
('mlop2',N'ktpm02',45,'mk02'),
('mlop3',N'ktpm03',67,'mk03')
go
insert into sv values
('sv01',N'a','2000-08-15',1,'mlop1'),
('sv02',N'b','2000-07-25',0,'mlop2'),
('sv03',N'c','2000-04-23',1,'mlop3'),
('sv04',N'd','2000-07-27',0,'mlop1'),
('sv05',N'e','2000-01-19',1,'mlop3')

---hien thi--
select*from khoa
select*from lop
select*from sv

--cau 2--
create function cau2(@tenkhoa nvarchar(20))
returns @bang table(
                     masv varchar(20),
                     hoten nvarchar(20),
                     ngaysinh date,
                     tenlop nvarchar(20),
                     gioitinh varchar(20)
                    )
as
   begin
     insert into @bang
		select sv.masv,sv.hoten,sv.ngaysinh,lop.tenlop,
         case gioitinh when 1 then N'nam'
				 else N'nu'
			end	 
			from sv inner join lop on sv.malop=lop.malop
				 inner join khoa on khoa.makhoa=lop.makhoa   
			 where khoa.tenkhoa=@tenkhoa 
     return                       
                            
   end 
   
---hien thi--
select*from cau2(N'cnhoa')

---cau3--
create proc cau3(@tenkhoa nvarchar(20))
as
     begin
         if(not exists(select*from khoa where khoa.tenkhoa=@tenkhoa))
            begin
                print(N'khong ton tai')
            end
         else
             begin
                  select khoa.tenkhoa,COUNT(*) as N'so lop'
                      from khoa inner join lop on lop.makhoa=khoa.makhoa
                   where khoa.tenkhoa=@tenkhoa  
                   group by khoa.tenkhoa          
             end   
     end
     
---hien thi--
execute cau3 N'dulich'-- k  thoa man
go
execute cau3 N'cnhoa'
     
                      
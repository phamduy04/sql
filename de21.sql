use master
go
create database de21
go
use de21
go
 create table monhoc(
     mamon varchar(20)not null primary key,
     tenmon nvarchar(20) not null,
     sotc int  
  )
  create table sv(
     masv varchar(20)not null primary key,
     hoten nvarchar(20) not null,
     ngaysinh date,
  )
create table diem(
    masv varchar(20)not null,
    mamon varchar(20)not null,
    diemthi int,
    constraint fk_diem primary key(masv,mamon),
    constraint fk_diem_sv foreign key(masv) references sv(masv),
    constraint fk_diem_monhoc foreign key(mamon) references monhoc(mamon)
    
)  
 
 insert into monhoc values
 ('ma01',N'toán',12),
  ('ma02',N'lý',10),
   ('ma03',N'hóa',14)
   
insert into sv values
('sv01',N'ab','2000-09-17'),
('sv02',N'cd','2001-06-27'),
('sv03',N'ef','2000-02-19') 

insert into diem values
('sv01','ma01',3),
('sv02','ma02',5), 
('sv03','ma03',9), 
('sv01','ma02',2), 
('sv03','ma01',6)  

---hiển thị--
select*from sv
select*from diem
select*from monhoc

---hiển thị---
create function cau2(@tenmonhoc nvarchar(20))
returns int
as
   begin
       declare @sl int
        select @sl=COUNT(*)
             from monhoc inner join diem on diem.mamon=monhoc.mamon
             where monhoc.tenmon=@tenmonhoc
       return @sl      
   end

---hiển thị---
select dbo.cau2(N'toán') as N'số sv có điểm<5'  

---cau 3---
create proc cau3(@masv varchar(20),@tenmonhoc nvarchar(20),@diem int) 
as
    begin
         if(not exists(select*from monhoc where monhoc.tenmon=@tenmonhoc))
            begin
                 print(N'không tồn tại')
            end
         else
             begin
                   declare @mamon varchar(20)
                     select @mamon=mamon from monhoc where monhoc.tenmon=@tenmonhoc
                     insert into diem values(@masv,@mamon,@diem)
             end   
    end
    
---hiển thị---
execute cau3 N'sv06',N'sinh',8 
go
execute cau3 N'sv01',N'hóa',7 
go
select*from diem  
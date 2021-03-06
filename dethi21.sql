use master
go
create database qldiem_de21
go
use qldiem_de21
go
create table monhoc(
   mamon varchar(20) not null primary key,
   tenmon nvarchar(20),
   sotc int
)
create table sv(
  masv varchar(20) not null primary key,
  hoten nvarchar(20) not null,
  ngaysinh date
)
create table diem(
    masv varchar(20) not null,
    mamon varchar(20) not null,
    diemthi int,
    constraint fk_diem primary key (masv,mamon),
    constraint fk_diem_sv foreign key(masv) references sv(masv),
    constraint fk_diem_monhoc foreign key(mamon) references monhoc(mamon)
)


insert into monhoc  values('mh01',N'toan',10)
insert into monhoc  values('mh02',N'ly',6)
insert into monhoc  values('mh03',N'hoa',4)

insert into sv values('sv01',N'a','2000-03-16')
insert into sv values('sv02',N'b','2000-10-25')
insert into sv values('sv03',N'c','2000-08-26')

insert into diem values('sv01','mh01',7)
insert into diem values('sv02','mh02',5)
insert into diem values('sv03','mh03',9)
insert into diem values('sv01','mh02',6)
insert into diem values('sv03','mh01',8)

--hien thi--
select*from monhoc
select*from diem
select*from sv

--cau 2--
create function cau2(@tenmon nvarchar(20))
returns int
as
    begin
        declare @sl int
			select @sl=COUNT(*) 
				 from sv inner join diem on diem.masv=sv.masv
				 where  diem.diemthi<5
	      return @sl       
    end
    
---hien thi--
select dbo.cau2(N'toan')as N'số sv có điểm<5' 

-- cau 3 --  
create proc cau3(@masv varchar(20),@tenmonhoc nvarchar(20),@diem int)
as
    begin
        if(not exists(select*from monhoc inner join diem on
                diem.mamon=monhoc.mamon 
               where monhoc.tenmon=@tenmonhoc))
           begin 
                print(N'KHONG TON TAI')
           end 
           else
               begin
                    declare @mamon varchar(20)
                    select @mamon= mamon from monhoc where tenmon=@tenmonhoc
                    insert into diem values(@masv,@mamon,@diem)  
               end
     end 
     
---hien thi---
execute cau3 'sv01',N'hoa',10 

select*from diem   
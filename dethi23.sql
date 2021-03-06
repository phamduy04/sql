use master
go
create database QLDIEM_de23
go
use QLDIEM_de23
go
create table monhoc(
      mamon varchar(20) not null primary key,
      tenmon nvarchar(20) not null,
      tinchilythuyet int,
      tinchithuchanh int
)
create table sv(
     masv varchar(20) not null primary key,
     hoten nvarchar(20) not null,
     ngaysinh date
)
create table dangki(
     madk varchar(20) not null primary key,
      masv varchar(20),
        mamon varchar(20),
      ngaydangki date,
      constraint fk_dangki_sv foreign key(masv) references sv(masv),
      constraint fk_dangki_monhoc foreign key(mamon) references monhoc(mamon)  
)

insert into monhoc values('mm01',N'toan',4,6)
insert into monhoc values('mm02',N'hoa',3,7)
insert into monhoc values('mm03',N'ly',5,5)

insert into sv values('sv01',N'a','2000-03-25')
insert into sv values('sv02',N'b','2000-08-03')
insert into sv values('sv03',N'c','2000-04-16')

insert into dangki values('dk01','sv01','mm01','2020-12-09')
insert into dangki values('dk02','sv02','mm02','2017-05-25')
insert into dangki values('dk03','sv03','mm03','2019-09-17')
insert into dangki values('dk04','sv01','mm02','2016-03-29')
insert into dangki values('dk05','sv03','mm01','2021-08-10')

---hien thi--
select*from monhoc
select*from dangki
select*from sv


---cau 2--
create function cau2(@tenmonhoc nvarchar(20),@x date)
returns int
as
    begin  
        declare @sl int
        select @sl=COUNT(*)
              from sv inner join dangki on dangki.masv=sv.masv
                      inner join monhoc on monhoc.mamon=dangki.mamon
                where monhoc.tenmon=@tenmonhoc and dangki.ngaydangki<@x
        return @sl        
    end
    
--- hien thi---
select dbo.cau2(N'toan','2020-12-29') as N'tổng sl sv dki'   


--cau  3---
create proc cau3(@masv varchar(20),@tenmonhoc nvarchar(20),@ngaydangki date)
as
   begin
       if(not exists(select*from monhoc where monhoc.tenmon=@tenmonhoc))
            begin
                 print(N'khong ton tai')
            end
       else 
           begin
					  declare @mamon varchar(20)
					  declare @madk varchar(20)
					  select @madk=madk from dangki where ngaydangki=@ngaydangki
					select @mamon=mamon from monhoc 
					 where  tenmon=@tenmonhoc
              insert into dangki values(@madk,@masv,@mamon,@ngaydangki)    
           end     
   end
   
 --hiển thị---
 execute cau3 'sv01',N'sinh','2020-12-09'  ---k t/m
 go 
 execute cau3 'sv03',N'hoa','2021-08-10'
 go
 select*from dangki
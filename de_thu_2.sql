use master
go
create database dethu2
go
use dethu2
go 
create table nhaxuatban(
  manxb varchar(10) not null primary key,
  tennxb varchar(20) not null,
  soluongxb int
)
create table tacgia(
    matg varchar(10) not null primary key,
    tentg varchar(20) not null
)
create table sach(
    masach varchar(10) not null primary key,
    tensach varchar(20) not null,
    namxb date,
    soluong int,
    dongia money,
    matg varchar(10),
     manxb varchar(10),
     constraint fk_sach_tacgia foreign key(matg) references tacgia(matg),
     constraint fk_sach_nhaxuatban foreign key( manxb) references nhaxuatban(manxb)
     
)

insert into nhaxuatban values('nxb1',N'a',12)
insert into nhaxuatban values('nxb2',N'b',34)

insert into tacgia values('tg01',N'ab')
insert into tacgia values('tg02',N'cd')

insert into sach values('sach1',N'hoa','2000/02/13',10,1200,'tg01','nxb1')
insert into sach values('sach2',N'toan','2017/05/25',23,1240,'tg02','nxb2')
insert into sach values('sach3',N'ly','2016/04/21',45,1380,'tg01','nxb2')

-- hien thi --
select*from nhaxuatban
select*from tacgia
select*from sach

--cau 2--
create view cau2
as
   select nhaxuatban.manxb,nhaxuatban.tennxb,
          SUM(sach.soluong*sach.dongia)as N'TONG TIEN SACH',
          SUM(nhaxuatban.soluongxb) as N'tong sl nxb'
          from sach inner join nhaxuatban on nhaxuatban.manxb=sach.manxb
                    inner join tacgia on tacgia.matg=sach.matg
          group by nhaxuatban.manxb,nhaxuatban.tennxb   
 
 -- hien thi --
 select*from dbo.cau2        
 
 -- cau 3 --
   create function cau3(@tennxb varchar(20),@x date,@y date)
   returns @bang table(
                 masach varchar(10),
                 tensach varchar(20),
                 tentg varchar(20),
                 dongia money
                 ) 
 as
  begin
      insert into @bang 
                  select sach.masach,sach.tensach,tacgia.tentg,sach.dongia
                   from sach inner join nhaxuatban on nhaxuatban.manxb=sach.manxb
                              inner join tacgia on tacgia.matg=sach.matg
                   where nhaxuatban.tennxb=@tennxb and sach.namxb between @x and @y   
                   return        
   end   
   
-- hien thi --
select *from dbo.cau3(N'a','2000/02/13','2017/05/25')

-- cau 4 --
create proc cau4(@tentg varchar(20), @tennxb varchar(20))
as
  begin
       select sach.masach,sach.tensach,nhaxuatban.tennxb,sach.namxb,sach.soluong
              ,sach.dongia,sum(sach.soluong*dongia)as N'tien'
           from sach inner join nhaxuatban on nhaxuatban.manxb=sach.manxb
                     inner join tacgia on tacgia.matg=sach.matg
          where tacgia.tentg=@tentg and nhaxuatban.tennxb=@tennxb 
          group by sach.masach,sach.tensach,nhaxuatban.tennxb,sach.namxb,sach.soluong
              ,sach.dongia           
   end 
   
 -- hien thi --
 execute cau4 N'ab',N'a'                  
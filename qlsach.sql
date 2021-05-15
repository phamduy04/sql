use master 
go 
create database qlsach
go
use qlsach
go 
create table nhaxuatban(
 manxb nvarchar(10) not null primary key,
 tennxb varchar(20) not null,
 soluongxb int
)
create table tacgia(
 matg nvarchar(10) not null primary key,
 tentg varchar(20) not null,
)
create table sach(
 masach nvarchar(10) not null primary key,
 tensach varchar(20) not null,
 namxb datetime,
 dongia money,                                                                                                                                       
 matg nvarchar(10),
   manxb nvarchar(10),
 constraint fk_sach_nhaxuatban foreign key(manxb) references nhaxuatban(manxb),
 constraint fk_sach_tacgia foreign key(matg) references tacgia(matg)
)
insert into nhaxuatban values('a01',N'duy','20')
insert into nhaxuatban values('a02',N'huy','30')

 
insert into tacgia values ('b01',N'PHAMVANDUY')
insert into tacgia values ('b02',N'PHAMVANHUY')

insert into sach values('sach01',N'VAN','7/7/2018',1000,'b02','a01')
insert into sach values('sach02',N'dia','2/4/2012',1300,'b01','a05')
insert into sach values('sach04',N'ly','5/6/2015',2300,'b02','a02')

select*from nhaxuatban
select*from tacgia 
select*from sach
                                                                                                                                                                                                                                                             
  select*from vw_thongke
  
    create function fc_thongtin(@namxb datetime)
    returns nvarchar(20)
    as
    begin
    delare @masach nvarchar(10),@tensach varchar(20),@tentg varchar(20),@dongia money
    set @namxb=(select namxb
    from sach
    where masach=@masach)
    returns @namxb
    end
    select dbo fc_thontin('sach01',N'dia',N'hung',1200)
    
    ---cau3--- 
    create function fn_thongtin(@tennxb varchar(20),@x datetime,@y datetime)
    return @bangtable
   (
      masach nvarchar(10),
       tensach varchar(20),
       tennxb varchar(20),
       dongia money,
       namxb datetime
    )
    as 
    begin
      insert into@bang(
        select masach,tensach,tentg,dongia 
        from nhaxuatban inner join sach on
        sach.masach=nhaxuatban.masach
      )
    end
    
   --- CAU 3---
   create view vw_thongke( 
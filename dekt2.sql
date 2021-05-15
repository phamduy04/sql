use master
go
 create database deso2
 go
  use deso2
  go
  create table nhaxuatban(
   manxb nchar(10) not null primary key,
   tennxb varchar(20) not null,
   soluongxb int
  )
  create table tacgia(
     matg nchar(10)  not null primary key,
     tentg varchar(20) not null
  )
  create table sach(
   masach nchar(10) not null primary key,
   tensach varchar(20) not null,
   namxb datetime, 
   soluong int,
   dongia money,
   matg nchar(10),
   manxb nchar(10),
   constraint fk_sach_tacgia foreign key(matg) references tacgia(matg),
   constraint fk_sach_nhaxuatban foreign key(manxb) references nhaxuatban(manxb)
  )
  
  insert into nhaxuatban values(N'01',N'a',100)
  insert into nhaxuatban values(N'02',N'b',130)
  
  insert into tacgia values(N'tg1',N'ab')
    insert into tacgia values(N'tg2',N'cd')
    
  insert into sach values(N's1',N'hoa','12/2/2000',10,1000,N'tg1',N'01')
  insert into sach values(N's2',N'ly','23/12/2001',13,1400,N'tg2',N'02')
  insert into sach values(N's3',N'sinh','21/5/2002',15,1700,N'tg1',N'02')
  
  select*from nhaxuatban
  select*from tacgia
  select*from sach
  
  --cau 2--
  create view vw_cau2
  as
  select nhaxuatban.manxb,nhaxuatban.tennxb,SUM(sach.soluong) as'tongsl',
    SUM(sach.soluong*sach.dongia) as 'tiensach'
      from sach inner join nhaxuatban on nhaxuatban.manxb=sach.manxb
       inner join tacgia on tacgia.matg=sach.matg
       group by nhaxuatban.manxb,nhaxuatban.tennxb
 select*from vw_cau2      
 
 --cau 3--
 create function fn_cau3(@tennxb varchar(20), @x datetime,@y datetime)
 returns table
 as
 return(
  select sach.masach,sach.tensach,tacgia.tentg,sach.dongia
  from sach inner join nhaxuatban on nhaxuatban.manxb=sach.manxb
  inner join tacgia on tacgia.matg=sach.matg
  where nhaxuatban.tennxb=@tennxb and sach.namxb between @x and @y
 )      
 select*from fn_cau3(N'tg1','1/1/1999','20/12/2020')
 
 --cau 4--
 create function fn_cau4(@tentg varchar(20),@tennxb varchar(20))
 returns table
 as
 return(
 select sach.masach,sach.tensach,nhaxuatban.tennxb,tacgia.tentg,sach.namxb
    ,sach.soluong,sach.dongia,sum(sach.soluong*sach.dongia) as 'tiensach'
    from sach inner join nhaxuatban on nhaxuatban.manxb=sach.manxb
    inner join tacgia on tacgia.matg=sach.matg
    where tacgia.tentg=@tentg and nhaxuatban.tennxb=@tennxb
    group by sach.masach,sach.tensach,nhaxuatban.tennxb,tacgia.tentg,sach.namxb
    ,sach.soluong,sach.dongia
 )
 select*from fn_cau4(N'ab',N'a')
use master
go
 create database QLYSACH
 go
 use QLYSACH 
 go
  create table NHAXUATBAN(
     manxb nvarchar(10) not null primary key,
     tennxb varchar(20) not null,
     soluongxb int,
  )
  create table TACGIA(
   matg nvarchar(10) not null primary key,
   tentg varchar(20) not null
  )
  create table SACH(
   masach nvarchar(10) not null primary key,
   tensach varchar(10) not null,
   namxb datetime,
   soluong int ,
   dongia money,
   matg nvarchar(10),
   manxb nvarchar(10),
   constraint fk_SACH_NHAXUATBAN foreign key(manxb) references NHAXUATBAN(manxb),
   constraint FK_sach_TACGIA foreign key(matg) references TACGIA( matg)
  )
 insert into NHAXUATBAN values (N'h01',N'DUY',100)
  insert into NHAXUATBAN values (N'h02',N'HUY',400)
  
  insert into TACGIA values (N'H03',N'PHAMVANDUY')
    insert into TACGIA values (N'H04',N'PHAMVANHUY')
    
 insert into SACH values(N'SACH1',N'ly','12/1/2020',12,2000,N'H03',N'h01')
  insert into SACH values(N'SACH12',N'hoa','12/5/2019',15,2060,N'H04',N'h02') 
   insert into SACH values(N'SACH3',N'toan','5/4/2023',20,2300,N'H03',N'h02')
   
   select*from NHAXUATBAN
   select*from TACGIA
   select*from SACH   
   
   --cau 2--
   create view vw_cau2
   as
    select NHAXUATBAN.manxb,NHAXUATBAN.tennxb,SUM(NHAXUATBAN.soluongxb)as'tongslxb'
    ,SUM(SACH.soluong*SACH.dongia) as 'tiensach'
    from SACH inner join NHAXUATBAN on NHAXUATBAN.manxb=SACH.manxb
    inner join TACGIA on TACGIA.matg=SACH.matg
    group by NHAXUATBAN.manxb, NHAXUATBAN.tennxb
    
    select*from vw_cau2  
    
    
    --cau 3--
    create function fn_cau3(@tennxb varchar(10),@x datetime,@y datetime)
    returns table
    as 
    return (
      select  SACH.masach,SACH.tensach,TACGIA.tentg,SACH.dongia
      from SACH inner join NHAXUATBAN on NHAXUATBAN.manxb=SACH.manxb
      inner join TACGIA on TACGIA.matg=SACH.matg
      where  tennxb=@tennxb
      and namxb between @x and @y
    )
    select*from fn_cau3(N'duy','13/2/1999','15/5/2027')
    
    --cau 4-- 
    create function fn_cau4(@tentg varchar(20),@tennxb varchar(20))
    returns table
    as
    return(
       select SACH.masach,SACH.tensach,NHAXUATBAN.tennxb,SACH.namxb,SACH.soluong
       ,SACH.dongia,SUM(SACH.soluong*SACH.dongia) as'tien'
       from SACH inner join NHAXUATBAN on NHAXUATBAN.manxb=SACH.manxb
       inner join TACGIA on TACGIA.matg=SACH.matg
       where tennxb=@tennxb and tentg=@tentg
       group by SACH.masach,SACH.tensach,NHAXUATBAN.tennxb,SACH.namxb,SACH.soluong
       ,SACH.dongia
       
    )
    
  select*from fn_cau4(N'PHAMVANDUY',N'DUY')
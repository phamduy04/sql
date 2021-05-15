use master 
go
create database QLHANG
go
use QLHANG
go 

create table HANG(
  mahang nchar(10) not null primary key,
  tenhang varchar(20) not null,
  dvtinh nchar(10),
  sl int,

)
create table HDBAN(
 mahd nchar(10) not null primary key,
 ngayban datetime,
 hotenkhach nvarchar(20) 
)
create table HANGBAN(
  mahd nchar(10) not null,
  mahang nchar(10) not null,
  dongia money,
  soluong int,
    constraint fk_HANGBAN primary key(mahd,mahang),
    constraint fk_HANGBAN_HANG foreign key(mahang) references HANG(mahang),
    constraint fk_HANGBAN_HDBAN foreign key(mahd) references HDBAN(mahd),   
)
insert into HANG values ('01',N'tao','dong',100)
insert into HANG values ('02',N'lee','dong',200)

insert into HDBAN  values ('03','1/1/2000',N'duy')
insert into HDBAN  values ('12','1/2/2001',N'thai')

insert into HANGBAN values ('12','01',1200,15)
insert into HANGBAN values ('03','02',3200,110)
insert into HANGBAN values ('12','02',1400,25)
insert into HANGBAN values ('03','01',1340,65)

select*from HANG
select*from HDBAN
select*from HANGBAN
--cau 2--
 create function fn_cau2( @tenhang varchar(20) ,@ngayban datetime)
 returns int 
 as 
 begin
  declare @soluong int
   set @soluong=(select SUM(HANGBAN.soluong) as'tong sl'
               from HANGBAN inner join HDBAN on HANGBAN.mahd=HDBAN.mahd
               inner join HANG on HANGBAN.mahang=HANG.mahang
               where ngayban =@ngayban and tenhang=@tenhang
   )
   return @soluong
   end
   
   select dbo fn_cau2(N'tao','1/1/2000')
   
   --cau 3---
   create function fn_cau3(@ngayy datetime ,@ngayz datetime)
   returns table
   as
   
   return(
   select HANG.mahang,HANG.tenhang,HANGBAN.soluong,HANGBAN.dongia
    from HANGBAN inner join HDBAN on HANGBAN.mahd=HDBAN.mahd
    inner join HANG on HANG.mahang=HANGBAN.mahang
    where ngayban
    between @ngayy and @ngayz
    )
select dbo fn_cau3('1/1/2000','19/5/2010')
--CAU 4---
create function fn_cau4( @x money,@y money)
returns table
as
 return(
 select HDBAN.mahd,HANG.tenhang,HDBAN.ngayban,HANGBAN.dongia,HANGBAN.soluong
 from HANGBAN inner join HANG on HANG.mahang=HANGBAN.mahang
 inner join HDBAN on HDBAN.mahd=HANGBAN.mahd
 where dongia
 between @x and @y)
 select*from fn_cau4(1000,2000)
 )
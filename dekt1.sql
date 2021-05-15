use master
go 
create database deso1
go
 use deso1
 go 
 create table hang(
  mahang nchar(10) not null primary key,
  tenhang varchar(20) not null,
  dvtinh nchar(10),
  sl int
 )
 create table hdban(
  mahd nchar(10) not null primary key,
  ngayban datetime,
  hotenkhach varchar(20)
 )
 create table hangban(
  mahd nchar(10) not null,
  mahang nchar(10) not null,
  dongia money,
  soluong int,
  constraint fk_hangban primary key( mahd, mahang),
   constraint fk_hangban_hdban foreign key(mahd) references hdban(mahd),
  constraint fk_hangban_hang foreign key(mahang) references hang(mahang)
 
 )
 
 insert into hang values(N'01',N'tao',N'dong',100)
  insert into hang values(N'02',N'mit',N'dong',130)
  
 insert into hdban values(N'03','10/8/2008',N'phamvanduy') 
  insert into hdban values(N'h4','29/7/2001',N'phamvanhuy') 
  
 insert into hangban values(N'h4',N'01',1050,100 )
 insert into hangban values(N'03',N'02',1200,12 )
 insert into hangban values(N'03',N'01',3000,40 )
 insert into hangban values(N'h4',N'02',1740,500 )
 
 select*from hang
 select*from hdban
 select*from hangban
 
 --cau 2--
 create function fn_cau2(@tenhang varchar(20), @ngayban datetime)
 returns int
 as 
 begin
   declare @sl int
   set @sl=(select SUM(hangban.soluong) as 'TONGSL'
       from hangban inner join hang on hang.mahang=hangban.mahang
       inner join hdban on hdban.mahd=hangban.mahd
       where hang.tenhang=@tenhang and hdban.ngayban=@ngayban)
       return @sl
 end
  select dbo fn_cau2(N'tao','19/2/2001')
  
 --cau 3--
 create function fn_cau3(@hotenkhach varchar(20) ,@ngayy datetime,@ngyz  datetime)
 returns table
 as
 return(
   select hangban.mahang,hang.tenhang,hangban.soluong
   from hangban inner join hang on hang.mahang=hangban.mahang
   inner join hdban on hdban.mahd=hangban.mahd
   where hdban.hotenkhach=@hotenkhach and hdban.ngayban between @ngayy
     and @ngyz)
 select*from fn_cau3(N'phamvanduy','1/1/1999','20/12/2020')
 
 --CAU 4---
 create function fn_cau4(@x money,@y money)
 returns table
 as
  return(
   select  hangban.mahd,hang.tenhang,hdban.ngayban,hangban.dongia,hangban.soluong
   from hangban inner join hang on  hang.mahang=hangban.mahang
   inner join hdban on hdban.mahd=hangban.mahd
    where hangban.dongia between @x and @y
  )
  select*from fn_cau4(50,1000)
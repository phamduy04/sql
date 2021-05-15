use master 
go 
create database qlhang
go
use qlbanhang
go
 create table hang(
  mahang nvarchar(10) not null primary key,
  tenhang nchar(20) not null,
  dvtinh nchar(10),
  sl int
 )
 create table hdban(
  mahd nvarchar(10) not null primary key,
  ngayban datetime,
  hotenkhach varchar(30) not null
 )
 create table hangban(
 mahd nvarchar(10) not null,
 mahang nvarchar(10) not null,
 dongia money,
 soluong int,
 constraint fk_hangban primary key(mahd,mahang)
 )
 insert into hang values('hang1',N'tao',N'dong','100')
  insert into hang values('hang2',N'le',N'dong','140')
 
  insert into hdban values('h01','1/1/2000',N'phamvanduy')
    insert into hdban values('h02','1/4/2000',N'phamvanhuy')
    
  insert into hangban values('h001','hang0001',10000,'10')
    insert into hangban values('h002','hang0002',20000,'82')
   insert into hangban values('h003','hang0003',25000,'30')
    insert into hangban values('h004','hang0004',14000,'25') 
   
   select*from hang
   select*from hdban
   select*from hangban 
   
   create function fc_slhang(@tenhang nchar(20),@ngayban datetime)
   returns int
   as
    begin
      declare @soluong int
        set @soluong =(select sum(soluong)
        from hangban
        return @soluong
        end
        select dbo fc_slhang(N'tao','1/4/2000')
   
   
   ---cau 3---
   create function fn_thongtin(@hotenkhach varchar(30),  @y datetime,@z datetime)
   returns @bangtable
   (
      mahang nvarchar(10),
      tenhang nchar(20),
       dongia money,
         soluong int,
           ngayban datetime,
   )
   as
   begin
      insert into @bang
      select mahang,tenhang,soluong,dongia,YEAR(getdate().YEAR(ngayban))
      from hang inner join hangban on
      hang.mahang=hangban.mahang
      where between @y and @z
      return @bang
end
select*from fn_thongtin(N'phamvanduy'','1/1/1999','4/6/2017')
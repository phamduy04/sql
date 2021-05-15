use master 
go
create database de1
go
use de1
create table hang(
  mahang nchar(10) not null primary key,
  tenhang varchar(20) not null,
  dvtinh nchar(10),
  sl int
)
create table hdban(
 mahd nchar(10) not null primary key,
 ngayban datetime,
 hotenkhach nvarchar(20) not null
)
create table hangban(
  mahd nchar(10) not null,
  mahang nchar(10) not null,
  dongia money,
 soluong int,
 constraint fk_hangban primary key(mahd,mahang),
 constraint fk_hangban_hang foreign key(mahang) references hang(mahang),
 constraint fk_hangban_hdban foreign key(mahd) references hdban(mahd)
)
insert into hang values(N'01',N'TAO',N'DONG',100)
insert into hang values(N'02',N'LE',N'DONG',150)

insert into hdban values(N'03','1/1/2000',N'DUY')
insert into hdban values(N'20','19/2/2001',N'HUY')

insert into hangban values(N'20',N'01',1000,18)
insert into hangban values(N'03',N'02',1500,48)
insert into hangban values(N'20',N'01',1700,100)
insert into hangban values(N'03',N'02',2900,10)

select*from hang
select*from hdban
select*from hangban

--cau2--
create function fn_cau2(@tenhang varchar(20),@ngayban datetime)
returns int
as
  begin
  declare @tsl int
set @tsl=(select SUM(hangban.soluong)as 'tongsl'
            from hangban inner join hang on hang.mahang=hangban.mahang
         inner join hdban on hdban.mahd=hangban.mahd
             where tenhang=@tenhang and ngayban=@ngayban
  )
  return @tsl
  end
  select dbo fn_cau2(N'TAO','19/2/2000')
  
  --cau3--
  create function fn_cau3( @hotenkhach nvarchar(20),@ngy datetime,@ngyz datetime)
  returns table
  as
  return(
    select hang.mahang,hang.tenhang,hangban.dongia,hangban.soluong
    from hangban inner join  hang on hang.mahang=hangban.mahang
    inner join hdban on hdban.mahd=hangban.mahd
    where hotenkhach=@hotenkhach and ngayban between @ngy and @ngyz
  )
 select*from fn_cau3(N'DUY','1/1/2000','19/2/2001')


--cau 4--
create function fn_cau4(@x money,@y money)
returns table
as
return(
select hdban.mahd,hang.tenhang,hdban.ngayban,hangban.dongia,hangban.soluong
from hangban inner join hang on hang.mahang=hangban.mahang
inner join hdban on hdban.mahd=hangban.mahd
where dongia between @x and @y
)
select*from fn_cau4(200,2000)
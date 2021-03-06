use master
go
create database dethi5
go
use dethi5
go 
create table hang
(
    mahang varchar(20) not null primary key,
    tenhang nvarchar(20) not null,
    soluongco int 
) 
create table hdban(
 mahd varchar(20) not null primary key,
 ngayban date,
 hotenkhach nvarchar(20) not null
)
create table hangban(
  mahd varchar(20) not null,
  mahang varchar(20) not null,
  dongiaban money,
  soluongban int
  constraint fk_hangban primary key(mahd,mahang),
  constraint fk_hangban_hdban foreign key(mahd) references hdban(mahd),
  constraint fk_hangban_hang foreign key(mahang) references hang(mahang)
)

insert into hang values
('mh01',N'táo',12),
('mh02',N'lê',63),
('mh03',N'mít',72)

insert into hdban values
('hd01','2012-09-28',N'ab'),
('hd02','2014-04-08',N'cd'),
('hd03','2013-07-16',N'ef')

insert into hangban values
('hd01','mh01',1200,16),
('hd02','mh02',1620,73),
('hd03','mh03',1170,18),
('hd01','mh02',1790,37),
('hd03','mh01',1540,91)

---hiển thị---
select*from hang 
select*from hdban
select*from hangban

---câu 2 ---
create proc cau2(@tenhang nvarchar(20),@dongiaban money,@soluongban int)
as 
   begin
       if(not exists(select*from hang where tenhang=@tenhang))
          begin
              print(N'không tồn tại')
          end
       else
         begin
				  declare @mahang varchar(20),
				  declare @mahd varchar(20)
				  select @mahd=mahd from hdban
				   select @mahang=mahang
				   from hang where tenhang=@tenhang
				   insert into hangban values(@mahd,@mahang,@dongiaban,@soluongban)
	               
         end   
    end 
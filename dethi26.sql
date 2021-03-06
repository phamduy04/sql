use master
go
create database QLHANG_DE26
go
use QLHANG_DE26
go
create table hang(
   mahang varchar(20) not null primary key,
   tenhang nvarchar(20) not null,
   dvtinh nvarchar(20) ,
   slton int
)
create table hdban(
   mahd varchar(20) not null primary key,
   ngayban date,
   hotenkhach nvarchar(20) not null,
)
create table hangban(
   mahd varchar(20) not null,
    mahang varchar(20) not null,
    dongia money,
    soluong int,
    constraint fk_hangban primary key(mahd,mahang),
    constraint fk_hangban_hdban foreign key(mahd) references hdban(mahd),
    constraint fk_hangban_hang foreign key(mahang) references hang(mahang)
)

insert into hang values
('mh01',N'hoa',N'cái',12),
('mh02',N'mit',N'cái',31),
('mh03',N'buoi',N'cái',73)

insert into hdban values
('hd01','2012-09-23',N'a'),
('hd02','2014-10-08',N'b'),
('hd03','2016-04-17',N'c')

insert into hangban values
('hd01','mh01',1000,12),
('hd02','mh02',1230,28),
('hd03','mh03',1150,81),
('hd01','mh02',1170,64),
('hd02','mh01',1080,84)

--hien thi--
select*from hang
select*from hdban
select*from hangban

---cau 2--
create view cau2
as
           select hangban.mahd,hdban.ngayban,SUM(hangban.soluong*hangban.dongia) as N'tổng tiền' 
             from hangban inner join hdban on hdban.mahd=hangban.mahd
             where hdban.ngayban=YEAR(getdate())
             group by   hangban.mahd,hdban.ngayban
 
 
 
--cau 3--
create proc cau3(@thang int,@nam int)
as
  begin
       select mahang,tenhang,ngayban,
              SUM(hangban.soluong) as N'tổng sl bán'
        from hang inner join hangban on hang.mahang=hangban.mahang
                  inner join hdban on hdban.mahd=hangban.mahd
           where               
   end             
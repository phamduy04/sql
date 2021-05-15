use master
go
 create database dethu5
 go
 use dethu5
 go
 create  table hang (
   mahang varchar(10) not null primary key,
   tenhang nvarchar(20) not null,
   soluongco int
 )
 create table hdban(
     mahd varchar(10) not null primary key,
     ngayban date,
     hotenkhachhang nvarchar(20) not null
 )
 create table hangban(
    mahd varchar(10) not null,
    mahang varchar(10) not null,
    dongiaban money,
    soluongban int,
    constraint fk_hangban primary key(mahd,mahang),
    constraint fk_hangban_hang foreign key(mahang) references hang(mahang),
    constraint fk_hangban_hdban foreign key(mahd) references hdban(mahd)
 )
 
 insert into hang values('hang01',N'chuoi',12)
  insert into hang values('hang02',N'mit',27)
   insert into hang values('hang03',N'hoa',52)
 
 insert into hdban values('hd1','2000-05-12',N'a')
  insert into hdban values('hd2','2012-10-03',N'b')
   insert into hdban values('hd3','2015-07-23',N'c')
   
insert into hangban values('hd1','hang01',1000,12) 
insert into hangban values('hd2','hang02',1050,23)
insert into hangban values('hd3','hang03',1300,41)
insert into hangban values('hd1','hang02',1230,57)
insert into hangban values('hd3','hang01',1390,19)   

--hien thi--
select*from hang
select*from hdban 
select*from hangban 

--cau 2--
create proc cau2(@mahd varchar(10),@tenhang varchar(20),@dongiaban money,@soluongban int)
as
begin 
     if(not exists(select*from hang where hang.tenhang=@tenhang))
         print(N'ten hang k ton tai')
      else
       begin
         insert into hangban values(@mahd,@tenhang,@dongiaban,@soluongban)
       end
end

--hien thi--
execute cau2 'hd6',N'xoai',1250,12

--cau 3--
create function cau3(@x date ,@y date)
returns @bang table(
                  mahang varchar(10),
                  tenhang nvarchar(20),
                  tongslban int
                  )
as
begin 
        insert into @bang
				select hang.mahang,hang.tenhang,SUM(hangban.soluongban) 
			  from hangban inner join hang on hang.mahang=hangban.mahang
						   inner join hdban on hdban.mahd=hangban.mahd
			  where hdban.ngayban between @x and @y
			  group by hang.mahang,hang.tenhang
      return
end 

-- hien thi--
select*from dbo.cau3('2000-05-03','2000-05-27')               
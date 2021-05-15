use master
go
 create database dethu1
 go
 use dethu1
 go 
 create table hang(
  mahang varchar(10) not null primary key,
  tenhang varchar(20) not null,
  dvtinh nvarchar(10),
  sl int ,

 )
 create table hdban(
     mahd varchar(10) not null primary key,
     ngayban date,
     hotenkhach varchar(20) not null,
 )
 create table hangban(
       mahd varchar(10),
       mahang varchar(10),
       dongia money,
       soluong int,
      constraint fk_hangban primary key(mahd,mahang),
      constraint fk_hangban_hdban foreign key(mahd) references hdban(mahd),
      constraint fk_hangban_hang foreign key(mahang) references hang(mahang)
 )
 
 insert into hang values('h01',N'hang1','cái',12)
  insert into hang values('h02',N'hang2','cái',52)
  
 insert into hdban values('hd1','2000/02/12',N'a')
 insert into hdban values('hd2','2020/10/23',N'b')
 
 insert into hangban values('hd1','h01',1000,12)
  insert into hangban values('hd2','h02',1300,52)
   insert into hangban values('hd1','h02',1060,72)
    insert into hangban values('hd2','h01',1500,34)
    
 -- hien thi --
 select*from hang
 select*from hdban
 select*from hangban  
 
 --cau 2--
 create function cau2(@tenhang varchar(20),@ngayban date)
 returns int
  as
  begin
      declare @tong int
      set @tong=(select SUM(hangban.soluong)
                 from hangban inner join hang on hang.mahang=hangban.mahang
                              inner join hdban on hdban.mahd=hangban.mahd
                 where hang.tenhang=@tenhang and hdban.ngayban=@ngayban
                 group by hangban.soluong)
                 return @tong             
  end
  
 select dbo.cau2(N'hang1','2000/02/12' ) as N'tong sl'
 
 --cau 3--
 create function cau3(@tenkhach varchar(20),@ngy date, @ngz date)
 returns @bang table(
                       mahang varchar(10),
                       tenhang varchar(20),
                       soluong int,
                       dongia money
                    )
 as
   begin
   insert into @bang
             select hang.mahang,hang.tenhang,hangban.soluong,hangban.dongia
             from hangban inner join hang on hang.mahang=hangban.mahang
                         inner join hdban on hdban.mahd=hangban.mahd
                where hdban.hotenkhach=@tenkhach and hdban.ngayban between @ngy and @ngz
            return              
   end
 
 select*from dbo.cau3(N'a','2000/02/09','2000/02/20')
 
 --cau 4--
 create proc cau4(@x money ,@y money)
 as
    begin
           select hdban.mahd,hang.tenhang,hdban.ngayban
          ,hangban.dongia,hangban.soluong
          from hangban inner join hang on hang.mahang=hangban.mahang
                       inner join hdban on hdban.mahd=hangban.mahd
          where hangban.dongia between @x and @y         
    end
    
  execute cau4 800,1500 
   
   
       
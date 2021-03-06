use master
go
create database qlbanhang_de20
go
use qlbanhang_de20
go
create table vattu(
       mavt varchar(20) not null primary key,
       tenvt nvarchar(20) not null,
       dvtinh nvarchar(20),
       slcon int
)
create table hoadon(
     mahd varchar(20) not null primary key,
     ngaylap date,
     hotenkhach nvarchar(20) not null
)
create table cthoadon(
   mahd varchar(20) not null,
   mavt varchar(20) not null,
   dongiaban money,
   slban int,
   constraint fk_cthoadon primary key(mahd,mavt),
   constraint fk_cthoadon_hoadon foreign key(mahd) references hoadon(mahd),
   constraint fk_cthoadon_vattu foreign key(mavt) references  vattu (mavt)
)


insert into vattu values('vt01',N'vattu1',N'cai',12)
insert into vattu values('vt02',N'vattu2',N'cai',62)
insert into vattu values('vt03',N'vattu3',N'cai',57)

insert into hoadon values('hd1','2012-03-13',N'a')
insert into hoadon values('hd2','2014-07-26',N'b')
insert into hoadon values('hd3','2017-10-15',N'c')

insert into cthoadon values('hd1','vt01',1000,19)
insert into cthoadon values('hd2','vt02',1350,59)
insert into cthoadon values('hd3','vt03',1060,36)
insert into cthoadon values('hd2','vt01',2900,81)
insert into cthoadon values('hd1','vt03',1180,74)

---hien thi--
select*from vattu
select*from hoadon
select*from cthoadon
 
 ---cau 2 viết hàm đưa ra tồng tiền bán hàng của vật tu có tên và ngày bán nhập từ bàn phím
 
 create function cau2(@tenvt nvarchar(20),@ngaylap date)
 returns money
 as
     begin
				   declare @tong money
				   select @tong=SUM(cthoadon.dongiaban*cthoadon.slban)
				   from vattu inner join cthoadon on cthoadon.mavt=vattu.mavt
							 inner join hoadon on hoadon.mahd=cthoadon.mahd  
				   where vattu.tenvt=@tenvt and hoadon.ngaylap=@ngaylap
           return @tong
     end  
 
 --hien thi--
 select dbo.cau2(N'vattu1','2012-03-13')as N'tong tien ban'
 
 --cau 3 viết thủ tục đưa ra tổng số lượng vật tư bán trong thang x, năm y
 
create proc cau3(@x int,@y int)
 as
	 begin
	          declare @tong int
				   if( not exists(select*from cthoadon inner join hoadon on hoadon.mahd=cthoadon.mahd
								  where MONTH(hoadon.ngaylap)= @x and YEAR(hoadon.ngaylap)= @y))
								  begin
										  print(N'KHONG TON TAI')
								  end

					  select @tong=SUM(cthoadon.slban) 
							 from cthoadon inner join hoadon on hoadon.mahd=cthoadon.mahd
							where MONTH(hoadon.ngaylap)=@x and YEAR(hoadon.ngaylap)=@y
					print(N'tổng số lượng vật tư bán trong')+cast(@x as char(5)) +'-'+cast(@y as char(10))
					print(N'la:')+cast(@tong as char(30))                 

	end		

--hien thi--
execute cau3 08,2019

execute cau3  03,2012
		 
			
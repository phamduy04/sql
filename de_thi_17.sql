use master
go
create database dethiso18
go
use dethiso18
go
create table congty(
    macongty varchar(20) not null primary key,
    tencongty nvarchar(50) not null,
    diachi nvarchar(50) not null,
)
create table sanpham(
  masanpham varchar(20) not null primary key,
  tensanpham nvarchar(50) not null,
  soluongco int,
)
create table cungung(
  macongty varchar(20) not null,
  masanpham varchar(20) not null,
  soluongcungung int,
  giacungung money,
  constraint fk_cungung primary key(macongty,masanpham),
  constraint fk_cungung_congty foreign key(macongty) references congty(macongty),
  constraint fk_cungung_sanpham foreign key(masanpham) references sanpham(masanpham)
)

insert into congty values('ct01',N'abc',N'namdinh')
insert into congty values('ct02',N'abcd',N'haihau')
insert into congty values('ct03',N'abcde',N'haian')

insert into sanpham values('sp01',N'hoa',12)
insert into sanpham values('sp02',N'mit',24)
insert into sanpham values('sp03',N'buoi',72)

insert into cungung values('ct01','sp01',15,1000)
insert into cungung values('ct02','sp02',56,2000)
insert into cungung values('ct03','sp03',91,3000)
insert into cungung values('ct01','sp02',65,4000)
insert into cungung values('ct02','sp01',35,4500)

--hien thi--
select*from congty
select*from sanpham
select*from cungung

--cau 2 viết hàm tính tổng (soluongcungung*giacungung) với tên công ty,tên sp 
-- đc nhập từ bàn phím

create function cau2(@tencongty nvarchar(50),@tensanpham nvarchar(50))
returns money
as
  begin
     declare @tong money
				 select @tong=SUM(cungung.soluongcungung*cungung.giacungung)
				 from cungung inner join  congty on congty.macongty=cungung.macongty
							  inner join sanpham on sanpham.masanpham=cungung.masanpham
				 where congty.tencongty=@tencongty and sanpham.tensanpham=@tensanpham
     return @tong             
   end
   
--- hien thi--- 
select dbo.cau2(N'abc',N'hoa')as N'tong tien' 

--cau 3 viết thủ tục thêm mới thông tin gồm(tensp,soluongcungung,giacungung) với tên công ty
--và giacungung từ @x đến @y .NẾU k tồn tại tên công ty trong công ty thì thông báo và trả vè 1 
-- ngược lại 

create proc cau3(@tencongty nvarchar(50),@x money,@y money)
as
  begin
      if(not exists(select*from congty where congty.tencongty=@tencongty))
           begin
                print(N'TEN CONG TY K TON TAI')
                return 1
           end
              select sanpham.tensanpham,cungung.soluongcungung,cungung.giacungung
              from sanpham inner join cungung on sanpham.masanpham=cungung.masanpham  
                           inner join congty on congty.macongty=cungung.macongty
              where congty.tencongty=@tencongty and cungung.giacungung between @x and @y   
                return 0           
  end

--hien thi--
execute cau3 N'abc',50,1900
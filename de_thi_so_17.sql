use master
go
create database dethiso17
go
use dethiso17
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
  giaban money
)
create table cungung(
  macongty varchar(20) not null,
  masanpham varchar(20) not null,
  soluongcungung int
  constraint fk_cungung primary key(macongty,masanpham),
  constraint fk_cungung_congty foreign key(macongty) references congty(macongty),
  constraint fk_cungung_sanpham foreign key(masanpham) references sanpham(masanpham)
)

insert into congty values('ct01',N'abc',N'namdinh')
insert into congty values('ct02',N'abcd',N'haihau')
insert into congty values('ct03',N'abcde',N'haian')

insert into sanpham values('sp01',N'hoa',12,1000)
insert into sanpham values('sp02',N'mit',24,1050)
insert into sanpham values('sp03',N'buoi',72,1670)

insert into cungung values('ct01','sp01',15)
insert into cungung values('ct02','sp02',56)
insert into cungung values('ct03','sp03',91)
insert into cungung values('ct01','sp02',65)
insert into cungung values('ct02','sp01',35)

--hien thi--
select*from congty
select*from sanpham
select*from cungung

---cau 2 viết hàm chứa các thông tin(teenessp,soluongcungung,giaban,tongtien) trong bang sản phẩm
--có tên công ty đc nhập từ bàn phím-

 create function cau2(@tencongty nvarchar(50))
 returns @bang table(
                      tensanpham nvarchar(50),
                      souongcungung int,
                      giaban money,
                      tongtien money
                    )
as
begin
      insert into @bang
       select sanpham.tensanpham,cungung.soluongcungung,
              sanpham.giaban,SUM(cungung.soluongcungung*sanpham.giaban)
               from cungung inner join congty on congty.macongty=cungung.macongty
                             inner join sanpham on sanpham.masanpham=cungung.masanpham
                             
           group by sanpham.tensanpham,cungung.soluongcungung, sanpham.giaban    
           return             
 end       
 
 select*from cau2(N'abc') 
 
  --cau 3  viết thủ tục chèn mới thông tn công ty(mact,tenct,dichi)
-- nếu tồn tại tenct trong công ty thì thong bao va trả về 1 ; nếu ngc lại thì có phép
-- nhập mới va tra ve 0 -- 

create proc cau3(@macongty varchar(20),@tencongty nvarchar(50),@dichi nvarchar(50))
as
   begin
       if(exists(select*from congty where congty.tencongty=@tencongty))
           begin
              print(N'TEN CONG TY DA TON TAI')
              return 1
           end
        insert into congty values(@macongty,@tencongty,@dichi)
        return 0    
   end
   
---hien thi---
execute cau3  'ct04',N'ab',N'hanam' --k thoa man
execute cau3  'ct06',N'samsung',N'bacninh'
select*from congty 
       
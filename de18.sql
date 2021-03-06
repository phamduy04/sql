use master
go
create database made18
go
use made18
go
create table congty(
  macongty varchar(20) not null primary key,
  tencongty nvarchar(20) not null,
   dichi nvarchar(20) not null
)
create table sanpham(
    masanpham varchar(20)not null primary key,
    tensanpham nvarchar(20) not null,
     soluongco int
)
create table cungung(
    macongty varchar(20) not null,
      masanpham varchar(20)not null,
      soluongcungung int,
      giacungung money,
      constraint fk_cungung primary key(macongty,masanpham),
      constraint fk_cungung_congty foreign key(macongty) references congty(macongty),
      constraint fk_cungung_sanpham foreign key(masanpham) references sanpham(masanpham)
      
)

insert into congty values
('ma01',N'a',N'namdinh'),
('ma02',N'b',N'hanam'),
('ma03',N'c',N'ninhbinh')

insert into sanpham values
('masp01',N'táo',12),
('masp02',N'lê',38),
('masp03',N'bưởi',91)

insert into cungung values
('ma01','masp01',12,1000),
('ma02','masp02',15,1270),
('ma03','masp03',56,1720),
('ma01','masp02',92,1840),
('ma03','masp01',47,1960)

--hiển thị--
select*from congty
select*from sanpham
select*from cungung

---câu 2 --
create function cau2(@tenconty nvarchar(20),@tensanpham nvarchar(20))
returns money
as  
    begin
       declare @tong money
       select @tong= SUM(cungung.soluongcungung*cungung.giacungung)
          from sanpham inner join cungung on cungung.masanpham=sanpham.masanpham
                      inner join congty on congty.macongty=cungung.macongty
             where congty.tencongty=@tenconty and sanpham.tensanpham =@tensanpham
            return @tong            
    end
   
   
---hiển thị --
select dbo.cau2(N'a',N'táo') as N'tổng tiền cung ứng' 

---cau 3--
create proc cau3(@tencongty nvarchar(20),@x money,@y money)
as
   begin
       if(not exists(select*from congty where congty.tencongty=@tencongty))
          begin
             print(N'KHÔNG TỒN TẠI')
             return 1
          end
       else
          begin
                 select sanpham.tensanpham,cungung.soluongcungung,cungung.giacungung
                   from cungung inner join sanpham on sanpham.masanpham=cungung.masanpham
                                inner join congty on congty.macongty=cungung.macongty
                   where congty.tencongty=@tencongty and cungung.giacungung between @x and @y
          end   
   end   
   
---- hiển thị---
execute cau3 N'd',800,1900  ---không thỏa mãn--
go
execute cau3 N'a',700,1900  -- thoản mã--
 
    
    
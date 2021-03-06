-- đề số 3--
 use master
 go 
 create database dethi3
 go
 use dethi3
 go
 create table congty(
      mact varchar(20) not null primary key,
      tenct nvarchar(20)not null,
      trangtha nvarchar(20),
      thanhpho nvarchar(50)
 )
 create table sanpham(
    masp varchar(20) not null primary key,
    mact varchar(20) not null,
    tensp nvarchar(50),
    mausac nvarchar(20),
    soluong int,
    giaban money,
    constraint fk_sanpham_congty foreign key(mact) references congty(mact)
     )
  create table cungung(
      macu varchar(20) not null ,
      masp varchar(20) not null,
      soluongcungung int,
      constraint fk_cungung primary key (macu,masp),
      constraint fk_cungung_sanpham foreign key(masp) references sanpham(masp)
      
  )
  

insert into congty values('ct1',N'ab',N'tot',N'namdinh')
insert into congty values('ct2',N'cd',N'hoatdong',N'haihau') 
insert into congty values('ct3',N'ef',N'thanhlap',N'haian') 

insert into sanpham values('sp1','ct1',N'hoa','vang',12,1000)
insert into sanpham values('sp2','ct2',N'dao','hong',25,1060)
insert into sanpham values('sp3','ct3',N'buoi','xanh',41,1500)

insert into cungung values('cu1','sp1',12)
insert into cungung values('cu2','sp2',68)
insert into cungung values('cu3','sp3',22)
insert into cungung values('cu4','sp1',19)
insert into cungung values('cu5','sp2',16)

--hien thi--
select*from congty  
select*from sanpham
select*from cungung  
     
--cau 2 viết ham chứa các thong tin tensp,màu sac,số lượng, gia bán, tổng tiền(soluong*giaban)trong san pham--
  -- vs tencty đc nhập từ bàn phím--
create function cau2(@tencty nvarchar(20))
returns @bang table(
                     tensp nvarchar(50),
                     mausac nvarchar(20),
                     soluong int,
                     giaban money,
                     tongtien money
                   )  
 as
   begin
     insert into @bang
        select sanpham.tensp,sanpham.mausac,sanpham.soluong,sanpham.giaban,
           sanpham.soluong*sanpham.giaban
         from sanpham inner join  congty on congty.mact=sanpham.mact
       where congty.tenct=@tencty  
       return
    end
    
--- hien thi--
select*from cau2(N'ab')  


                
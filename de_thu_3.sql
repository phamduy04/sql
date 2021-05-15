use master 
go
create database dethu3
go
use dethu3
go
create table ton(
   mavt varchar(20)not null primary key,
   ten varchar(20) not null,
   soluongt int,
)
create table nhap(
   sohdn varchar(10) not null,
   mavt varchar(20)not null,
   soluongn int,
   dongia money,
   ngayn date,
   constraint fk_nhap primary key(sohdn,mavt),
   constraint fk_nhap_ton foreign key(mavt)  references ton(mavt)
)
create table xuat(
   sohdx varchar(10) not null,
   mavt varchar(20)not null,
   soluongx int,
   dongia money,
   ngayx date,
   constraint fk_xuat primary key(sohdx,mavt),
     constraint fk_xuat_ton foreign key(mavt)  references ton(mavt)
)

insert into ton values('vt1','ton1',12)
insert into ton values('vt2','ton2',34)
insert into ton values('vt3','ton3',56)
insert into ton values('vt4','ton4',72)

insert into nhap values('01','vt1',12,1000,'2000-02-12')
insert into nhap values('02','vt2',15,1050,'2012-06-15')
insert into nhap values('03','vt3',53,1300,'2017-04-26')

insert into xuat values('x1','vt2',30,1200,'2000-05-28')
insert into xuat values('x2','vt3',35,1400,'2012-10-07')
insert into xuat values('x3','vt4',67,1900,'2017-07-21')

-- hien thi --
select*from nhap
select*from xuat
select*from ton

--cau 2--
create proc cau2(@sohdx varchar(10),@mavt varchar(20),@soluongx int,@dongiax money,@ngyx date)
as 
  begin
       declare @slt int
         set @slt=(select ton.soluongt from ton where ton.mavt=@mavt)
         if(@soluongx<=@slt)
           begin
              insert into xuat values(@sohdx,@mavt,@soluongx,@dongiax,@ngyx)
             end
         else
            print(N'sl ton k du')    
   end
 -- hien thi --  
execute cau2  'x4','vt5',30,1700,'2012-05-28'  

--cau 3--
create function cau3(@ngyn date,@tenvt varchar(20))
returns money
as
 begin
      declare @tong money
      select @tong= SUM(nhap.soluongn*nhap.dongia)
         from ton inner join nhap on nhap.mavt=ton.mavt
                   inner join xuat on xuat.mavt=ton.mavt
          where nhap.ngayn=@ngyn and ton.ten=@tenvt 
          group by nhap.soluongn,nhap.dongia
      return @tong            
  end
  
-- hien thi --
select dbo.cau3('2012-06-15',N'ton2')as N'tong tien nhap'  
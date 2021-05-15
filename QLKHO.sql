use master
go
create database QLYKHO
go
use QLYKHO
create table ton(
   mavt nchar(10) not null primary key,
   tenvt varchar(20) not null,
   soluongt int,
)
create table nhap(
  sohdn nchar(10) not null,
  mavt nchar(10) not null,
  soluongn int,
  dongian money,
  ngayn datetime,
  constraint fk_nhap primary key( sohdn, mavt),
 
)
create table xuat(
 sohdx nchar(10) not null,
  mavt nchar(10) not null,
  soluongx int,
  dongiax money,
  ngayx datetime,
    constraint fk_xuat primary key( sohdx, mavt),

)

insert into ton values (N'T1',N'MIT',100)
insert into ton values (N'T2',N'HOA',150)
insert into ton values (N'T3',N'BUOI',160)
insert into ton values (N'T4',N'THOM',190)

insert into nhap values('dhn1',N'T1',20,1000,'12/5/2007')
insert into nhap values('hdn2',N'T2',20,1000,'23/7/2017')
insert into nhap values('hdn3',N'T3',20,1000,'19/2/2024')

insert into xuat values('dhx1',N'T1',10,1200,'20/9/2018')
insert into xuat values('hdx2',N'T2',13,1250,'26/3/2028')
insert into xuat values('hdx3',N'T3',16,1700,'28/10/2026')


select*from  ton
select*from nhap
select*from xuat


--cau 2--

create proc cau2(@sohdx nchar(10),@mavt nchar(10),@soluongx int, @dongiax int,
@ngayx datetime)
as 
begin
 declare @slt int
 set @slt=(select ton.soluongt from ton 
where ton.mavt=@mavt
)
if(@soluongx<=@slt)
begin
    insert into xuat values(@sohdx,@mavt,@soluongx,@ngayx)
end
else 
begin
    pRINT(N'SO LUONG TON KHONG DU')
 end
end
exec cau2(
--CAU 3--
create function fn_cau3(@ngayn datetime, @tenvt varchar(10))
returns table
as 
return(
select sum(nhap.soluongn*nhap.dongian) as 'tongtien'
from ton inner join nhap on nhap.mavt=ton.mavt
where ngayn=@ngayn and tenvt=@tenvt
)
select*from fn_cau3('19/12/2000',N'HOA')

--CAU 4--
create function fn_cau4(@mavt nchar(10) ,@ngayn datetime)
returns table
as
return(
  select nhap.ngayn,nhap.mavt,ton.tenvt,
  SUM(nhap.soluongn*nhap.dongian)as 'tiennhap'
 from nhap inner join ton on ton.mavt=nhap.mavt
 where nhap.mavt=@mavt and  ngayn=@ngayn
 group by nhap.ngayn,nhap.mavt,ton.tenvt
)
select*from fn_cau4(N'T1','19/5/2018')

--cau 5--
create proc cau5 (@sohdx nchar(10),@mavt nchar(10),@soluongx int,@dongiax money,
                  @ngayx datetime)
 as
  begin        
       declare @slt int
       set @slt=(select ton.soluongt from ton
       where ton.mavt=@mavt
       )
       if(@soluongx<=@slt)
       begin
           insert into xuat values(@sohdx ,@mavt ,@soluongx ,@dongiax ,
                  @ngayx )
       end
       else
       begin
          print(N' SL TON K DU')
       end
  end 
  
 ---cau          
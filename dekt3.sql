use master
go
create database deso3
go
use deso3
go
create table ton(
 mavt nchar(10) not null primary key,
 tenvt varchar(20) not null,
 soluongt int
)
create table nhap(
 sohdn nchar(10) not null,
 mavt nchar(10) not null,
 soluongn int,
 dongian money,
 ngayn datetime,
 constraint fk_nhap primary key(sohdn,mavt),
 constraint fk_nhap_ton foreign key(mavt) references ton (mavt)
)
create table xuat(
sohdx nchar(10) not null,
 mavt nchar(10) not null,
 soluongx int,
 dongiax money,
 ngayx datetime,
 constraint fk_xuat primary key(sohdx,mavt),
 constraint fk_xuat_ton foreign key(mavt) references ton (mavt)
)

insert into ton values(N'01',N'a',100)
insert into ton values(N'02',N'b',130)
insert into ton values(N'03',N'c',140)
insert into ton values(N'04',N'd',200)

insert into nhap values(N'n1',N'01',10,1000,'1/1/2000')
insert into nhap values(N'n02',N'02',23,1020,'10/5/2000')
insert into nhap values(N'n3',N'03',16,1400,'16/10/2000')

insert into xuat values(N'x1',N'01',20,2000,'10/2/2010')
insert into xuat values(N'x02',N'02',24,2300,'15/9/2014')
insert into xuat values(N'x3',N'03',50,2600,'10/2/2019')

select*from nhap
select *from xuat
select*from ton

--cau 2--
create proc cau2(@sohdx nchar(10),@mavt nchar(10),@soluongx int,@dongiax money,@ngyx datetime)
as
 begin
    declare @slt int
    set @slt=(select ton.soluongt from ton where ton.mavt=@mavt)
      if(@soluongx<=@slt)
        begin
            insert into xuat values(@sohdx,@mavt,@soluongx,@dongiax,@ngyx)
         end
       else 
         begin
            print(N'SL TON K DU')
          end
 end


--cau 4--
create function fn_cau4(@mavt nchar(10),@ngayn datetime)
returns table
as
return(
  select nhap.ngayn,ton.mavt,ton.tenvt,SUM(nhap.soluongn*nhap.dongian)as 'TIENNHAP'
   from ton inner join nhap on nhap.mavt=ton.mavt
   where ton.mavt=@mavt and nhap.ngayn=@ngayn
   group by nhap.ngayn,ton.mavt,ton.tenvt
)
select*from fn_cau4(N'01','1/1/2000')

--CAU 5--
 create function fn_cau5(@ngayn datetime,@tenvt varchar(20))
 returns int
 as
 begin
   declare @sl int
   set @sl=(select sum(nhap.soluongn*nhap.dongian) as'tongtien'
    from ton inner join nhap on nhap.mavt=ton.mavt
    where nhap.ngayn=@ngayn and ton.tenvt=@tenvt)
    return @sl
 end
 select*from fn_cau5('05/10/2000',N'a')
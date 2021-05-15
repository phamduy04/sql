use master
go
create database tonghop
go
use tonghop
go 
create table gv(
 magv nchar(10) not null primary key,
 tengv varchar(20) not null,
 email nvarchar(20),
 phone nchar(10)
)
create table lop(
 malop nchar(10) not null primary key,
 tenlop varchar(20) not null,
 phong nchar(10),
 magv nchar(10),
 constraint fk_lop_gv foreign key(magv) references gv(magv)
)
create table sv(
 masv nchar(10) not null primary key,
 tensv varchar(20) not null,
 que varchar(20) not null,
 ngaysinh datetime,
 gioitinh nchar(10),
 malop nchar(10),
 constraint fk_sv_lop foreign key(malop) references lop(malop)
)

insert into gv values(N'gv1',N'hoa',N'hoa@gmail.com','012')
insert into gv values(N'gv2',N'thuy',N'thuy@gmail.com','0123')
insert into gv values(N'gv3',N'hao',N'hao@gmail.com','01234')
insert into gv values(N'gv4',N'ngan',N'ngan@gmail.com','012345')

insert into lop values(N'01',N'lop1','1',N'gv1')
insert into lop values(N'02',N'lop2','2',N'gv2')
insert into lop values(N'03',N'lop3','3',N'gv3')
insert into lop values(N'04',N'lop4','4',N'gv4')

insert into sv values(N'sv1',N'a',N'a1','1/1/2000',N'nam',N'01')
insert into sv values(N'sv2',N'b',N'b2','12/11/2001',N'nam',N'02')
insert into sv values(N'sv3',N'c',N'c3','1/3/2000',N'nu',N'03')
insert into sv values(N'sv4',N'd',N'd4','10/10/2002',N'nam',N'04')

select*from sv
select*from lop
select*from gv

--cau 2 dua ra top 10 sv tren cung--
select top 10*
 from sv
 
 --cau 3 tao view dua ra dssv ho lopktpm 3--
  create view vw_cau3
  as
  select masv ,tensv
  from sv inner join lop on lop.malop=sv.malop
  where tenlop=N'03'
  select*from vw_cau3
 
 --cau 4 tao view dua ra dssv nam co cung co chu nhiem--
 create view vw_cau4
 as
 select masv,tensv
 from sv inner join lop on sv.malop=lop.malop
 inner join gv on  lop.magv=gv.magv
 where gioitinh=N'nam' and tengv=N'hoa'
select*from vw_cau4

--cau 5 tao view dua ra cac que va soluong sv nam moi que lop1--
create view vw_cau5
as
select que,COUNT(*) as 'tongsv'
 from sv inner join lop on lop.malop=sv.malop
where tenlop=N'lop1'
group by que
select*from vw_cau5

--cau 6 tao view dua ra cac gv va soluong sv ma cac gv chu nhiem , chi lap cac gv co 2 sv tro len--
create view vw_cau6
as
select tengv, COUNT(*) as 'tongsv'
from sv inner join lop on lop.malop=sv.malop
inner join gv on gv.magv=lop.magv
group by tengv
having COUNT(*)>=2
select*from vw_cau6

--cau 7 tao ham dua ra ten sv khi masv nhap tu ban phim
create function fn_cau7(@masv nchar(10))
returns varchar(20)
as 
begin
  declare @tsv varchar(20)
  set @tsv=( select masv from sv 
                where masv=@masv)
      return @tsv          
end
select dbo fn_cau7(N'sv5')

---cau 8 thu tuc dem so sv hoc lop x co tuoi tu a den b , voi x,a,b nhap tu ban phim
create function fn_cau8(@x varchar(20), @a datetime,@b datetime)
returns int
as
begin
    declare @sl int
    set @sl=(select count(*) as 'tongsv'
    from sv inner join lop on lop.malop=sv.malop
    where tenlop=@x and YEAR(getdate()).YEAR(ngaysinh)
    between @a and @b)
    return @sl
end
 select*from fn_cau8(N'lop2','1/1/1999','20/11/2020')
 
--cau9 dua ra dssv voi ten lop nhap tu ban phim--
create function fn_cau9(@tenlop varchar(20))
returns table
as
  return(
     select masv,tensv,que,gioitinh,YEAR(getdate()).YEAR(ngaysinh)
     from sv inner join lop on lop.malop=sv.malop
     where tenlop=@tenlop
  )
select*from fn_cau9(N'lop4')

--cau 10 dua ra cac lop va so  luong sv co gioi tinh nhap tu ban phim--
create function fn_cau10(@gioitinh nchar(10))
returns table
as
return(
  select lop.tenlop,COUNT(*)as 'tongsv'
  from sv inner join lop on lop.malop=sv.malop
  where gioitinh=@gioitinh
  group by lop.tenlop
)
select*from fn_cau10(N'nam')

--cau 11 dua ra  masv,tensv, malop co gv ma x chu nhiem va co tuoi tu a den b voi x,a,b, nhap tuy ban phim--
create function fn_cau11(@x nchar(10),@a int,@b int)
returns @bang table
(
masv nchar(10),tensv varchar(20),tuoi int,tenlop varchar(20)
)
as
 begin 
   insert into @bang 
   select sv.masv,sv.tensv, lop.malop,YEAR(GETDATE().year(ngaysinh)
   from sv inner join lop on  lop.malop=sv.malop
   inner join gv on gv.magv=lop.magv
   where gv.magv=@x and tuoi between @a and @b
    return 
 end

--cau 12 them moi 1 sv voi cac tham bien tham vao la masv,tensv,que gioitinh,ngaysinh,malop .
-- ktra malop co trong bang lop co hay chua  ? ( neu cchua thi thong bao , nguoc lai thi them moi---
create proc cau12(@masv nchar(10),@tensv varchar(20),@que varchar(20), @gioitinh datetime,@malop nchar(10))
as
begin
 if(not exists(select*from lop
               where malop=@malop))
     print(N'malop k ton tai')
 else
   insert into sv values (@masv,@tensv,@que,@gioitinh,@malop) 
   print(N'SUCESSLULY')
  end 
  exec cau12(N'05',N'quynh',N'haihoa','12/10/2001',N'nu',N'b4' )  
  
  --cau 13 them moi 1 lop voi cac tham bien la malop,tenlop,phong,magv .
  -- kt tenlop nay co chua( neu CO thi thong bao)--
  --kt magv nhap vao co trong ban gv chua(neu chua thi thong bao, ngc lai thi cho phep nhap--
  create proc cau13(@malop nchar(10),@tenlop varchar(20),@phong nchar(10),@magv nchar(10))
  as
   begin
     if(exists(select*from lop where tenlop=@tenlop))
       print(N' ten lop da ton tai')
      else if( not exists(select*from gv where magv=@magv))
        print(N'magv k ton tai')
        else
        begin
            declare @mgv nchar(10)
            set @mgv=(select magv from gv where magv=@magv)
             insert into lop values(@malop,@tenlop,@phong,@magv)
        end     
   end   
   exec cau13(N'10',N'lop10','11',N'gv10')  
   
   --cau 14 them moi 1 lop gom malop,tenlop,phong,tengv nhap tu banphim--
   --ktra tenlop co chua(co thi tra ve 2) ngc lai cho nhap va tra ve 0--
   create proc cau14(@malop nchar(10),@tenlop varchar(20),@phong nchar(10),@tengv varchar(20) @trave output)
   as
     begin
         if(exists (select*from lop where tenlop=@tenlop))
         set @trave =2
         else 
            begin
               declare @mgv nchar(10)
               set @mgv=(select magv from gv where tengv=@tengv)
              insert into lop values(@malop,@tenlop,@phong,@tengv,)
            end
     end
     
     --cau 15    viet thu tu cap  nhat 1 sv vs masv,ten sv, que, gioitinh ,ngaysinh, malop nhap tu nan phim--
     -- neu  malop k ton tai thi trar ve 1
     -- neu masv k toi tai thi them moi sv vao va tra ve 2
     --neu masv da ton tai thi cap nhat thong tin sv--
     
    create proc cau15(@masv nchar(10),@tensv varchar(20),@que varchar(20),@gioitinh nchar(10),ngaysinh datetime,@trave output)
    as
     begin
       if(not exists(select*from lop where malop=@malop))
         set @trave =1
       else
        if(not exists(select*from sv where masv =@masv))
         begin
           insert into sv values(@masv,@tensv,@que,@gioitinh,@
         end  
     end 
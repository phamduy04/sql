use master 
go
create database de5
go
use de5
go 
create table hang(
  mahang nchar(10) not null primary key,
  tenhang varchar(20) not null,
  soluongco int
)
create  table hdban(
 mahd nchar(10) not null primary key,
 ngayban datetime,
 hotenkhach varchar(20) not null,
)
create table hangban(
  mahd nchar(10) not null,
  mahang nchar(10) not null,
  dongiaban money,
  soluongban int,
  constraint fk_hangban primary key(mahd,mahang),
  constraint fk_hangban_hang foreign key(mahang) references hang(mahang),
  constraint fk_hangban_hdban foreign key(mahd) references hdban(mahd)
)

insert into hang values(N'H01',N'TAO',100)
insert into hang values(N'H02',N'MIT',200)
insert into hang values(N'H03',N'HOA',300)

insert into hdban values(N'HD1','1/2/2000',N'DUY')
insert into hdban values(N'HD2','16/10/2000',N'HUY')
insert into hdban values(N'HD3','1/10/2000',N'THAI')

insert into hangban values(N'HD1',N'HO1',1000,10)
insert into hangban values(N'HD2',N'HO2',1400,14)
insert into hangban values(N'HD3',N'HO3',1500,20)
insert into hangban values(N'HD1',N'HO2',1700,50)
insert into hangban values(N'HD3',N'HO1',1100,13)

select*from hang
select*from hdban
select*from hangban

--cau 2--
create proc cau2 (@mahd nchar(10),@tenhang varchar(20),@dongiaban money,@soluongban int)
as
begin 
if(exists(select*from hang 
    where tenhang=@tenhang))
    print(N'TEN HANG DA TON TAI')
    
    else 
     if( not exists (select*from hang   
                     where tenhang=@tenhang))
            begin
               insert into hang values(@mahd,@tenhang,@dongiaban,@soluongban)
            end         
end
exec cau2(N'HD5',N'H10',12000,1000)

--CAU 3--
create function fn_cau3(@x datetime,@y datetime)
returns table
as 
return(
  select hang.tenhang,SUM(hangban.soluongban)as 'tong'
  from hangban inner join hang on hang.mahang=hangban.mahang
  inner join hdban on hdban.mahd=hangban.mahd
  where ngayban between @x and @y
  group by hang.tenhang
)
select*from fn_cau3('1/1/1999','20/10/2020')

---cau 4--

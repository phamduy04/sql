use master
 go
 create database QLYSV
 go
 use QLYSV
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
    constraint fk_lop_gv foreign key( magv) references gv(magv)
 )
 create table sv(
 mavs nchar(10) not null primary key,
 tensv varchar(20) not null,
 que varchar(20) not null,
 ngaysinh datetime,
 gioitnh nchar(10),
  malop nchar(10) ,
  constraint fk_sv_lop foreign key( malop) references lop(malop)
 )
 
 
 insert into gv values(N'01',N'HOA',N'ABC@GMAIL.COM','1234')
  insert into gv values(N'02',N'THAI',N'ABCD@GMAIL.COM','12345')
   insert into gv values(N'03',N'THAO',N'ABCDE@GMAIL.COM','123456')
    insert into gv values(N'04',N'BINH',N'ABCDEF@GMAIL.COM','1234567')
    
insert into lop values(N'LOP1',N'KTPM3',N'PHONG1',N'01')  
insert into lop values(N'LOP2',N'KTPM1',N'PHONG2',N'02') 
insert into lop values(N'LOP3',N'KTPM2',N'PHONG4',N'03') 
insert into lop values(N'LOP4',N'KTPM4',N'PHONG3',N'04')  
 
 insert into sv values(N'05',N'duy',N'namdinh','4/11/2000',N'nam',N'LOP1')
  insert into sv values(N'06',N'huy',N'thaibinh','23/10/2003',N'nam',N'LOP2')
   insert into sv values(N'07',N'ngoan',N'namdinh','12/9/2001',N'nu',N'LOP3')
    insert into sv values(N'08',N'hien',N'haihau','10/6/2000',N'nam',N'LOP4')
    
  select*from gv
  select*from lop 
  select *from sv 
  
  
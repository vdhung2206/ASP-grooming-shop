use DoAnWEB
create table TaiKhoan(
TK nvarchar(20) primary key,
MK nvarchar(20),
Ten nvarchar(20),
LoaiTK tinyint,--2:admin, 1:quan ly, 0:thanh vien
TinhTrang bit,--1:enable, 0:disable
TichDiem int,
)
alter table TaiKhoan add UID int identity(1,1) 
go
alter trigger tg_TaiKhoan_CheckMK on TaiKhoan for insert
as
declare @mk varchar(20)
select @mk = MK from inserted
if(DATALENGTH(@mk)<6 or DATALENGTH(@mk)>20)
begin
rollback tran
print 'Mat khau phai tu 6 den 20 ky tu'
end
go
insert into TaiKhoan values('duyhung22061','duyhung21','Duy Hung',2,1,0)
create table SanPham(
MaSP int identity(1,1) primary key,
HinhAnh varchar(50),
ChiTiet nvarchar(2000),
TenSP nvarchar(50),
MaLoaiSP int,
HangSP nvarchar(50),
SLTonKho int,
GiaGocSP money,
GiamGiaSP money,
GiaSP money,
TrangThai bit,--1:enable 0:disable
constraint FK_SanPham_LoaiSP foreign key (MaLoaiSP) references LoaiSP(MaLoaiSP)
)

go
create table DonHang(
MaDH int identity(1,1) primary key not null,
TK nvarchar(25),
TenNguoiNhan nvarchar(20),
SDTNguoiNhan nvarchar(20),
DiaChi nvarchar(20),
IDGiamGia int,
NgayDat date,
TongTien money,
ChietKhau money,
ThanhToan money,
TrangThai tinyint,
constraint FK_DONHANG_TK foreign key (TK) references TaiKhoan (TK),
constraint FK_DONHANG_MaGG foreign key (IDGiamGia) references GiamGia (IDGiamGia),
)
go
create table ChiTietDonHang(
MaDH int,
MaSP int,
TenSP nvarchar(50),
SL int,
DonGia money,
ThanhTien money,
constraint PK_ChiTietDonHang primary key (MaDH,MaSP),
constraint FK_ChiTietDonHang_MaDH foreign key (MaDH) references DonHang (MaDH),
constraint FK_ChiTietDonHang_MaSP foreign key (MaSP) references SanPham (MaSP),
)
create table GiamGia(
IDGiamGia int primary key identity(1,1),
MaGG nvarchar(20),
TenGG nvarchar(50),
MaSP int,
LoaiSP nvarchar(50),
HangSP nvarchar(50),
DKKhachHang int,
BatDau date,
KetThuc date,
ConHieuLuc bit,
PhanTramGG tinyint check(PhanTramGG > 0 and PhanTramGG < 100),
SoTienGG money,
)

create table ChiTietGiamGia(
IDChiTietGiamGia int primary key identity(1,1),
IDGiamGia int,
MaSP int,
constraint FK_IDGiamGia_IDGiamGia foreign key (IDGiamGia) references GiamGia (IDGiamGia),
constraint FK_MaSP foreign key (MaSP) references SanPham (MaSP)
)

create table DanhMucSP(
	MaDM int primary key identity(1,1),
	TenDM nvarchar(50)
)

create table LoaiSP(
	MaLoaiSP int primary key identity(1,1),
	TenLoaiSO nvarchar(50),
	MaDM int,
	constraint FK_LoaiSP_TenDM foreign key (MaDM) references DanhMucSP(MaDM)
)
insert into SanPham values(N'Sáp Hanz de Fuko Quicksand',1,'Hanz de Fuko','10',560000,0,560000,1,'sap6.jpg','asfasf')
insert into SanPham values(N'Sáp vu?t tóc Forte Texture Clay by Alex Costa',1,'Alex Costa','10',300000,40000,260000,1,'sap2.jpg','asfasf')
insert into SanPham values(N'Sáp vu?t tóc Medusa by The Mythos',1,'The Mythos','10',300000,40000,260000,1,'sap3.jpg','asfasf')
insert into SanPham values(N'Sáp vu?t tóc Wax by 1821 Man Made',1,'1821 Man Made','10',300000,40000,260000,1,'sap4.jpg','asfasf')
insert into SanPham values(N'Pomade G?c N??c Whiskey Leather by Signed Contract',1,'Whiskey Leather','10',300000,40000,260000,1,'sap5.jpg','asfasf')
insert into SanPham values(N'Refine Molding Paste',1,'Paradox Gromming','10',370000,0,370000,1,'sap6.jpg','asfasf')

insert into DanhMucSP values('Sap')
insert into LoaiSP values('Clay',1)
drop view view1_SanPham
select * from view1_SanPham
create view view1_SanPham as
select SanPham.MaSP,SanPham.MaLoaiSP,DanhMucSP.MaDM,TenLoaiSP,TenDM,TenSP,HangSP,SLTonKho,GiaGocSP,GiamGiaSP,GiaSP,TrangThai,HinhAnh,ChiTiet from (LoaiSP join DanhMucSP on (LoaiSP.MaDM) = DanhMucSP.MaDM) join SanPham on SanPham.MaLoaiSP = LoaiSP.MaLoaiSP

select TenLoaiSP,MaLoaiSP  from LoaiSP where MaDM = 3
select MaDM, TenDM from DanhMucSP
select count (TenLoaiSP) as c from DanhMucSP join LoaiSP on DanhMucSP.MaDM = LoaiSP.MaDM and DanhMucSP.MaDM =1

select min (SLTonKho) from SanPham where MaSP !=''
select count(*) as c from LoaiSP where MaLoaiSP ='35'
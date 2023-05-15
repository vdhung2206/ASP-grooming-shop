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
MaSP int identity(1,1) primary key not null,
TenSP nvarchar(50),
LoaiSP nvarchar(50),
HangSP nvarchar(50),
SLTonKho int,
GiaGocSP money,
GiamGiaSP money,
GiaSP money,
TrangThai bit,--1:enable 0:disable
)
alter table SanPham add HinhAnh varchar(50)
alter table SanPham add ChiTiet nvarchar(2000)
go
create table DonHang(
MaDH int identity(1,1) primary key not null,
TK nvarchar(20),
TenNguoiNhan nvarchar(20),
SDTNguoiNhan nvarchar(20),
DiaChi nvarchar(20),
MaGG nvarchar(20),
NgayDat date,
TongTien money,
ChietKhau money,
ThanhToan money,
TrangThai tinyint,
constraint FK_DONHANG_TK foreign key (TK) references TaiKhoan (TK),
constraint FK_DONHANG_MaGG foreign key (MaGG) references GiamGia (MaGG),
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
MaGG nvarchar(20) primary key,
TenGG nvarchar(50),
MaSP int,
LoaiSP nvarchar(50),
HangSP nvarchar(50),
DKKhachHang int,
BatDau date,
KetThuc date,
PhanTramGG tinyint check(PhanTramGG > 0 and PhanTramGG < 100),
SoTienGG money,
constraint FK_GiamGia_MaSP foreign key (MaSP) references SanPham (MaSP),
)
insert into SanPham values(N'Sáp Hanz de Fuko Quicksand','Sap','Wax','Hanz de Fuko','10',560000,0,560000,1,'sap6.jpg','asfasf')
insert into SanPham values(N'Sáp vu?t tóc Forte Texture Clay by Alex Costa','Sap','Clay','Alex Costa','10',300000,40000,260000,1,'sap2.jpg','asfasf')
insert into SanPham values(N'Sáp vu?t tóc Medusa by The Mythos','Sap','Clay','The Mythos','10',300000,40000,260000,1,'sap3.jpg','asfasf')
insert into SanPham values(N'Sáp vu?t tóc Wax by 1821 Man Made','Sap','Clay','1821 Man Made','10',300000,40000,260000,1,'sap4.jpg','asfasf')
insert into SanPham values(N'Pomade G?c N??c Whiskey Leather by Signed Contract','Sap','Pomade','Whiskey Leather','10',300000,40000,260000,1,'sap5.jpg','asfasf')
insert into SanPham values(N'Refine Molding Paste','Sap','Wax','Paradox Gromming','10',370000,0,370000,1,'sap6.jpg','asfasf')
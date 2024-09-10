CREATE TABLE Diskon (
	Diskon_ID INT NOT NULL IDENTITY, 
	Persen_Diskon INT NOT NULL, 
	Tanggal_Awal_Berlaku DATETIME NOT NULL, 
	Tanggal_Akhir_Berlaku DATETIME NOT NULL, 
	MinQty INT NOT NULL, 
	Deskripsi NVARCHAR(60) NOT NULL, 
	PRIMARY KEY (Diskon_ID)
	);

CREATE TABLE Diskon_Produk (
	Diskon_Produk_ID INT NOT NULL IDENTITY, 
	DiskonDiskon_ID INT NOT NULL, 
	ProdukProduk_ID INT NOT NULL, 
	PRIMARY KEY (Diskon_Produk_ID)
	);

CREATE TABLE Gerai (
	Gerai_ID INT NOT NULL IDENTITY, 
	Nama_Cabang NVARCHAR(40) NOT NULL, 
	Tanggal_Pembukaan timestamp NOT NULL, 
	Alamat NVARCHAR(60) NOT NULL, 
	Kelurahan NVARCHAR(40) NOT NULL, 
	Kecamatan NVARCHAR(40) NOT NULL, 
	Kabupaten_Kota NVARCHAR(40) NOT NULL, 
	Provinsi NVARCHAR(40) NOT NULL, 
	PRIMARY KEY (Gerai_ID)
	);

CREATE TABLE Jabatan (
	Jabatan_ID INT NOT NULL IDENTITY, 
	Nama_Jabatan NVARCHAR(40) NOT NULL, 
	Deskripsi NVARCHAR(60) NOT NULL, 
	PRIMARY KEY (Jabatan_ID)
	);

CREATE TABLE Jenis_Member (
	Jenis_Member_ID INT NOT NULL IDENTITY, 
	Nama_Jenis_Member NVARCHAR(40) NOT NULL, 
	Min_Trans NVARCHAR(20) NOT NULL, 
	Deskripsi NVARCHAR(60) NOT NULL, 
	PRIMARY KEY (Jenis_Member_ID)
	);

CREATE TABLE Member (
	Member_ID INT NOT NULL IDENTITY, 
	No_KTP NVARCHAR(20) NOT NULL UNIQUE, 
	Nama NVARCHAR(40) NOT NULL, 
	Jenis_Kelamin NVARCHAR(20) NOT NULL, 
	Alamat NVARCHAR(60) NOT NULL, 
	Kelurahan NVARCHAR(40) NOT NULL, 
	Kecamatan NVARCHAR(40) NOT NULL, 
	Kabupaten_Kota NVARCHAR(40) NOT NULL, 
	Provinsi NVARCHAR(40) NOT NULL, 
	Tanggal_Daftar_Member DATETIME NOT NULL, 
	Tanggal_Kadaluarsa_Member DATETIME NOT NULL, 
	No_Kontak NVARCHAR(20) NOT NULL UNIQUE, 
	Jenis_MemberJenis_Member_ID INT NOT NULL, 
	PRIMARY KEY (Member_ID)
	);

CREATE TABLE Pegawai (
	Pegawai_ID INT NOT NULL IDENTITY, 
	Nama NVARCHAR(40) NOT NULL, 
	Jenis_Kelamin NVARCHAR(20) NOT NULL, 
	Tanggal_Lahir DATETIME NOT NULL, 
	Tanggal_Diterima DATETIME NOT NULL, 
	Alamat NVARCHAR(60) NOT NULL, 
	Kelurahan NVARCHAR(40) NOT NULL, 
	Kecamatan NVARCHAR(40) NOT NULL, 
	Kabupaten_Kota NVARCHAR(40) NOT NULL, 
	Provinsi NVARCHAR(40) NOT NULL, 
	Lulusan_Pendidikan NVARCHAR(20) NOT NULL, 
	Honor MONEY NOT NULL, 
	Status_Pernikahan NVARCHAR(20) NOT NULL, 
	Jumlah_Anak INT NOT NULL, 
	Jenis_Pegawai NVARCHAR(20) NOT NULL, 
	GeraiGerai_ID INT NOT NULL, 
	JabatanJabatan_ID INT NOT NULL, 
	Atasan_ID INT NOT NULL, 
	PRIMARY KEY (Pegawai_ID)
	);

CREATE TABLE Pengiriman (
	Pengiriman_ID INT NOT NULL IDENTITY, 
	Tanggal_Pengiriman DATETIME NOT NULL, 
	Tanggal_Penerimaan DATETIME NOT NULL, 
	Nama_Penerima NVARCHAR(40) NOT NULL, 
	Alamat NVARCHAR(60) NOT NULL, 
	Kelurahan NVARCHAR(40) NOT NULL, 
	Kecamatan NVARCHAR(40) NOT NULL, 
	Kabupaten_Kota NVARCHAR(40) NOT NULL, 
	Provinsi NVARCHAR(40) NOT NULL, 
	PegawaiPegawai_ID INT NOT NULL, 
	PenjualanNo_Transaksi INT NOT NULL, 
	PRIMARY KEY (Pengiriman_ID)
	);

CREATE TABLE Penjualan (
	No_Transaksi INT NOT NULL IDENTITY, 
	Tanggal_Transaksi DATETIME NOT NULL, 
	Total_Pembayaran MONEY NOT NULL, 
	Jenis_Pembayaran NVARCHAR(20) NOT NULL, 
	PegawaiPegawai_ID INT NOT NULL, 
	MemberMember_ID INT NOT NULL, 
	PRIMARY KEY (No_Transaksi)
	);

CREATE TABLE Produk (
	Produk_ID INT NOT NULL IDENTITY, 
	Nama_Produk NVARCHAR(40) NOT NULL, 
	Jenis_Produk NVARCHAR(20) NOT NULL, 
	Tanggal_Kadaluarsa DATETIME NOT NULL, 
	Berat INT NOT NULL, 
	Satuan_Berat INT NOT NULL, 
	Sumber_Produk NVARCHAR(40) NOT NULL, 
	Harga_Satuan MONEY NOT NULL, 
	ProdukProduk_ID INT NOT NULL, 
	SupplierSupplier_ID INT NOT NULL, 
	PRIMARY KEY (Produk_ID)
	);

CREATE TABLE Rincian_Penjualan (
	Rincian_ID INT NOT NULL IDENTITY, 
	Harga_Satuan MONEY NOT NULL, 
	Kuantitas_Penjualan INT NOT NULL, 
	Nominal_Diskon INT NOT NULL, 
	Total_Biaya_Per_Produk MONEY NOT NULL, 
	PenjualanNo_Transaksi INT NOT NULL, 
	ProdukProduk_ID INT NOT NULL, 
	Diskon_ProdukDiskon_Produk_ID INT NOT NULL, 
	PRIMARY KEY (Rincian_ID)
	);

CREATE TABLE Supplier (
	Supplier_ID INT NOT NULL IDENTITY, 
	Nama_Supplier NVARCHAR(40) NOT NULL, 
	Alamat NVARCHAR(60) NOT NULL, 
	Kelurahan NVARCHAR(40) NOT NULL, 
	Kecamatan NVARCHAR(40) NOT NULL, 
	Kabupaten_Kota NVARCHAR(40) NOT NULL, 
	Provinsi NVARCHAR(40) NOT NULL, 
	No_Kontak NVARCHAR(20) NOT NULL UNIQUE, 
	PRIMARY KEY (Supplier_ID)
	);

ALTER TABLE Rincian_Penjualan
ADD CONSTRAINT FKRincian_Pe641973 FOREIGN KEY (Diskon_ProdukDiskon_Produk_ID) 
REFERENCES Diskon_Produk (Diskon_Produk_ID);

ALTER TABLE Diskon_Produk 
ADD CONSTRAINT FKDiskon_Pro616815 FOREIGN KEY (ProdukProduk_ID) 
REFERENCES Produk (Produk_ID);

ALTER TABLE Diskon_Produk 
ADD CONSTRAINT FKDiskon_Pro543845 FOREIGN KEY (DiskonDiskon_ID) 
REFERENCES Diskon (Diskon_ID);

ALTER TABLE Produk 
ADD CONSTRAINT FKProduk121103 FOREIGN KEY (SupplierSupplier_ID) 
REFERENCES Supplier (Supplier_ID);

ALTER TABLE Rincian_Penjualan 
ADD CONSTRAINT FKRincian_Pe767564 FOREIGN KEY (ProdukProduk_ID) 
REFERENCES Produk (Produk_ID);

ALTER TABLE Rincian_Penjualan 
ADD CONSTRAINT FKRincian_Pe256002 FOREIGN KEY (PenjualanNo_Transaksi) 
REFERENCES Penjualan (No_Transaksi);

ALTER TABLE Member 
ADD CONSTRAINT FKMember315319 FOREIGN KEY (Jenis_MemberJenis_Member_ID) 
REFERENCES Jenis_Member (Jenis_Member_ID);

ALTER TABLE Penjualan 
ADD CONSTRAINT FKPenjualan559490 FOREIGN KEY (MemberMember_ID) 
REFERENCES Member (Member_ID);

ALTER TABLE Pengiriman 
ADD CONSTRAINT FKPengiriman392349 FOREIGN KEY (PenjualanNo_Transaksi) 
REFERENCES Penjualan (No_Transaksi);

ALTER TABLE Penjualan 
ADD CONSTRAINT FKPenjualan440803 FOREIGN KEY (PegawaiPegawai_ID) 
REFERENCES Pegawai (Pegawai_ID);

ALTER TABLE Pengiriman 
ADD CONSTRAINT FKPengiriman185161 FOREIGN KEY (PegawaiPegawai_ID) 
REFERENCES Pegawai (Pegawai_ID);

ALTER TABLE Pegawai 
ADD CONSTRAINT FKPegawai548309 FOREIGN KEY (Atasan_ID) 
REFERENCES Pegawai (Pegawai_ID);

ALTER TABLE Pegawai 
ADD CONSTRAINT FKPegawai726894 FOREIGN KEY (JabatanJabatan_ID) 
REFERENCES Jabatan (Jabatan_ID);

ALTER TABLE Pegawai 
ADD CONSTRAINT FKPegawai935947 FOREIGN KEY (GeraiGerai_ID) 
REFERENCES Gerai (Gerai_ID);

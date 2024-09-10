-- Dari Materi
CREATE TABLE OrderItems
(
OrderID INT NOT NULL,
Item VARCHAR(20) NOT NULL,
Quantity SMALLINT NOT NULL,
PRIMARY KEY(OrderID, Item)
);--++++++++++++++++++++++++++++INSERT INTO OrderItems (OrderID, Item, Quantity)
VALUES
(1, 'M8 Bolt', 100),
(2, 'M8 Nut', 100),
(3, 'M8 Washer', 200);

--++++++++++++++++++++++++++++++

DECLARE OrderItemCursor CURSOR FAST_FORWARD
FOR
SELECT OrderID,
 SUM(Quantity) AS NumItems
FROM OrderItems
GROUP BY OrderID
ORDER BY OrderID;
DECLARE @OrderID INT, @NumItems INT;
-- Instantiate the cursor and loop through all orders.
OPEN OrderItemCursor;
FETCH NEXT FROM OrderItemCursor
INTO @OrderID, @NumItems
WHILE @@Fetch_Status = 0
BEGIN;
 IF @NumItems > 100
 PRINT 'EXECUTING LogLargeOrder - '
 + CAST(@OrderID AS VARCHAR(5))
 + ' ' + CAST(@NumItems AS VARCHAR(5));
 ELSE
 PRINT 'EXECUTING LogSmallOrder - '
 + CAST(@OrderID AS VARCHAR(5))
 + ' ' + CAST(@NumItems AS VARCHAR(5));
FETCH NEXT FROM OrderItemCursor
INTO @OrderID, @NumItems;
END;
-- Close and deallocate the cursor.
CLOSE OrderItemCursor;
DEALLOCATE OrderItemCursor;--+++++++++++++++++++++++++++++++++ Latihan soal ada di slide pert 13

CREATE TABLE dbo.barang
(
barang_id INT NOT NULL,
nama_barang VARCHAR(40) NOT NULL,
jumlah INT NOT NULL,
harga MONEY NOT NULL,
discount SMALLMONEY NULL,
cartegory_id INT NULL,
brand_id INT NULL,
PRIMARY KEY(barang_id)
);--++++++++++++++++++++++++++++INSERT INTO dbo.barang VALUES
(3, 'Laptop', 11, 10000000.00, 0.00, 4, 2),
(4, 'Sepatu', 12, 135000.00, 5000.00, 4, 1),
(5, 'Sendal Swalow', 15, 165000.00, 1000.00, 3, 1),
(6, 'Jaket', 4, 90000.00, 1000.00, 3, 1),
(7, 'Kaos Naruto', 6, 50000.00, 1000.00, 3, 3),
(8, 'Kaos Oblong', 5, 35000.00, 1000.00, 3, 3),
(9, 'Mouse Logitech', 10, 200000.00, NULL, 4, 4),
(10, 'Dongkrak', 2, 500000.00, NULL, 5, 5),
(11, 'Tas Adidas', 2, 200000.00, NULL, NULL, NULL),
(13, 'switer new', 10, 300000.00, 0.00, 3, 3);--+++++++++++++++++++++++++++DECLARE barangCursor CURSOR FAST_FORWARD
FOR
SELECT nama_barang, SUM(Harga) AS Price
FROM dbo.barang
GROUP BY nama_barang
ORDER BY nama_barang;
DECLARE @nama_barang INT, @price INT;
-- Instantiate the cursor and loop through all orders.
OPEN barangCursor;
FETCH NEXT FROM barangCursor
INTO @barang_id, @NumItems
WHILE @@Fetch_Status = 0
BEGIN;
 IF @NumItems > 100
 PRINT 'EXECUTING LogLargeOrder - '
 + CAST(@OrderID AS VARCHAR(5))
 + ' ' + CAST(@NumItems AS VARCHAR(5));
 ELSE
 PRINT 'EXECUTING LogSmallOrder - '
 + CAST(@OrderID AS VARCHAR(5))
 + ' ' + CAST(@NumItems AS VARCHAR(5));
FETCH NEXT FROM OrderItemCursor
INTO @OrderID, @NumItems;
END;
-- Close and deallocate the cursor.
CLOSE OrderItemCursor;
DEALLOCATE OrderItemCursor;


---- no 2 dri si ozi

DECLARE BarangItemCursor CURSOR FAST_FORWARD
FOR
SELECT nama_barang , SUM(harga) as price
FROM dbo.barang
GROUP BY nama_barang 
ORDER BY nama_barang ;

DECLARE @nama_barang VARCHAR, @price INT;
-- Instantiate the cursor and loop through all orders.
OPEN BarangItemCursor;
FETCH NEXT FROM BarangItemCursor

INTO @nama_barang, @price
WHILE @@Fetch_Status = 0
BEGIN;

IF @price > 5000000
PRINT 'Terdapat barang bernama'
+ CAST(@nama_barang AS VARCHAR(50))
+ ' Harga ' + CAST(@price AS INT);

ELSE
PRINT 'Terdapat barang bernama - '
+ CAST(@nama_barang AS VARCHAR(5))
+ ' ' + CAST(@price AS VARCHAR(5));

FETCH NEXT FROM BarangItemCursor
INTO @nama_barang, @price;
END;
-- Close and deallocate the cursor.
CLOSE BarangItemCursor;
DEALLOCATE BarangItemCursor;

-- new yang bener

DECLARE BarangItemCursor CURSOR FAST_FORWARD
FOR
SELECT nama_barang , SUM(harga) as price
FROM dbo.barang
GROUP BY nama_barang 
ORDER BY nama_barang ;

DECLARE @nama_barang VARCHAR(100), @price INT;
-- Instantiate the cursor and loop through all orders.
OPEN BarangItemCursor;
FETCH NEXT FROM BarangItemCursor

INTO @nama_barang, @price
WHILE @@Fetch_Status = 0
BEGIN;
IF @price > 5000000
PRINT 'Barang bernama'
+ @nama_barang 
+ ' Harga ' + CAST(@price AS VARCHAR(50));
ELSE
PRINT 'Barang bernama '
+ @nama_barang 
+ ' Tidak Lebih dari 5000000';

FETCH NEXT FROM BarangItemCursor
INTO @nama_barang, @price;
END;
-- Close and deallocate the cursor.
CLOSE BarangItemCursor;
DEALLOCATE BarangItemCursor;

-- No 3

DECLARE @jumlah_harga MONEY
DECLARE @penjualan MONEY

BEGIN
SELECT @jumlah_harga = SUM(harga)
FROM dbo.barang b 
WHERE cartegory_id = 3

SELECT @penjualan = 300000

IF @jumlah_harga > @penjualan
PRINT 'Penjualan lebih dari 300.000'
END


--++++++++++++

DECLARE @nama_barang VARCHAR(50)
DECLARE @no int
BEGIN
SELECT @nama_barang = nama_barang 
FROM dbo.barang 
WHERE cartegory_id BETWEEN  5 AND 10

WHILE @no <= 10

PRINT @nama_barang
SET @no = @no + 1;
END

-- 4

DECLARE @id INT = 5;

WHILE @id <= 10
BEGIN
	SELECT nama_barang
	FROM dbo.barang
	WHERE barang_id = @id
	SET @id = @id + 1
END
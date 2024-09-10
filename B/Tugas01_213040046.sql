--Modul 1

SELECT shipcountry, AVG(freight) AS avgfreight
FROM Sales.Orders
WHERE YEAR(orderdate) = 2007
GROUP BY shipcountry
ORDER BY avgfreight DESC, shipcountry
OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY;

Modul 2

update dbo.dosen set nama_dosen = 'Firman Syahputra'
where id_dosen = 'ds-001';
select * from dbo.dosen;

delete from dbo.Dosen
WHERE nip = 'ds-006'

select nama_dosen, id_dosen, alamat_dosen, 
tanggal_lahir_dosen,
'Dosen' AS jabatan from dbo.dosen
UNION
select nama_mahasiswa, id_mahasiswa, alamat_mahasiswa,
tanggal_lahir_mahasiswa,
'mahasiswa' AS jabatan from dbo.mahasiswa

select id_dosen, nama_dosen from dbo.dosen
EXCEPT
select id_mahasiswa, nama_mahasiswa from dbo.mahasiswa

Modul 3

SELECT custid,orderid,  qty,
RANK() OVER(partition by custid ORDER BY qty) AS rnk,
DENSE_RANK() OVER(partition by custid ORDER BY qty) AS drnk
FROM dbo.Orders;

SELECT empid,
COUNT(CASE WHEN year(orderdate) = 2007 THEN orderdate END) AS cnt2007,
COUNT(CASE WHEN year(orderdate) =2008 THEN orderdate END) AS cnt2008,
COUNT(CASE WHEN year(orderdate) = 2009 THEN orderdate END) AS cnt2009
FROM 
Orders
GROUP BY empid;

SELECT 
    GROUPING_ID(empid,custid,YEAR(orderdate)) AS groupingset,
    empid, custid, YEAR(orderdate) AS orderyear, SUM(qty) AS sumqty
FROM dbo.Orders
GROUP BY
    GROUPING SETS
    (
     (empid,custid,YEAR(orderdate)),
     (empid, YEAR(orderdate)),
     (custid, YEAR(orderdate))
    );
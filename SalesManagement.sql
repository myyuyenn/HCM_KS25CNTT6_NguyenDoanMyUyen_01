DROP DATABASE IF EXiSTS SalesManagement;
CREATE DATABASE SalesManagement;
USE SalesManagement;

CREATE TABLE Product(
ProductID VARCHAR(10) PRIMARY KEY,
ProductName NVARCHAR(100),
Manufacturer NVARCHAR(100),
Price DECIMAL(10,2),
Stock INT
);

CREATE TABLE Customer (
CustomerID VARCHAR(10) PRIMARY KEY,
Name NVARCHAR(100),
Email VARCHAR(100),
Phone VARCHAR(15),
Address NVARCHAR(200)
);

CREATE TABLE Orders(
OrderID VARCHAR(10) PRIMARY KEY,
OrderDate DATE,
TotalAmount DECIMAL(10,2),
CustomerID VARCHAR(10),
FOREIGN KEY(CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE Order_Detail(
OrderID VARCHAR(10),
ProductID VARCHAR(10),
Quantify INT,
Price DECIMAL(10,2),
PRIMARY KEY (OrderID, ProductID),
FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- Thêm cột ghi chú
ALTER TABLE Orders
ADD Note NVARCHAR(255);

-- Đổi tên cột
EXEC sp_rename 'Product.Manufacturer', 'NhaSanXuat', 'COLUMN';

-- Drop
DROP TABLE Order_Detail;
DROP TABLE Orders;


INSERT INTO Product(ProductID,ProductName,NhaSanXuat,Price,Stock) VALUES
('P01','MacBook Air M2','Apple', 25000000,10),
('P02', 'iPhone 15', 'Apple',20000000,15),
('P03', 'Dell XPS 13', 'Dell', 22000000,8),
('P04', 'HP Pavilion', 'HP', 15000000,12),
('P05', 'Asus ROG', 'Asus',30000000,5);

INSERT INTO Customer(CustomerID,Name,Email,Phone,Address) VALUES
('C01','An','an@gamil.com','0123','HN'),
('C02','Binh','binh@gmailcom',NULL, 'HCM'),
('C03','Hong','hong@gmail.com','0456','DN'),
('C04','Han','han@gmail.com',NULL,'HN'),
('C05','Huy','huy@gmail.com','0789','HP');

INSERT INTO Orders(OrderID, OrderDate,TotalAmount,CustomerID, Note)VALUES 
('DH001','2026-01-01',25000000, 'C01',NULL),
('DH002','2026-01-02',20000000,'C02',NULL),
('DH003','2026-01-03',22000000,'C03',NULL),
('DH004', '2026-01-04',15000000,'C04',NULL),
('DH005','2026-02-05',30000000,'C05',NULL);

INSERT INTO Order_Detail( OrderID, ProductID, Quantity,Price)VALUES
('DH001','P01',1,25000000),
('DH002','P02',1,20000000),
('DH003','P03',1,22000000),
('DH004','P04',1,15000000),
('DH005','P05',1,30000000);

UPDATE Product
SET Price = Price*1.1
WHERE Manufacturer='Apple';

DELETE FROM Customer
WHERE Phone IS NULL;

-- Phần 4
SELECT *
FROM Product 
WHERE Price BETWEEN 10000000 AND 20000000;

SELECT P.ProductName
FROM Product P 
JOIN Order_Detail OD ON P.ProductID=OD.ProductID
WHERE OD.OrderID='DH001';

SELECT DISTINCT C.*
FROM Customer C 
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN Order_Detail OD ON O.OrderID = OD.OrderID
JOIN Product P ON OD.ProductID = P.ProductID
WHERE P.ProductName = 'MacBook Air M2';



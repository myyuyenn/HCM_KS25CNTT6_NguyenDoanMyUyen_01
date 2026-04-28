-- PHẦN 1 + 2
DROP DATABASE IF EXISTS SalesManagement;
CREATE DATABASE SalesManagement;
USE SalesManagement;

CREATE TABLE Product(
  ProductID VARCHAR(10) PRIMARY KEY,
  ProductName NVARCHAR(100),
  NhaSanXuat NVARCHAR(100),
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
  Note NVARCHAR(255),
  FOREIGN KEY(CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE Order_Detail(
  OrderID VARCHAR(10),
  ProductID VARCHAR(10),
  Quantity INT,
  Price DECIMAL(10,2),
  PRIMARY KEY (OrderID, ProductID),
  FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
  FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- PHẦN 3
INSERT INTO Product(ProductID,ProductName,NhaSanXuat,Price,Stock) VALUES
('P01','MacBook Air M2','Apple',25000000,10),
('P02','iPhone 15','Apple',20000000,15),
('P03','Dell XPS 13','Dell',22000000,8),
('P04','HP Pavilion','HP',15000000,12),
('P05','Asus ROG','Asus',30000000,5);

INSERT INTO Customer(CustomerID,Name,Email,Phone,Address) VALUES
('C01','An','an@gmail.com','0123','HN'),
('C02','Binh','binh@gmail.com',NULL,'HCM'),
('C03','Hong','hong@gmail.com','0456','DN'),
('C04','Han','han@gmail.com',NULL,'HN'),
('C05','Huy','huy@gmail.com','0789','HP');

INSERT INTO Orders(OrderID,OrderDate,TotalAmount,CustomerID) VALUES 
('OR001','2026-01-01',25000000,'C01'),
('OR002','2026-01-02',20000000,'C02'),
('OR003','2026-01-03',22000000,'C03'),
('OR004','2026-01-04',15000000,'C04'),
('OR005','2026-01-05',30000000,'C05');

INSERT INTO Order_Detail(OrderID,ProductID,Quantity,Price) VALUES
('OR001','P01',1,25000000),
('OR002','P02',1,20000000),
('OR003','P03',1,22000000),
('OR004','P04',1,15000000),
('OR005','P05',1,30000000);

-- Update: tăng giá Apple thêm 10%
UPDATE Product
SET Price = Price*1.1
WHERE NhaSanXuat='Apple';

-- Delete
DELETE FROM Customer
WHERE Phone IS NULL;

-- PHẦN 4
-- 1. Tìm sản phẩm có giá từ 10 triệu đến 20 triệu
SELECT * 
FROM Product 
WHERE Price BETWEEN 10000000 AND 20000000;

-- 2. Liệt kê đơn hàng có mã OR001
SELECT * 
FROM Orders 
WHERE OrderID='OR001';

-- 3. Tìm mã đơn hàng và ngày đặt hàng của khách hàng ở TPHCM
SELECT O.OrderID, O.OrderDate
FROM Orders O
JOIN Customer C ON O.CustomerID=C.CustomerID
WHERE C.Address='HCM';

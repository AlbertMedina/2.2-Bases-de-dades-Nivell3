DROP DATABASE IF EXISTS tienda;
CREATE DATABASE tienda CHARACTER SET utf8mb4;
USE tienda;

CREATE TABLE fabricante (
  codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL
);

CREATE TABLE producto (
  codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  precio DOUBLE NOT NULL,
  codigo_fabricante INT UNSIGNED NOT NULL,
  FOREIGN KEY (codigo_fabricante) REFERENCES fabricante(codigo)
);

INSERT INTO fabricante VALUES(1, 'Asus');
INSERT INTO fabricante VALUES(2, 'Lenovo');
INSERT INTO fabricante VALUES(3, 'Hewlett-Packard');
INSERT INTO fabricante VALUES(4, 'Samsung');
INSERT INTO fabricante VALUES(5, 'Seagate');
INSERT INTO fabricante VALUES(6, 'Crucial');
INSERT INTO fabricante VALUES(7, 'Gigabyte');
INSERT INTO fabricante VALUES(8, 'Huawei');
INSERT INTO fabricante VALUES(9, 'Xiaomi');

INSERT INTO producto VALUES(1, 'Disco duro SATA3 1TB', 86.99, 5);
INSERT INTO producto VALUES(2, 'Memoria RAM DDR4 8GB', 120, 6);
INSERT INTO producto VALUES(3, 'Disco SSD 1 TB', 150.99, 4);
INSERT INTO producto VALUES(4, 'GeForce GTX 1050Ti', 185, 7);
INSERT INTO producto VALUES(5, 'GeForce GTX 1080 Xtreme', 755, 6);
INSERT INTO producto VALUES(6, 'Monitor 24 LED Full HD', 202, 1);
INSERT INTO producto VALUES(7, 'Monitor 27 LED Full HD', 245.99, 1);
INSERT INTO producto VALUES(8, 'Portátil Yoga 520', 559, 2);
INSERT INTO producto VALUES(9, 'Portátil Ideapd 320', 444, 2);
INSERT INTO producto VALUES(10, 'Impresora HP Deskjet 3720', 59.99, 3);
INSERT INTO producto VALUES(11, 'Impresora HP Laserjet Pro M26nw', 180, 3);


-- -----------------------------------------------------
-- Queries
-- -----------------------------------------------------

-- 1. Products names
SELECT nombre FROM producto;

-- 2. Products names and prices
SELECT nombre, precio FROM producto;

-- 3. Products (all columns)
SELECT * FROM producto;

-- 4. Products name, prices in euros and prices in dollars
SELECT nombre, precio, ROUND(precio * 1.16, 2) AS price_dollars FROM producto;

-- 5. Products names, prices in euros and prices in dollars (using alias)
SELECT nombre AS product_name, precio AS euros, ROUND(precio * 1.16, 2) AS dollars FROM producto;

-- 6. Products names (upper case) and prices
SELECT UPPER(nombre) AS product_name_upper_case, precio FROM producto;

-- 7. Products names (lower case) and prices
SELECT LOWER(nombre) AS product_name_lower_case, precio FROM producto;

-- 8. Manufacturers names and two first letters in upper case
SELECT nombre, UPPER(SUBSTRING(nombre, 1, 2)) AS first_letters FROM fabricante;

-- 9. Products names and rounded prices
SELECT nombre, ROUND(precio) AS price_rounded FROM producto;

-- 10. Products names and truncated prices
SELECT nombre, FLOOR(precio) AS price_truncated FROM producto;

-- 11. Codes of manufacterers with any product
SELECT f.codigo FROM fabricante f JOIN producto p ON f.codigo = p.codigo_fabricante;

-- 12. Codes of manufacterers with any product (non-repeated)
SELECT DISTINCT f.codigo FROM fabricante f JOIN producto p ON f.codigo = p.codigo_fabricante;

-- 13. Manufacturers names sorted in ascending order
SELECT nombre FROM fabricante ORDER BY nombre;

-- 14. Manufacturers names sorted in descending order
SELECT nombre FROM fabricante ORDER BY nombre DESC;

-- 15. Products names orderes in ascending order and then by price in descending order
SELECT nombre FROM producto ORDER BY nombre ASC, precio DESC;

-- 16. 5 first rows from manufacterers table
SELECT * FROM fabricante LIMIT 5;

-- 17. 2 rows from 4th row from manufacterers table
SELECT * FROM fabricante LIMIT 2 OFFSET 3;

-- 18. Cheapest product name and price
SELECT nombre, precio FROM producto ORDER BY precio LIMIT 1;

-- 19. Most expensive product name and price
SELECT nombre, precio FROM producto ORDER BY precio DESC LIMIT 1;

-- 20. Products from manufacterer number 2 names
SELECT nombre FROM producto WHERE codigo_fabricante = 2;
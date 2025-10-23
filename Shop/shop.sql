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
SELECT nombre, precio, ROUND(precio * 1.16, 2) AS precio_dolares FROM producto;

-- 5. Products names, prices in euros and prices in dollars (using alias)
SELECT nombre AS nombre_producto, precio AS euros, ROUND(precio * 1.16, 2) AS dolares FROM producto;

-- 6. Products names (upper case) and prices
SELECT UPPER(nombre) AS nombre_mayusculas, precio FROM producto;

-- 7. Products names (lower case) and prices
SELECT LOWER(nombre) AS nombre_minusculas, precio FROM producto;

-- 8. Manufacturers names and two first letters in upper case
SELECT nombre, UPPER(SUBSTRING(nombre, 1, 2)) AS primeras_letras FROM fabricante;

-- 9. Products names and rounded prices
SELECT nombre, ROUND(precio) AS precio_redondeado FROM producto;

-- 10. Products names and truncated prices
SELECT nombre, FLOOR(precio) AS precio_truncado FROM producto;

-- 11. Codes of manufacterers with any product
SELECT codigo_fabricante FROM producto;

-- 12. Codes of manufacterers with any product (non-repeated)
SELECT DISTINCT codigo_fabricante FROM producto;

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

-- 21. Products names, prices and manufacterers names
SELECT p.nombre, p.precio, f.nombre AS fabricante FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo;

-- 22. Products names, prices and manufacterers names (sorted alphabetically by manufacturer name)
SELECT p.nombre, p.precio, f.nombre AS fabricante FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo ORDER BY f.nombre;

-- 23. Products codes, names, manufacterers codes and manufacturers names
SELECT p.codigo, p.nombre, f.codigo AS codigo_fabricante, f.nombre AS nombre_fabricante FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo ORDER BY p.codigo;

-- 24. Cheapest product name, price ad manufacterer name
SELECT p.nombre, p.precio, f.nombre AS fabricante FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo ORDER BY p.precio LIMIT 1;

-- 25. Most expensive product name, price ad manufacterer name
SELECT p.nombre, p.precio, f.nombre AS fabricante FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo ORDER BY p.precio DESC LIMIT 1;

-- 26. Lenovo products names
SELECT p.nombre FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = "Lenovo";

-- 27. Crucial products more expensive than 200€
SELECT p.nombre FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = "Crucial" AND p.precio > 200;

-- 28. Asus, Hewlett-Packard and Seagate products names
SELECT p.nombre, f.nombre AS fabricante FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = "Asus" OR f.nombre = "Hewlett-Packard" OR f.nombre = "Seagate";

-- 29. Asus, Hewlett-Packard and Seagate products names (using IN)
SELECT p.nombre, f.nombre AS fabricante FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre IN ("Asus", "Hewlett-Packard", "Seagate");

-- 30. Name and price for products whose manufacterer name ends with letter 'e'
SELECT p.nombre, p.precio FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre LIKE "%e";

-- 31. Name and price for products whose manufacterer name contains letter 'w'
SELECT p.nombre, p.precio FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre LIKE "%w%";

-- 32. Name, price and manufacturer name for those products that cost 180€ or more sorted by price in descending order and then by name in ascending order
SELECT p.nombre, p.precio, f.nombre AS fabricante FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE p.precio >= 180 ORDER BY p.precio DESC, p.nombre;

-- 33. Name and code for these manufacturers with any product
SELECT DISTINCT f.codigo, f.nombre FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo ORDER BY f.codigo;

-- 34. Manufacterers with their products
SELECT f.nombre AS fabricante, p.nombre AS producto FROM fabricante f LEFT JOIN producto p ON f.codigo = p.codigo_fabricante;

-- 35. Manufacterers with no products
SELECT f.nombre AS fabricante, p.nombre AS producto FROM fabricante f LEFT JOIN producto p ON f.codigo = p.codigo_fabricante WHERE p.codigo_fabricante IS NULL;

-- 36. Lenovo products names (without INNER JOIN)
SELECT nombre FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = "Lenovo");

-- 37. All data of products that have the same price than Lenovo most expensive product (without INNER JOIN)
SELECT * FROM producto WHERE precio = (SELECT MAX(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = "Lenovo"));

-- 38. Lenovo most expensive product name
SELECT p.nombre FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = "Lenovo" ORDER BY p.precio DESC LIMIT 1;

-- 39. Hewlett-Packard cheapest product name
SELECT p.nombre FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = "Hewlett-Packard" ORDER BY p.precio LIMIT 1;

-- 40. Name of products that are more expensive than Lenovo most expensive product
SELECT p.nombre FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE p.precio >= (SELECT MAX(p.precio) FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = 'Lenovo');

-- 41. Name of Asus products with a price above Asus average price
SELECT p.nombre FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = 'Asus' AND p.precio > (SELECT AVG(p.precio) FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = 'Asus');
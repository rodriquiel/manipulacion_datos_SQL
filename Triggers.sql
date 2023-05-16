USE ventas_jugos;

CREATE TABLE tb_facturacion(
	FECHA DATE NULL,
    VENTA_TOTAL FLOAT
);

CREATE TABLE `tb_items_facturas1` (
  `NUMERO` varchar(5) NOT NULL,
  `CODIGO` varchar(10) NOT NULL,
  `CANTIDAD` int DEFAULT NULL,
  `PRECIO` float DEFAULT NULL,
  PRIMARY KEY (`NUMERO`,`CODIGO`),
  KEY `FK_PRODUCTO1` (`CODIGO`),
  CONSTRAINT `FK_FACTURAS1` FOREIGN KEY (`NUMERO`) REFERENCES `tb_factura1` (`NUMERO`),
  CONSTRAINT `FK_PRODUCTO1` FOREIGN KEY (`CODIGO`) REFERENCES `tb_producto` (`CODIGO`)
);


CREATE TABLE `tb_factura1` (
  `NUMERO` varchar(5) NOT NULL,
  `FECHA` date DEFAULT NULL,
  `DNI` varchar(11) NOT NULL,
  `MATRICULA` varchar(5) NOT NULL,
  `IMPUESTO` float DEFAULT NULL,
  PRIMARY KEY (`NUMERO`),
  KEY `FK_CLIENTE1` (`DNI`),
  KEY `FK_VENDEDOR1` (`MATRICULA`),
  CONSTRAINT `FK_CLIENTE1` FOREIGN KEY (`DNI`) REFERENCES `tb_cliente` (`DNI`),
  CONSTRAINT `FK_VENDEDOR1` FOREIGN KEY (`MATRICULA`) REFERENCES `tb_vendedor` (`MATRICULA`)
);

SELECT * FROM tb_items_facturas1;
SELECT * FROM tb_factura1;
SELECT * FROM tb_factura;
SELECT * FROM tb_facturacion;

INSERT INTO tb_factura1 
VALUES ('0100', '2021-01-01', '1471156710', '235', 0.10);
INSERT INTO tb_items_facturas1
VALUES ('0100', '1002767', 100, 25),
('0100', '1004327', 200, 25),
('0100', '1013793', 300, 25);

INSERT INTO tb_factura1 
VALUES ('0101', '2021-01-01', '1471156710', '235', 0.10);
INSERT INTO tb_items_facturas1
VALUES ('0101', '1002767', 100, 25),
('0101', '1004327', 200, 25),
('0101', '1013793', 300, 25);

/*Se busca que el siguiente Select se ejecute cada vez que se insertan nuevos valores*/
SELECT A.FECHA, SUM(B.CANTIDAD * B.PRECIO) AS VENTA_TOTAL
FROM tb_factura1 A
INNER JOIN
tb_items_facturas1 B
ON A.NUMERO = B.NUMERO
GROUP BY A.FECHA;

/*Se crea el trigger para ejecutar la accion buscada luego de cada insercion*/
DELIMITER //

CREATE TRIGGER TG_FACTURACION_INSERT
AFTER INSERT ON tb_items_facturas1
FOR EACH ROW BEGIN
	DELETE FROM tb_facturacion;
	INSERT INTO tb_facturacion
	SELECT A.FECHA, SUM(B.CANTIDAD * B.PRECIO) AS VENTA_TOTAL
	FROM tb_factura1 A
	INNER JOIN
	tb_items_facturas1 B
	ON A.NUMERO = B.NUMERO
	GROUP BY A.FECHA;
END //

INSERT INTO tb_factura1 
VALUES ('0102', '2021-01-01', '1471156710', '235', 0.10);
INSERT INTO tb_items_facturas1
VALUES ('0102', '1002767', 200, 25),
('0102', '1004327', 300, 25),
('0102', '1013793', 400, 25);

INSERT INTO tb_factura1 
VALUES ('0103', '2021-01-01', '1471156710', '235', 0.10);
INSERT INTO tb_items_facturas1
VALUES ('0103', '1002767', 200, 25),
('0103', '1004327', 400, 30),
('0103', '1013793', 500, 25);


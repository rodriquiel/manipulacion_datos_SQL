USE ventas_jugos;

/*TABLA tb_producto*/
SELECT * FROM jugos_ventas.tabla_de_productos;

/*Se modifican los nombres de los campos de la abla antigua para que coincidan con 
el de la tabla utilizada para trabajar y se controla que no haya repetidos*/

SELECT CODIGO_DEL_PRODUCTO AS CODIGO, NOMBRE_DEL_PRODUCTO AS DESCRIPCION, TAMANO, SABOR,
ENVASE, PRECIO_DE_LISTA AS PRECIO_LISTA
FROM jugos_ventas.tabla_de_productos
WHERE CODIGO_DEL_PRODUCTO NOT IN (SELECT CODIGO FROM tb_producto);

/*Insercion datos tabla antigua en tabla nueva*/

INSERT INTO tb_producto
SELECT CODIGO_DEL_PRODUCTO AS CODIGO, NOMBRE_DEL_PRODUCTO AS DESCRIPCION, TAMANO, SABOR,
ENVASE, PRECIO_DE_LISTA AS PRECIO_LISTA
FROM jugos_ventas.tabla_de_productos
WHERE CODIGO_DEL_PRODUCTO NOT IN (SELECT CODIGO FROM tb_producto);

SELECT * FROM tb_producto;

/*TABLA tb_cliente*/

SELECT * FROM jugos_ventas.tabla_de_clientes;

INSERT INTO tb_cliente
SELECT DNI, NOMBRE, DIRECCION_1 AS DIRECCION, BARRIO, CIUDAD, ESTADO, CP, FECHA_DE_NACIMIENTO AS FECHA_NAC,
EDAD, SEXO, LIMITE_DE_CREDITO AS LIMITE_CREDITO, VOLUMEN_DE_COMPRA AS VOLUMEN_COMPRA, PRIMERA_COMPRA
FROM jugos_ventas.tabla_de_clientes
WHERE DNI NOT IN (SELECT DNI FROM tb_cliente);

SELECT * FROM tb_cliente;
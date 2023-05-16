USE ventas_jugos;

SELECT * FROM tb_producto;

ALTER TABLE tb_producto RENAME COLUMN SABOR TO TAMANO1;
ALTER TABLE tb_producto RENAME COLUMN TAMANO TO SABOR; 
ALTER TABLE tb_producto RENAME COLUMN TAMANO1 TO TAMANO; 

UPDATE tb_producto SET PRECIO_LISTA = 5
WHERE CODIGO = '1000889';

/*Actualizacion individual*/
UPDATE tb_producto SET DESCRIPCION = 'Sabor de la Montaña',
TAMANO = '1 Litro',
ENVASE = 'Botella PET'
WHERE CODIGO = '1000889';

/*Cambio de volumen de compra en decilitros a litros en tb_cliente*/

SELECT * FROM tb_cliente;

/*Actualizacion grupal*/
UPDATE tb_cliente SET VOLUMEN_COMPRA = VOLUMEN_COMPRA/10;

/*Actualizacion individual*/
UPDATE tb_cliente SET 
DIRECCION = 'Jorge Emilio 23',
BARRIO = 'San Antonio',
CIUDAD = 'Guadalajara',
ESTADO = 'JC',
CP = '44700000'
WHERE DNI = '5840119709'; 


/*Uso UPDATE con FROM*/

SELECT * FROM tb_vendedor;

SELECT * FROM jugos_ventas.tabla_de_vendedores;

/*Se busca actualizar la condicion DE_VACACIONES a partir de la tabla antigua de vendedores*/

SELECT * FROM tb_vendedor A
INNER JOIN
jugos_ventas.tabla_de_vendedores B
ON A.MATRICULA = SUBSTRING(B.MATRICULA,3,3);

UPDATE tb_vendedor A
INNER JOIN
jugos_ventas.tabla_de_vendedores B
ON A.MATRICULA = SUBSTRING(B.MATRICULA,3,3)
SET A.DE_VACACIONES = B.VACACIONES;

/*Aumento en 30% el volumen de compra de los clientes que tienen, 
en sus direcciones, barrios donde los vendedores cuentan con oficinas.*/

UPDATE tb_cliente A 
INNER JOIN 
tb_vendedor B
ON A.BARRIO = B.BARRIO
SET A.VOLUMEN_COMPRA = A.VOLUMEN_COMPRA * 1.3;

/*Exclusion datos de tablas*/

INSERT INTO tb_producto (CODIGO,DESCRIPCION,SABOR,TAMANO,ENVASE,PRECIO_LISTA)
     VALUES ('1001001','Sabor Alpino','Mango','700 ml','Botella',7.50),
         ('1001000','Sabor Alpino','Melón','700 ml','Botella',7.50),
         ('1001002','Sabor Alpino','Guanábana','700 ml','Botella',7.50),
         ('1001003','Sabor Alpino','Mandarina','700 ml','Botella',7.50),
         ('1001004','Sabor Alpino','Banana','700 ml','Botella',7.50),
         ('1001005','Sabor Alpino','Asaí','700 ml','Botella',7.50),
         ('1001006','Sabor Alpino','Mango','1 Litro','Botella',7.50),
         ('1001007','Sabor Alpino','Melón','1 Litro','Botella',7.50),
         ('1001008','Sabor Alpino','Guanábana','1 Litro','Botella',7.50),
         ('1001009','Sabor Alpino','Mandarina','1 Litro','Botella',7.50),
         ('1001010','Sabor Alpino','Banana','1 Litro','Botella',7.50),
         ('1001011','Sabor Alpino','Asaí','1 Litro','Botella',7.50);


SELECT * FROM tb_producto WHERE DESCRIPCION = 'Sabor Alpino';

/*Borrar un elemento*/
DELETE FROM tb_producto WHERE CODIGO = '1001000';

/*Borrar varios elementos*/
DELETE FROM tb_producto WHERE TAMANO = '1 Litro';

SELECT CODIGO_DEL_PRODUCTO FROM jugos_ventas.tabla_de_productos;

SELECT CODIGO FROM tb_producto
WHERE CODIGO NOT IN 
(SELECT CODIGO_DEL_PRODUCTO FROM jugos_ventas.tabla_de_productos);

/*Sincronizacion de tabla actual y antigua*/
DELETE FROM tb_producto WHERE CODIGO NOT IN 
(SELECT CODIGO_DEL_PRODUCTO FROM jugos_ventas.tabla_de_productos);

USE ventas_jugos;

CREATE TABLE tb_identificacion(
	ID INT AUTO_INCREMENT NOT NULL,
    DESCRIPCION VARCHAR(50) NULL,
    PRIMARY KEY (ID)
);

INSERT INTO tb_identificacion (DESCRIPCION)
VALUES ('Cliente A');

SELECT * FROM tb_identificacion;

INSERT INTO tb_identificacion (DESCRIPCION)
VALUES ('Cliente B');

INSERT INTO tb_identificacion (DESCRIPCION)
VALUES ('Cliente C');

INSERT INTO tb_identificacion (DESCRIPCION)
VALUES ('Cliente D');

DELETE FROM tb_identificacion WHERE ID = 3;

INSERT INTO tb_identificacion (DESCRIPCION)
VALUES ('Cliente E');

/*Si se fuerza algun valor en el campo con auto increment, al insertar a continuacion continua desde ese valor*/
INSERT INTO tb_identificacion (ID,DESCRIPCION)
VALUES (100, 'Cliente H');

INSERT INTO tb_identificacion (DESCRIPCION)
VALUES ('Cliente I');
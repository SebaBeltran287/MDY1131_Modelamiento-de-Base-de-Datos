-- Generado por Oracle SQL Developer Data Modeler 18.1.0.082.1035
--   en:        2021-12-16 15:52:45 CLST
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



CREATE TABLE camion (
    id_camion           INTEGER NOT NULL,
    matricula           VARCHAR2(50) NOT NULL,
    fecha_de_alta       DATE NOT NULL,
    peso_max_carga      INTEGER NOT NULL,
    id_tipo_conductor   INTEGER NOT NULL,
    id_tarifa           INTEGER NOT NULL
);

ALTER TABLE camion ADD CONSTRAINT camion_pk PRIMARY KEY ( id_camion );

CREATE TABLE cliente (
    rut_cliente        INTEGER NOT NULL,
    nombre_cliente     VARCHAR2(50) NOT NULL,
    id_comuna          INTEGER NOT NULL,
    apellido_paterno   VARCHAR2(50) NOT NULL,
    apellido_materno   VARCHAR2(50) NOT NULL,
    direccion          VARCHAR2(50) NOT NULL
);

ALTER TABLE cliente ADD CONSTRAINT cliente_pk PRIMARY KEY ( rut_cliente );

CREATE TABLE comuna (
    id_comuna          INTEGER NOT NULL,
    nombre_comuna      VARCHAR2(50) NOT NULL,
    nombre_ciudad      VARCHAR2(50) NOT NULL,
    nombre_provincia   VARCHAR2(50) NOT NULL
);

ALTER TABLE comuna ADD CONSTRAINT comuna_pk PRIMARY KEY ( id_comuna );

CREATE TABLE conductor (
    rut_conductor       INTEGER NOT NULL,
    nombre_conductor    VARCHAR2(50) NOT NULL,
    apellido_paterno    VARCHAR2(50) NOT NULL,
    apellido_materno    VARCHAR2(50) NOT NULL,
    direccion           VARCHAR2(50) NOT NULL,
    telefono            INTEGER NOT NULL,
    id_tipo_conductor   INTEGER NOT NULL,
    id_comuna           INTEGER NOT NULL
);

ALTER TABLE conductor ADD CONSTRAINT conductor_pk PRIMARY KEY ( rut_conductor,
                                                                id_tipo_conductor );

CREATE TABLE detalle_movimiento (
    id_detallemov       INTEGER NOT NULL,
    monto_movimiento    INTEGER NOT NULL,
    codigo_movimiento   INTEGER NOT NULL,
    fecha_movimiento    DATE NOT NULL,
    id_tipo_conductor   INTEGER NOT NULL
);

ALTER TABLE detalle_movimiento ADD CONSTRAINT detalle_movimiento_pk PRIMARY KEY ( id_detallemov );

CREATE TABLE movimiento_caja (
    codigo_movimiento   INTEGER NOT NULL,
    fecha_movimiento    DATE NOT NULL
);

ALTER TABLE movimiento_caja ADD CONSTRAINT movimiento_caja_pk PRIMARY KEY ( codigo_movimiento );

CREATE TABLE parque (
    nro_parque      INTEGER NOT NULL,
    nombre_parque   VARCHAR2(50) NOT NULL,
    id_comuna       INTEGER NOT NULL
);

ALTER TABLE parque ADD CONSTRAINT parque_pk PRIMARY KEY ( nro_parque );

CREATE TABLE pedido (
    numero_pedido        INTEGER NOT NULL,
    fecha_entrega        DATE NOT NULL,
    matricula_remolque   INTEGER NOT NULL,
    rut_cliente          INTEGER NOT NULL
);

ALTER TABLE pedido ADD CONSTRAINT pedido_pk PRIMARY KEY ( numero_pedido );

CREATE TABLE remolque (
    matricula_remolque   INTEGER NOT NULL,
    fecha_ingreso        DATE NOT NULL,
    fecha_salida         DATE NOT NULL,
    peso_carga           INTEGER NOT NULL,
    peso_remolque        INTEGER NOT NULL
);

ALTER TABLE remolque ADD CONSTRAINT remolque_pk PRIMARY KEY ( matricula_remolque );

CREATE TABLE remolque_parque (
    id_remolque_parque   INTEGER NOT NULL,
    fecha_ingreso        DATE NOT NULL,
    fecha_salida         DATE NOT NULL,
    nro_parque           INTEGER NOT NULL,
    matricula_remolque   INTEGER NOT NULL
);

ALTER TABLE remolque_parque ADD CONSTRAINT remolque_parque_pk PRIMARY KEY ( id_remolque_parque );

CREATE TABLE ruta (
    nro_identificador   INTEGER NOT NULL,
    nombre_ruta         VARCHAR2(50) NOT NULL,
    id_tiporuta         INTEGER NOT NULL,
    id_comuna           INTEGER NOT NULL
);

ALTER TABLE ruta ADD CONSTRAINT ruta_pk PRIMARY KEY ( nro_identificador );

CREATE TABLE sueldo (
    id_sueldo      INTEGER NOT NULL,
    monto_sueldo   INTEGER NOT NULL
);

ALTER TABLE sueldo ADD CONSTRAINT sueldo_pk PRIMARY KEY ( id_sueldo );

CREATE TABLE tarifa (
    id_tarifa      INTEGER NOT NULL,
    monto_tarifa   INTEGER NOT NULL
);

ALTER TABLE tarifa ADD CONSTRAINT tarifa_pk PRIMARY KEY ( id_tarifa );

CREATE TABLE tipo_conductor (
    id_tipo_conductor      INTEGER NOT NULL,
    nombre_tipoconductor   VARCHAR2(50) NOT NULL,
    id_sueldo              INTEGER NOT NULL
);

ALTER TABLE tipo_conductor ADD CONSTRAINT tipo_conductor_pk PRIMARY KEY ( id_tipo_conductor );

CREATE TABLE tipo_ruta (
    id_tiporuta          INTEGER NOT NULL,
    nombre_tiporuta      VARCHAR2(50) NOT NULL,
    matricula_remolque   INTEGER NOT NULL
);

ALTER TABLE tipo_ruta ADD CONSTRAINT tipo_ruta_pk PRIMARY KEY ( id_tiporuta );

ALTER TABLE camion
    ADD CONSTRAINT camion_tarifa_fk FOREIGN KEY ( id_tarifa )
        REFERENCES tarifa ( id_tarifa );

ALTER TABLE camion
    ADD CONSTRAINT camion_tipo_conductor_fk FOREIGN KEY ( id_tipo_conductor )
        REFERENCES tipo_conductor ( id_tipo_conductor );

ALTER TABLE cliente
    ADD CONSTRAINT cliente_comuna_fk FOREIGN KEY ( id_comuna )
        REFERENCES comuna ( id_comuna );

ALTER TABLE conductor
    ADD CONSTRAINT conductor_comuna_fk FOREIGN KEY ( id_comuna )
        REFERENCES comuna ( id_comuna );

ALTER TABLE conductor
    ADD CONSTRAINT conductor_tipo_conductor_fk FOREIGN KEY ( id_tipo_conductor )
        REFERENCES tipo_conductor ( id_tipo_conductor );

ALTER TABLE detalle_movimiento
    ADD CONSTRAINT movimiento_caja_fk FOREIGN KEY ( codigo_movimiento )
        REFERENCES movimiento_caja ( codigo_movimiento );

ALTER TABLE detalle_movimiento
    ADD CONSTRAINT tipo_conductor_fk FOREIGN KEY ( id_tipo_conductor )
        REFERENCES tipo_conductor ( id_tipo_conductor );

ALTER TABLE parque
    ADD CONSTRAINT parque_comuna_fk FOREIGN KEY ( id_comuna )
        REFERENCES comuna ( id_comuna );

ALTER TABLE pedido
    ADD CONSTRAINT pedido_cliente_fk FOREIGN KEY ( rut_cliente )
        REFERENCES cliente ( rut_cliente );

ALTER TABLE pedido
    ADD CONSTRAINT pedido_remolque_fk FOREIGN KEY ( matricula_remolque )
        REFERENCES remolque ( matricula_remolque );

ALTER TABLE remolque_parque
    ADD CONSTRAINT remolque_parque_parque_fk FOREIGN KEY ( nro_parque )
        REFERENCES parque ( nro_parque );

ALTER TABLE remolque_parque
    ADD CONSTRAINT remolque_parque_remolque_fk FOREIGN KEY ( matricula_remolque )
        REFERENCES remolque ( matricula_remolque );

ALTER TABLE ruta
    ADD CONSTRAINT ruta_comuna_fk FOREIGN KEY ( id_comuna )
        REFERENCES comuna ( id_comuna );

ALTER TABLE ruta
    ADD CONSTRAINT ruta_tipo_ruta_fk FOREIGN KEY ( id_tiporuta )
        REFERENCES tipo_ruta ( id_tiporuta );

ALTER TABLE tipo_conductor
    ADD CONSTRAINT tipo_conductor_sueldo_fk FOREIGN KEY ( id_sueldo )
        REFERENCES sueldo ( id_sueldo );

ALTER TABLE tipo_ruta
    ADD CONSTRAINT tipo_ruta_remolque_fk FOREIGN KEY ( matricula_remolque )
        REFERENCES remolque ( matricula_remolque );



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            15
-- CREATE INDEX                             0
-- ALTER TABLE                             31
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0

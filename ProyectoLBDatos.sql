                                                        -----------CREACIÓN DE TABLAS-----------
-- Tabla de rol
CREATE TABLE Rol (
    id_rol NUMBER PRIMARY KEY,
    nombre_rol VARCHAR2(50)
);

-- Tabla de usuarios del sistema
CREATE TABLE Usuario (
    id_usuario NUMBER PRIMARY KEY,
    nombre_usuario VARCHAR2(100),
    contrasena VARCHAR2(100),
    id_rol NUMBER,
    FOREIGN KEY (id_rol) REFERENCES Rol(id_rol)
);

-- Tabla de clientes
CREATE TABLE Cliente (
    id_cliente NUMBER PRIMARY KEY,
    nombre_cliente VARCHAR2(100),
    tipo_cliente VARCHAR2(50) CHECK (tipo_cliente IN ('Carniceria', 'Bar', 'Restaurante', 'Público General')),
    zona_entrega VARCHAR2(100)
);

-- Tabla de zonas de entrega
CREATE TABLE Zona_Entrega (
    id_zona NUMBER PRIMARY KEY,
    nombre_zona VARCHAR2(100)
);

-- Tabla de entregas (relaciona cliente y zona de entrega)
CREATE TABLE Entrega (
    id_entrega NUMBER PRIMARY KEY,
    id_cliente NUMBER,
    id_zona NUMBER,
    fecha_entrega DATE,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    FOREIGN KEY (id_zona) REFERENCES Zona_Entrega(id_zona)
);

-- Tabla de categorias de productos
CREATE TABLE Categoria (
    id_categoria NUMBER PRIMARY KEY,
    nombre_categoria VARCHAR2(100)
);

-- Tabla de productos (con categoría)
CREATE TABLE Producto (
    id_producto NUMBER PRIMARY KEY,
    nombre_producto VARCHAR2(100),
    descripcion VARCHAR2(200),
    id_categoria NUMBER,
    FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria)
);

-- Inventario actual por producto
CREATE TABLE Inventario (
    id_producto NUMBER PRIMARY KEY,
    cantidad NUMBER,
    fecha_actualizacion DATE,
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

-- Historial de inventario
CREATE TABLE Historial_Inventario (
    id_historial NUMBER PRIMARY KEY,
    id_producto NUMBER,
    cantidad NUMBER,
    fecha_modificacion DATE,
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

-- Precios actuales según tipo de cliente
CREATE TABLE Precio (
    id_precio NUMBER PRIMARY KEY,
    id_producto NUMBER,
    tipo_cliente VARCHAR2(50),
    precio_unitario NUMBER(10,2),
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

-- Historial de precios
CREATE TABLE Historial_Precio (
    id_historial NUMBER PRIMARY KEY,
    id_producto NUMBER,
    tipo_cliente VARCHAR2(50),
    precio_unitario NUMBER(10,2),
    fecha_cambio DATE,
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

--Tabla de Combo
CREATE TABLE COMBO (
    id_combo INT PRIMARY KEY,
    nombre VARCHAR2(100),
    descripcion CLOB,
    fecha_inicio DATE,
    fecha_fin DATE
);

--Tabla de Cobertura de Zona 
CREATE TABLE COBERTURA_ZONA (
    id_cobertura INT PRIMARY KEY,
    id_zona INT,
    detalles VARCHAR2(200)
);
                                                   -----------INSERTS-------------------------
INSERT INTO Rol VALUES (1, 'Administrador');
INSERT INTO Rol VALUES (2, 'Vendedor');
INSERT INTO Rol VALUES (3, 'Supervisor');
INSERT INTO Rol VALUES (4, 'Cliente');
INSERT INTO Rol VALUES (5, 'Invitado');

INSERT INTO Usuario VALUES (1, 'admin', 'admin123', 1);
INSERT INTO Usuario VALUES (2, 'jose_vendedor', 'jose584', 2);
INSERT INTO Usuario VALUES (3, 'ana_supervisor', 'ana784', 3);
INSERT INTO Usuario VALUES (4, 'cliente_juan', 'juan874', 4);
INSERT INTO Usuario VALUES (5, 'visitante1', 'guest245', 5);

INSERT INTO Cliente VALUES (1, 'Carniceria La Esperanza', 'Carniceria', 'Zona Norte');
INSERT INTO Cliente VALUES (2, 'Bar El Refugio', 'Bar', 'Zona Centro');
INSERT INTO Cliente VALUES (3, 'Restaurante Buen Sabor', 'Restaurante', 'Zona Este');
INSERT INTO Cliente VALUES (4, 'Pedro Ramírez', 'Público General', 'Zona Oeste');
INSERT INTO Cliente VALUES (5, 'Bar El Sueño', 'Bar', 'Zona Centro');

INSERT INTO Zona_Entrega VALUES (1, 'Zona Norte');
INSERT INTO Zona_Entrega VALUES (2, 'Zona Centro');
INSERT INTO Zona_Entrega VALUES (3, 'Zona Este');
INSERT INTO Zona_Entrega VALUES (4, 'Zona Oeste');
INSERT INTO Zona_Entrega VALUES (5, 'Zona Sur');

INSERT INTO Entrega VALUES (1, 1, 1, TO_DATE('2025-07-01', 'YYYY-MM-DD'));
INSERT INTO Entrega VALUES (2, 2, 2, TO_DATE('2025-07-02', 'YYYY-MM-DD'));
INSERT INTO Entrega VALUES (3, 3, 3, TO_DATE('2025-07-03', 'YYYY-MM-DD'));
INSERT INTO Entrega VALUES (4, 4, 4, TO_DATE('2025-07-04', 'YYYY-MM-DD'));
INSERT INTO Entrega VALUES (5, 5, 5, TO_DATE('2025-07-05', 'YYYY-MM-DD'));

INSERT INTO Categoria VALUES (1, 'Carnes');
INSERT INTO Categoria VALUES (2, 'Bebidas');
INSERT INTO Categoria VALUES (3, 'Postres');
INSERT INTO Categoria VALUES (4, 'Lácteos');
INSERT INTO Categoria VALUES (5, 'Enlatados');

INSERT INTO Producto VALUES (1, 'Carne Molida', 'Carne fresca molida de res', 1);
INSERT INTO Producto VALUES (2, 'Cerveza Artesanal', 'Botella de 500ml', 2);
INSERT INTO Producto VALUES (3, 'Helado de Vainilla', '1 litro', 3);
INSERT INTO Producto VALUES (4, 'Leche Entera', 'Botella de 1L', 4);
INSERT INTO Producto VALUES (5, 'Atún en Agua', 'Lata de 140g', 5);

UPDATE Inventario SET cantidad = 50, fecha_actualizacion = SYSDATE WHERE id_producto = 1;
UPDATE Inventario SET cantidad = 120, fecha_actualizacion = SYSDATE WHERE id_producto = 2;
UPDATE Inventario SET cantidad = 30, fecha_actualizacion = SYSDATE WHERE id_producto = 3;
UPDATE Inventario SET cantidad = 200, fecha_actualizacion = SYSDATE WHERE id_producto = 4;
UPDATE Inventario SET cantidad = 75, fecha_actualizacion = SYSDATE WHERE id_producto = 5;

INSERT INTO Historial_Inventario VALUES (1, 1, 45, TO_DATE('2025-07-01', 'YYYY-MM-DD'));
INSERT INTO Historial_Inventario VALUES (2, 2, 130, TO_DATE('2025-07-02', 'YYYY-MM-DD'));
INSERT INTO Historial_Inventario VALUES (3, 3, 25, TO_DATE('2025-07-03', 'YYYY-MM-DD'));
INSERT INTO Historial_Inventario VALUES (4, 4, 190, TO_DATE('2025-07-04', 'YYYY-MM-DD'));
INSERT INTO Historial_Inventario VALUES (5, 5, 60, TO_DATE('2025-07-05', 'YYYY-MM-DD'));

INSERT INTO Precio VALUES (1, 1, 'Carniceria', 2500.00);
INSERT INTO Precio VALUES (2, 2, 'Bar', 1500.00);
INSERT INTO Precio VALUES (3, 3, 'Restaurante', 1800.00);
INSERT INTO Precio VALUES (4, 4, 'Público General', 2000.00);
INSERT INTO Precio VALUES (5, 5, 'Carniceria', 900.00);

INSERT INTO Historial_Precio VALUES (1, 1, 'Carniceria', 2300.00, TO_DATE('2025-06-20', 'YYYY-MM-DD'));
INSERT INTO Historial_Precio VALUES (2, 2, 'Bar', 1450.00, TO_DATE('2025-06-25', 'YYYY-MM-DD'));
INSERT INTO Historial_Precio VALUES (3, 3, 'Restaurante', 1700.00, TO_DATE('2025-06-28', 'YYYY-MM-DD'));
INSERT INTO Historial_Precio VALUES (4, 4, 'Público General', 1900.00, TO_DATE('2025-06-29', 'YYYY-MM-DD'));
INSERT INTO Historial_Precio VALUES (5, 5, 'Carniceria', 850.00, TO_DATE('2025-06-30', 'YYYY-MM-DD'));

INSERT INTO COMBO VALUES (1, 'Combo Familiar', 'Incluye 2 kg de carne y bebidas', TO_DATE('2025-07-01', 'YYYY-MM-DD'), TO_DATE('2025-07-31', 'YYYY-MM-DD'));
INSERT INTO COMBO VALUES (2, 'Combo Bar', '6 cervezas artesanales a precio especial', TO_DATE('2025-07-10', 'YYYY-MM-DD'), TO_DATE('2025-07-31', 'YYYY-MM-DD'));
INSERT INTO COMBO VALUES (3, 'Combo Infantil', 'Incluye postre + leche', TO_DATE('2025-07-05', 'YYYY-MM-DD'), TO_DATE('2025-08-05', 'YYYY-MM-DD'));
INSERT INTO COMBO VALUES (4, 'Combo Express', 'Carne molida + atún en oferta', TO_DATE('2025-07-03', 'YYYY-MM-DD'), TO_DATE('2025-07-15', 'YYYY-MM-DD'));
INSERT INTO COMBO VALUES (5, 'Combo Restaurante', 'Incluye cortes especiales', TO_DATE('2025-07-01', 'YYYY-MM-DD'), TO_DATE('2025-07-30', 'YYYY-MM-DD'));

INSERT INTO COBERTURA_ZONA VALUES (1, 1, 'Cobertura completa para la zona norte');
INSERT INTO COBERTURA_ZONA VALUES (2, 2, 'Cobertura parcial por clima en zona centro');
INSERT INTO COBERTURA_ZONA VALUES (3, 3, 'Cobertura total en zona este');
INSERT INTO COBERTURA_ZONA VALUES (4, 4, 'Cobertura limitada en zona oeste');
INSERT INTO COBERTURA_ZONA VALUES (5, 5, 'Sin cobertura los domingos');

                                                   ----------PROCEDIMIENTOS ALMACENADOS CRUD-----------------


-- CRUD PARA ROL
CREATE OR REPLACE PROCEDURE insertar_rol(p_id IN NUMBER, p_nombre IN VARCHAR2) IS
BEGIN
    INSERT INTO Rol VALUES (p_id, p_nombre);
END;
/

CREATE OR REPLACE PROCEDURE obtener_rol(p_id IN NUMBER, p_cursor OUT SYS_REFCURSOR) IS
BEGIN
    OPEN p_cursor FOR SELECT * FROM Rol WHERE id_rol = p_id;
END;
/

CREATE OR REPLACE PROCEDURE actualizar_rol(p_id IN NUMBER, p_nombre IN VARCHAR2) IS
BEGIN
    UPDATE Rol SET nombre_rol = p_nombre WHERE id_rol = p_id;
END;
/

CREATE OR REPLACE PROCEDURE eliminar_rol(p_id IN NUMBER) IS
BEGIN
    DELETE FROM Rol WHERE id_rol = p_id;
END;
/

-- CRUD PARA USUARIO
CREATE OR REPLACE PROCEDURE insertar_usuario(p_id IN NUMBER, p_nombre IN VARCHAR2, p_pass IN VARCHAR2, p_rol IN NUMBER) IS
BEGIN
    INSERT INTO Usuario VALUES (p_id, p_nombre, p_pass, p_rol);
END;
/

CREATE OR REPLACE PROCEDURE obtener_usuario(p_id IN NUMBER, p_cursor OUT SYS_REFCURSOR) IS
BEGIN
    OPEN p_cursor FOR SELECT * FROM Usuario WHERE id_usuario = p_id;
END;
/

CREATE OR REPLACE PROCEDURE actualizar_usuario(p_id IN NUMBER, p_nombre IN VARCHAR2, p_pass IN VARCHAR2, p_rol IN NUMBER) IS
BEGIN
    UPDATE Usuario SET nombre_usuario = p_nombre, contrasena = p_pass, id_rol = p_rol WHERE id_usuario = p_id;
END;
/

CREATE OR REPLACE PROCEDURE eliminar_usuario(p_id IN NUMBER) IS
BEGIN
    DELETE FROM Usuario WHERE id_usuario = p_id;
END;
/

-- CRUD PARA ZONA_ENTREGA
CREATE OR REPLACE PROCEDURE insertar_zona(p_id IN NUMBER, p_nombre IN VARCHAR2) IS
BEGIN
    INSERT INTO Zona_Entrega VALUES (p_id, p_nombre);
END;
/

CREATE OR REPLACE PROCEDURE obtener_zona(p_id IN NUMBER, p_cursor OUT SYS_REFCURSOR) IS
BEGIN
    OPEN p_cursor FOR SELECT * FROM Zona_Entrega WHERE id_zona = p_id;
END;
/

CREATE OR REPLACE PROCEDURE actualizar_zona(p_id IN NUMBER, p_nombre IN VARCHAR2) IS
BEGIN
    UPDATE Zona_Entrega SET nombre_zona = p_nombre WHERE id_zona = p_id;
END;
/

CREATE OR REPLACE PROCEDURE eliminar_zona(p_id IN NUMBER) IS
BEGIN
    DELETE FROM Zona_Entrega WHERE id_zona = p_id;
END;
/


-- CRUD PARA ENTREGA
CREATE OR REPLACE PROCEDURE insertar_entrega(p_id IN NUMBER, p_cliente IN NUMBER, p_zona IN NUMBER, p_fecha DATE) IS
BEGIN
    INSERT INTO Entrega VALUES (p_id, p_cliente, p_zona, p_fecha);
END;
/

CREATE OR REPLACE PROCEDURE obtener_entrega(p_id IN NUMBER, p_cursor OUT SYS_REFCURSOR) IS
BEGIN
    OPEN p_cursor FOR SELECT * FROM Entrega WHERE id_entrega = p_id;
END;
/

CREATE OR REPLACE PROCEDURE actualizar_entrega(p_id IN NUMBER, p_cliente IN NUMBER, p_zona IN NUMBER, p_fecha DATE) IS
BEGIN
    UPDATE Entrega
    SET id_cliente = p_cliente, id_zona = p_zona, fecha_entrega = p_fecha
    WHERE id_entrega = p_id;
END;
/

CREATE OR REPLACE PROCEDURE eliminar_entrega(p_id IN NUMBER) IS
BEGIN
    DELETE FROM Entrega WHERE id_entrega = p_id;
END;
/


-- CRUD PARA CATEGORIA
CREATE OR REPLACE PROCEDURE insertar_categoria(p_id IN NUMBER, p_nombre IN VARCHAR2) IS
BEGIN
    INSERT INTO Categoria VALUES (p_id, p_nombre);
END;
/

CREATE OR REPLACE PROCEDURE obtener_categoria(p_id IN NUMBER, p_cursor OUT SYS_REFCURSOR) IS
BEGIN
    OPEN p_cursor FOR SELECT * FROM Categoria WHERE id_categoria = p_id;
END;
/

CREATE OR REPLACE PROCEDURE actualizar_categoria(p_id IN NUMBER, p_nombre IN VARCHAR2) IS
BEGIN
    UPDATE Categoria SET nombre_categoria = p_nombre WHERE id_categoria = p_id;
END;
/

CREATE OR REPLACE PROCEDURE eliminar_categoria(p_id IN NUMBER) IS
BEGIN
    DELETE FROM Categoria WHERE id_categoria = p_id;
END;
/

-- CRUD PARA CLIENTE
CREATE OR REPLACE PROCEDURE actualizar_cliente(
    p_id_cliente IN NUMBER,
    p_nombre_cliente IN VARCHAR2,
    p_tipo_cliente IN VARCHAR2,
    p_zona IN VARCHAR2
) IS
BEGIN
    UPDATE Cliente
    SET nombre_cliente = p_nombre_cliente,
        tipo_cliente = p_tipo_cliente,
        zona_entrega = p_zona
    WHERE id_cliente = p_id_cliente;
END;
/

CREATE OR REPLACE PROCEDURE obtener_cliente(
    p_id_cliente IN NUMBER,
    p_cursor OUT SYS_REFCURSOR
) IS
BEGIN
    OPEN p_cursor FOR SELECT * FROM Cliente WHERE id_cliente = p_id_cliente;
END;
/

CREATE OR REPLACE PROCEDURE eliminar_cliente(p_id_cliente IN NUMBER) IS
BEGIN
    DELETE FROM Cliente WHERE id_cliente = p_id_cliente;
END;
/


-- CRUD PARA PRODUCTO
CREATE OR REPLACE PROCEDURE obtener_producto(p_id_producto IN NUMBER, p_cursor OUT SYS_REFCURSOR) IS
BEGIN
    OPEN p_cursor FOR SELECT * FROM Producto WHERE id_producto = p_id_producto;
END;
/

CREATE OR REPLACE PROCEDURE actualizar_producto(
    p_id_producto IN NUMBER,
    p_nombre IN VARCHAR2,
    p_descripcion IN VARCHAR2,
    p_id_categoria IN NUMBER
) IS
BEGIN
    UPDATE Producto
    SET nombre_producto = p_nombre,
        descripcion = p_descripcion,
        id_categoria = p_id_categoria
    WHERE id_producto = p_id_producto;
END;
/

CREATE OR REPLACE PROCEDURE eliminar_producto(p_id_producto IN NUMBER) IS
BEGIN
    DELETE FROM Producto WHERE id_producto = p_id_producto;
END;
/


-- CRUD PARA INVENTARIO
CREATE OR REPLACE PROCEDURE obtener_inventario(p_id_producto IN NUMBER, p_cursor OUT SYS_REFCURSOR) IS
BEGIN
    OPEN p_cursor FOR SELECT * FROM Inventario WHERE id_producto = p_id_producto;
END;
/

CREATE OR REPLACE PROCEDURE eliminar_inventario(p_id_producto IN NUMBER) IS
BEGIN
    DELETE FROM Inventario WHERE id_producto = p_id_producto;
END;
/


-- CRUD PARA PRECIO
CREATE OR REPLACE PROCEDURE insertar_precio(p_id IN NUMBER, p_producto IN NUMBER, p_tipo IN VARCHAR2, p_precio IN NUMBER) IS
BEGIN
    INSERT INTO Precio VALUES (p_id, p_producto, p_tipo, p_precio);
END;
/

CREATE OR REPLACE PROCEDURE actualizar_precio(p_id IN NUMBER, p_precio IN NUMBER) IS
BEGIN
    UPDATE Precio SET precio_unitario = p_precio WHERE id_precio = p_id;
END;
/

CREATE OR REPLACE PROCEDURE obtener_precio(p_id_precio IN NUMBER, p_cursor OUT SYS_REFCURSOR) IS
BEGIN
    OPEN p_cursor FOR SELECT * FROM Precio WHERE id_precio = p_id_precio;
END;
/

CREATE OR REPLACE PROCEDURE eliminar_precio(p_id_precio IN NUMBER) IS
BEGIN
    DELETE FROM Precio WHERE id_precio = p_id_precio;
END;
/
                                                               ------------TRIGGERS-----------
----PARA CORRER LOS TRIGGERS TENEMOS QUE HACER SECUENCIAS
-- 1. Historial de precios
CREATE OR REPLACE TRIGGER trg_historial_precio
AFTER UPDATE ON Precio
FOR EACH ROW
BEGIN
    INSERT INTO Historial_Precio (id_historial, id_producto, tipo_cliente, precio_unitario, fecha_cambio)
    VALUES (Historial_Precio_seq.NEXTVAL, :NEW.id_producto, :NEW.tipo_cliente, :NEW.precio_unitario, SYSDATE);
END;
/

-- 2. Historial de inventario
CREATE OR REPLACE TRIGGER trg_historial_inventario
AFTER UPDATE ON Inventario
FOR EACH ROW
BEGIN
    INSERT INTO Historial_Inventario (id_historial, id_producto, cantidad, fecha_modificacion)
    VALUES (Historial_Inventario_seq.NEXTVAL, :NEW.id_producto, :NEW.cantidad, SYSDATE);
END;
/

-- 3. Auditoría creación de producto
CREATE OR REPLACE TRIGGER trg_log_producto_insert
AFTER INSERT ON Producto
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('Producto creado: ' || :NEW.nombre_producto);
END;
/

-- 4. Verificación nombre de usuario único
CREATE OR REPLACE TRIGGER trg_usuario_unico
BEFORE INSERT ON Usuario
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM Usuario WHERE nombre_usuario = :NEW.nombre_usuario;
    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'El nombre de usuario ya existe.');
    END IF;
END;
/

-- 5. Control tipo de cliente válido
CREATE OR REPLACE TRIGGER trg_validar_tipo_cliente
BEFORE INSERT OR UPDATE ON Cliente
FOR EACH ROW
BEGIN
    IF :NEW.tipo_cliente NOT IN ('Carniceria', 'Bar', 'Restaurante', 'Publico General') THEN
        RAISE_APPLICATION_ERROR(-20002, 'Tipo de cliente inválido.');
    END IF;
END;
/

--------------------------------------Funciones----------------------------------
--Devuelve el precio actual de un producto para un tipo de cliente.
CREATE OR REPLACE FUNCTION FN_OBTENER_PRECIO_CLIENTE (
    p_id_producto IN NUMBER,
    p_tipo_cliente IN VARCHAR2
) RETURN NUMBER IS
    v_precio NUMBER(10,2);
BEGIN
    SELECT precio_unitario INTO v_precio
    FROM Precio
    WHERE id_producto = p_id_producto
      AND tipo_cliente = p_tipo_cliente;

    RETURN v_precio;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
END;
/

--Devuelve la cantidad disponible en inventario de un producto.
CREATE OR REPLACE FUNCTION FN_EXISTENCIA_PRODUCTO (
    p_id_producto IN NUMBER
) RETURN NUMBER IS
    v_cantidad NUMBER;
BEGIN
    SELECT cantidad INTO v_cantidad
    FROM Inventario
    WHERE id_producto = p_id_producto;

    RETURN v_cantidad;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
END;
/

---Devuelve la cantidad de clientes asignados a una zona de entrega.
CREATE OR REPLACE FUNCTION FN_CLIENTES_ZONA (
    p_id_zona IN NUMBER
) RETURN NUMBER IS
    v_total NUMBER;
BEGIN
    SELECT COUNT(DISTINCT id_cliente)
    INTO v_total
    FROM Entrega
    WHERE id_zona = p_id_zona;

    RETURN v_total;
END;
/

----Devuelve el total de entregas realizadas a un cliente.
CREATE OR REPLACE FUNCTION FN_TOTAL_ENTREGAS_CLIENTE (
    p_id_cliente IN NUMBER
) RETURN NUMBER IS
    v_total NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_total
    FROM Entrega
    WHERE id_cliente = p_id_cliente;

    RETURN v_total;
END;
/

---Devuelve el tipo de cliente según su ID.
CREATE OR REPLACE FUNCTION FN_TIPO_CLIENTE (
    p_id_cliente IN NUMBER
) RETURN VARCHAR2 IS
    v_tipo VARCHAR2(50);
BEGIN
    SELECT tipo_cliente INTO v_tipo
    FROM Cliente
    WHERE id_cliente = p_id_cliente;

    RETURN v_tipo;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'No Encontrado';
END;
/

--Retorna el nombre del producto según el ID.
CREATE OR REPLACE FUNCTION FN_NOMBRE_PRODUCTO (
    p_id_producto IN NUMBER
) RETURN VARCHAR2 IS
    v_nombre VARCHAR2(100);
BEGIN
    SELECT nombre_producto INTO v_nombre
    FROM Producto
    WHERE id_producto = p_id_producto;

    RETURN v_nombre;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'Producto no existe';
END;
/

---Cuenta cuántos combos están activos en una fecha específica.
CREATE OR REPLACE FUNCTION FN_COMBOS_ACTIVOS (
    p_fecha IN DATE
) RETURN NUMBER IS
    v_total NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_total
    FROM COMBO
    WHERE p_fecha BETWEEN fecha_inicio AND fecha_fin;

    RETURN v_total;
END;
/
----------------------------Cursores-----------------------------------------------------
--Lista los clientes de una zona específica.
DECLARE
    CURSOR cur_clientes_zona(p_id_zona NUMBER) IS
        SELECT C.id_cliente, C.nombre_cliente
        FROM Cliente C
        JOIN Entrega E ON C.id_cliente = E.id_cliente
        WHERE E.id_zona = p_id_zona;

    v_id_cliente Cliente.id_cliente%TYPE;
    v_nombre_cliente Cliente.nombre_cliente%TYPE;
BEGIN
    FOR cliente_rec IN cur_clientes_zona(2) LOOP
        v_id_cliente := cliente_rec.id_cliente;
        v_nombre_cliente := cliente_rec.nombre_cliente;
        DBMS_OUTPUT.PUT_LINE('Cliente: ' || v_nombre_cliente || ' (ID: ' || v_id_cliente || ')');
    END LOOP;
END;
/

--Muestra todos los productos de una categoría.
DECLARE
    CURSOR cur_productos_categoria(p_id_categoria NUMBER) IS
        SELECT nombre_producto, descripcion
        FROM Producto
        WHERE id_categoria = p_id_categoria;

BEGIN
    FOR prod IN cur_productos_categoria(1) LOOP
        DBMS_OUTPUT.PUT_LINE('Producto: ' || prod.nombre_producto || ' - ' || prod.descripcion);
    END LOOP;
END;
/

--Lista productos con cantidad menor o igual a 10 unidades.
DECLARE
    CURSOR cur_inventario_bajo IS
        SELECT P.nombre_producto, I.cantidad
        FROM Inventario I
        JOIN Producto P ON I.id_producto = P.id_producto
        WHERE I.cantidad <= 10;

BEGIN
    FOR item IN cur_inventario_bajo LOOP
        DBMS_OUTPUT.PUT_LINE('¡Bajo stock! Producto: ' || item.nombre_producto || ' - Cantidad: ' || item.cantidad);
    END LOOP;
END;
/

----Muestra entregas realizadas en una fecha específica.
DECLARE
    CURSOR cur_entregas_fecha(p_fecha DATE) IS
        SELECT E.id_entrega, C.nombre_cliente, Z.nombre_zona
        FROM Entrega E
        JOIN Cliente C ON E.id_cliente = C.id_cliente
        JOIN Zona_Entrega Z ON E.id_zona = Z.id_zona
        WHERE E.fecha_entrega = p_fecha;

BEGIN
    FOR entrega IN cur_entregas_fecha(SYSDATE) LOOP
        DBMS_OUTPUT.PUT_LINE('Entrega ID: ' || entrega.id_entrega || ' - Cliente: ' || entrega.nombre_cliente || ' - Zona: ' || entrega.nombre_zona);
    END LOOP;
END;
/

---Lista los precios por tipo de cliente para un producto específico.
DECLARE
    CURSOR cur_precios_producto(p_id_producto NUMBER) IS
        SELECT tipo_cliente, precio_unitario
        FROM Precio
        WHERE id_producto = p_id_producto;

BEGIN
    FOR precio IN cur_precios_producto(1) LOOP
        DBMS_OUTPUT.PUT_LINE('Tipo cliente: ' || precio.tipo_cliente || ' - Precio: ₡' || precio.precio_unitario);
    END LOOP;
END;
/

----Muestra movimientos históricos para un producto.
DECLARE
    CURSOR cur_historial_inventario(p_id_producto NUMBER) IS
        SELECT cantidad, fecha_modificacion
        FROM Historial_Inventario
        WHERE id_producto = p_id_producto
        ORDER BY fecha_modificacion DESC;

BEGIN
    FOR hist IN cur_historial_inventario(1) LOOP
        DBMS_OUTPUT.PUT_LINE('Fecha: ' || hist.fecha_modificacion || ' - Cantidad: ' || hist.cantidad);
    END LOOP;
END;
/

----Lista combos activos hoy.
DECLARE
    CURSOR cur_combos_activos IS
        SELECT nombre, descripcion
        FROM COMBO
        WHERE SYSDATE BETWEEN fecha_inicio AND fecha_fin;

BEGIN
    FOR combo IN cur_combos_activos LOOP
        DBMS_OUTPUT.PUT_LINE('Combo Activo: ' || combo.nombre || ' - ' || SUBSTR(combo.descripcion, 1, 50));
    END LOOP;
END;
/

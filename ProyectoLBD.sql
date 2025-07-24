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
    tipo_cliente VARCHAR2(50) CHECK (tipo_cliente IN ('Carnicería', 'Bar', 'Restaurante', 'Público General')),
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

-- Tabla de categorías de productos
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
    IF :NEW.tipo_cliente NOT IN ('Carnicería', 'Bar', 'Restaurante', 'Público General') THEN
        RAISE_APPLICATION_ERROR(-20002, 'Tipo de cliente inválido.');
    END IF;
END;
/

CREATE DATABASE delivery_db;
USE delivery_db;

-- Tabla Usuarios
CREATE TABLE Usuarios (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    direccion VARCHAR(255) NOT NULL
);

-- Tabla Restaurante
CREATE TABLE Restaurante (
    Id_Restaurante INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(100) NOT NULL UNIQUE,
    telefono VARCHAR(100) NOT NULL
);

-- Tabla Productos
CREATE TABLE Productos (
    Id_Productos INT PRIMARY KEY AUTO_INCREMENT,  -- Corregido: Id_Produtos → Id_Productos
    Restaurante_id INT NOT NULL,
    nombre VARCHAR(100) UNIQUE,
    descripcion TEXT,  -- TEXT no admite longitud como (200)
    precio DECIMAL(10,2),
    FOREIGN KEY (Restaurante_id) REFERENCES Restaurante (Id_Restaurante)
);

-- Tabla Pedidos
CREATE TABLE Pedidos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    Usuarios_id INT NOT NULL,
    Restaurante_id INT NOT NULL,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    estado VARCHAR(50) DEFAULT 'Pendiente',
    FOREIGN KEY (Usuarios_id) REFERENCES Usuarios (Id),  -- Corregido: Id_Usuarios no existe
    FOREIGN KEY (Restaurante_id) REFERENCES Restaurante (Id_Restaurante)
);

-- Tabla Detalles_Pedido
CREATE TABLE Detalles_Pedido (
    id INT PRIMARY KEY AUTO_INCREMENT,
    pedido_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES Pedidos (id),
    FOREIGN KEY (producto_id) REFERENCES Productos (Id_Productos)  -- Corregido: Productos (id) no existe
);

INSERT INTO Restaurante (nombre, direccion, telefono) VALUES
("Pizza Paraíso", "Calle Falsa 123", "555-0101"),
("Sushi Express", "Avenida Siempre Viva 456", "555-0102"),
("Taco Fiesta", "Plaza Central 789", "555-0103");

SELECT * FROM Restaurante;

INSERT INTO Usuarios (nombre, email, telefono, direccion) VALUES
('Ana Torres', 'ana.t@email.com', '310-1234567', 'Carrera 5 # 4-56, Apartamento 101'),
('Carlos Ruiz', 'carlos.r@email.com', '311-9876543', 'Avenida del Río # 89-12'),
('Lucía Fernandez', 'lucia.f@email.com', '312-5558899', 'Calle 100 = 15-20'),
('Javier Moreno', 'javier.m@email.com', '313-2223344', 'Transversal 1 # 23-45'),
('Sofía Castro', 'sofia.c@email.com', '314-7776655', 'Avenida del Parque # 67-89');

SELECT * FROM Usuarios;

INSERT INTO Productos (restaurante_id, nombre, descripcion, precio) VALUES
(1, "Pizza Hawaiana", "Pizza con piña, jamón y queso mozzarella.", 25.50),
(1, "Pizza Pepperoni", "Clásica pizza de pepperoni con extra queso", 22.00),
(1, "Lasaña de Carne", "Capas de pasta con salsa boloñesa y bechamel.", 28.00);

SELECT * FROM Productos;


INSERT INTO Productos (restaurante_id, nombre, descripcion, precio) VALUES
(2, "Rollo California", "Rollo de cangrejo, aguacate y pepino.", 18.00),
(2, "Nigiri de Salmón", "Finas lonjas de salmón sobre arroz de sushi", 15.58),
(2, "Vakimeshi Mixto", "Arroz frito con verduras, pollo y camarón", 21.00);

INSERT INTO Pedidos (Usuarios_id, Restaurante_id, estado) VALUES
(2, 3, 'En preparación');

-- Lucia Fernandez (usuario_id = 3) ha cambiadod su numero de telefono.

UPDATE Usuarios SET telefono = '353434' WHERE Id = 3;

-- El precio de la pizza hawaiana (producto_id = 1) ha subido 
-- este es para actualizar. 
UPDATE Productos SET precio = 30 WHERE Id_Productos = 1;

-- obten la lista de todos los restaurantes de 'Sushi Express' (Restaurante_id = 2).
-- este es para buscar.
-- el asterisco trae todas las columnas y el "FROM" seleciona la tabla  "de donde viene" 
SELECT * FROM Productos WHERE Restaurante_id = 2;

-- Encuentra todos los pedidos realizados por 'carlos ruiz' (usuario_id = 2).

SELECT * FROM Pedidos WHERE Usuarios_id = 2;

SELECT  p.id AS pedido_id, u.nombre AS usuario, r.nombre AS restaurante, p.fecha, 
p.estado FROM Pedidos p JOIN Usuarios u ON p.Usuarios_id = u.Id JOIN Restaurante 
r ON p.Restaurante_id = r.Id_Restaurante WHERE u.Id = 2;
-- =============================================
-- 1. CREACIÓN DE TABLAS (Directo en tu base de la nube)
-- =============================================

-- TABLA 1: CATEGORIAS
CREATE TABLE Categorias (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(50) NOT NULL,
    Orden INT DEFAULT 99
);
GO

-- TABLA 2: PRODUCTOS
CREATE TABLE Productos (
    Id INT PRIMARY KEY IDENTITY(1,1),
    IdCategoria INT NOT NULL,
    Nombre VARCHAR(100) NOT NULL,
    Precio INT NOT NULL, -- ENTERO
    Unidad VARCHAR(20) NOT NULL,
    Activo BIT DEFAULT 1,
    Descripcion VARCHAR(255) NULL,
    
    CONSTRAINT FK_Productos_Categorias FOREIGN KEY (IdCategoria) REFERENCES Categorias(Id)
);
GO

-- TABLA 3: CLIENTES
CREATE TABLE Clientes (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(100) NOT NULL,
    Telefono VARCHAR(50) NOT NULL UNIQUE,
    Direccion VARCHAR(200) NOT NULL,
    Barrio VARCHAR(100) NULL
);
GO

-- TABLA 4: PEDIDOS
CREATE TABLE Pedidos (
    Id INT PRIMARY KEY IDENTITY(1,1),
    IdCliente INT NOT NULL,
    Fecha DATETIME DEFAULT GETDATE(),
    Total INT NOT NULL,
    Estado VARCHAR(20) DEFAULT 'Pendiente',
    
    CONSTRAINT FK_Pedidos_Clientes FOREIGN KEY (IdCliente) REFERENCES Clientes(Id)
);
GO

-- TABLA 5: DETALLES DE PEDIDO
CREATE TABLE DetallesPedido (
    Id INT PRIMARY KEY IDENTITY(1,1),
    IdPedido INT NOT NULL,
    IdProducto INT NOT NULL,
    Cantidad INT NOT NULL,
    PrecioUnitario INT NOT NULL,
    
    CONSTRAINT FK_Detalles_Pedidos FOREIGN KEY (IdPedido) REFERENCES Pedidos(Id),
    CONSTRAINT FK_Detalles_Productos FOREIGN KEY (IdProducto) REFERENCES Productos(Id)
);
GO

-- =============================================
-- 2. CARGA DE DATOS DE PRUEBA (SEED DATA)
-- =============================================

-- Cargamos Categorias
INSERT INTO Categorias (Nombre, Orden) VALUES 
('Combos y Ofertas', 1),
('Verduras Pesadas', 2),
('Verduras de Hoja', 3),
('Frutas', 4);

-- Cargamos Productos
INSERT INTO Productos (IdCategoria, Nombre, Precio, Unidad, Activo, Descripcion) VALUES 
(2, 'Papas Negras', 1200, 'Kg', 1, 'Papas seleccionadas'),
(2, 'Cebolla', 1000, 'Kg', 1, NULL),
(4, 'Banana Ecuador', 1800, 'Kg', 1, 'Banana premium'),
(3, 'Acelga', 1500, 'Paquete', 1, 'Paquete grande de campo'),
(1, 'Combo Ensalada', 5000, 'Bolsa', 1, 'Trae lechuga, tomate, cebolla y zanahoria');

-- Cargamos un Cliente de prueba

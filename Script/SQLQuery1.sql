-- BORRAMOS LAS TABLAS VIEJAS (Las de la web)
IF OBJECT_ID('dbo.DetallesPedido', 'U') IS NOT NULL DROP TABLE dbo.DetallesPedido;
IF OBJECT_ID('dbo.Pedidos', 'U') IS NOT NULL DROP TABLE dbo.Pedidos;

-- CREAMOS LA TABLA PEDIDOS (Formato Web / Sin Login)
CREATE TABLE Pedidos (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Fecha DATETIME DEFAULT GETDATE(),
    Cliente NVARCHAR(100),    -- <--- AHORA SÍ TIENE CLIENTE
    Direccion NVARCHAR(200),
    Telefono NVARCHAR(50),
    Comentarios NVARCHAR(MAX),
    Total DECIMAL(10,2)
);

-- CREAMOS LA TABLA DETALLES
CREATE TABLE DetallesPedido (
    Id INT PRIMARY KEY IDENTITY(1,1),
    IdPedido INT FOREIGN KEY REFERENCES Pedidos(Id),
    IdProducto INT,
    NombreProducto NVARCHAR(100),
    PrecioUnitario DECIMAL(10,2),
    Cantidad INT
);
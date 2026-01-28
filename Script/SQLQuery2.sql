    -- 1. Si existe, borramos la tabla Clientes vieja (que no se usa)
    IF OBJECT_ID('dbo.Clientes', 'U') IS NOT NULL 
       DROP TABLE dbo.Clientes;

    -- 2. Creamos la tabla Usuarios (La definitiva)
    CREATE TABLE Usuarios (
        Id INT PRIMARY KEY IDENTITY(1,1),
        Email VARCHAR(100) NOT NULL UNIQUE,
        Pass VARCHAR(50) NOT NULL,
        Nombre VARCHAR(50),
        Apellido VARCHAR(50),
        Telefono VARCHAR(50),   -- Dato de contacto
        Direccion VARCHAR(200), -- Para autocompletar envíos
        TipoUsuario INT DEFAULT 2 
    );
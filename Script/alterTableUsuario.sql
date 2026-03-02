CREATE TABLE Tipos_Usuario (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(50) NOT NULL -- Acá va 'Admin' o 'Normal'
)
SET IDENTITY_INSERT Tipos_Usuario ON;

INSERT INTO Tipos_Usuario (Id, Nombre) VALUES (1, 'Admin');
INSERT INTO Tipos_Usuario (Id, Nombre) VALUES (2, 'Cliente');

SET IDENTITY_INSERT Tipos_Usuario OFF;

ALTER TABLE Usuarios
ADD CONSTRAINT FK_Usuarios_Tipos
FOREIGN KEY (TipoUsuario) REFERENCES Tipos_Usuario(Id);

UPDATE Usuarios SET TipoUsuario = 1 WHERE Email = 'tu-email-de-logueo@ejemplo.com';

SELECT Id, Email, Nombre, TipoUsuario FROM Usuarios;

UPDATE Usuarios 
SET TipoUsuario = 1 
WHERE Id = 3;
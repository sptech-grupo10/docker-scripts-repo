-- Drop database if exists
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'ByteGuard')
    DROP DATABASE ByteGuard;

-- Create database
CREATE DATABASE ByteGuard;
GO

-- Use database
USE ByteGuard;
GO

-- Create table Endereco
CREATE TABLE Endereco (
    idEndereco INT PRIMARY KEY IDENTITY,
    cep CHAR(9),
    logradouro VARCHAR(50),
    numero VARCHAR(5),
    bairro VARCHAR(50),
    cidade VARCHAR(50),
    uf CHAR(2)
);
GO

-- Create table Representante
CREATE TABLE Representante (
    idRepresentante INT PRIMARY KEY IDENTITY,
    nome VARCHAR(45),
    telefone VARCHAR(15),
    email VARCHAR(45),
    cpf CHAR(14),
    status TINYINT DEFAULT 1
);
GO

-- Create table Empresa
CREATE TABLE Empresa (
    idEmpresa INT PRIMARY KEY IDENTITY,
    cnpj CHAR(14),
    nomeFantasia VARCHAR(45),
    razaoSocial VARCHAR(45),
    status TINYINT DEFAULT 1,
    fkRepresentante INT,
    fkEndereco INT,
    CONSTRAINT fkEmpresaEndereco FOREIGN KEY (fkEndereco) REFERENCES Endereco(idEndereco),
    CONSTRAINT fkEmpresaRepresentante FOREIGN KEY (fkRepresentante) REFERENCES Representante(idRepresentante)
);
GO

-- Create table LanHouse
CREATE TABLE LanHouse (
    idLanHouse INT PRIMARY KEY IDENTITY,
    unidade VARCHAR(45),
    cnpj CHAR(14),
    statusLanhouse TINYINT DEFAULT 1,
    codigoAcesso VARCHAR(40),
    fkEndereco INT,
    fkEmpresa INT,
    fkRepresentante INT,
    CONSTRAINT fkLanhouseEmpresa FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa),
    CONSTRAINT fkLanhouseEndereco FOREIGN KEY (fkEndereco) REFERENCES Endereco(idEndereco),
    CONSTRAINT fkLanhouseRepresentante FOREIGN KEY (fkRepresentante) REFERENCES Representante(idRepresentante)
);
GO

-- Create table TipoUsuario
CREATE TABLE TipoUsuario (
    idTipoUsuario INT PRIMARY KEY IDENTITY,
    descTipoUsuario VARCHAR(45)
);
GO

-- Insert into TipoUsuario
INSERT INTO TipoUsuario (descTipoUsuario)
VALUES ('Empresa'), ('Lanhouse');
GO

-- Create table Usuario
CREATE TABLE Usuario (
    idUsuario INT PRIMARY KEY IDENTITY,
    nome VARCHAR(45),
    email VARCHAR(45),
    senha VARCHAR(20),
    statusUsuario TINYINT DEFAULT 1,
    fkEmpresa INT,
    fkLanhouse INT,
    fkTipoUsuario INT,
    CONSTRAINT fkUsuarioLanhouse FOREIGN KEY (fkLanhouse) REFERENCES Lanhouse(idLanHouse),
    CONSTRAINT fkEmpresaUsuario FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa),
    CONSTRAINT fkTipoUsuarioUsuario FOREIGN KEY (fkTipoUsuario) REFERENCES TipoUsuario(idTipoUsuario)
);
GO

-- Create table Maquina
CREATE TABLE Maquina (
    idMaquina INT PRIMARY KEY IDENTITY,
    nomeMaquina VARCHAR(45),
    fkLanhouse INT,
    CONSTRAINT fkMaquinaLanhouse FOREIGN KEY (fkLanhouse) REFERENCES LanHouse(idLanHouse)
);
GO

-- Create table TipoComponente
CREATE TABLE TipoComponente (
    idTipoComponente INT PRIMARY KEY IDENTITY,
    tipoComponente VARCHAR(45)
);
GO

-- Insert into TipoComponente
INSERT INTO TipoComponente (tipoComponente)
VALUES ('RAM'), ('Processador'), ('Disco'), ('Rede'), ('GPU');
GO

-- Create table MetricaComponente
CREATE TABLE MetricaComponente (
    idMetricaComponente INT PRIMARY KEY IDENTITY,
    minMetrica INT,
    maxMetrica INT,
    unidadeMedida VARCHAR(7)
);
GO

-- Create table Componente
CREATE TABLE Componente (
    idComponente INT PRIMARY KEY IDENTITY,
    valorTotal FLOAT,
    fkMaquina INT,
    fkTipoComponente INT,
    fkMetricaComponente INT,
    CONSTRAINT fkComponenteMaquina FOREIGN KEY (fkMaquina) REFERENCES Maquina(idMaquina),
    CONSTRAINT fkComponenteTipoComponente FOREIGN KEY (fkTipoComponente) REFERENCES TipoComponente(idTipoComponente),
    CONSTRAINT fkComponenteMetricaComponente FOREIGN KEY (fkMetricaComponente) REFERENCES MetricaComponente(idMetricaComponente)
);
GO

-- Create table EspecificacaoComponente
CREATE TABLE EspecificacaoComponente (
    idEspecificacaoComponente INT PRIMARY KEY IDENTITY,
    especificacao VARCHAR(100),
    valorEspecificacao VARCHAR(100),
    fkComponente INT,
    CONSTRAINT fkEspecificacaoComponenteComp FOREIGN KEY (fkComponente) REFERENCES Componente(idComponente)
);
GO

-- Create table Log
CREATE TABLE Log (
    idLog INT PRIMARY KEY IDENTITY,
    textLog VARCHAR(45),
    valor FLOAT,
    dataLog DATETIME,
    statusLog TINYINT,
    fkComponente INT,
    CONSTRAINT fkLogComponente FOREIGN KEY (fkComponente) REFERENCES Componente(idComponente)
);
GO

-- Describe table Empresa
EXEC sp_help 'Empresa';
GO

-- Insert into Endereco
INSERT INTO Endereco (cidade)
VALUES ('São Paulo');
GO

-- Insert into Empresa
INSERT INTO Empresa (nomeFantasia, razaoSocial, fkEndereco)
VALUES ('Empresa', 'Empresa', 1);
GO

-- Insert into LanHouse
INSERT INTO LanHouse (unidade, cnpj, codigoAcesso, fkEndereco, fkEmpresa)
VALUES ('LanHousers', '49150759000140', 'LanHousers0152', 1, 1);
GO

-- Insert into Usuario
INSERT INTO Usuario (nome, senha, fkEmpresa, fkLanhouse)
VALUES ('Usuario', 'Usuario0@', 1, 1);
GO

-- Select query
SELECT m.nomeMaquina, m.idMaquina, COUNT(c.idComponente) AS 'componentessobrecarrecados'
FROM Log l
JOIN Componente c ON l.fkComponente = c.idComponente
JOIN Maquina m ON c.fkMaquina = m.idMaquina
WHERE dataLog = (SELECT TOP 1 dataLog FROM Log ORDER BY dataLog DESC)
    AND fkLanhouse = 1
    AND l.statusLog != 1
GROUP BY nomeMaquina, idMaquina
ORDER BY componentessobrecarrecados DESC;
GO

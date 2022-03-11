﻿-- Criação da base de dados

USE master
GO

CREATE DATABASE TheaterWebsite
GO

-- Criação das tabelas

USE TheaterWebsite
GO

-- ####### ENTIDADES #######

CREATE TABLE Utilizador
(
	Id INTEGER IDENTITY (1,1),
	Nome VARCHAR(100) NOT NULL,
	Email VARCHAR(320) NOT NULL UNIQUE,
	Username VARCHAR(20) NOT NULL UNIQUE,
	Password VARCHAR(16) NOT NULL,
	PRIMARY KEY (Id),
);

CREATE TABLE Cliente
(
	Id INTEGER,
	NIF CHAR(9),
	Data_Nasc DATE NOT NULL,
	Estado BIT NOT NULL DEFAULT 0,
	PRIMARY KEY (Id),
	FOREIGN KEY (Id) REFERENCES Utilizador(Id)
);

CREATE TABLE Admin
(
	Id INTEGER,
	Id_Crt INTEGER NOT NULL,
	PRIMARY KEY (Id),
	FOREIGN KEY (Id) REFERENCES Utilizador(Id),
	FOREIGN KEY (Id_Crt) REFERENCES Admin(Id)
);

CREATE TABLE Funcionario
(
	Id INTEGER,
	Telefone CHAR(9) NOT NULL,
	Id_Admin INTEGER NOT NULL,
	PRIMARY KEY (Id),
	FOREIGN KEY (Id) REFERENCES Utilizador(Id),
	FOREIGN KEY (Id_Admin) REFERENCES Admin(Id)
);

CREATE TABLE Categoria
(
	Id INTEGER NOT NULL IDENTITY(1,1),
	Nome VARCHAR(50) NOT NULL UNIQUE,
	Estado BIT NOT NULL DEFAULT 1,
	PRIMARY KEY (Id)
);

CREATE TABLE Filme
(
	Id INTEGER IDENTITY(1,1),
	Titulo VARCHAR(50) NOT NULL,
	Poster VARCHAR(50) NOT NULL,
	Sinopse VARCHAR(500) NOT NULL,
	Realizador VARCHAR(50) NOT NULL,
	Elenco VARCHAR(100) NOT NULL,
	Duracao INTEGER NOT NULL, -- Em minutos
	Trailer VARCHAR(50),  -- Id do vídeo do YT
	Id_Cat INTEGER NOT NULL,
	Id_Func INTEGER NOT NULL,
	PRIMARY KEY (Id),
	FOREIGN KEY (Id_Cat) REFERENCES Categoria(Id),
	FOREIGN KEY (Id_Func) REFERENCES Funcionario(Id)
);

CREATE TABLE Sessao
(
	Id INTEGER IDENTITY(1,1),
	Horas TIME NOT NULL,
	Estado BIT NOT NULL DEFAULT 1,
	PRIMARY KEY (Id)
);

CREATE TABLE Sala
(
	Id INTEGER IDENTITY(1,1),
	Nome VARCHAR(50) NOT NULL,
	Lotacao INTEGER NOT NULL,
	Estado BIT NOT NULL DEFAULT 1,
	PRIMARY KEY (Id)
);

-- ENTIdADES ASSOCIATIVAS

CREATE TABLE Bilhete
(
	Id INTEGER IDENTITY(1,1),
	Id_Filme INTEGER NOT NULL,
	Id_Sessao INTEGER NOT NULL,
	Id_Sala INTEGER NOT NULL,
	Preco MONEY NOT NULL,
	Data_Ini DATE NOT NULL,
	Data_Fim DATE NOT NULL,
	PRIMARY KEY (Id),
	FOREIGN KEY (Id_Filme) REFERENCES Filme(Id),
	FOREIGN KEY (Id_Sessao) REFERENCES Sessao(Id),
	FOREIGN KEY (Id_Sala) REFERENCES Sala(Id)
);

-- ####### RELACIONAMENTOS #######

-- Cliente <> Bilhete

CREATE TABLE Comprar
(
	Id_Cliente INTEGER NOT NULL,
	Id_Bil INTEGER NOT NULL,
	Data_Compra DATETIME,
	Data_Sessao DATE NOT NULL,
	Num_Bil INTEGER NOT NULL,
	PRIMARY KEY (Id_Cliente, Id_Bil, Data_Compra),
	FOREIGN KEY (Id_Cliente) REFERENCES Cliente(Id),
	FOREIGN KEY (Id_Bil) REFERENCES Bilhete(Id)
);

CREATE TABLE Cli_Cat
(
	Id_Cliente INTEGER,
	Id_Cat INTEGER,
	PRIMARY KEY (Id_Cliente, Id_Cat),
	FOREIGN KEY (Id_Cliente) REFERENCES Cliente(Id),
	FOREIGN KEY (Id_Cat) REFERENCES Categoria(Id) 
);

GO
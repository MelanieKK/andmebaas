CREATE DATABASE kyberspot_db;
USE kyberspot_db;

CREATE TABLE Mang (
    MangID INT PRIMARY KEY IDENTITY(1,1),
    MangNimi VARCHAR(100) NOT NULL
);

CREATE TABLE KyberSport (
    KyberSportID INT PRIMARY KEY IDENTITY(1,1),
    KyberRyhmaNimi VARCHAR(100) NOT NULL,
    OsalejateArv INT,
    MangID INT,
    FOREIGN KEY (MangID) REFERENCES Mang(MangID)
);

CREATE TABLE KyberOsaleja (
    OsalejaID INT PRIMARY KEY IDENTITY(1,1),
    OsalejaaNimi VARCHAR(100) NOT NULL,
    Vanus INT,
    KyberSportID INT,
    FOREIGN KEY (KyberSportID) REFERENCES KyberSport(KyberSportID)
);

CREATE TABLE logi (
    id INT PRIMARY KEY IDENTITY(1,1),
    kasutaja VARCHAR(100),
    kuupaev DATE,
    sisestatudAndmed TEXT
);

SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE';

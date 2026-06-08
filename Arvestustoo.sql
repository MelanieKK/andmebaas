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

USE kyberspot_db;

INSERT INTO Mang (MangNimi) VALUES ('Minecraft');
INSERT INTO Mang (MangNimi) VALUES ('Fortnite');
INSERT INTO Mang (MangNimi) VALUES ('Valorant');

INSERT INTO KyberSport (KyberRyhmaNimi, OsalejateArv, MangID) VALUES
('TiimA', 5, 1),
('TiimB', 8, 2),
('TiimC', 3, 3),
('TiimD', 6, 1);

INSERT INTO KyberOsaleja (OsalejaaNimi, Vanus, KyberSportID) VALUES
('Mati', 16, 1),
('Kati', 20, 2),
('Juku', 15, 3),
('Mari', 22, 4),
('Peeter', 17, 1);

SELECT * FROM Mang;
SELECT * FROM KyberSport;
SELECT * FROM KyberOsaleja;

USE kyberspot_db;

CREATE LOGIN osalejanimi WITH PASSWORD = 'Kyber@Sport123!';
CREATE USER osalejanimi FOR LOGIN osalejanimi;

GRANT SELECT, INSERT, DELETE ON KyberSport TO osalejanimi;
GRANT SELECT, INSERT, DELETE ON KyberOsaleja TO osalejanimi;
GRANT SELECT ON Mang TO osalejanimi;

SELECT dp.name, o.name AS tabel, dp2.permission_name, dp2.state_desc
FROM sys.database_permissions dp2
JOIN sys.database_principals dp ON dp2.grantee_principal_id = dp.principal_id
JOIN sys.objects o ON dp2.major_id = o.object_id
WHERE dp.name = 'osalejanimi';

USE kyberspot_db;

CREATE TRIGGER kyber_lisa_logi
ON KyberSport
AFTER INSERT
AS
BEGIN
    INSERT INTO logi (kasutaja, kuupaev, sisestatudAndmed)
    SELECT 
        SYSTEM_USER,
        CAST(GETDATE() AS DATE),
        CONCAT('LISATUD KyberSport: ID=', CAST(i.KyberSportID AS VARCHAR),
               ', Ryhm=', i.KyberRyhmaNimi,
               ', MangID=', CAST(i.MangID AS VARCHAR),
               ', Aeg=', CAST(GETDATE() AS VARCHAR))
    FROM inserted i;
END;
GO

CREATE TRIGGER kyber_kustuta_logi
ON KyberSport
AFTER DELETE
AS
BEGIN
    INSERT INTO logi (kasutaja, kuupaev, sisestatudAndmed)
    SELECT 
        SYSTEM_USER,
        CAST(GETDATE() AS DATE),
        CONCAT('KUSTUTATUD KyberSport: ID=', CAST(d.KyberSportID AS VARCHAR),
               ', Ryhm=', d.KyberRyhmaNimi,
               ', MangID=', CAST(d.MangID AS VARCHAR),
               ', Aeg=', CAST(GETDATE() AS VARCHAR))
    FROM deleted d;
END;
GO

SELECT name, type_desc FROM sys.triggers;

USE kyberspot_db;

INSERT INTO KyberSport (KyberRyhmaNimi, OsalejateArv, MangID)
VALUES ('TestTiim', 4, 1);

DELETE FROM KyberSport WHERE KyberRyhmaNimi = 'TestTiim';

SELECT * FROM logi;


USE kyberspot_db;

-- Võta CREATE õigus ära
DENY CREATE TABLE TO osalejanimi;
DENY ALTER ON SCHEMA::dbo TO osalejanimi;

-- Testi uuesti
EXECUTE AS USER = 'osalejanimi';
CREATE TABLE TestTabel2 (id INT);
REVERT;

USE kyberspot_db;

DROP TRIGGER kyber_lisa_logi;
DROP TRIGGER kyber_kustuta_logi;
GO

CREATE TRIGGER kyber_lisa_logi
ON KyberSport
AFTER INSERT
AS
BEGIN
    INSERT INTO logi (kasutaja, kuupaev, sisestatudAndmed)
    SELECT 
        SYSTEM_USER,
        CAST(GETDATE() AS DATE),
        CONCAT('LISATUD KyberSport: ID=', CAST(i.KyberSportID AS VARCHAR),
               ', Ryhm=', i.KyberRyhmaNimi,
               ', MangID=', CAST(i.MangID AS VARCHAR),
               ', Aeg=', CAST(GETDATE() AS VARCHAR))
    FROM inserted i;
END;
GO

CREATE TRIGGER kyber_kustuta_logi
ON KyberSport
AFTER DELETE
AS
BEGIN
    INSERT INTO logi (kasutaja, kuupaev, sisestatudAndmed)
    SELECT 
        SYSTEM_USER,
        CAST(GETDATE() AS DATE),
        CONCAT('KUSTUTATUD KyberSport: ID=', CAST(d.KyberSportID AS VARCHAR),
               ', Ryhm=', d.KyberRyhmaNimi,
               ', MangID=', CAST(d.MangID AS VARCHAR),
               ', Aeg=', CAST(GETDATE() AS VARCHAR))
    FROM deleted d;
END;
GO

SELECT name, type_desc FROM sys.triggers;

USE kyberspot_db;

INSERT INTO KyberSport (KyberRyhmaNimi, OsalejateArv, MangID)
VALUES ('TestTiim', 4, 1);

DELETE FROM KyberSport WHERE KyberRyhmaNimi = 'TestTiim';

SELECT * FROM logi;

USE kyberspot_db;
GO

CREATE PROCEDURE lisa_mang
    @p_nimi VARCHAR(100)
AS
BEGIN
    INSERT INTO Mang (MangNimi) VALUES (@p_nimi);
END;
GO

CREATE PROCEDURE lisa_kyber
    @p_ryhm VARCHAR(100),
    @p_arv INT,
    @p_mangID INT
AS
BEGIN
    INSERT INTO KyberSport (KyberRyhmaNimi, OsalejateArv, MangID)
    VALUES (@p_ryhm, @p_arv, @p_mangID);
END;
GO

CREATE PROCEDURE otsi_vanus
    @p_vanus INT
AS
BEGIN
    SELECT o.OsalejaID, o.OsalejaaNimi, o.Vanus, k.KyberRyhmaNimi
    FROM KyberOsaleja o
    JOIN KyberSport k ON o.KyberSportID = k.KyberSportID
    WHERE o.Vanus <= @p_vanus;
END;
GO

EXEC lisa_mang 'League of Legends';
EXEC lisa_kyber 'TiimE', 7, 1;
EXEC otsi_vanus 18;

USE kyberspot_db;
GO

CREATE VIEW vaade_osaleja_meeskond AS
SELECT o.OsalejaaNimi, o.Vanus, k.KyberRyhmaNimi
FROM KyberOsaleja o
JOIN KyberSport k ON o.KyberSportID = k.KyberSportID;
GO

CREATE VIEW vaade_alaealised AS
SELECT o.OsalejaaNimi, o.Vanus, k.KyberRyhmaNimi
FROM KyberOsaleja o
JOIN KyberSport k ON o.KyberSportID = k.KyberSportID
WHERE o.Vanus < 18;
GO

CREATE VIEW vaade_suured_meeskonnad AS
SELECT k.KyberRyhmaNimi, k.OsalejateArv, m.MangNimi
FROM KyberSport k
JOIN Mang m ON k.MangID = m.MangID
WHERE k.OsalejateArv > 5;
GO

SELECT * FROM vaade_osaleja_meeskond;
SELECT * FROM vaade_alaealised;
SELECT * FROM vaade_suured_meeskonnad;

USE kyberspot_db;

CREATE TABLE KyberTulemus (
    TulemusID INT PRIMARY KEY IDENTITY(1,1),
    KyberSportID INT,
    Voite INT DEFAULT 0,
    Kaotus INT DEFAULT 0,
    FOREIGN KEY (KyberSportID) REFERENCES KyberSport(KyberSportID)
);

INSERT INTO KyberTulemus (KyberSportID, Voite, Kaotus) VALUES
(1, 10, 3),
(2, 7, 5),
(3, 4, 8),
(4, 9, 2);
GO

CREATE VIEW edetabel AS
SELECT k.KyberRyhmaNimi, m.MangNimi,
       t.Voite, t.Kaotus,
       (t.Voite - t.Kaotus) AS Punktid
FROM KyberTulemus t
JOIN KyberSport k ON t.KyberSportID = k.KyberSportID
JOIN Mang m ON k.MangID = m.MangID;
GO

SELECT * FROM edetabel ORDER BY Punktid DESC;

USE kyberspot_db;

DROP TRIGGER kyber_lisa_logi;
DROP TRIGGER kyber_kustuta_logi;
GO

CREATE TRIGGER kyber_lisa_logi
ON KyberSport
AFTER INSERT
AS
BEGIN
    INSERT INTO logi (kasutaja, kuupaev, sisestatudAndmed)
    SELECT 
        SYSTEM_USER,
        CAST(GETDATE() AS DATE),
        CONCAT(
            'LISATUD KyberSport: ID=', CAST(i.KyberSportID AS VARCHAR),
            ', Ryhm=', i.KyberRyhmaNimi,
            ', OsalejateArv=', CAST(i.OsalejateArv AS VARCHAR),
            ', MangID=', CAST(i.MangID AS VARCHAR),
            ', MangNimi=', ISNULL(m.MangNimi, 'N/A'),
            ', Aeg=', CAST(GETDATE() AS VARCHAR)
        )
    FROM inserted i
    LEFT JOIN Mang m ON i.MangID = m.MangID;
END;
GO

CREATE TRIGGER kyber_kustuta_logi
ON KyberSport
AFTER DELETE
AS
BEGIN
    INSERT INTO logi (kasutaja, kuupaev, sisestatudAndmed)
    SELECT 
        SYSTEM_USER,
        CAST(GETDATE() AS DATE),
        CONCAT(
            'KUSTUTATUD KyberSport: ID=', CAST(d.KyberSportID AS VARCHAR),
            ', Ryhm=', d.KyberRyhmaNimi,
            ', OsalejateArv=', CAST(d.OsalejateArv AS VARCHAR),
            ', MangID=', CAST(d.MangID AS VARCHAR),
            ', MangNimi=', ISNULL(m.MangNimi, 'N/A'),
            ', Aeg=', CAST(GETDATE() AS VARCHAR)
        )
    FROM deleted d
    LEFT JOIN Mang m ON d.MangID = m.MangID;
END;
GO

SELECT name, type_desc FROM sys.triggers;
GO

EXECUTE AS USER = 'osalejanimi';

INSERT INTO KyberSport (KyberRyhmaNimi, OsalejateArv, MangID)
VALUES ('OsalejaTiim', 3, 2);

DELETE FROM KyberSport WHERE KyberRyhmaNimi = 'OsalejaTiim';

REVERT;

SELECT * FROM logi;

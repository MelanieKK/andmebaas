CREATE DATABASE kyberspot_db;
USE kyberspot_db;

-- ÜLESANNE 1+2: Tabelite loomine ja seostamine

-- Mäng tabel: hoiab mängude nimesid
CREATE TABLE Mang (
    MangID INT PRIMARY KEY IDENTITY(1,1),
    MangNimi VARCHAR(100) NOT NULL
);

-- KyberSport tabel: hoiab meeskondade infot
CREATE TABLE KyberSport (
    KyberSportID INT PRIMARY KEY IDENTITY(1,1),
    KyberRyhmaNimi VARCHAR(100) NOT NULL,
    OsalejateArv INT,
    MangID INT,
    FOREIGN KEY (MangID) REFERENCES Mang(MangID)
);

-- KyberOsaleja tabel: hoiab osalejaate infot
CREATE TABLE KyberOsaleja (
    OsalejaID INT PRIMARY KEY IDENTITY(1,1),
    OsalejaaNimi VARCHAR(100) NOT NULL,
    Vanus INT,
    KyberSportID INT,
    FOREIGN KEY (KyberSportID) REFERENCES KyberSport(KyberSportID)
);

-- ÜLESANNE 4: Logi tabel

-- logi tabel: salvestab kõik muudatused automaatselt
CREATE TABLE logi (
    id INT PRIMARY KEY IDENTITY(1,1),  -- automaatne primaarvõti
    kasutaja VARCHAR(100),  -- kes tegi muudatuse
    kuupaev DATE,  --millal tehti
    sisestatudAndmed TEXT --mis täpselt tehti
);

-- Kontrollin et kõik 4 tabelit on loodud. 5kybertulemus on 12ül 
SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE';

-- ÜLESANNE 1: Testandmed tabelitesse
USE kyberspot_db;

-- Lisa 3 mängu Mang tabelisse
INSERT INTO Mang (MangNimi) VALUES ('Minecraft');
INSERT INTO Mang (MangNimi) VALUES ('Fortnite');
INSERT INTO Mang (MangNimi) VALUES ('Valorant');

-- Lisan 4 meeskonda KyberSport tabelisse
INSERT INTO KyberSport (KyberRyhmaNimi, OsalejateArv, MangID) VALUES
('TiimA', 5, 1),
('TiimB', 8, 2),
('TiimC', 3, 3),
('TiimD', 6, 1);

-- Lisa 5 osalejaad KyberOsaleja tabelisse
INSERT INTO KyberOsaleja (OsalejaaNimi, Vanus, KyberSportID) VALUES
('Mati', 16, 1),
('Kati', 20, 2),
('Juku', 15, 3),
('Mari', 22, 4),
('Peeter', 17, 1);

-- Kuva kõik andmed
SELECT * FROM Mang;
SELECT * FROM KyberSport;
SELECT * FROM KyberOsaleja;

-- ÜLESANNE 3: Kasutaja loomine ja õiguste määramine
USE kyberspot_db;

-- Loosin serveri kasutaja
CREATE LOGIN osalejanimi WITH PASSWORD = 'Kyber@Sport123!';
-- Sidusin kasutaja andmebaasiga
CREATE USER osalejanimi FOR LOGIN osalejanimi;

-- Annan õigused: KyberSport ja KyberOsaleja - vaatamine, lisamine, kustutamine
GRANT SELECT, INSERT, DELETE ON KyberSport TO osalejanimi;
GRANT SELECT, INSERT, DELETE ON KyberOsaleja TO osalejanimi;
-- Mang tabelis ainult vaatamisõigus
GRANT SELECT ON Mang TO osalejanimi;

-- Kontrolli määratud õigused
SELECT dp.name, o.name AS tabel, dp2.permission_name, dp2.state_desc
FROM sys.database_permissions dp2
JOIN sys.database_principals dp ON dp2.grantee_principal_id = dp.principal_id
JOIN sys.objects o ON dp2.major_id = o.object_id
WHERE dp.name = 'osalejanimi';

-- ÜLESANNE 5+6: Triggerid kustutamisele ja lisamisele
USE kyberspot_db;

-- Trigger ülesanne 6: jälgib lisamist KyberSport tabelis
CREATE TRIGGER kyber_lisa_logi
ON KyberSport
AFTER INSERT -- käivitub automaatselt pärast iga lisamist
AS
BEGIN
    INSERT INTO logi (kasutaja, kuupaev, sisestatudAndmed)
    SELECT 
        SYSTEM_USER, -- salvestab kes lisas
        CAST(GETDATE() AS DATE), -- salvestab kuupäeva
        CONCAT('LISATUD KyberSport: ID=', CAST(i.KyberSportID AS VARCHAR),
               ', Ryhm=', i.KyberRyhmaNimi,
               ', MangID=', CAST(i.MangID AS VARCHAR), -- MangNimi Mang tabelist (ül 7)
               ', Aeg=', CAST(GETDATE() AS VARCHAR)) -- salvestab kellaaja
    FROM inserted i; -- inserted- just lisatud read
END;
GO

-- Trigger ülesanne 5: jälgib kustutamist KyberSport tabelis
CREATE TRIGGER kyber_kustuta_logi
ON KyberSport
AFTER DELETE -- käivitub automaatselt pärast iga kustutamist
AS
BEGIN
    INSERT INTO logi (kasutaja, kuupaev, sisestatudAndmed)
    SELECT 
        SYSTEM_USER, -- salvestab kes kustutas
        CAST(GETDATE() AS DATE), -- salvestab kuupäeva
        CONCAT('KUSTUTATUD KyberSport: ID=', CAST(d.KyberSportID AS VARCHAR),
               ', Ryhm=', d.KyberRyhmaNimi,
               ', MangID=', CAST(d.MangID AS VARCHAR), -- MangNimi Mang tabelist (ül 7)
               ', Aeg=', CAST(GETDATE() AS VARCHAR)) -- salvestab kellaaja
    FROM deleted d; -- deleted - just kustutatud read
END;
GO
-- Kontrolli et mõlemad triggerid on olemas
SELECT name, type_desc FROM sys.triggers;

-- ÜLESANNE 8: Trigerite kontroll osalejanimi kaudu
USE kyberspot_db;

-- osalejanimi lisab meeskonna - trigger käivitub automaatselt
INSERT INTO KyberSport (KyberRyhmaNimi, OsalejateArv, MangID)
VALUES ('TestTiim', 4, 1);

DELETE FROM KyberSport WHERE KyberRyhmaNimi = 'TestTiim';

SELECT * FROM logi;

-- ÜLESANNE 9: Kontrolli et kasutaja ei saa muuta ega luua
USE kyberspot_db;

-- Võta CREATE ja ALTER õigused ära
DENY CREATE TABLE TO osalejanimi;
DENY ALTER ON SCHEMA::dbo TO osalejanimi;

-- Testi - peaks andma ACCESS DENIED vea
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

-- ÜLESANNE 10: 3 protseduuri parameetritega
USE kyberspot_db;
GO

-- Protseduur 1: lisab uue mängu Mang tabelisse
CREATE PROCEDURE lisa_mang
    @p_nimi VARCHAR(100) -- parameeter: mängu nimi
AS
BEGIN
    INSERT INTO Mang (MangNimi) VALUES (@p_nimi);
END;
GO

-- Protseduur 2: lisab uue meeskonna KyberSport tabelisse
CREATE PROCEDURE lisa_kyber
    @p_ryhm VARCHAR(100), -- parameeter: meeskonna nimi
    @p_arv INT, -- parameeter: liikmete arv
    @p_mangID INT -- parameeter: mängu ID
AS
BEGIN
    INSERT INTO KyberSport (KyberRyhmaNimi, OsalejateArv, MangID)
    VALUES (@p_ryhm, @p_arv, @p_mangID);
END;
GO

-- Protseduur 3: otsib osalejaad vanuse järgi
CREATE PROCEDURE otsi_vanus
    @p_vanus INT -- parameeter: maksimaalne vanus
AS
BEGIN
 -- tagastab kõik osalejaad kes on sellest vanusest nooremad või sama vanad
    SELECT o.OsalejaID, o.OsalejaaNimi, o.Vanus, k.KyberRyhmaNimi
    FROM KyberOsaleja o
    JOIN KyberSport k ON o.KyberSportID = k.KyberSportID
    WHERE o.Vanus <= @p_vanus;
END;
GO

-- Testi kõik 3 protseduuri 
USE kyberspot_db;
REVERT;
GO

EXEC lisa_mang 'League of Legends';
EXEC lisa_kyber 'TiimE', 7, 1;
EXEC otsi_vanus 18;


-- ÜLESANNE 11: 3 vaadet kahest tabelist
-- Vaade 1: kõik osalejaad koos meeskonnanimega
CREATE VIEW vaade_osaleja_meeskond AS
SELECT o.OsalejaaNimi, o.Vanus, k.KyberRyhmaNimi
FROM KyberOsaleja o
JOIN KyberSport k ON o.KyberSportID = k.KyberSportID;
GO

-- Vaade 2: ainult alaealised osalejaad (alla 18)
CREATE VIEW vaade_alaealised AS
SELECT o.OsalejaaNimi, o.Vanus, k.KyberRyhmaNimi
FROM KyberOsaleja o
JOIN KyberSport k ON o.KyberSportID = k.KyberSportID
WHERE o.Vanus < 18;
GO

-- Vaade 3: suured meeskonnad (üle 5 liikme) koos mängu nimega
CREATE VIEW vaade_suured_meeskonnad AS
SELECT k.KyberRyhmaNimi, k.OsalejateArv, m.MangNimi
FROM KyberSport k
JOIN Mang m ON k.MangID = m.MangID
WHERE k.OsalejateArv > 5;
GO

-- Kuva kõik 3 vaadet
SELECT * FROM vaade_osaleja_meeskond;
SELECT * FROM vaade_alaealised;
SELECT * FROM vaade_suured_meeskonnad;

USE kyberspot_db;

-- ÜLESANNE 12: Oma lisategevus - edetabel
-- Uus tabel meeskondade tulemuste salvestamiseks
CREATE TABLE KyberTulemus (
    TulemusID INT PRIMARY KEY IDENTITY(1,1), -- automaatne primaarvõti
    KyberSportID INT,  -- viide KyberSport tabelile
    Voite INT DEFAULT 0, -- võitude arv, vaikimisi 0
    Kaotus INT DEFAULT 0, -- kaotuste arv, vaikimisi 0
    FOREIGN KEY (KyberSportID) REFERENCES KyberSport(KyberSportID) -- seos
);

-- Lisa 4 meeskonna tulemused
INSERT INTO KyberTulemus (KyberSportID, Voite, Kaotus) VALUES
(1, 10, 3),
(2, 7, 5),
(3, 4, 8),
(4, 9, 2);
GO

-- Edetabeli vaade: arvutab punktid ja sorteerib automaatselt
CREATE VIEW edetabel AS
SELECT k.KyberRyhmaNimi, m.MangNimi,
       t.Voite, t.Kaotus,
       (t.Voite - t.Kaotus) AS Punktid -- arvutab punktid: võidud miinus kaotused
FROM KyberTulemus t
JOIN KyberSport k ON t.KyberSportID = k.KyberSportID -- JOIN KyberSport tabeliga
JOIN Mang m ON k.MangID = m.MangID; --JOIN Mang tabeliga
GO

-- Kuva edetabel punktide järgi 
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

-- ÜLESANNE 8: Trigerite kontroll osalejanimi kaudu
-- Lülitu osalejanimi kasutajale
EXECUTE AS USER = 'osalejanimi';

-- osalejanimi lisab meeskonna - trigger käivitub automaatselt
INSERT INTO KyberSport (KyberRyhmaNimi, OsalejateArv, MangID)
VALUES ('OsalejaTiim', 3, 2);

-- osalejanimi kustutab meeskonna - trigger käivitub automaatselt
DELETE FROM KyberSport WHERE KyberRyhmaNimi = 'OsalejaTiim';

-- Lülitu tagasi admin kasutajale
REVERT;

-- Kuva logi - kasutaja veerus näha osalejanimi 
SELECT * FROM logi;

USE kyberspot_db;

DROP TABLE IF EXISTS TestTabel;
DROP TABLE IF EXISTS TestTabel2;

SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE';

USE kyberspot_db;
REVERT;
GO

EXEC lisa_mang 'League of Legends';
EXEC lisa_kyber 'TiimE', 7, 1;
EXEC otsi_vanus 18;

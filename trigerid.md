## Triger - trigger -päästik
### Triger - andmebaasi objekt, mis käivitud automaatselt, kui toimub teatud sündmus (nt INSERT, UPDATE, DELETE).
trigerite loomine - automatseerub protsessid SQL Serveris.

TAbelid, mis tuleb luua enne trigerit!
```SQL
Create Database trigerLogitpe24;

use trigerLogitpe24;
CREATE TABLE linnad(
linnId int primary key identity(1,1),
linnanimi varchar(30) unique,
maakond varchar(50),
rahvaarv int);
select * from linnad;
INSERT INTO linnad(linnanimi, maakond, rahvaarv)
VALUES ('Tallinn', 'Harjumaa', 600000);

--tabel logi - tabel, mis täidab triger!!! kui kasutaja täidab tabeli linnad!
CREATE TABLE logi(
id int primary key identity(1,1),
kasutaja varchar(50),
aeg DATETIME,
andmed TEXT);

```SQL
CREATE TRIGGER linnaLisamine
ON linnad -- tabel, mida triger jälgib
FOR INSERT
AS
INSERT INTO logi(kasutaja, aeg, andmed)
SELECT 
SYSTEM_USER, --siselogitud user
GETDATE(), 
CONCAT('lisatud:' ,inserted.linnanimi, ', ',
inserted.maakond,' ,',inserted.rahvaarv)
FROM inserted;

--kontrollimiseks tuleb lisada linna tabelise linnad 
INSERT INTO linnad(linnanimi, maakond, rahvaarv)
VALUES ('Viljandi', 'Viljandimaa', 50000);

SELECT * FROM linnad;
SELECT * FROM logi;
```
<img width="626" height="400" alt="{E38AEE1C-73CF-4AAE-A28D-C373E291A343}" src="https://github.com/user-attachments/assets/a33cc0cb-49fd-4231-bb95-d6b6d6ec361a" />

```SQL
--2. DELETE triger - jälgib kust kasutamine tabelis linnad ja teeb vastava kirje logi tabelisse
--ja teeb vastava kirje logi tabelisse
CREATE TRIGGER linnaKustutamine
ON linnad -- tabel, mida triger jälgib
FOR DELETE
AS
INSERT INTO logi(kasutaja, aeg, andmed)
SELECT 
SYSTEM_USER, --siselogitud user
GETDATE(), 
CONCAT('kustutatud:' ,deleted.linnanimi, ', ',
deleted.maakond,' ,',deleted.rahvaarv)
FROM deleted;
```
<img width="685" height="500" alt="{B5118D7D-F991-4FA8-BDF4-B91E6B3EFDF2}" src="https://github.com/user-attachments/assets/a1a2cf78-5f16-4266-9f9b-f0e6630d9bcb" />

```SQL
--3.UPDATE TRIGGER -jälgib uuendused/muutused tabelis linnad
--ja teeb vastava kirje tabelise logi

CREATE TRIGGER linnaUuendamine
ON linnad -- tabel, mida triger jälgib
FOR UPDATE
AS
INSERT INTO logi(kasutaja, aeg, andmed)
SELECT 
SYSTEM_USER, --siselogitud user
GETDATE(), 
CONCAT('vana andmed :' ,
deleted.linnanimi, ', ', deleted.maakond,' ,',deleted.rahvaarv,
' ||| uued andmed: ',
inserted.linnanimi, ', ', inserted.maakond,' ,',inserted.rahvaarv)
FROM deleted INNER JOIN inserted
ON deleted.linnId=inserted.linnId;

--kontroll
UPDATE linnad SET linnanimi='Tallinn22', rahvaarv=700000
WHERE linnId=1;

SELECT * FROM linnad;
SELECT * FROM logi;

--trigeri sisse/välja lülitamine 
DISABLE TRIGGER linnaLisamine ON linnad;
DISABLE TRIGGER linnaKustutamine ON linnad;
ENABLE TRIGGER linnaUuendamine ON linnad;

--Ühine triger, mis jälgib kas lisamine või kustutamine tabelisse linnad
CREATE TRIGGER linnaLisamineKustutamine
ON linnad -- tabel, mida triger jälgib
FOR INSERT, DELETE
AS
BEGIN
SET NOCOUNT ON;
	INSERT INTO logi(kasutaja, aeg, andmed)
	SELECT 
	SYSTEM_USER, --siselogitud user
	GETDATE(), 
	CONCAT('lisatud:' ,inserted.linnanimi, ', ',
	inserted.maakond,' ,',inserted.rahvaarv)
	FROM inserted

	UNION ALL

	SELECT 
	SYSTEM_USER, --siselogitud user
	GETDATE(), 
	CONCAT('kustutatud:' ,deleted.linnanimi, ', ',
	deleted.maakond,' ,',deleted.rahvaarv)
	FROM deleted;
END;

--kontroll 
DELETE FROM linnad WHERE linnId=3;

INSERT INTO linnad(linnanimi, maakond, rahvaarv)
VALUES ('Viljandi', 'Viljandimaa', 50000);

SELECT * FROM linnad;
SELECT * FROM logi;
``` SQL
<img width="643" height="430" alt="{E3C525F4-150E-4BC3-8A24-62451ED5B4B4}" src="https://github.com/user-attachments/assets/534b4544-22ff-4b19-94e9-598a9500ccf5" />


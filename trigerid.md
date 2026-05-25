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

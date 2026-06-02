## Triger - trigger - päästik

[Select laused](select.md) | [Kasutaja loomine SQL serveris](kasutajad.md) | [Protseduurid](Protseduurid.md) | [Küsimused](kysimused.md) | [Triggerid](trigerid.md) | [Vaade](vaade.md) | [Kodutöö](Kodutöö.md) |

### Triger - andmebaasi objekt, mis käivitub automaatselt, kui toimub steatud sündmus (nt INSERT, UPDATE , DELETE).
Trigerite loomine - automatseerub protsessid SQL Serveris

Tabelid mis tuleb luua enne trigerit!
```sql
create database trigerLogitpe24

use trigerLogitpe24
Create table linnad(
linnId int primary key identity (1, 1),
linnanimi varchar(30) unique,
maakond varchar(50),
rahvarv int)
select * from linnad

insert into linnad(linnanimi, maakond, rahvarv)
Values('Tallinn', 'Harjumaa', 600000);

--tabeli logi - tabel, mis täidab triger, kui kasutaja täidab tabeli linnad!
Create table logi(
id int primary key identity(1, 1),
kasutaja varchar(50),
aeg datetime,
andmed TEXT)
```

```sql
--1. Triger lisatud andmete jälgimiseks tabelis linnad,
--jälgib andmete sisestamine tabelisse ja teeb vastava kirje logi-tabelise

Create trigger linnaLisamine
On linnad -- tabel, mis triger jälgib
for insert
as
insert into logi(kasutaja, aeg, andmed)
select
SYSTEM_USER, --siselogitud user
GETDATE(), 
concat('lisatud: ', inserted.linnanimi, ', ', inserted.maakond, ', ', inserted.rahvarv)
from inserted;

--kontrollimiseks tuleb lisada linna tabelisse linnad
insert into linnad(linnanimi, maakond, rahvarv)
Values('Viljandi', 'Viljandimaa', 50000);

select * from linnad
select * from logi
```
<img width="466" height="351" alt="{479946D2-22E1-4C02-BFD6-A2C71189E47D}" src="https://github.com/user-attachments/assets/0c292472-48d9-4b28-bbe9-1260088ed9da" />

```sql
--2. Delete triger - jälgib kustutamibe tabelis linnad 
--ja teeb vastava kirje logi tabelisse

Create trigger linnaKustutamine
On linnad -- tabel, mis triger jälgib
for delete
as
insert into logi(kasutaja, aeg, andmed)
select
SYSTEM_USER, --siselogitud user
GETDATE(), 
concat('kustutatud: ', deleted.linnanimi, ', ', deleted.maakond, ', ', deleted.rahvarv)
from deleted;

--kontroll
Delete from linnad where linnId=2
```
<img width="477" height="286" alt="{CD9DE4F1-CDB2-4C94-B551-F10901322B07}" src="https://github.com/user-attachments/assets/0221a66e-209a-4270-96f1-b24c75585b2f" />

```sql
--3.Update Trigger - jälgib uuendused/muutused tabelis linnad
--ja teeb vastava kirje tabelis logi

Create trigger linnaUuendamine
On linnad -- tabel, mis triger jälgib
for update
as
insert into logi(kasutaja, aeg, andmed)
select
SYSTEM_USER, --siselogitud user
GETDATE(), 
concat('vana andmed : ',
deleted.linnanimi, ', ', deleted.maakond, ', ', deleted.rahvarv,
' ||| uued andmed: ',
inserted.linnanimi, ', ', inserted.maakond, ', ', inserted.rahvarv)
from deleted INNER JOIN inserted
on deleted.linnId=inserted.linnId;

--kontroll
Update linnad set linnanimi='Tallinn22', rahvarv=700000
where linnId=1
```
<img width="563" height="354" alt="{6CC68111-EBFD-430E-8429-BFF9FC73C545}" src="https://github.com/user-attachments/assets/7a2782bf-d184-4195-9023-1e9a83f8f1b5" />

```sql
--triger sisse/välja lülitamine
Disable Trigger linnaLisamine on linnad
Disable Trigger linnaKustutamine on linnad
Enable trigger linnaUuendamine ON linnad
Enable trigger linnaKustutamine on linnad
```
<img width="244" height="67" alt="{1CBABE5C-4E3A-4480-8617-C4F243566C5F}" src="https://github.com/user-attachments/assets/50091d3f-8a8a-4562-a9dd-a534c12935f0" />

```sql
--Ühine triger mis jälgib kas lisamine või kustutamine tabelisse linnad
Create trigger linnaLisamineKustutamine
On linnad -- tabel, mis triger jälgib
for insert, Delete
as
begin
set nocount on; 
	insert into logi(kasutaja, aeg, andmed)
	select
	SYSTEM_USER, --siselogitud user
	GETDATE(), 
	concat('lisatud: ', inserted.linnanimi, ', ', 
	inserted.maakond, ', ', inserted.rahvarv)
	from inserted

	UNION all 

	select
	SYSTEM_USER, --siselogitud user
	GETDATE(), 
	concat('kustutatud: ', deleted.linnanimi, ', ', 
	deleted.maakond, ', ', deleted.rahvarv)
	from deleted;
end;

--kontroll
Delete from linnad where linnId=3

insert into linnad(linnanimi, maakond, rahvarv)
Values('Viljandi', 'Viljandimaa', 50000);

select * from linnad
select * from logi

```
<img width="555" height="319" alt="{EC327A5B-AEFA-4271-AC95-967C3D09B756}" src="https://github.com/user-attachments/assets/5a9015d5-36c8-4a1f-a060-853083d842ef" />

<img width="703" height="653" alt="{592BE182-3E9F-4184-942F-3BDDF728B9A4}" src="https://github.com/user-attachments/assets/0c78b8c7-dd3a-4fe7-b969-75ff05431edb" />

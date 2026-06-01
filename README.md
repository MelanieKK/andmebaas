# Andmebaasid Melanie Koroljova portfoolio Logitpe24
Andmebaasidega seotud sql kood ja konspektid

[Select laused](select.md) | [Protseduurid](Protseduur.md) [Kasutaja loomine SQL serveris](kasutajad.md) [Triggerid](trigerid.md)

- SQL - structured Query Language - struktureeritud päringukeel
- DDl - Data Definition Language -andmebaasi struktuuri loomiseks - CREATE, ALTER
- DML - Data Manipulation Language -admete lisamine ja uuendamine tabelis - INSERT, UPDATE, DELETE

  ## Sisukord
  - [Andmebaasihaldusüsteemid](#Andmebaasihaldusüsteemid)
  - [Põhimõisted](#Põhimõisted)
  - [Andmetüübid](#Andmetüübid)
  - [Piirangud](#Piirangud)
  - [Seosed](#Seosed)

### Andmebaasihaldusüsteemid
1. SQL Server Management Stuudio (SQL Serveri haldamine)
   <img width="478" height="511" alt="{DE58127B-02A4-45B1-AE15-2C28F9AC2FE8}" src="https://github.com/user-attachments/assets/6d1615b6-998b-4b3b-8582-32614efee06f" />

3. XAMPP -phpmyAdmin (mariaDB andmebaas) -vabavara

   ## Põhimõisted

Andmebaas - struktueeritud admete kogum
- Tabel - olem (entity)
- veerg - väli (field)
- rida - kirja (record)
- primaarne võti -PK-Primary Key - veerg (tavaliselt nimiga id) unikaalse identifikaatooriga mis eristab iga kirjet
- Välisvõti (võõrvõti) -FK Foreign Key - veerg, mis loob seose teise tabeli primaarvõtmega

  ## Andmetüübid
  - INT, float, decimal(6,2) - numbrilised
  - varchar(50), char(6) -tekst/sümboolid
  - boolean, bool, bit -loogiline tüüp
  - date, time, datetime - kuupäeva

## Piirangud
```
1. CHECK
2. PRIMARY KEY
3. FOREIGN KEY
4. Not null
5. UNIQUE

```



## Seosed
- üks  - ühele (nt mees --naine)
- üks  - mitmele (nt õpilane käib erinevates õppeainetes)
  <img width="519" height="265" alt="{78702CBC-6009-46D8-972D-CE6510BDBFFD}" src="https://github.com/user-attachments/assets/aa87f6a7-7497-4f9d-9952-ae3c06e9da63" />
- mitu  -mitmele (nt õpilane - õpetaja

## Stored procedure
  Salvestatud protseduurid - sama mis on funktsioonid programeerimises - mingi tegevus(ed), mida saab automaatselt teha        (Insert, Select, Update, Delete)

```sql
-- Proceduur, mis täidab tabeli
Create Procedure lisakatagooria
@nimi varchar(15)
As
Begin
	Insert into Category
	values (@nimi);
	select * from Category;
end
--kutse
Exec lisakatagooria 'test'

--Proceduur, mis kustutab tabelist id järgi
Create procedure kustutaIDJargi
@id int
AS
Begin
	SELECT * from Category;
	Delete from Category where category_id=@id;
	Select * from Category
End
-- kutse
EXEC kustutaIDJargi 3 

--otsing
--protseduur mis otsib kõik kategooriad sisestatud 1 tähe
Create Procedure otsing1taht
@taht char(1)
AS
Begin
	Select Category_Name from Category
	Where Category_Name like @taht + '%';
ENd
--kutse
Select * from Category
Exec otsing1taht 'j'

--Prodceduur, mis uuendab nimed sisestatud id järgi
Create procedure uuendaKategooria
@id int, 
@uuendarudNimi varchar(20)
As 
Begin
	Select * from Category;
	Update Category set Category_Name=@uuendarudNimi
	Where category_id=@id;
end

--kutse
exec uuendaKategooria 4, 'jope'  
```
<img width="945" height="402" alt="{EB00BA5A-E58F-4CF2-8F6E-644C1AB65E27}" src="https://github.com/user-attachments/assets/de98860b-f350-45fb-9f36-b37c1922aa2f" />

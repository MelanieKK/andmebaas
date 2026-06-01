# SQL Protseduurid (Stored Procedures)

## Mis on protseduur?

Protseduur (stored procedure) on eelkompileeritud SQL-lausete kogum, mis salvestatakse andmebaasi ja mida saab korduvalt käivitada. Protseduurid võtavad vastu parameetreid ja täidavad kindlaid toiminguid.

**Süntaks:**
```sql
CREATE PROCEDURE protseduur
    @parameeter andmetüüp
AS
BEGIN
    -- SQL laused
END
```

**Käivitamine:**
```sql
EXEC protseduur 'väärtus'
```

---

## Näide 1 – Protseduur, mis lisab reа tabelisse

```sql
-- Proceduur, mis täidab tabeli
Create Procedure lisa
    @First_Name varchar(15)
AS
Begin
    Insert into Brands
    values (@First_Name);
    select * from Brands;
end

-- Kutse (käivitamine):
Exec lisa 'test'
```

**Selgitus:**
- Protseduur nimega `lisa` võtab ühe parameetri `@First_Name` (kuni 15 tähemärki)
- Lisab väärtuse tabelisse `Brands`
- Kuvab kogu tabeli sisu pärast lisamist
- Kutse: `EXEC lisa 'test'` — lisab nime `'test'`

---

## Näide 2 – Protseduur, mis kustutab rea ID järgi

```sql
-- Proceduur, mis kustutab tabelist id järgi
Create procedure kustuta
    @id int
AS
Begin
    SELECT * from Brands;
    Delete from Brands where brand_id = @id;
    Select * from Brands
End

-- Kutse:
EXEC kustuta 3
```

**Selgitus:**
- Protseduur `kustuta` võtab täisarvu parameetri `@id`
- Kuvab tabeli enne kustutamist
- Kustutab rea, kus `brand_id = @id`
- Kuvab tabeli pärast kustutamist
- Kutse: `EXEC kustuta 3` — kustutab rea, mille ID on 3

---

## Näide 3 – Protseduur, mis otsib nime esitähe järgi

```sql
Create Procedure otsing
    @taht char(1)
AS
Begin
    Select Brand_Name from Brands
    where Brand_Name like @taht + '%';
End

-- Kutse:
Exec otsing 'N'
```

**Selgitus:**
- Protseduur `otsing` võtab ühe tähe parameetri `@taht`
- Otsib kõik `Brand_Name` väärtused, mis algavad selle tähega
- `LIKE @taht + '%'` — `%` tähendab "ükskõik mis järgneb"
- Kutse: `EXEC otsing 'N'` — kuvab kõik brändid, mille nimi algab N-tähega

---

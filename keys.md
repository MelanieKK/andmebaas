# Andmebaasi võtmed (Keys)

Andmebaasi võtmed on vahendid, millega tuvastatakse ridu tabelites, luuakse seoseid tabelite vahel ja tagatakse andmete unikaalsus ning terviklus.

---

## 1. Primary Key (Primaarvõti)

**Definitsioon:**
Primary Key on veerg (või veergude kombinatsioon), mis tuvastab iga rea tabelis **unikaalselt**. Tabelil saab olla ainult **üks** primaarvõti.

**Milleks kasutatakse:**
Iga rea üheseks identifitseerimiseks. Näiteks õpilase ID, arve number, tellimuse kood.

**Mille poolest erineb:**
- Ei tohi olla NULL
- Peab olema unikaalne
- Iga tabelil ainult üks

**Näide:**
```sql
CREATE TABLE Õpilased (
    õpilane_id   INT PRIMARY KEY,
    eesnimi      VARCHAR(50),
    perenimi     VARCHAR(50)
);

INSERT INTO Õpilased VALUES (1, 'Mari', 'Mägi');
INSERT INTO Õpilased VALUES (2, 'Jaan', 'Kask');
```

<img width="397" height="527" alt="{D6FD9E55-7CD5-4791-BF7E-69C1F63C1756}" src="https://github.com/user-attachments/assets/d879d667-be96-4031-957f-f203c60f42da" />


---

## 2. Foreign Key (Võõrvõti)

**Definitsioon:**
Foreign Key on veerg, mis **viitab teise tabeli primaarvõtmele**. See loob seose kahe tabeli vahel.

**Milleks kasutatakse:**
Tabelite vaheliste seoste loomiseks ja referentsiaalse tervikluse tagamiseks — ei saa lisada andmeid, mis ei eksisteeri viidatavas tabelis.

**Mille poolest erineb:**
- Viitab alati teise tabeli PK-le
- Võib olla NULL (kui seos on valikuline)
- Ühes tabelis võib olla mitu Foreign Key-d

**Näide:**
```sql
CREATE TABLE Klassid (
    klass_id    INT PRIMARY KEY,
    klassinimi  VARCHAR(10)
);

CREATE TABLE Õpilased (
    õpilane_id  INT PRIMARY KEY,
    eesnimi     VARCHAR(50),
    klass_id    INT FOREIGN KEY REFERENCES Klassid(klass_id)
);

INSERT INTO Klassid VALUES (1, '10A');
INSERT INTO Õpilased VALUES (1, 'Mari', 1);
```

<img width="610" height="304" alt="{6A20A09F-92DF-49F7-BD69-495957C94330}" src="https://github.com/user-attachments/assets/fa221348-93d4-4a1e-9fef-d39be4ccdeee" />
<img width="316" height="139" alt="{D4EA38D2-820A-49A1-B6B9-DFD67CBDDF71}" src="https://github.com/user-attachments/assets/2fbc69b5-6728-46c0-a659-dd1bc879c695" />


---

## 3. Unique Key (Unikaalne võti)

**Definitsioon:**
Unique Key tagab, et kõik veerus olevad väärtused on **unikaalsed**, kuid erinevalt Primary Key-st **lubab ühe NULL-väärtuse**.

**Milleks kasutatakse:**
Kui tuleb tagada unikaalsus, aga tegemist ei ole peamise identifikaatoriga. Nt e-posti aadress, isikukood, telefoninumber.

**Mille poolest erineb:**
- Lubab NULL-i (PK ei luba)
- Tabelil võib olla mitu Unique Key-d
- Ei ole tabeli peamine identifikaator

**Näide:**
```sql
CREATE TABLE Kasutajad (
    kasutaja_id  INT PRIMARY KEY,
    eesnimi      VARCHAR(50),
    email        VARCHAR(100) UNIQUE
);

INSERT INTO Kasutajad VALUES (1, 'Mari', 'mari@kool.ee');
INSERT INTO Kasutajad VALUES (2, 'Jaan', 'jaan@kool.ee');
-- Järgmine rida annab vea, sest email on juba olemas:
-- INSERT INTO Kasutajad VALUES (3, 'Tiiu', 'mari@kool.ee');
```

<img width="460" height="293" alt="{34B549D8-82A6-4190-9005-A9ABFCEC239A}" src="https://github.com/user-attachments/assets/382afee4-ff58-472d-9d74-9cbc122fc42c" />


---

## 4. Simple Key (Lihtne võti)

**Definitsioon:**
Simple Key koosneb **ainult ühest veerust**, mis tuvastab rea unikaalselt.

**Milleks kasutatakse:**
Kõige levinum võtme tüüp — üks veerg (nt ID) identifitseerib rea.

**Mille poolest erineb:**
- Ainult üks veerg (erinevalt Composite ja Compound Key-st)
- Lihtsaim ja selgeim võtme vorm

**Näide:**
```sql
CREATE TABLE Tooted (
    toode_id    INT PRIMARY KEY,   -- Simple Key: ainult üks veerg
    toode_nimi  VARCHAR(100),
    hind        DECIMAL(10,2)
);

INSERT INTO Tooted VALUES (1, 'Pliiats', 0.99);
INSERT INTO Tooted VALUES (2, 'Vihik', 1.49);
```

<img width="347" height="283" alt="{25AEF095-81A3-4E92-825C-8844E0F09E54}" src="https://github.com/user-attachments/assets/da351ae4-33b3-43db-80c6-498c2805ded1" />


---

## 5. Composite Key (Liitvõti)

**Definitsioon:**
Composite Key on primaarvõti, mis koosneb **kahest või enamast veerust**. Ükski veerg eraldi ei tuvasta rida unikaalselt — ainult koos.

**Milleks kasutatakse:**
Seosetabelites (junction tables), kus ühe tabeli rida seob kahte teist tabelit. Nt õpilane saab olla mitmes kursuses ja kursusel on mitu õpilast.

**Mille poolest erineb:**
- Mitu veergu moodustavad koos võtme
- Kasutatakse M:N seoste lahendamiseks
- Ükski üksikveerg pole üksi primaarvõti

**Näide:**
```sql
CREATE TABLE Kursused (
    kursus_id   INT PRIMARY KEY,
    kursuse_nimi VARCHAR(100)
);

CREATE TABLE Õpilane_Kursus (
    õpilane_id  INT,
    kursus_id   INT,
    PRIMARY KEY (õpilane_id, kursus_id),   -- Composite Key
    FOREIGN KEY (õpilane_id) REFERENCES Õpilased(õpilane_id),
    FOREIGN KEY (kursus_id)  REFERENCES Kursused(kursus_id)
);

INSERT INTO Õpilane_Kursus VALUES (1, 101);
INSERT INTO Õpilane_Kursus VALUES (1, 102);
INSERT INTO Õpilane_Kursus VALUES (2, 101);
```

<img width="433" height="417" alt="{599CC856-06FC-405E-A271-D0062E92A9D4}" src="https://github.com/user-attachments/assets/533d2aff-2d8d-491e-8050-719acac54d58" />
<img width="416" height="443" alt="{728D7B0F-C780-47ED-8971-950827FDA25C}" src="https://github.com/user-attachments/assets/7e5ab8fd-b689-41cf-af90-95ad66700a85" />


---

## 6. Compound Key (Liitidentifikaator)

**Definitsioon:**
Compound Key on sarnane Composite Key-ga — koosneb **mitmest veerust** — kuid erinevalt Composite Key-st sisaldab **vähemalt ühte Foreign Key veergu**.

**Milleks kasutatakse:**
Tabelites, kus võti on moodustatud seosveergudest (FK-dest).

**Mille poolest erineb:**
- Sisaldab Foreign Key veerge (Composite Key ei pruugi)
- Rõhutab, et võtme osad on seosed teiste tabelitega

**Näide:**
```sql
CREATE TABLE Tellimuse_Toode (
    tellimus_id  INT,   -- FK - Tellimused
    toode_id     INT,   -- FK - Tooted
    kogus        INT,
    PRIMARY KEY (tellimus_id, toode_id),          -- Compound Key
    FOREIGN KEY (tellimus_id) REFERENCES Tellimused(tellimus_id),
    FOREIGN KEY (toode_id)    REFERENCES Tooted(toode_id)
);
```

<img width="449" height="386" alt="{B6025BC5-C8E9-42EA-8D31-1D467B4FBECC}" src="https://github.com/user-attachments/assets/93eadb6c-c418-485b-b4e9-016d23422401" />
<img width="449" height="407" alt="{48153E50-5CCA-4269-8F0C-6E461B8AD446}" src="https://github.com/user-attachments/assets/1afea100-6d75-498e-9099-260382cfc49f" />


---

## 7. Superkey (Supervõti)

**Definitsioon:**
Superkey on **ükskõik milline veergude kombinatsioon**, mis tuvastab rea unikaalselt. Superkey võib sisaldada "üleliigseid" veerge.

**Milleks kasutatakse:**
Teoreetiline mõiste andmebaasi disainis — aitab mõista, millised veergude kombinatsioonid suudavad ridu unikaalselt identifitseerida.

**Mille poolest erineb:**
- Võib sisaldada mittevajalikke veerge
- Candidate Key on Superkey minimaalne versioon (ilma üleliigsete veergudeta)
- Kõik Candidate Key-d on Superkey-d, aga mitte vastupidi

**Näide:**
```sql
CREATE TABLE Töötajad (
    töötaja_id   INT PRIMARY KEY,
    eesnimi      VARCHAR(50),
    perenimi     VARCHAR(50),
    isikukood    CHAR(11) UNIQUE
);

-- Kõik järgmised on Superkey-d (tuvastavad rea unikaalselt):
-- (töötaja_id)
-- (isikukood)
-- (töötaja_id, eesnimi)         - üleliigne, aga toimib
-- (töötaja_id, eesnimi, perenimi) - üleliigne, aga toimib
```
-- 7. SUPERKEY / 8. CANDIDATE KEY / 9. ALTERNATE KEY

<img width="567" height="277" alt="{2581A64F-28BE-45D9-BEEB-C27625A76ED5}" src="https://github.com/user-attachments/assets/65f541a6-c4e7-46e9-a3e3-f4c2b9f1b3bc" />


---

## 8. Candidate Key (Kandidaatvõti)

**Definitsioon:**
Candidate Key on **minimaalne Superkey** — veerg või veergude kombinatsioon, mis tuvastab rea unikaalselt ilma üleliigsete veergudeta. Tabelil võib olla mitu Candidate Key-d.

**Milleks kasutatakse:**
Andmebaasi disainis — ühest Candidate Key-st saab Primary Key, ülejäänud saavad Alternate Key-deks.

**Mille poolest erineb:**
- Minimaalne (ei sisalda üleliigseid veerge)
- Võib olla mitu tabelis
- Üks neist valitakse PK-ks

**Näide:**
```sql
CREATE TABLE Õpetajad (
    õpetaja_id   INT UNIQUE NOT NULL,   -- Candidate Key 1
    isikukood    CHAR(11) UNIQUE NOT NULL, -- Candidate Key 2
    tööemail     VARCHAR(100) UNIQUE NOT NULL, -- Candidate Key 3
    eesnimi      VARCHAR(50),
    perenimi     VARCHAR(50)
);

-- Kõik kolm veergu on Candidate Key-d:
-- igaüks tuvastab rea unikaalselt ja on minimaalne
-- Tavaliselt valitakse õpetaja_id - Primary Key
```

---

## 9. Alternate Key (Alternatiivvõti)

**Definitsioon:**
Alternate Key on **Candidate Key, mida ei valitud Primary Key-ks**. See on "varuidentifikaator".

**Milleks kasutatakse:**
Alternatiivne viis rea tuvastamiseks. Nt isikukood on AK siis, kui primaarvõtmeks on valitud ID-number.

**Mille poolest erineb:**
- On Candidate Key, aga mitte PK
- Rakendatakse tavaliselt UNIQUE constraintina
- Tabelil võib olla mitu AK-d

**Näide:**
```sql
CREATE TABLE Õpilased (
    õpilane_id   INT PRIMARY KEY,          -- Primary Key (valitud Candidate Key)
    isikukood    CHAR(11) UNIQUE NOT NULL, -- Alternate Key
    email        VARCHAR(100) UNIQUE,      -- Alternate Key
    eesnimi      VARCHAR(50),
    perenimi     VARCHAR(50)
);

INSERT INTO Õpilased VALUES (1, '50501010001', 'mari@kool.ee', 'Mari', 'Mägi');
```
---

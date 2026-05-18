## SQL Server – Kasutajate autentimine ja õiguste haldamine
Mis on autentimine SQL Serveris?
## Autentimine tähendab kasutaja tuvastamist ehk kontrollimist, kas kasutajal on õigus SQL Serverisse sisse logida.

**SQL Serveris kasutatakse kahte peamist autentimise tüüpi:**

1. Windows Authentication
Selle puhul kasutatakse samu kasutajaandmeid, millega logitakse sisse Windows operatsioonisüsteemi.

Kasutajanimi ja parool on seotud Windowsiga
Turvalisem lahendus
Paroole haldab Windows
Kasutaja ei pea eraldi SQL Serveri parooli teadma
2. SQL Server Authentication
>Selle puhul luuakse kasutaja otse SQL Serverisse.
>Kasutaja ei ole seotud Windowsiga
>Määratakse eraldi kasutajanimi ja parool
>Sobib veebirakenduste jaoks
--------------------------------------------------
**Näide kasutajast: DirectorMelanie Parool: director**
**Kasutaja loomine SQL Serveris**
1. Serveritaseme kasutaja loomine (Login)
Sammud
Ava:

Security → Logins
Tee paremklikk ja vali:

New Login...

<img width="742" height="675" alt="{4863F22D-29B8-4351-BB0C-C7D4832F163B}" src="https://github.com/user-attachments/assets/a1e3c101-63dc-4fcb-9d69-e539e43bc919" />


Harjutamiseks võib eemaldada linnukese:  User must change password at next login
Server Roles
Menüüst Server Roles saab määrata serveri üldised õigused.

Tavaliselt piisab rollist: public

<img width="775" height="692" alt="{DBCC4C8B-1BCF-47C5-91CF-54A7F14BBA55}" src="https://github.com/user-attachments/assets/b83a520f-94e4-48f6-8c3b-ca6a4bbdd37a" />

<img width="248" height="139" alt="{F5B49DC2-8557-4402-A262-48A1755C682B}" src="https://github.com/user-attachments/assets/f9a93ec6-0720-4a63-b4d7-8ad59f54750f" />

2. Andmebaasi kasutaja loomine (User)
Ava:

Database → Security → Users
Tee paremklikk:  New User...
<img width="259" height="144" alt="{A28917A7-6887-4465-B412-789135E6C332}" src="https://github.com/user-attachments/assets/88a45eff-bd22-4ecf-8739-060a98963d27" />

Seosta kasutaja loginiga
>>>>>pilt
Membership ja õigused
Menüüst Membership saab määrata kasutaja rollid.

db_datareader → võib lugeda SELECT
db_datawriter → võib kirjutada INSERT, UPDATE, DELETE
<img width="703" height="686" alt="{73E891F5-2141-4C45-ADDC-78B1F1A7A28C}" src="https://github.com/user-attachments/assets/758e3922-a019-4e64-b98c-60ab9e3a8fcf" />

-------------------------------------------------------------------
## Kasutaja õiguste kontroll##
1. tuleb sisselogida kasutajana direktorMelanie. Connect--> Datebase Engine
   <img width="498" height="512" alt="{862527AC-FB32-42D0-BE75-4619C09DC311}" src="https://github.com/user-attachments/assets/50610e83-b0a7-4ccd-84a4-a4ae8e2ad1bb" />

<img width="471" height="183" alt="{F2E4C17F-2289-4520-A1E5-4A39C8550E33}" src="https://github.com/user-attachments/assets/2ff1c1db-91c8-4ab8-a18d-ef15d5742cbb" />


2. Saab tabeli sisu näha ja sisestatud uus kiri
   <img width="822" height="623" alt="{59DE48D2-ADE8-4A60-B06A-550550A21EBC}" src="https://github.com/user-attachments/assets/86bd8723-8206-4604-820c-bb766148fbbb" />

3. Kontrollime tegevus, mis ei ole lubatud kasutajale, näiteks tabeli loomine
   <img width="792" height="619" alt="{2FF2848D-AE18-450F-AFC2-7C60B8388803}" src="https://github.com/user-attachments/assets/9d4cd98e-f82a-4bff-a11c-8e9a1362c0b7" />

   
SQL Server Authentication Mode muutmine
Kui ilmub viga: Error 18456, siis on tavaliselt lubatud ainult Windows Authentication.
Lahendus
Server → Properties
Security
Vali: SQL Server and Windows Authentication mode
GRANT käsud õiguste jagamiseks
GRANT käsuga antakse kasutajale õigused.
<img width="807" height="936" alt="{0709CCB0-DCB4-4B3F-B13A-C8D5C17C6920}" src="https://github.com/user-attachments/assets/c717983b-0cea-4b33-8e40-ac7b638b22de" />

<img width="839" height="603" alt="{161F861B-7F47-4FCF-A0AB-BCE7E3F852B2}" src="https://github.com/user-attachments/assets/92d4028c-b955-47b3-ad70-42495879663e" />


Käsk	Tähendus
SELECT	Lugemine
INSERT	Lisamine
UPDATE	Muutmine
DELETE	Kustutamine

<img width="760" height="804" alt="{0E8C1516-449F-4BEF-B9F9-E370A9A3BCF4}" src="https://github.com/user-attachments/assets/825ea034-7e52-4aa4-87ff-afb0ef576713" />


    
Ülesanne 1:
Luua andmebaas: MovieBase

Luua tabelid: 

movies (id, moviesNimi, moviesYear, movieDir и movieCost).
guest (id, name)
Lisada vähemalt 7 kirjet.

Luua kasutaja Produtsent parooliga director, kellel on järgmised õigused:
Õigus vaadata ja uuendada tabeli movies välju movieDir ja movieCost + lisada üks enda valitud privileeg.
Õigus vaadata ja lisada kirjeid tabelisse guest.
Keela andmete kustutamine tabelis.
Vihje! UPDATE õigused parem lubada SQL käsuga
GRANT UPDATE (movieCost, movieDir)
ON movies
TO Produtsent;

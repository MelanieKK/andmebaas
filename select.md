## Select laused SQL

[Select laused](select.md) [Kasutaja loomine SQL serveris](kasutajad.md) [Küsimused](kysimused.md) [Triggerid](trigerid.md)

<img width="1025" height="666" alt="{31090670-5AAA-48A5-B776-7D3EBD4723B1}" src="https://github.com/user-attachments/assets/6ec98934-18af-458f-8ed7-34ef88306194" />


```sql
create database selectMelanie
use selectMelanie
create table auto(
autonumber char(6) primary key,
mark varchar(30),
mudell varchar(50),
v_aasta int,
varv varchar(50),
hind money)

select * from auto

--mockaroo.com 


insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('3459Xu', 'Jaguar', 'XK', 2011, 'Maroon', '€5915,65');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('227ogo', 'Cadillac', 'DeVille', 1996, 'Red', '€6680,98');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('052K7x', 'Ford', 'Freestyle', 2005, 'Violet', '€9492,05');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('7809bQ', 'Lexus', 'HS', 2010, 'Indigo', '€2677,11');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('451Mwy', 'Subaru', 'Legacy', 2005, 'Goldenrod', '€9251,36');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('842Odj', 'Ford', 'Bronco', 1991, 'Khaki', '€7373,40');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('547kGf', 'Cadillac', 'Eldorado', 1998, 'Turquoise', '€921,35');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('658G2s', 'Chevrolet', 'Tahoe', 2008, 'Goldenrod', '€3589,06');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('745bmr', 'Hyundai', 'Elantra', 2012, 'Yellow', '€2631,29');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('782ZGN', 'Toyota', 'Tercel', 1994, 'Teal', '€5141,97');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('033roV', 'Toyota', 'Previa', 1993, 'Purple', '€1562,65');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('278klG', 'Mercedes-Benz', 'GL-Class', 2008, 'Purple', '€5272,71');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('569CPZ', 'Hyundai', 'Santa Fe', 2006, 'Teal', '€2261,50');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('763Da4', 'Kia', 'Rio', 2003, 'Orange', '€986,79');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('86663z', 'Lexus', 'GS', 2003, 'Crimson', '€1398,59');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('067xzj', 'Nissan', '280ZX', 1979, 'Mauv', '€3318,54');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('993Kcm', 'Volvo', 'S80', 2000, 'Orange', '€4815,32');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('347nuD', 'Lexus', 'LX', 2000, 'Crimson', '€285,45');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('838CQe', 'Ford', 'Edge', 2012, 'Red', '€33,07');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('371RTK', 'Rolls-Royce', 'Phantom', 2010, 'Orange', '€3184,02');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('621D8V', 'Mazda', 'Mazda6', 2006, 'Aquamarine', '€3911,38');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('224Rcu', 'Volvo', 'V40', 2002, 'Yellow', '€6149,22');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('355Ybs', 'Chevrolet', 'Corvette', 1968, 'Teal', '€9362,20');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('277Xwq', 'Infiniti', 'J', 1993, 'Goldenrod', '€5400,07');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('266K9T', 'Jeep', 'Liberty', 2011, 'Fuscia', '€5928,80');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('943UQb', 'Chevrolet', 'Tahoe', 2002, 'Aquamarine', '€6100,41');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('089ONA', 'Nissan', 'JUKE', 2012, 'Turquoise', '€8871,48');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('978Xmw', 'Cadillac', 'CTS', 2011, 'Mauv', '€7140,57');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('5300bW', 'Ford', 'Probe', 1989, 'Mauv', '€8534,82');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('928TJM', 'Toyota', 'Celica', 2002, 'Puce', '€9303,03');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('2698dt', 'Mercedes-Benz', 'C-Class', 2010, 'Violet', '€1982,73');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('7220IG', 'Volkswagen', 'Passat', 2003, 'Yellow', '€3495,44');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('976oPh', 'Dodge', 'Caravan', 2003, 'Crimson', '€9224,63');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('694W3n', 'Toyota', 'Highlander', 2011, 'Violet', '€5938,43');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('101Xrk', 'Dodge', 'Intrepid', 1993, 'Purple', '€1189,59');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('700Zpf', 'Toyota', 'Matrix', 2009, 'Puce', '€9252,64');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('8270q4', 'Toyota', 'Sienna', 2005, 'Orange', '€6127,77');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('238PFk', 'Honda', 'Pilot', 2005, 'Crimson', '€7219,55');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('796iev', 'Volkswagen', 'Jetta', 1992, 'Pink', '€8424,23');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('967bOQ', 'BMW', '7 Series', 2003, 'Orange', '€6472,75');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('405inV', 'Dodge', 'Dakota', 2005, 'Crimson', '€4729,78');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('547Vl4', 'Ford', 'Expedition', 2007, 'Goldenrod', '€8639,93');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('12518h', 'Buick', 'Regal', 2000, 'Mauv', '€4789,81');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('400vCv', 'Buick', 'Century', 1996, 'Aquamarine', '€4862,36');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('865rRb', 'Isuzu', 'Space', 1993, 'Turquoise', '€6247,37');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('166NnO', 'Kia', 'Sephia', 1994, 'Turquoise', '€947,20');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('821VA2', 'GMC', 'Savana 3500', 2001, 'Indigo', '€9558,32');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('3364zJ', 'Isuzu', 'VehiCROSS', 1999, 'Mauv', '€7437,08');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('1757fH', 'Dodge', 'Ram 1500 Club', 1998, 'Pink', '€6515,63');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('829SZM', 'Mercedes-Benz', 'E-Class', 2008, 'Mauv', '€8684,11');


```

```sql

--Näita kõik
Select * from auto
-- Näita ainult mark, mudel ja hind
select mark, mudell, hind from auto
--tingimused
-- sorteerimine -Order by -kasvavalt, DESC - kahanevalt
Select mark, mudell, hind
from auto
order by hind DESC;

```

<img width="715" height="430" alt="{9C938AB8-A063-447B-AAB3-7002554824AE}" src="https://github.com/user-attachments/assets/ab34cacc-9760-4173-9e96-86453127f412" />

```sql

-- mark algab C tähega
select mark from auto
where mark like 'C%'

```

<img width="406" height="292" alt="{B7BDCF54-86F2-44D2-96B0-61429C014D37}" src="https://github.com/user-attachments/assets/98dc21d3-2f90-425d-b9dc-10e621c5ce55" />

```sql


--hind on vahemikus 500-800
select hind, autonumber, mark 
from auto
Where hind > 5000 and hind <8000 

--teine variant
select hind, autonumber, mark 
from auto
Where hind between 5000 and 10000

-- kombineeritud tingimused (AND, OR, NOT)
select hind, autonumber, mark 
from auto
Where mark lIKe 'Volkswagen' or hind <= 100000

--vaate loomine - VIEW
create view VolkswagenAutod
as
select hind, autonumber, mark 
from auto
Where mark lIKe 'Volkswagen' 

--view kasutamine
Select * from VolkswagenAutod

```

```sql
--Agregaatfunktsioond - SUM, MAX, MIN, AVG, COUNT-kogus

--Leia mitu autot on tabelis
Select count(*) as autodeArv from auto

--Leia keskmine autohind 
Select AVG(hind) as keskmineHind from auto

--Leia keskmine autohind iga margi kohta
Select mark, AVG(hind) as keskmineHind 
from auto
GROUP by mark
```

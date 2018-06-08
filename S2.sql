-- 1. Geef code en omschrijving van alle cursussen die precies vier dagen duren.
SELECT CODE, OMSCHRIJVING FROM CURSUSSEN WHERE LENGTE = 4;

-- 2. Geef alle medewerkers, alfabetisch gesorteerd op functie, en per functie op leeftijd (van jong naar oud).
SELECT * FROM MEDEWERKERS ORDER BY FUNCTIE ASC, GBDATUM DESC;

-- 3. Welke cursussen zijn in Utrecht en/of in Maastricht uitgevoerd?
SELECT * FROM UITVOERINGEN WHERE LOCATIE = 'UTRECHT' OR LOCATIE = 'MAASTRICHT';

-- 4. Welke medewerkers hebben zowel de Java als de XML cursus gevolgd? Geef hun nummers.
SELECT CURSIST FROM INSCHRIJVINGEN WHERE CURSUS = 'JAV' OR CURSUS = 'XML';

-- 5. Geef de naam en voorletters van alle medewerkers, behalve van R. Jansen.
SELECT NAAM, VOORL FROM MEDEWERKERS WHERE (NAAM != 'JANSEN' AND VOORL != 'R');

-- 6. Geef nummer, functie en geboortedatum van alle medewerkers die vóór 1960 geboren zijn, en trainer of verkoper zijn.
SELECT MNR, FUNCTIE, GBDATUM FROM MEDEWERKERS WHERE GBDATUM < '01-01-1960';

-- 7. Geef de nummers van alle medewerkers die niet aan de afdeling opleidingen zijn verbonden. 
SELECT MNR FROM AFDELINGEN CROSS JOIN MEDEWERKERS WHERE AFDELINGEN.ANR != MEDEWERKERS.AFD;

-- 8. Geef de nummers van alle medewerkers die de Java-cursus niet hebben gevolgd.
SELECT * FROM MEDEWERKERS RIGHT JOIN INSCHRIJVINGEN ON MEDEWERKERS.MNR = INSCHRIJVINGEN.CURSIST WHERE INSCHRIJVINGEN.CURSUS = 'JAV';

-- 9. Welke medewerkers hebben voorvoegsels in hun naam?
SELECT * FROM MEDEWERKERS WHERE NAAM LIKE 'DE%' OR NAAM LIKE 'DEN%';

-- 10. Welke medewerkers hebben ondergeschikten? En welke niet?
SELECT NAAM, FUNCTIE FROM MEDEWERKERS;

-- 11. Geef een overzicht van alle uitvoeringen van algemene cursussen (type ALG) in 1999.
SELECT * FROM CURSUSSEN RIGHT JOIN UITVOERINGEN ON CURSUSSEN.CODE = UITVOERINGEN.CURSUS WHERE CURSUSSEN.TYPE = 'ALG' AND UITVOERINGEN.BEGINDATUM LIKE '%-%-1999';

-- 12. Geef naam en voorletters van iedereen die ooit bij N. Smit een cursus heeft gevolgd. Aanwijzing: gebruik subqueries, en werk vervolgens van binnen naar buiten. Dus: bepaal het nummer van N. Smit, zoek dan naar de cursussen die hij heeft gegeven, etc.
SELECT VOORL FROM MEDEWERKERS; -- ??????
SELECT * FROM UITVOERINGEN RIGHT JOIN CURSUSSEN ON UITVOERINGEN.CURSUS = CURSUSSEN.CODE;

-- 13. Wat is de verklaring van het resultaat ‘no rows selected’ in figuur 4.41?
-- ?

--------------------------------------------------------------------------------------------------------------------------------

-- 2. Er wordt een nieuwe uitvoering gepland voor cursus S02, en wel op de komende 13 maart. De cursus wordt gegeven in Leerdam door N. Smit. Voeg deze gegevens toe.
INSERT INTO MEDEWERKERS VALUES(7901, 'SMIT', 'N', NULL, NULL, '18-11-1995', 2000, NULL, NULL);
INSERT INTO UITVOERINGEN VALUES('S02', '13-03-2018', 7901, 'Leerdam');

-- 3. Neem twee van je collega-studenten aan als stagiair en voer hun gegevens in.
INSERT INTO MEDEWERKERS VALUES(7367, 'EL BOUZIDI', 'M', 'STAGAIR', NULL, '18-11-1995', 2300, NULL, NULL);
INSERT INTO MEDEWERKERS VALUES(7368, 'BOGAARTS', 'S', 'STAGAIR', NULL, '18-11-1995', 2300, NULL, NULL);

-- 4. We voeren een extra schaal in tussen schaal 4 en 5, voor mensen die tussen de 3001 en 4000 euro verdienen. Voer dit door.
INSERT INTO SCHALEN VALUES(41, 3001, 4000, 0);

-- 5. Er wordt een nieuwe cursus dataprocessing in het programma opgenomen. Voeg hem toe, maak een paar uitvoeringen en schrijf een aantal mensen in.
SELECT * FROM CURSUSSEN; -- CODE, OMSCHRIJVING, TYPE, LENGTE
INSERT INTO CURSUSSEN VALUES('DAP', 'DATAPROCESSING', 'ALG', 2);
SELECT * FROM UITVOERINGEN; -- CURSUS, BEGINDATUM, DOCENT, LOCATIE
INSERT INTO UITVOERINGEN VALUES('DAP', '18-11-1995', 8001, 'UTRECHT');
SELECT * FROM MEDEWERKERS; -- MNR, NAAM, VOORL, FUNCTIE, CHEF, GBDATUM, MAANDSAL, COMM, AFD
INSERT INTO MEDEWERKERS VALUES(8001, 'JANSEN', 'A', 'DOCENT', NULL, '18-11-1995', 3200, NULL, NULL);
SELECT * FROM INSCHRIJVINGEN;
INSERT INTO INSCHRIJVINGEN VALUES (8001, 'DAP', '18-11-1995', NULL);

-- 6. De medewerkers van de afdeling VERKOOP krijgen een salarisverhoging van 5,5%, behalve de manager van de afdeling, deze krijgt namelijk meer: 7%. Voer deze verhogingen door.
SELECT * FROM MEDEWERKERS;
UPDATE MEDEWERKERS SET MAANDSAL = (SELECT MAANDSAL FROM MEDEWERKERS) * 1.055 WHERE FUNCTIE = 'VERKOPER'; -- ???
UPDATE MEDEWERKERS SET MAANDSAL = (SELECT MAANDSAL FROM MEDEWERKERS) * 1.07 WHERE FUNCTIE = 'MANAGER'; -- ???

-- 7. Martens heeft als verkoper succes en wordt door de concurrent weggekocht. Verwijder zijn gegevens. Zijn collega Alders heeft ook plannen om te vertrekken. Verwijder ook zijn gegevens. Waarom lukt dit (niet)?
SELECT * FROM MEDEWERKERS;
DELETE FROM MEDEWERKERS WHERE NAAM = 'MARTENS';
DELETE FROM MEDEWERKERS WHERE NAAM = 'ALDERS'; -- Er is een record dat afhankelijk is van deze medewerker

-- 8. Je wordt hoofd van de nieuwe afdeling Financiën te Leerdam, onder de hoede van De Koning. Zorg voor de juiste invoer van deze gegevens.
SELECT * FROM AFDELINGEN;
SELECT * FROM MEDEWERKERS;
INSERT INTO AFDELINGEN VALUES(50, 'FINANCIËN', 'LEERDAM', 8002);
UPDATE AFDELINGEN SET HOOFD = 8002 WHERE LOCATIE = 'LEERDAM';
DELETE FROM AFDELINGEN WHERE LOCATIE = 'LEERDAM';
INSERT INTO MEDEWERKERS VALUES(8002, 'SIMSEK', 'B', 'MANAGER', 7839, '18-11-1995', 3200, NULL, NULL);
UPDATE MEDEWERKERS SET CHEF = 7839 WHERE NAAM = 'SIMSEK';

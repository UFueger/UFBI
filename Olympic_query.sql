use olympics;

# Abfrage nach Länder Athleten und sortiert nach Medallien
select 
NOC as 'Länder',
sport as 'Sportart',
event,
medal AS 'Medallien',
name AS 'Name Athlet',
sex as 'Geschlecht'

from athlete_event ae

join athletes a on a.Athlete_ID = ae.Athlete_ID
join events e on e.Event_ID = ae.Athlete_ID
Order by Medal;

#Abfrage nach Länder Athleten  Gold-Medallien sortiert nach Geschlecht
select 
NOC as 'Länder',
sport as 'Sportart',
event,
medal AS 'Medallien',
name AS 'Name Athlet',
sex as 'Geschlecht'

from athlete_event ae

join athletes a on a.Athlete_ID = ae.Athlete_ID
join events e on e.Event_ID = ae.Athlete_ID
Where medal = 'gold'
Order by sex;

#Abfrage nach Länder Athleten  und Geschlecht, sortiert nach Gold, Silber und Bronze
select 
NOC as 'Länder',
sport as 'Sportart',
event,
medal AS 'Medallien',
name AS 'Name Athlet',
age as 'Alter Athlet',
sex as 'Geschlecht'

from athlete_event ae

join athletes a on a.Athlete_ID = ae.Athlete_ID
join events e on e.Event_ID = ae.Athlete_ID
Where medal = 'gold' or medal = 'silver' or medal = 'bronze'
Order by medal;

# Anzahl Medallien sortiert by Medallie
select 
max(medal),
count(medal)

from athlete_event

Where medal = 'gold' or medal = 'silver' or medal = 'bronze' 

Group by medal;

# Welcher Athlet hat an mehreren Events (mehr als 2 Events) teilgenommen und Medallien gewonnen

SELECT a.Athlete_ID, COUNT(DISTINCT event_id) AS 'event_anzahl', count(medal), Name, sex

FROM athlete_event ae
join athletes a on a.Athlete_ID = ae.Athlete_ID
GROUP BY athlete_id
HAVING COUNT(DISTINCT event_id) > 2
order by event_anzahl DESC;

#Abfrage welcher Athlete_ID hat an mehreren Event_ID teilgenommen und hat wieviele Gold-Silber und Bronze Medallien gewonnen?
SELECT 
    a.Athlete_ID, COUNT(DISTINCT event_id) AS 'event_anzahl', 
    name,
    sex,
    SUM(CASE WHEN medal = 'Gold' THEN 1 ELSE 0 END) AS 'Goldmedallien',
    SUM(CASE WHEN medal = 'Silver' THEN 1 ELSE 0 END) AS 'Silbermedallien',
    SUM(CASE WHEN medal = 'Bronze' THEN 1 ELSE 0 END) AS 'Bronzemmedallien'
FROM athlete_event ae
join athletes a on a.Athlete_ID = ae.Athlete_ID
WHERE medal IN ('Gold', 'Silver', 'Bronze')  -- Falls nur Medaillengewinner berücksichtigt werden sollen
GROUP BY athlete_id
HAVING COUNT(DISTINCT event_id) > 1
order by event_anzahl DESC;

# #Abfrage welcher Athlete_ID hat die meisten Gold-Silber und Bronze Medallien gewonnen?

SELECT 
    a.Athlete_ID, COUNT(DISTINCT event_id) AS 'event_anzahl', 
    name,
    sex,
    SUM(CASE WHEN medal = 'Gold' THEN 1 ELSE 0 END) AS 'Goldmedallien',
    SUM(CASE WHEN medal = 'Silver' THEN 1 ELSE 0 END) AS 'Silbermedallien',
    SUM(CASE WHEN medal = 'Bronze' THEN 1 ELSE 0 END) AS 'Bronzemmedallien'
FROM athlete_event ae
join athletes a on a.Athlete_ID = ae.Athlete_ID
WHERE medal IN ('Gold', 'Silver', 'Bronze')  -- Falls nur Medaillengewinner berücksichtigt werden sollen
GROUP BY athlete_id
HAVING COUNT(DISTINCT event_id) > 1
order by sum(medal) DESC;
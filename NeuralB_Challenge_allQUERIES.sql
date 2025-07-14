CREATE DATABASE IF NOT EXISTS hospital_db;
USE hospital_db;     
/*
 the above code is to check if the hospital_db is present or not, if it isnt present we create and start using it.
*/

CREATE TABLE hospital (
    hospital_id INT PRIMARY KEY,
    hospital_name VARCHAR(100)                       /* very simple query to create hospital table, the below queries are also the same, they follow the same table creation policy that is 
                                                       followed for the  hospital table.*/
                                                       
);

CREATE TABLE patient (
    patient_id INT PRIMARY KEY,                     
    hospital_id INT,
    patient_name VARCHAR(100),
    dob DATE,
    admission_datetime DATETIME,
    discharge_datetime DATETIME,
    FOREIGN KEY (hospital_id) REFERENCES hospital(hospital_id)
);

CREATE TABLE diagnosis (
    diagnosis_id INT PRIMARY KEY,
    patient_id INT,
    diagnosis_name VARCHAR(100),
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
);

CREATE TABLE treatment (
    treatment_id INT PRIMARY KEY,
    patient_id INT,
    medicine_name VARCHAR(100),
    dose_time VARCHAR(50),
    duration INT,
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
);

CREATE TABLE billing (
    bill_id INT PRIMARY KEY,
    patient_id INT,
    bill_amount DECIMAL(10, 2),
    payment_mode VARCHAR(10),
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
);

SET FOREIGN_KEY_CHECKS = 0;   /*I suffered an error here while importing the files it occured due to 
								the rules of referential integrity were being violated.
                                as I was not able to insert any record into a child table
                                diagnosis treatement etc
                                during this i suffered from error code 1452 cannot add or update child row*/

TRUNCATE TABLE diagnosis;
TRUNCATE TABLE treatment;
TRUNCATE TABLE billing;
TRUNCATE TABLE patient;
TRUNCATE TABLE hospital;

SET FOREIGN_KEY_CHECKS = 1;   /*since turncating part was completed, i was then able to implement the referential 
                              integrity back */

LOAD DATA  INFILE 'C:/Users/kat92/Desktop/hospitals.csv'
INTO TABLE hospital
FIELDS TERMINATED BY ','     /*Now to upload data in mySQL there are various ways. I which it can be implemented
							 but on off the really ineffecient ways were to load the  
                             Go to Table → Right Click → Table Data Import Wizard, this just didnt work, i would fail everytime
                             hence I needed a better way and that was the following 
                             i disabled the following value i set it to null --secure-file-priv "" hence i was able to
                             load the data more efficently and within Minutes*/
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA  INFILE 'C:/Users/kat92/Desktop/patients_100k.csv'
INTO TABLE patient
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA  INFILE 'C:/Users/kat92/Desktop/diagnoses_100k.csv'
INTO TABLE diagnosis
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA  INFILE 'C:/Users/kat92/Desktop/treatments_100k.csv'
INTO TABLE treatment
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA  INFILE 'C:/Users/kat92/Desktop/billings_100k.csv'
INTO TABLE billing
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Monthly
SELECT hospital_id, YEAR(admission_datetime) AS year, MONTH(admission_datetime) AS month,
       COUNT(*) AS patients_in_month
FROM patient
GROUP BY hospital_id, year, month;

-- Weekly
SELECT hospital_id, YEAR(admission_datetime) AS year, WEEK(admission_datetime) AS week,
       COUNT(*) AS patients_in_week
FROM patient
GROUP BY hospital_id, year, week;

-- Yearly
SELECT hospital_id, YEAR(admission_datetime) AS year,
       COUNT(*) AS patients_in_year
FROM patient
GROUP BY hospital_id, year;

SELECT DATE(admission_datetime) AS date, COUNT(*) AS admissions
FROM patient
GROUP BY date;

-- Weekly
SELECT YEAR(admission_datetime) AS year, WEEK(admission_datetime) AS week, COUNT(*) AS admissions
FROM patient
GROUP BY year, week;

-- Monthly
SELECT YEAR(admission_datetime) AS year, MONTH(admission_datetime) AS month, COUNT(*) AS admissions
FROM patient
GROUP BY year, month;

-- Yearly
SELECT YEAR(admission_datetime) AS year, COUNT(*) AS admissions
FROM patient
GROUP BY year;

SELECT
  CASE
    WHEN TIMESTAMPDIFF(YEAR, dob, CURDATE()) < 18 THEN 'Child'
    WHEN TIMESTAMPDIFF(YEAR, dob, CURDATE()) BETWEEN 18 AND 60 THEN 'Adult'
    ELSE 'Senior'
  END AS age_group,
  COUNT(*) AS count
FROM patient
GROUP BY age_group;

SELECT medicine_name, COUNT(*) AS times_used
FROM treatment
GROUP BY medicine_name
ORDER BY times_used DESC
LIMIT 1;

SELECT d.diagnosis_name, t.medicine_name, COUNT(*) AS usage_count
FROM diagnosis d
JOIN treatment t ON d.patient_id = t.patient_id
GROUP BY d.diagnosis_name, t.medicine_name
HAVING usage_count = (
  SELECT MAX(sub.usage_count)
  FROM (
    SELECT d2.diagnosis_name, t2.medicine_name, COUNT(*) AS usage_count
    FROM diagnosis d2
    JOIN treatment t2 ON d2.patient_id = t2.patient_id
    GROUP BY d2.diagnosis_name, t2.medicine_name
  ) AS sub
  WHERE sub.diagnosis_name = d.diagnosis_name
);


SELECT ROUND(AVG(DATEDIFF(discharge_datetime, admission_datetime)), 2) AS avg_days
FROM patient;

SELECT
  YEAR(p.admission_datetime) AS year,
  MONTH(p.admission_datetime) AS month,
  b.payment_mode,
  SUM(b.bill_amount) AS total_income
FROM billing b
JOIN patient p ON b.patient_id = p.patient_id
GROUP BY year, month, b.payment_mode;


SELECT
  YEAR(p.admission_datetime) AS year,
  b.payment_mode,
  SUM(b.bill_amount) AS total_income
FROM billing b
JOIN patient p ON b.patient_id = p.patient_id
GROUP BY year, b.payment_mode;
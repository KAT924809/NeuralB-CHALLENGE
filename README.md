🏥 Project Title: Hospital Patient Analytics System
📌 Project Overview
This project involved designing and implementing a relational database for a synthetic healthcare environment involving 100,000 patients across 5 hospitals. Each patient had multiple diagnoses, treatments, and billing records. The system was built to support advanced SQL analytics such as occupancy rates, medicine consumption trends, and revenue insights. The objective was to simulate a realistic hospital database environment for analytical querying and reporting — the kind often expected in healthcare tech and data roles.
________________________________________
🛠 Technologies Used
•	Python (Pandas, Faker) – For synthetic data generation
•	MySQL – Core database system for data storage and SQL querying
•	MySQL Workbench & CLI – For schema design, data import, and query execution
•	CSV – As an intermediate format for data loading
•	(Optional: SQLite/Jupyter if using notebook version)
________________________________________
👨‍💻 My Role and Contributions
•	Designed the relational schema involving hospital, patient, diagnosis, treatment, and billing tables
•	Built a Python script using Faker to generate clean, realistic data adhering to relational constraints
•	Imported and integrated the data into MySQL using LOAD DATA LOCAL INFILE
•	Wrote and optimized 7 complex SQL queries to deliver business intelligence insights (e.g., most consumed medicine, age group analysis, monthly income reports, etc.)
•	Resolved foreign key, duplication, and file permission issues during data loading
________________________________________
🧠 Key Challenges and How I Solved Them
•	Data volume handling: Managing and loading large datasets (100k+ rows) efficiently required breaking the data into normalized tables and importing them in the correct order to maintain referential integrity.
•	Foreign key constraint errors: Solved by carefully sequencing table imports (e.g., loading patient before diagnosis) and temporarily disabling foreign key checks when needed.
•	File import errors (secure_file_priv, 1062, 1452): Resolved by using LOAD DATA LOCAL INFILE and cleaning the data files to remove mismatched keys and duplicates.
•	Complex query logic: Used subqueries and joins to solve problems like "most consumed medicine per diagnosis," demonstrating a good grasp of SQL analytics.


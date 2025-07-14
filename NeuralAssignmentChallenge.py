#!/usr/bin/env python
# coding: utf-8

# In[54]:


from faker import Faker 
import pandas as pd
import numpy as np
import random
from datetime import datetime, timedelta
import os


# In[27]:


get_ipython().system('pip install faker')


# In[55]:


from faker import Faker   ##worked 
import pandas as pd
import numpy as np


# In[56]:


fake = Faker()


# In[57]:


NUM_HOSPITALS = 5 ##BASED ON CONDITION PROVIDED 
NUM_PATIENTS = 100_000  ##BASED ON CONDITION PROVIDED
DIAGNOSES = ['Hypertension', 'Diabetes', 'Asthma', 'COPD', 'Arthritis', 'Anxiety', 'Depression', 'Migraine'] 
#BASED ON CONDITION PROVIDED
MEDICINES = ['Paracetamol', 'Ibuprofen', 'Metformin', 'Amlodipine', 'Atorvastatin', 'Omeprazole', 'Amoxicillin', 'Salbutamol'] 
#BASED ON CONDITION PROVIDED.


# In[58]:


patients = []
diagnoses = []
treatments = []
billings = []


# In[59]:


fake = Faker()
random_date = fake.date_between(start_date='-1y', end_date='today')
print(random_date) ##okay works better then previous 


# In[42]:


hospitals = [{'hospital_id': i+1, 'hospital_name': f"{fake.company()} Hospital"} for i in range(NUM_HOSPITALS)]


# In[46]:


#THE CODE BELOW IS USED FOR FINDING THE VALUES OUT.AND GENERATE THE FAKE DATA REQUIRED FOR THE CODE.
##EACH OF THE COLUMNS FOLLOWS THE REQUIRED CONDITIONS THAT WERE MARKED INSIDE THE CHALLENGE PDF.
##


for pid in range(1, NUM_PATIENTS + 1): ##
    hospital_id = random.randint(1, NUM_HOSPITALS) ##LOOPS THROUGH 5 DIFF HOSPITALS
    patient_name = fake.name() ##NAME GENRATION
    dob = fake.date_of_birth(minimum_age=1, maximum_age=90)
    admission = fake.date_time_between(start_date='-2y', end_date='now')  ##GOES BACK TWO YEARS COMES TILL 2025
    discharge = admission + timedelta(days=random.randint(1, 15)) 

    patients.append({                            
        'patient_id': pid,
        'hospital_id': hospital_id,
        'patient_name': patient_name,
        'dob': dob,
        'admission_datetime': admission,
        'discharge_datetime': discharge
    })

    for _ in range(2):
        diagnoses.append({
            'diagnosis_id': len(diagnoses) + 1,
            'patient_id': pid,
            'diagnosis_name': random.choice(DIAGNOSES)
        })

    for _ in range(5):
        treatments.append({
            'treatment_id': len(treatments) + 1,
            'patient_id': pid,
            'medicine_name': random.choice(MEDICINES),
            'dose_time': random.choice(['Morning', 'Evening', 'Night']),
            'duration': random.randint(1, 10)
        })

    billings.append({
        'bill_id': pid,
        'patient_id': pid,
        'bill_amount': round(random.uniform(1000, 10000), 2),
        'payment_mode': random.choice(['cash', 'credit'])
    })


# In[47]:


df_hospitals = pd.DataFrame(hospitals)
df_patients = pd.DataFrame(patients)
df_diagnoses = pd.DataFrame(diagnoses)
df_treatments = pd.DataFrame(treatments)
df_billings = pd.DataFrame(billings)


# In[52]:


df_hospitals.to_csv("desktop/hospitals.csv", index=False)
df_patients.to_csv("desktop/patients.csv", index=False)
df_diagnoses.to_csv("desktop/diagnoses.csv", index=False)
df_treatments.to_csv("desktop/treatments.csv", index=False)
df_billings.to_csv("desktop/billings.csv", index=False)

##wasn't able to load the data in its desired path that is the desktop.


# In[62]:


# Get Desktop path
desktop_path = os.path.join(os.path.expanduser("~"), "Desktop")

# Save files to Desktop
df_hospitals.to_csv(os.path.join(desktop_path, "hospitals.csv"), index=False)
df_patients.to_csv(os.path.join(desktop_path, "patients.csv"), index=False)
df_diagnoses.to_csv(os.path.join(desktop_path, "diagnoses.csv"), index=False)
df_treatments.to_csv(os.path.join(desktop_path, "treatments.csv"), index=False)
df_billings.to_csv(os.path.join(desktop_path, "billings.csv"), index=False)
## the above code works but does not open properly. hence i tried the below alternative of the code.


# In[61]:


import os
import ctypes
from pathlib import Path

#found this on yt-- Use shell API to get Desktop PATH
desktop_path = str(Path(os.path.join(os.environ["USERPROFILE"], "Desktop")))
print("Detected desktop path:", desktop_path)


# In[63]:


df_hospitals.to_csv(os.path.join(desktop_path, "hospitals.csv"), index=False)
df_patients.to_csv(os.path.join(desktop_path, "patients.csv"), index=False)
df_diagnoses.to_csv(os.path.join(desktop_path, "diagnoses.csv"), index=False)
df_treatments.to_csv(os.path.join(desktop_path, "treatments.csv"), index=False)
df_billings.to_csv(os.path.join(desktop_path, "billings.csv"), index=False)   ##this code works better and a bit faster


# In[ ]:


##AFTER GENERATION OF EACH CODE THE FILE NAMES WERE CHANGED TO [FILENAME]_100K.CSV TO KEEP A BETTER 
##TRACK OF THESE FILES DURING CODE SUBMISSION
##YES I COULD HAVE DONE IT IN CODE ITSELF, BUT I M A HUMAN AFTERALL REMEMBERED IT BIT LATE
##ALSO I DIDNT WANT TO BREAK THE CODE PERCHANCE

##---------------------------------------END OF CODE-FILE---------------------------------------------------##


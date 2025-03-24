from flask import Flask, request, jsonify
import joblib
import pandas as pd
import numpy as np

app = Flask(__name__)

model = joblib.load('voting_classifier.pkl')

symptoms = ['itching', 'skin_rash', 'nodal_skin_eruptions', 'continuous_sneezing', 'shivering', 'chills', 'joint_pain', 'stomach_pain', 'acidity', 'ulcers_on_tongue', 'muscle_wasting', 'vomiting', 'burning_micturition', 'spotting_ urination', 'fatigue', 'weight_gain', 'anxiety', 'cold_hands_and_feets', 'mood_swings', 'weight_loss', 'restlessness', 'lethargy', 'patches_in_throat', 'irregular_sugar_level', 'cough', 'high_fever', 'sunken_eyes', 'breathlessness', 'sweating', 'dehydration', 'indigestion', 'headache', 'yellowish_skin', 'dark_urine', 'nausea', 'loss_of_appetite', 'pain_behind_the_eyes', 'back_pain', 'constipation', 'abdominal_pain', 'diarrhoea', 'mild_fever', 'yellow_urine', 'yellowing_of_eyes', 'acute_liver_failure', 'fluid_overload', 'swelling_of_stomach', 'swelled_lymph_nodes', 'malaise', 'blurred_and_distorted_vision', 'phlegm', 'throat_irritation', 'redness_of_eyes', 'sinus_pressure', 'runny_nose', 'congestion', 'chest_pain', 'weakness_in_limbs', 'fast_heart_rate', 'pain_during_bowel_movements', 'pain_in_anal_region', 'bloody_stool', 'irritation_in_anus', 'neck_pain', 'dizziness', 'cramps', 'bruising', 'obesity', 'swollen_legs', 'swollen_blood_vessels', 'puffy_face_and_eyes', 'enlarged_thyroid', 'brittle_nails', 'swollen_extremeties', 'excessive_hunger', 'extra_marital_contacts', 'drying_and_tingling_lips', 'slurred_speech', 'knee_pain', 'hip_joint_pain', 'muscle_weakness', 'stiff_neck', 'swelling_joints', 'movement_stiffness', 'spinning_movements', 'loss_of_balance', 'unsteadiness', 'weakness_of_one_body_side', 'loss_of_smell', 'bladder_discomfort', 'foul_smell_of urine', 'continuous_feel_of_urine', 'passage_of_gases', 'internal_itching', 'toxic_look_(typhos)', 'depression', 'irritability', 'muscle_pain', 'altered_sensorium', 'red_spots_over_body', 'belly_pain', 'abnormal_menstruation', 'dischromic _patches', 'watering_from_eyes', 'increased_appetite', 'polyuria', 'family_history', 'mucoid_sputum', 'rusty_sputum', 'lack_of_concentration', 'visual_disturbances', 'receiving_blood_transfusion', 'receiving_unsterile_injections', 'coma', 'stomach_bleeding', 'distention_of_abdomen', 'history_of_alcohol_consumption', 'fluid_overload.1', 'blood_in_sputum', 'prominent_veins_on_calf', 'palpitations', 'painful_walking', 'pus_filled_pimples', 'blackheads', 'scurring', 'skin_peeling', 'silver_like_dusting', 'small_dents_in_nails', 'inflammatory_nails', 'blister', 'red_sore_around_nose', 'yellow_crust_ooze',]


label_to_disease = {
0            :   "(vertigo) Paroymsal  Positional Vertigo",
1              :                    "Tuberculosis",
2               :                 "Acne" ,
3              :           "Alcoholic hepatitis",
4              :            "Allergy",
5             :                    "Common Cold",
6             :                      "Pneumonia",
7             :              "Osteoarthristis",
8             :                   "Heart attack",
9             :            "Chronic cholestasis"    ,
10              :              " Hypothyroidism",
11             :               "Hyperthyroidism",
12             :                  "Hypoglycemia",
13              :            "Dimorphic hemmorhoids(piles)",
14             :                     "Arthritis",
15    :                         "Fungal infection",
16           :                    "GERD" ,
17           :         "Urinary tract infection",
18            :                      "Psoriasis",
19                :                "Hepatitis D",
20               :                 "Hepatitis B",
21                 :                 "Dengue"  ,
22                :                "hepatitis A",
23                :                    "Hepatitis E" ,
24                :     "Varicose veins"   ,
25                :              "Drug Reaction",
26                :      "Cervical spondylosis"  ,
27                :                     "Impetigo"  ,
28                   :               "Diabetes" ,
29                 :           "Gastroenteritis",
30                :           "Bronchial Asthma",
31                :              "Hypertension" ,
32               :                    "Migraine",
33              :       "Peptic ulcer diseae"  ,
34            :   "Paralysis (brain hemorrhage)",
35               :                    "Jaundice",
36                 :                   "Malaria",
37                  :              "Chicken pox",
38                 :                "Hepatitis C"    ,
39                  :                  "Typhoid",
40                :                   "AIDS"

}

disease_info = {
    "Fungal infection": {
        "description": "A fungal infection is caused by fungi that invade and grow in the body.",
        "symptoms": ["itching", "skin_rash", "nodal_skin_eruptions"],
        "prevention": "Keep skin clean and dry, avoid sharing personal items.",
        "treatment": "Antifungal creams or oral medications."
    },
    "Hepatitis C": {
        "description": "Hepatitis C is a viral infection that causes liver inflammation.",
        "symptoms": ["fatigue", "jaundice", "abdominal_pain"],
        "prevention": "Avoid sharing needles, practice safe sex.",
        "treatment": "Antiviral medications."
    },
    "Hepatitis E": {
        "description": "Hepatitis E is a liver infection caused by the hepatitis E virus.",
        "symptoms": ["fatigue", "jaundice", "abdominal_pain"],
        "prevention": "Drink clean water, practice good hygiene.",
        "treatment": "Rest, hydration, and supportive care."
    },
    "Alcoholic hepatitis": {
        "description": "Liver inflammation caused by excessive alcohol consumption.",
        "symptoms": ["jaundice", "abdominal_pain", "nausea"],
        "prevention": "Limit alcohol intake, maintain a healthy diet.",
        "treatment": "Abstinence from alcohol, medications, and lifestyle changes."
    },
    "Tuberculosis": {
        "description": "A bacterial infection that mainly affects the lungs.",
        "symptoms": ["cough", "fever", "weight_loss"],
        "prevention": "Vaccination, avoid close contact with infected individuals.",
        "treatment": "Antibiotics for several months."
    },
    "Common Cold": {
        "description": "A viral infection of the upper respiratory tract.",
        "symptoms": ["cough", "sore_throat", "runny_nose"],
        "prevention": "Wash hands frequently, avoid close contact with sick people.",
        "treatment": "Rest, hydration, and over-the-counter medications."
    },
    "Pneumonia": {
        "description": "Infection that inflames air sacs in one or both lungs.",
        "symptoms": ["cough", "fever", "breathlessness"],
        "prevention": "Vaccination, good hygiene, and a healthy lifestyle.",
        "treatment": "Antibiotics, rest, and fluids."
    },
    "Dimorphic hemmorhoids(piles)": {
        "description": "Swollen veins in the lower rectum and anus.",
        "symptoms": ["pain_in_anal_region", "bloody_stool", "itching"],
        "prevention": "High-fiber diet, avoid straining during bowel movements.",
        "treatment": "Topical treatments, lifestyle changes, or surgery."
    },
    "Heart attack": {
        "description": "Blockage of blood flow to the heart muscle.",
        "symptoms": ["chest_pain", "breathlessness", "nausea"],
        "prevention": "Healthy diet, regular exercise, avoid smoking.",
        "treatment": "Immediate medical attention, medications, or surgery."
    },
    "Varicose veins": {
        "description": "Swollen, twisted veins visible under the skin.",
        "symptoms": ["swollen_legs", "painful_walking", "swollen_blood_vessels"],
        "prevention": "Exercise, avoid prolonged standing, wear compression stockings.",
        "treatment": "Lifestyle changes, compression therapy, or surgery."
    },
    "Hypothyroidism": {
        "description": "Underactive thyroid gland.",
        "symptoms": ["fatigue", "weight_gain", "cold_hands_and_feets"],
        "prevention": "Regular check-ups, balanced diet.",
        "treatment": "Thyroid hormone replacement therapy."
    },
    "Hyperthyroidism": {
        "description": "Overactive thyroid gland.",
        "symptoms": ["weight_loss", "anxiety", "sweating"],
        "prevention": "Regular check-ups, avoid excessive iodine.",
        "treatment": "Medications, radioactive iodine, or surgery."
    },
    "Hypoglycemia": {
        "description": "Low blood sugar levels.",
        "symptoms": ["dizziness", "sweating", "fatigue"],
        "prevention": "Regular meals, monitor blood sugar levels.",
        "treatment": "Consume fast-acting carbohydrates."
    },
    "Osteoarthristis": {
        "description": "Degeneration of joint cartilage and underlying bone.",
        "symptoms": ["joint_pain", "swelling_joints", "movement_stiffness"],
        "prevention": "Maintain a healthy weight, exercise regularly.",
        "treatment": "Pain relievers, physical therapy, or surgery."
    },
    "Arthritis": {
        "description": "Inflammation of one or more joints.",
        "symptoms": ["joint_pain", "swelling_joints", "movement_stiffness"],
        "prevention": "Healthy diet, regular exercise, avoid joint injuries.",
        "treatment": "Medications, physical therapy, or surgery."
    },
    "(vertigo) Paroymsal Positional Vertigo": {
        "description": "A sudden sensation of spinning.",
        "symptoms": ["dizziness", "loss_of_balance", "unsteadiness"],
        "prevention": "Avoid sudden head movements.",
        "treatment": "Vestibular rehabilitation or medications."
    },
    "Acne": {
        "description": "Skin condition causing pimples and inflammation.",
        "symptoms": ["pus_filled_pimples", "blackheads", "skin_peeling"],
        "prevention": "Keep skin clean, avoid oily cosmetics.",
        "treatment": "Topical treatments, medications, or lifestyle changes."
    },
    "Urinary tract infection": {
        "description": "Infection in any part of the urinary system.",
        "symptoms": ["burning_micturition", "spotting_urination", "foul_smell_of_urine"],
        "prevention": "Stay hydrated, practice good hygiene.",
        "treatment": "Antibiotics and increased fluid intake."
    },
    "Psoriasis": {
        "description": "A skin disease causing red, itchy scaly patches.",
        "symptoms": ["skin_rash", "itching", "silver_like_dusting"],
        "prevention": "Avoid triggers like stress and infections.",
        "treatment": "Topical treatments, light therapy, or medications."
    },
    "Hepatitis D": {
        "description": "A liver infection caused by the hepatitis D virus.",
        "symptoms": ["fatigue", "jaundice", "abdominal_pain"],
        "prevention": "Vaccination against hepatitis B, avoid risky behaviors.",
        "treatment": "Antiviral medications and supportive care."
    },
    "Hepatitis B": {
        "description": "A liver infection caused by the hepatitis B virus.",
        "symptoms": ["fatigue", "jaundice", "abdominal_pain"],
        "prevention": "Vaccination, avoid sharing needles.",
        "treatment": "Antiviral medications and supportive care."
    },
    "Allergy": {
        "description": "Immune system reaction to a foreign substance.",
        "symptoms": ["itching", "skin_rash", "continuous_sneezing"],
        "prevention": "Avoid allergens, use antihistamines.",
        "treatment": "Antihistamines, decongestants, or immunotherapy."
    },
    "hepatitis A": {
        "description": "A liver infection caused by the hepatitis A virus.",
        "symptoms": ["fatigue", "jaundice", "abdominal_pain"],
        "prevention": "Vaccination, practice good hygiene.",
        "treatment": "Rest, hydration, and supportive care."
    },
    "GERD": {
        "description": "Chronic acid reflux.",
        "symptoms": ["acidity", "indigestion", "chest_pain"],
        "prevention": "Avoid spicy foods, eat smaller meals.",
        "treatment": "Antacids, lifestyle changes, or surgery."
    },
    "Chronic cholestasis": {
        "description": "Reduced bile flow from the liver.",
        "symptoms": ["yellowish_skin", "dark_urine", "itching"],
        "prevention": "Avoid alcohol, maintain a healthy diet.",
        "treatment": "Medications, lifestyle changes, or surgery."
    },
    "Drug Reaction": {
        "description": "Adverse reaction to a medication.",
        "symptoms": ["skin_rash", "itching", "fever"],
        "prevention": "Inform your doctor about allergies.",
        "treatment": "Discontinue the drug, use antihistamines."
    },
    "Peptic ulcer diseae": {
        "description": "Sores in the lining of the stomach or small intestine.",
        "symptoms": ["abdominal_pain", "indigestion", "nausea"],
        "prevention": "Avoid NSAIDs, limit alcohol and smoking.",
        "treatment": "Antibiotics, antacids, or surgery."
    },
    "AIDS": {
        "description": "A chronic immune system disease caused by HIV.",
        "symptoms": ["fatigue", "weight_loss", "fever"],
        "prevention": "Practice safe sex, avoid sharing needles.",
        "treatment": "Antiretroviral therapy."
    },
    "Diabetes": {
        "description": "A chronic condition affecting blood sugar levels.",
        "symptoms": ["fatigue", "weight_loss", "increased_appetite"],
        "prevention": "Healthy diet, regular exercise.",
        "treatment": "Insulin, medications, or lifestyle changes."
    },
    "Gastroenteritis": {
        "description": "Inflammation of the stomach and intestines.",
        "symptoms": ["diarrhoea", "vomiting", "abdominal_pain"],
        "prevention": "Practice good hygiene, drink clean water.",
        "treatment": "Hydration, rest, and medications."
    },
    "Bronchial Asthma": {
        "description": "Chronic inflammation of the airways.",
        "symptoms": ["cough", "breathlessness", "chest_pain"],
        "prevention": "Avoid triggers like smoke and allergens.",
        "treatment": "Inhalers, medications, or lifestyle changes."
    },
    "Hypertension": {
        "description": "High blood pressure.",
        "symptoms": ["headache", "dizziness", "chest_pain"],
        "prevention": "Healthy diet, regular exercise, avoid smoking.",
        "treatment": "Medications and lifestyle changes."
    },
    "Migraine": {
        "description": "A severe headache often accompanied by nausea.",
        "symptoms": ["headache", "nausea", "sensitivity_to_light"],
        "prevention": "Avoid triggers like stress and certain foods.",
        "treatment": "Pain relievers, preventive medications."
    },
    "Cervical spondylosis": {
        "description": "Age-related wear and tear of the spinal disks.",
        "symptoms": ["neck_pain", "stiff_neck", "headache"],
        "prevention": "Maintain good posture, exercise regularly.",
        "treatment": "Physical therapy, medications, or surgery."
    },
    "Paralysis (brain hemorrhage)": {
        "description": "Loss of muscle function due to brain bleeding.",
        "symptoms": ["weakness_of_one_body_side", "loss_of_balance", "headache"],
        "prevention": "Control blood pressure, avoid smoking.",
        "treatment": "Immediate medical attention, rehabilitation."
    },
    "Jaundice": {
        "description": "Yellowing of the skin due to liver problems.",
        "symptoms": ["yellowish_skin", "dark_urine", "fatigue"],
        "prevention": "Avoid alcohol, maintain a healthy diet.",
        "treatment": "Treat the underlying cause."
    },
    "Malaria": {
        "description": "A mosquito-borne infectious disease.",
        "symptoms": ["fever", "chills", "headache"],
        "prevention": "Use mosquito nets, avoid mosquito bites.",
        "treatment": "Antimalarial medications."
    },
    "Chicken pox": {
        "description": "A highly contagious viral infection.",
        "symptoms": ["skin_rash", "fever", "itching"],
        "prevention": "Vaccination, avoid contact with infected individuals.",
        "treatment": "Antiviral medications and supportive care."
    },
    "Dengue": {
        "description": "A mosquito-borne viral infection.",
        "symptoms": ["high_fever", "headache", "joint_pain"],
        "prevention": "Use mosquito nets, avoid mosquito bites.",
        "treatment": "Hydration, rest, and supportive care."
    },
    "Typhoid": {
        "description": "A bacterial infection causing high fever.",
        "symptoms": ["fever", "headache", "abdominal_pain"],
        "prevention": "Vaccination, drink clean water.",
        "treatment": "Antibiotics and supportive care."
    },
    "Impetigo": {
        "description": "A highly contagious skin infection.",
        "symptoms": ["red_sore_around_nose", "yellow_crust_ooze", "itching"],
        "prevention": "Practice good hygiene, avoid scratching.",
        "treatment": "Antibiotics and topical treatments."
    }
}

@app.route('/predict', methods=['POST'])
def predict():

    if request.headers.get('Content-Type') != 'application/json':
        return jsonify({'error': 'Unsupported Media Type. Expected application/json.'}), 415
  
    if not request.json or 'symptoms' not in request.json:
        return jsonify({'error': 'Invalid input. Expected JSON with "symptoms" key.'}), 400

    data = request.json
    input_symptoms = data.get('symptoms', [])

    valid_symptoms = set(symptoms)
    input_symptoms = [symptom for symptom in input_symptoms if symptom in valid_symptoms]

    if not input_symptoms:
        return jsonify({'error': 'No valid symptoms provided.'}), 400

    try:
        input_data = {symptom: 1 if symptom in input_symptoms else 0 for symptom in symptoms}
        df = pd.DataFrame([input_data])

        prediction = model.predict(df)
        
        predicted_label = prediction[0].item() if isinstance(prediction[0], np.int64) else prediction[0]
        predicted_disease = label_to_disease.get(predicted_label, "Unknown Disease")

        disease_details = disease_info.get(predicted_disease, {
            "description": "No information available.",
            "symptoms": [],
            "prevention": "No prevention tips available.",
            "treatment": "No treatment information available."
        })

        return jsonify({
            'disease': predicted_disease,
            'details': disease_details
        })
    except Exception as e:
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(port=5000)
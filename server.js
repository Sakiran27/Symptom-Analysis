const express = require('express');
const bodyParser = require('body-parser');
const mysql = require('mysql');
const cors = require('cors');
const path = require('path');
const axios = require('axios'); 

const app = express();
const port = 3000;

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(cors());
app.use(express.static(path.join(__dirname, 'public')));

const db = mysql.createConnection({
    host: 'localhost',
    user: 'root', 
    password: '123456', 
    database: 'medical_app'
});

db.connect((err) => {
    if (err) throw err;
    console.log('MySQL Connected...');
});
const diseaseToSpecialization = {
    "Tuberculosis": "Tuberculosis Specialist",
    "Acne": "Dermatologist",
    "Alcoholic hepatitis": "Hepatitis Specialist",
    "Allergy": "Allergist",
    "Common Cold": "General Physician",
    "Pneumonia": "Pulmonologist",
    "Osteoarthristis": "Orthopedic Surgeon",
    "Heart attack": "Cardiologist",
    "Chronic cholestasis": "Hepatologist",
    "Hypothyroidism": "Endocrinologist",
    "Hyperthyroidism": "Endocrinologist",
    "Hypoglycemia": "Endocrinologist",
    "Dimorphic hemmorhoids(piles)": "Proctologist",
    "Arthritis": "Rheumatologist",
    "Fungal infection": "Fungal Infection Specialist",
    "GERD": "Gastroenterologist",
    "Urinary tract infection": "Urologist",
    "Psoriasis": "Dermatologist",
    "Hepatitis D": "Hepatitis Specialist",
    "Hepatitis B": "Hepatitis Specialist",
    "Dengue": "Infectious Disease Specialist",
    "Hepatitis A": "Hepatitis Specialist",
    "Hepatitis E": "Hepatitis Specialist",
    "Varicose veins": "Vascular Surgeon",
    "Drug Reaction": "Toxicologist",
    "Cervical spondylosis": "Neurologist",
    "Impetigo": "Dermatologist",
    "Diabetes": "Endocrinologist",
    "Gastroenteritis": "Gastroenterologist",
    "Bronchial Asthma": "Pulmonologist",
    "Hypertension": "Cardiologist",
    "Migraine": "Neurologist",
    "Peptic ulcer diseae": "Gastroenterologist",
    "Paralysis (brain hemorrhage)": "Neurologist",
    "Jaundice": "Hepatologist",
    "Malaria": "Infectious Disease Specialist",
    "Chicken pox": "Infectious Disease Specialist",
    "Hepatitis C": "Hepatitis Specialist",
    "Typhoid": "Infectious Disease Specialist",
    "AIDS": "Infectious Disease Specialist"
};
// Serve HTML files
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'views', 'index.html'));
});

app.get('/views/patient_login.html', (req, res) => {
    res.sendFile(path.join(__dirname, 'views', 'patient_login.html'));
});

app.get('/views/patient_register.html', (req, res) => {
    res.sendFile(path.join(__dirname, 'views', 'patient_register.html'));
});

app.get('/views/doctor_login.html', (req, res) => {
    res.sendFile(path.join(__dirname, 'views', 'doctor_login.html'));
});

app.get('/views/admin_dashboard.html', (req, res) => {
    res.sendFile(path.join(__dirname, 'views', 'admin_dashboard.html'));
});
app.get('/views/admin_login.html', (req, res) => {
    res.sendFile(path.join(__dirname, 'views', 'admin_login.html'));
});

app.get('/views/patient_dashboard.html', (req, res) => {
    res.sendFile(path.join(__dirname, 'views', 'patient_dashboard.html'));
});

app.get('/views/doctor_dashboard.html', (req, res) => {
    res.sendFile(path.join(__dirname, 'views', 'doctor_dashboard.html'));
});

// Predict Disease (Call Flask API)
app.post('/predict-disease', async (req, res) => {
    const { symptoms } = req.body;

    if (!symptoms || !Array.isArray(symptoms)) {
        return res.status(400).json({ error: 'Invalid input. Expected an array of symptoms.' });
    }

    try {
        // Call the Flask API
        const response = await axios.post('http://localhost:5000/predict', { symptoms });
        const predictedDisease = response.data.disease;


        const specialization = diseaseToSpecialization[predictedDisease] || predictedDisease
        // Fetch recommended doctors from the database
        const fetchDoctorsSql = 'SELECT * FROM doctors WHERE specialization LIKE ?';
        db.query(fetchDoctorsSql, [`%${specialization}%`], (err, doctors) => {
            if (err) {
                console.error('Error fetching doctors:', err);
                return res.status(500).json({ error: 'Error fetching doctors.' });
            }
            res.json({
                disease: predictedDisease,
                details: response.data.details,
                doctors: doctors
            });
        });
    } catch (error) {
        console.error('Error calling Flask API:', error);
        res.status(500).json({ error: 'Error predicting disease. Please try again.' });
    }
});


// Book Appointment
app.post('/book-appointment', (req, res) => {
    const { patientName, patientAge, patientMobile, appointmentDate, doctorId } = req.body;

    if (!patientName || !patientAge || !patientMobile || !appointmentDate || !doctorId) {
        return res.status(400).json({ error: 'All fields are required.' });
    }

    const insertSql = 'INSERT INTO appointments (patient_name, patient_age, patient_mobile, appointment_date, doctor_id) VALUES (?, ?, ?, ?, ?)';
    db.query(insertSql, [patientName, patientAge, patientMobile, appointmentDate, doctorId], (err, result) => {
        if (err) {
            console.error('Error booking appointment:', err);
            return res.status(500).json({ error: 'Error booking appointment.', details: err.message });
        }
        res.json({ message: 'Appointment booked successfully.' });
    });
});

// View Doctor Appointments
app.get('/doctor-appointments', (req, res) => {
    const { doctor_id, appointment_date } = req.query;

    if (!doctor_id || !appointment_date) {
        return res.status(400).json({ error: 'Doctor ID and appointment date are required.' });
    }

    const fetchAppointmentsSql = 'SELECT * FROM appointments WHERE doctor_id = ? AND appointment_date = ?';
    db.query(fetchAppointmentsSql, [doctor_id, appointment_date], (err, appointments) => {
        if (err) {
            console.error('Error fetching appointments:', err);
            return res.status(500).json({ error: 'Error fetching appointments.' });
        }
        console.log('Appointments:', appointments); 
        res.json({ appointments });
    });
});

// Patient Registration
app.post('/register/patient', (req, res) => {
    const { username, email, password } = req.body;
    const checkEmailSql = 'SELECT * FROM patients WHERE email = ?';
    db.query(checkEmailSql, [email], (err, result) => {
        if (err) throw err;
        if (result.length > 0) {
            res.status(400).send('Email already registered');
        } else {
            const insertSql = 'INSERT INTO patients (username, email, password) VALUES (?, ?, ?)';
            db.query(insertSql, [username, email, password], (err, result) => {
                if (err) throw err;
                res.send('Patient registered successfully');
            });
        }
    });
});

// Patient Login
app.post('/login/patient', (req, res) => {
    const { email, password } = req.body;
    const sql = 'SELECT * FROM patients WHERE email = ?';
    db.query(sql, [email], (err, result) => {
        if (err) throw err;
        if (result.length > 0) {
            const patient = result[0];
            if (patient.password === password) {
                res.send('Patient login successful');
            } else {
                res.status(401).send('Incorrect password');
            }
        } else {
            res.status(401).send('Email not found. Please register.');
        }
    });
});


// Admin Registration of Doctors
app.post('/register/doctor', (req, res) => {
    const { doctorname, gender, age, specialization, city, rating, password } = req.body;

    if (!doctorname || !gender || !age || !specialization || !city || !rating || !password) {
        return res.status(400).json({ error: 'All fields are required.' });
    }

    const insertSql = `
        INSERT INTO doctors (doctorname, gender, age, specialization, city, rating, password)
        VALUES (?, ?, ?, ?, ?, ?, ?)
    `;
    db.query(insertSql, [doctorname, gender, age, specialization, city, rating, password], (err, result) => {
        if (err) {
            console.error('Error registering doctor:', err);
            return res.status(500).json({ error: 'Error registering doctor.' });
        }
        res.json({ message: 'Doctor registered successfully.' });
    });
});


//login for doctor
app.post('/login/doctor', (req, res) => {
    const { doctorname, password } = req.body;
    const sql = 'SELECT * FROM doctors WHERE doctorname = ?';
    db.query(sql, [doctorname], (err, result) => {
        if (err) {
            console.error('Error logging in:', err);
            return res.status(500).json({ error: 'Error logging in.' });
        }
        if (result.length > 0) {
            const doctor = result[0];

            if (doctor.password === password) {
                res.json({ message: 'Doctor login successful.' });
            } else {
                res.status(401).json({ error: 'Incorrect password.' });
            }
        } else {
            res.status(401).json({ error: 'Doctor not found.' });
        }
    });
});

app.listen(port, () => {
    console.log(`Server running on port ${port}`);
});

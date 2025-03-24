// Patient Registration
document.getElementById('patientRegisterForm')?.addEventListener('submit', function (e) {
    e.preventDefault();
    const username = document.getElementById('username').value;
    const email = document.getElementById('email').value;
    const password = document.getElementById('password').value;

    fetch('/register/patient', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ username, email, password })
    })
    .then(response => {
        if (response.status === 400) {
            throw new Error('Email already registered');
        }
        return response.text();
    })
    .then(data => {
        alert(data);
        window.location.href = '/views/patient_login.html'; 
    })
    .catch(error => {
        console.error('Error:', error);
        alert(error.message); 
    });
});
// Patient Login
document.getElementById('patientLoginForm')?.addEventListener('submit', function (e) {
    e.preventDefault();
    const email = document.getElementById('email').value;
    const password = document.getElementById('password').value;

    fetch('/login/patient', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ email, password })
    })
    .then(response => {
        if (response.status === 401) {
            return response.text().then(errorMessage => {
                throw new Error(errorMessage);
            });
        }
        return response.text();
    })
    .then(data => {
        alert(data); 
        window.location.href = '/views/patient_dashboard.html'; 
    })
    .catch(error => {
        console.error('Error:', error);
        alert(error.message); 
        if (error.message === 'Email not found. Please register.') {
            window.location.href = '/views/patient_register.html'; 
        }
    });
});
//doctor login
document.getElementById('doctorLoginForm')?.addEventListener('submit', function (e) {
    e.preventDefault();

    const doctorname = document.getElementById('doctorname').value;
    const password = document.getElementById('password').value;

    fetch('/login/doctor', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ doctorname, password })
    })
    .then(response => {
        if (!response.ok) {
            return response.json().then(errorData => {
                throw new Error(errorData.error || 'Login failed.');
            });
        }
        return response.json();
    })
    .then(data => {
        alert(data.message); 
        window.location.href = '/views/doctor_dashboard.html'; 
    })
    .catch(error => {
        console.error('Error:', error);
        alert(error.message); 

        if (error.message === 'Doctor not found.') {
            window.location.href = '/views/doctor_register.html';
        }
    });
});

//To display appountment forms
function showAppointmentForm(doctorId) {
    const appointmentForm = `
        <h3>Book Appointment</h3>
        <form id="bookAppointmentForm">
            <input type="text" id="patientName" placeholder="Name" required>
            <input type="number" id="patientAge" placeholder="Age" required>
            <input type="text" id="patientMobile" placeholder="Mobile No" required>
            <input type="date" id="appointmentDate" required>
            <button type="submit">Book Appointment</button>
        </form>
    `;
    document.getElementById('doctorsList').innerHTML = appointmentForm;

    document.getElementById('bookAppointmentForm').onsubmit = function (e) {
        e.preventDefault();
        const patientName = document.getElementById('patientName').value;
        const patientAge = document.getElementById('patientAge').value;
        const patientMobile = document.getElementById('patientMobile').value;
        const appointmentDate = document.getElementById('appointmentDate').value;

        fetch('/book-appointment', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                patient_name: patientName,
                patient_age: patientAge,
                patient_mobile: patientMobile,
                appointment_date: appointmentDate,
                doctor_id: doctorId
            })
        })
        .then(response => response.json())
        .then(data => {
            alert(data.message);
        })
        .catch(error => {
            console.error('Error:', error);
            alert('Error booking appointment.');
        });
    };
}

//To analyze symptoms.
function analyzeSymptoms() {
    const selectedSymptoms = Array.from(document.querySelectorAll('#symptoms option:checked'))
        .map(option => option.value);

    fetch('/predict-disease', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ symptoms: selectedSymptoms })
    })
    .then(response => response.json())
    .then(data => {
        if (data.error) {
            document.getElementById('diseaseDetails').innerHTML = `<p>Error: ${data.error}</p>`;
            document.getElementById('doctorsList').innerHTML = `<p>No doctors recommended.</p>`;
        } else {
            // Display disease information
            const diseaseDetails = document.getElementById('diseaseDetails');
            diseaseDetails.innerHTML = `
                <h3>${data.disease}</h3>
                <p><strong>Description:</strong> ${data.details.description}</p>
                <p><strong>Symptoms:</strong> ${data.details.symptoms.join(', ')}</p>
                <p><strong>Prevention:</strong> ${data.details.prevention}</p>
                <p><strong>Treatment:</strong> ${data.details.treatment}</p>
            `;

            // Display recommended doctors
            const doctorsList = document.getElementById('doctorsList');
            if (data.doctors.length > 0) {
                doctorsList.innerHTML = `
                    ${data.doctors.map(doctor => `
                        <div class="doctor-card">
                            <p><strong>Name:</strong> ${doctor.doctorname}</p>
                            <p><strong>Specialization:</strong> ${doctor.specialization}</p>
                            <p><strong>Rating:</strong> ${doctor.rating}</p>
                            <button onclick="showAppointmentForm(${doctor.id})">Book Appointment</button>
                        </div>
                    `).join('')}
                `;
            } else {
                doctorsList.innerHTML = `<p>No doctors recommended for this disease.</p>`;
            }
        }
    })
    .catch(error => {
        console.error('Error:', error);
        document.getElementById('diseaseDetails').innerHTML = `<p>Error analyzing symptoms.</p>`;
        document.getElementById('doctorsList').innerHTML = `<p>No doctors recommended.</p>`;
    });
}


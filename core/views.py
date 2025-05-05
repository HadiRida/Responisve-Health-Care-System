import os
import re
import numpy as np
import joblib
from django.conf import settings
from django.contrib import messages, auth
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required
from django.contrib.auth.hashers import make_password
from django.http import JsonResponse, HttpResponse
from django.shortcuts import render, redirect, get_object_or_404
from django.views.decorators.csrf import csrf_exempt
from reportlab.lib.pagesizes import letter, inch
from reportlab.lib import colors
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer, Image, Table, TableStyle, HRFlowable, PageBreak
from .models import Medical, User, Ment, Profile
from core.models import Profile
from core.forms import ProfileForm
from reportlab.lib.enums import TA_LEFT, TA_CENTER
from django.http import JsonResponse
from datetime import datetime
from django.utils import timezone

def generate_profile_pdf(request, profile_id):
    profile = get_object_or_404(Profile, id=profile_id)

    response = HttpResponse(content_type='application/pdf')
    response['Content-Disposition'] = f'attachment; filename="profile_{profile.id}.pdf"'

    doc = SimpleDocTemplate(response, pagesize=letter,
                            rightMargin=50, leftMargin=50,
                            topMargin=60, bottomMargin=40)
    elements = []

    styles = getSampleStyleSheet()
    title_style = ParagraphStyle(name='Title', fontSize=22, leading=26, alignment=TA_CENTER, fontName='Helvetica-Bold')
    section_title_style = ParagraphStyle(name='SectionTitle', fontSize=14, leading=18, alignment=TA_LEFT, fontName='Helvetica-Bold', textColor=colors.HexColor('#003366'))
    normal_style = ParagraphStyle(name='NormalText', fontSize=11, leading=15, alignment=TA_LEFT, fontName='Helvetica')
    bold_text_style = ParagraphStyle(name='BoldText', fontSize=11, leading=15, fontName='Helvetica-Bold', alignment=TA_LEFT)

    elements.append(Paragraph("Patient Profile Summary", title_style))
    elements.append(Spacer(1, 15))

    elements.append(HRFlowable(width="100%", thickness=1, lineCap='round', color=colors.HexColor('#003366')))
    elements.append(Spacer(1, 15))

    if profile.avatar:
        avatar = Image(profile.avatar.path, 2 * inch, 2.4 * inch)
        avatar.hAlign = 'CENTER'
        elements.append(avatar)
        elements.append(Spacer(1, 20))

    elements.append(Paragraph("Patient Information", section_title_style))
    elements.append(Spacer(1, 10))

    patient_info = [
        [Paragraph("<b>Patient ID</b>", bold_text_style), Paragraph(str(profile.id), normal_style)],
        [Paragraph("<b>Name</b>", bold_text_style), Paragraph(profile.full_name, normal_style)],
        [Paragraph("<b>Contact Info</b>", bold_text_style), Paragraph(profile.contact_info or "No contact info", normal_style)],
        [Paragraph("<b>Birth Date</b>", bold_text_style), Paragraph(profile.birth_date.strftime('%B %d, %Y'), normal_style)],
        [Paragraph("<b>Gender</b>", bold_text_style), Paragraph(profile.gender, normal_style)],
        [Paragraph("<b>Allergies</b>", bold_text_style), Paragraph(profile.allergies or "None", normal_style)],
        [Paragraph("<b>Current Medications</b>", bold_text_style), Paragraph(profile.medications or "None", normal_style)],
        [Paragraph("<b>Medical History</b>", bold_text_style), Paragraph(profile.medical_history or "None", normal_style)],
        [Paragraph("<b>Family Medical History</b>", bold_text_style), Paragraph(profile.family_history or "None", normal_style)],
        [Paragraph("<b>Lifestyle</b>", bold_text_style), Paragraph(profile.lifestyle or "None", normal_style)],
    ]

    table = Table(patient_info, colWidths=[150, 350], hAlign='LEFT')
    table.setStyle(TableStyle([
        ('BACKGROUND', (0, 0), (-1, -1), colors.whitesmoke),
        ('ROWBACKGROUNDS', (0, 0), (-1, -1), [colors.whitesmoke, colors.lightgrey]),
        ('TEXTCOLOR', (0, 0), (-1, -1), colors.black),
        ('FONTNAME', (0, 0), (-1, -1), 'Helvetica'),
        ('FONTSIZE', (0, 0), (-1, -1), 10),
        ('ALIGN', (0, 0), (-1, -1), 'LEFT'),
        ('VALIGN', (0, 0), (-1, -1), 'MIDDLE'),
        ('INNERGRID', (0, 0), (-1, -1), 0.25, colors.grey),
        ('BOX', (0, 0), (-1, -1), 0.5, colors.grey),
        ('BOTTOMPADDING', (0, 0), (-1, -1), 6),
    ]))
    elements.append(table)
    elements.append(Spacer(1, 20))

    diseases = Medical.objects.filter(patient=profile.user)
    approved_diseases = diseases.filter(is_approved=True)
    pending_diseases = diseases.filter(is_approved=False)

    if approved_diseases.exists():
        elements.append(Paragraph("Approved Diseases", section_title_style))
        elements.append(Spacer(1, 10))

        approved_data = [["Diagnosis Date", "Disease Name"]]
        for disease in approved_diseases:
            approved_data.append([
                disease.created_on.strftime('%B %d, %Y'),
                disease.disease
            ])

        table = Table(approved_data, colWidths=[200, 300], hAlign='LEFT')
        table.setStyle(TableStyle([
            ('BACKGROUND', (0, 0), (-1, 0), colors.HexColor("#e8f5e9")),
            ('TEXTCOLOR', (0, 0), (-1, 0), colors.HexColor("#2e7d32")),
            ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
            ('ALIGN', (0, 0), (-1, -1), 'LEFT'),
            ('FONTNAME', (0, 1), (-1, -1), 'Helvetica'),
            ('ROWBACKGROUNDS', (0, 1), (-1, -1), [colors.white, colors.lightgrey]),
            ('GRID', (0, 0), (-1, -1), 0.3, colors.grey),
            ('BOTTOMPADDING', (0, 0), (-1, -1), 6),
        ]))
        elements.append(table)
        elements.append(Spacer(1, 20))

    if pending_diseases.exists():
        elements.append(Paragraph("Pending Diseases", section_title_style))
        elements.append(Spacer(1, 10))

        pending_data = [["Diagnosis Date", "Disease Name"]]
        for disease in pending_diseases:
            pending_data.append([
                disease.created_on.strftime('%B %d, %Y'),
                disease.disease
            ])

        table = Table(pending_data, colWidths=[200, 300], hAlign='LEFT')
        table.setStyle(TableStyle([
            ('BACKGROUND', (0, 0), (-1, 0), colors.HexColor("#fff8e1")),
            ('TEXTCOLOR', (0, 0), (-1, 0), colors.HexColor("#f57c00")),
            ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
            ('ALIGN', (0, 0), (-1, -1), 'LEFT'),
            ('FONTNAME', (0, 1), (-1, -1), 'Helvetica'),
            ('ROWBACKGROUNDS', (0, 1), (-1, -1), [colors.white, colors.lightgrey]),
            ('GRID', (0, 0), (-1, -1), 0.3, colors.grey),
            ('BOTTOMPADDING', (0, 0), (-1, -1), 6),
        ]))
        
        elements.append(table)

    def footer(canvas, doc):
        canvas.saveState()
        canvas.setFont('Helvetica', 8)
        canvas.drawString(270, 10, f"Page {doc.page}")
        canvas.restoreState()

    doc.build(elements, onFirstPage=footer, onLaterPages=footer)
    return response


def edit_patient_profile(request, patient_id):
    profile = get_object_or_404(Profile, id=patient_id)

    if request.method == 'POST':
        form = ProfileForm(request.POST, request.FILES, instance=profile)
        if form.is_valid():
            form.save()
            messages.success(request, 'Patient profile updated successfully!')
            return redirect('patient_profile', patient_id=profile.user.id)
        else:
            messages.error(request, 'Please correct the errors below.')
    else:
        form = ProfileForm(instance=profile)

    return render(request, 'doctor/edit_patient_profile.html', {'form': form, 'profile': profile})

def approve_disease(request, disease_id):
    disease = get_object_or_404(Medical, id=disease_id)

    if request.method == "POST":
        disease.is_approved = True
        disease.save()
        messages.success(request, "Disease has been approved.")

    return redirect('patient_profile', patient_id=disease.patient.id)
    


def patient_diagnosed_list(request):
    disease = Medical.objects.all().order_by('-created_on')  
    return render(request, 'patient/patient_profiles.html', {'disease': disease})


def patient_profiles(request):
    disease = Medical.objects.all().order_by('-created_on')  
    return render(request, 'doctor/patient_profiles.html', {'disease': disease})



def filter_doctors(request):
    specialty = request.GET.get('specialty', 'all')  
    if specialty == 'all':
        doctors = Profile.objects.all()
    else:
        doctors = Profile.objects.filter(specialty__iexact=specialty)  
    return render(request, 'doctors.html', {'doctors': doctors, 'specialty': specialty})
    
def about(request):
    return render(request, 'about.html', {})

def hospital_search(request):
    context = {
        "google_maps_api_key": settings.GOOGLE_MAPS_API_KEY  
    }
    return render(request, "findhospital.html", context)

def doctor_list(request):
    return render(request, 'doctors.html',{})

def home(request):
    return render(request, 'home.html',{})

def registerView(request):
    return render(request, 'register.html',{})

def form(request):
    return render(request, 'appointment_request.html',{})

def terms_of_service(request):
    return render(request, 'terms.html',{})

def privacy(request):
    return render(request, 'privacy.html',{})

def department(request):
    return render(request, 'department.html',{})


def registerUser(request):
    if request.method == 'POST':
        username = request.POST['username']
        email = request.POST['email']
        email_confirm = request.POST.get('email_confirm')
        password = request.POST['password']
        password_confirm = request.POST.get('password_confirm')

        if password != password_confirm:
            messages.error(request, 'Passwords do not match.')
            return redirect('reg')

        if len(password) < 8:
            messages.error(request, 'Password must be at least 8 characters long.')
            return redirect('reg')

        if not re.search(r'[^a-zA-Z0-9]', password):
            messages.error(request, 'Password must contain at least one special character (e.g., @, #, !, etc.).')
            return redirect('reg')

        password = make_password(password)

        try:
            a = User(username=username, email=email, password=password, is_patient=True)
            a.save()
            messages.success(request, 'Account Created Successfully')
            return redirect('reg')
        except Exception as e:
            messages.error(request, f'Failed to Register: {str(e)}')
            return redirect('reg')
    else:
        messages.error(request, 'Failed to Register')
        return redirect('reg')
    
    

def loginView(request):
    if request.method == 'POST':
        username = request.POST['username']
        password = request.POST['password']
        user = authenticate(request, username=username, password=password)
        if user is not None and user.is_active:
            auth.login(request, user)

            if user.is_patient:
                if not Profile.objects.filter(user_id=user.id).exists():
                    return redirect('create_profile')  
                return redirect('patient')

            elif user.is_doctor:
                if not Profile.objects.filter(user_id=user.id).exists():
                    return redirect('create_doctorprofile')  
                return redirect('doctor')
        else:
            messages.info(request, 'Invalid username or password')
            return redirect('login')
    else:
        return render(request, 'login.html')


def patient_home(request):
    doctor = User.objects.filter(is_doctor=True).count()
    patient = User.objects.filter(is_patient=True).count()
    appointment = Ment.objects.filter(approved=True).count()
    medical1 = Medical.objects.filter(medicine='See Doctor').count()
    medical2 = Medical.objects.all().count()
    medical3 = int(medical2) - int(medical1)

    user_id = request.user.id

    user_profile = Profile.objects.filter(user_id=user_id).first()
    if not user_profile:
        context = {
            'profile_status': 'Please Create Profile to Continue',
            'doctor': doctor,
            'ment': appointment,
            'patient': patient,
            'drug': medical3,
        }
        return render(request, 'patient/home.html', context)
    else:
        context = {
            'status': '1',
            'doctor': doctor,
            'ment': appointment,
            'patient': patient,
            'drug': medical3,
            'user_name': user_profile.full_name,  
        }
        return render(request, 'patient/home.html', context)

@login_required
def doctor_home(request):
    doctor = User.objects.filter(is_doctor=True).count()
    patient = User.objects.filter(is_patient=True).count()
    appointment = Ment.objects.filter(approved=True).count()
    medical1 = Medical.objects.filter(medicine='See Doctor').count()
    medical2 = Medical.objects.all().count()
    medical3 = int(medical2) - int(medical1)
    user_id = request.user.id
    disease = Medical.objects.all()
    patients = User.objects.filter(is_patient=True).prefetch_related('profile')

    user_profile = Profile.objects.filter(user_id=user_id).first()
    if not user_profile:
        context = {
            'profile_status': 'Please Create Profile to Continue',
            'doctor': doctor,
            'ment': appointment,
            'patient': patient,
            'drug': medical3,
            'patients': patients,  
            'disease_records': Medical.objects.all(),
            'disease': disease,  
    }
        
        return render(request, '    ', context)
    else:
        context = {
            'status': '1',
            'doctor': doctor,
            'ment': appointment,
            'patient': patient,
            'drug': medical3,
            'patients': patients,  
            'disease_records': Medical.objects.all(),
            'disease': disease,  
            'user_name': user_profile.full_name,  

    }
        
        return render(request, 'doctor/home.html', context)

def create_profile(request):
    if request.method == 'POST':
        full_name = request.POST['full_name']
        contact_info = request.POST['contact_info']
        birth_date = request.POST['birth_date']
        region = request.POST['region']
        country = request.POST['country']
        gender = request.POST['gender']
        medical_history = request.POST['medical_history']
        allergies = request.POST['allergies']
        medications = request.POST['medications']
        family_history = request.POST['family_history']
        lifestyle = request.POST['lifestyle']
        avatar = request.FILES.get('avatar')  

        Profile.objects.create(
            user_id=request.user.id,
            full_name=full_name,
            contact_info=contact_info,
            birth_date=birth_date,
            gender=gender,
            country=country,
            region=region,
            medical_history=medical_history,
            allergies=allergies,
            medications=medications,
            family_history=family_history,
            lifestyle=lifestyle,
            avatar=avatar,  
        )
        messages.success(request, 'Profile Created Successfully')
        return redirect('patient')
    else:
        context = {'gender': ['Male', 'Female']}
        return render(request, 'patient/create_profile.html', context)


def create_doctorprofile(request):
    if request.method == 'POST':
        full_name = request.POST['full_name']
        contact_info = request.POST['contact_info']
        birth_date = request.POST['birth_date']
        region = request.POST['region']
        country = request.POST['country']
        gender = request.POST['gender']
        specialty = request.POST['specialty']
        license_number = request.POST['license_number']
        experience_years = request.POST['experience_years']
        medical_school = request.POST['medical_school']
        hospital_affiliation = request.POST['hospital_affiliation']
        avatar = request.FILES.get('avatar')  

        Profile.objects.create(
            user_id=request.user.id,
            full_name=full_name,
            contact_info=contact_info,
            birth_date=birth_date,
            gender=gender,
            country=country,
            region=region,
            specialty=specialty,
            license_number=license_number,
            experience_years=experience_years,
            medical_school=medical_school,
            hospital_affiliation=hospital_affiliation,
            avatar=avatar,  
        )
        messages.success(request, 'Profile Created Successfully')
        return redirect('doctor')
    else:
        context = {'gender': ['Male', 'Female']}
        return render(request, 'doctor/create_doctorprofile.html', context)
    

def diagnosis(request):
    symptoms = ['itching', 'skin_rash', 'nodal_skin_eruptions', 'continuous_sneezing', 'shivering', 'chills', 'joint_pain', 'stomach_pain', 'acidity', 'ulcers_on_tongue', 'muscle_wasting', 'vomiting', 'burning_micturition', 'spotting_ urination', 'fatigue', 'weight_gain', 'anxiety', 'cold_hands_and_feets', 'mood_swings', 'weight_loss', 'restlessness', 'lethargy', 'patches_in_throat', 'irregular_sugar_level', 'cough', 'high_fever', 'sunken_eyes', 'breathlessness', 'sweating', 'dehydration', 'indigestion', 'headache', 'yellowish_skin', 'dark_urine', 'nausea', 'loss_of_appetite', 'pain_behind_the_eyes', 'back_pain', 'constipation', 'abdominal_pain', 'diarrhoea', 'mild_fever', 'yellow_urine', 'yellowing_of_eyes', 'acute_liver_failure', 'fluid_overload', 'swelling_of_stomach', 'swelled_lymph_nodes', 'malaise', 'blurred_and_distorted_vision', 'phlegm', 'throat_irritation', 'redness_of_eyes', 'sinus_pressure', 'runny_nose', 'congestion', 'chest_pain', 'weakness_in_limbs', 'fast_heart_rate', 'pain_during_bowel_movements', 'pain_in_anal_region', 'bloody_stool', 'irritation_in_anus', 'neck_pain', 'dizziness', 'cramps', 'bruising', 'obesity', 'swollen_legs', 'swollen_blood_vessels', 'puffy_face_and_eyes', 'enlarged_thyroid',
                'brittle_nails', 'swollen_extremeties', 'excessive_hunger', 'extra_marital_contacts', 'drying_and_tingling_lips', 'slurred_speech', 'knee_pain', 'hip_joint_pain', 'muscle_weakness', 'stiff_neck', 'swelling_joints', 'movement_stiffness', 'spinning_movements', 'loss_of_balance', 'unsteadiness', 'weakness_of_one_body_side', 'loss_of_smell', 'bladder_discomfort', 'foul_smell_of urine', 'continuous_feel_of_urine', 'passage_of_gases', 'internal_itching', 'toxic_look_(typhos)', 'depression', 'irritability', 'muscle_pain', 'altered_sensorium', 'red_spots_over_body', 'belly_pain', 'abnormal_menstruation', 'dischromic _patches', 'watering_from_eyes', 'increased_appetite', 'polyuria', 'family_history', 'mucoid_sputum', 'rusty_sputum', 'lack_of_concentration', 'visual_disturbances', 'receiving_blood_transfusion', 'receiving_unsterile_injections', 'coma', 'stomach_bleeding', 'distention_of_abdomen', 'history_of_alcohol_consumption', 'fluid_overload', 'blood_in_sputum', 'prominent_veins_on_calf', 'palpitations', 'painful_walking', 'pus_filled_pimples', 'blackheads', 'scurring', 'skin_peeling', 'silver_like_dusting', 'small_dents_in_nails', 'inflammatory_nails', 'blister', 'red_sore_around_nose', 'yellow_crust_ooze']
    symptoms = sorted(symptoms)
    context = {'symptoms': symptoms, 'status': '1'}
    return render(request, 'patient/diagnosis.html', context)

@csrf_exempt
@csrf_exempt
def MakePredict(request):
    if request.method == 'POST':
        symptoms = []
        for key, value in request.POST.items():
            if key.startswith('Symptom') and value:
                symptoms.append(value)

        patient_id = request.POST.get('user_id')

        print("Collected Symptoms:", symptoms)

        first_five_symptoms = symptoms[:5]
        additional_symptoms = symptoms[5:]  

        list_a = ['itching', 'skin_rash', 'nodal_skin_eruptions', 'continuous_sneezing', 'shivering', 'chills', 'joint_pain', 'stomach_pain', 'acidity', 'ulcers_on_tongue', 'muscle_wasting', 'vomiting', 'burning_micturition', 'spotting_ urination', 'fatigue', 'weight_gain', 'anxiety', 'cold_hands_and_feets', 'mood_swings', 'weight_loss', 'restlessness', 'lethargy', 'patches_in_throat', 'irregular_sugar_level', 'cough', 'high_fever', 'sunken_eyes', 'breathlessness', 'sweating', 'dehydration', 'indigestion', 'headache', 'yellowish_skin', 'dark_urine', 'nausea', 'loss_of_appetite', 'pain_behind_the_eyes', 'back_pain', 'constipation', 'abdominal_pain', 'diarrhoea', 'mild_fever', 'yellow_urine', 'yellowing_of_eyes', 'acute_liver_failure', 'fluid_overload', 'swelling_of_stomach', 'swelled_lymph_nodes', 'malaise', 'blurred_and_distorted_vision', 'phlegm', 'throat_irritation', 'redness_of_eyes', 'sinus_pressure', 'runny_nose', 'congestion', 'chest_pain', 'weakness_in_limbs', 'fast_heart_rate', 'pain_during_bowel_movements', 'pain_in_anal_region', 'bloody_stool', 'irritation_in_anus', 'neck_pain', 'dizziness', 'cramps', 'bruising', 'obesity', 'swollen_legs', 'swollen_blood_vessels', 'puffy_face_and_eyes', 'enlarged_thyroid',
                  'brittle_nails', 'swollen_extremeties', 'excessive_hunger', 'extra_marital_contacts', 'drying_and_tingling_lips', 'slurred_speech', 'knee_pain', 'hip_joint_pain', 'muscle_weakness', 'stiff_neck', 'swelling_joints', 'movement_stiffness', 'spinning_movements', 'loss_of_balance', 'unsteadiness', 'weakness_of_one_body_side', 'loss_of_smell', 'bladder_discomfort', 'foul_smell_of urine', 'continuous_feel_of_urine', 'passage_of_gases', 'internal_itching', 'toxic_look_(typhos)', 'depression', 'irritability', 'muscle_pain', 'altered_sensorium', 'red_spots_over_body', 'belly_pain', 'abnormal_menstruation', 'dischromic _patches', 'watering_from_eyes', 'increased_appetite', 'polyuria', 'family_history', 'mucoid_sputum', 'rusty_sputum', 'lack_of_concentration', 'visual_disturbances', 'receiving_blood_transfusion', 'receiving_unsterile_injections', 'coma', 'stomach_bleeding', 'distention_of_abdomen', 'history_of_alcohol_consumption', 'fluid_overload', 'blood_in_sputum', 'prominent_veins_on_calf', 'palpitations', 'painful_walking', 'pus_filled_pimples', 'blackheads', 'scurring', 'skin_peeling', 'silver_like_dusting', 'small_dents_in_nails', 'inflammatory_nails', 'blister', 'red_sore_around_nose', 'yellow_crust_ooze']

        list_c = [1 if symptom in symptoms else 0 for symptom in list_a]

        test = np.array(list_c).reshape(1, -1)
        print("Test Shape:", test.shape)

        clf = joblib.load('healthcare/model/decision_tree.pkl')
        prediction = clf.predict(test)
        result = prediction[0]

        a = Medical(
            s1=first_five_symptoms[0] if len(first_five_symptoms) > 0 else '',
            s2=first_five_symptoms[1] if len(first_five_symptoms) > 1 else '',
            s3=first_five_symptoms[2] if len(first_five_symptoms) > 2 else '',
            s4=first_five_symptoms[3] if len(first_five_symptoms) > 3 else '',
            s5=first_five_symptoms[4] if len(first_five_symptoms) > 4 else '',
            additional_symptoms=additional_symptoms,  
            disease=result,
            patient_id=patient_id,
            is_approved=False  
        )
        a.save()

        return JsonResponse({'status': 'pending'})
    
def patient_result(request):
    user_id = request.user.id
    disease = Medical.objects.all().filter(patient_id=user_id)
    context = {'disease': disease, 'status': '1'}

    return render(request, 'patient/result.html', context)

def doctor_commend(request):
    disease = Medical.objects.all()
    context = {'disease': disease, 'status': '1'}
    
    return render(request, 'doctor/result.html', context)

@csrf_exempt
def MakeMent(request):
    disease = request.POST.get('disease')
    userid = request.POST.get('userid')

    try:
        check_medical = Ment.objects.filter(medical_id=disease).exists()
        if (check_medical == False):
            a = Ment(medical_id=disease, patient_id=userid)
            a.save()
            return JsonResponse({'status': 'saved'})
        else:
            print('Appointment Exist')
            return JsonResponse({'status': 'exist'})
    except Exception as e:
        return JsonResponse({'status': 'error'}) 


def patient_ment(request):
    user_id = request.user.id
    appointment = Ment.objects.all().filter(patient_id=user_id)
    context = {'ment': appointment, 'status': '1'}
    return render(request, 'patient/ment.html', context)

def logoutView(request):
    if '_messages' in request.session:
        del request.session['_messages']
    
    logout(request)
    
    return redirect('login')

def patient_profile(request, patient_id):
    patient = get_object_or_404(User, id=patient_id, is_patient=True)
    
    profile = get_object_or_404(Profile, user=patient)

    diseases = Medical.objects.filter(patient=patient)

    approved_diseases = diseases.filter(is_approved=True)
    pending_diseases = diseases.filter(is_approved=False)

    context = {
        'patient': patient,
        'profile': profile,  
        'disease': diseases,  
        'approved_diseases': approved_diseases,
        'pending_diseases': pending_diseases,
    }

    return render(request, 'doctor/patient_profile.html', context)

def add_doctor_diagnosis(request, disease_id):
    if request.method == 'POST':
        disease = get_object_or_404(Medical, id=disease_id)
        doctor_diagnosis = request.POST.get('doctor_diagnosis')

        if doctor_diagnosis:
            disease.disease_by_doctor = doctor_diagnosis
            disease.save()
            messages.success(request, "Diagnosis updated successfully.")
        else:
            messages.error(request, "Diagnosis cannot be empty.")

    return redirect('patient_profile', patient_id=disease.patient.id)

@login_required
@csrf_exempt
def MakeMend(request):
    disease = request.POST.get('disease')
    userid = request.POST.get('userid')

    print('Disease ID', disease)
    print('User ID is', userid)

    patient_id = Medical.objects.filter(
        pk=disease).values_list('patient_id', flat=True)
    patient_id = list(patient_id)
    patient_id = patient_id[0]
    disease_id = disease

    dob = Profile.objects.filter(
        user_id=patient_id).values_list('birth_date', flat=True)
    dob = list(dob)
    dob = dob[0]
    print('Date of birth is', dob)
    dob = str(dob)
    dob = dob[0:4]
    print('New Date of birth is', dob)
    dob = int(dob)
    age = 2021 - dob
    print('Patient Age is', age)

    gender = Profile.objects.filter(
        user_id=patient_id).values_list('gender', flat=True)
    gender = list(gender)
    gender = gender[0]
    print('Patient Gender is', gender)

    if gender == 'Male':
        sex = 1
    else:
        sex = 0

    print('Patient Sex is', sex)

    sick = Medical.objects.filter(pk=disease).values_list('disease', flat=True)
    sick = list(sick)
    sick = sick[0]
    sick = str(sick)

    print('Patient Disease Diagnosed is', sick)

    disease_list = ['Acne', 'Allergy', 'Diabetes', 'Fungal infection',
                    'Urinary tract infection', 'Malaria', 'Malaria', 'Migraine', 'Hepatitis B', 'AIDS']

    disease_dict = {'Acne': 0, 'Allergy': 1, 'Diabetes': 2, 'Fungal infection': 3,
                    'Urinary tract infection': 4, 'Malaria': 5, 'Malaria': 6, 'Migraine': 7, 'Hepatitis B': 8, 'AIDS': 9}

    if sick in disease_list:
        print('AI Got Drug For This Disease')
        print(disease_dict.get(sick))
        new_sick = disease_dict.get(sick)

        test = [new_sick, sex, age]
        print(test)
        test = np.array(test)
        print(test.shape)
        test = np.array(test).reshape(1, -1)
        print(test.shape)

        clf=joblib.load('healthcare/model/medical_rf.pkl')
        prediction = clf.predict(test)
        prediction = prediction[0]
        print('Predicted Disease Is', prediction)

        try:
            check_medical = Medical.objects.filter(patient_id=disease).exists()
            if(check_medical == False):
                Medical.objects.filter(pk=disease).update(medicine=prediction)
                return JsonResponse({'status': 'recommended'})
            else:
                print('Drug Exist')
            return JsonResponse({'status': 'exist'})
        except Exception as e:
            print(e)
    else:
        print('AI Can Not Recommend Drug')
        Medical.objects.filter(pk=disease).update(medicine='See Doctor')
        return JsonResponse({'status': 'not is store'})

@login_required
def doctor_ment(request):
    user_id = request.user.id
    appointment = Ment.objects.all()
    context = {'ment': appointment, 'status': '1'}
    return render(request, 'doctor/ment.html', context)


@login_required
@csrf_exempt
def SaveMent(request):
    if request.method != 'POST':
        return JsonResponse({'status': 'error', 'message': 'Invalid request method.'})

    pk = request.POST.get('pk')
    day = request.POST.get('day')
    time = request.POST.get('time')

    if not day or not time:
        return JsonResponse({'status': 'error', 'message': 'Day and time are required.'})

    try:
        appointment_datetime_str = f"{day} {time}"
        appointment_datetime = datetime.strptime(appointment_datetime_str, "%Y-%m-%d %H:%M")
        appointment_datetime = timezone.make_aware(appointment_datetime, timezone.get_current_timezone())

        ment_instance = Ment.objects.filter(pk=pk).first()

        if not ment_instance:
            return JsonResponse({'status': 'error', 'message': 'Appointment does not exist.'})

        if ment_instance.doctor and ment_instance.doctor != request.user:
            return JsonResponse({'status': 'error', 'message': 'You are not authorized to modify this appointment.'})

        ment_instance.ment_day = appointment_datetime
        ment_instance.time = time
        ment_instance.approved = True
        ment_instance.doctor = request.user  
        ment_instance.save()

        return JsonResponse({'status': 'success', 'message': 'Appointment set successfully.'})

    except ValueError as e:
        return JsonResponse({'status': 'error', 'message': f"Invalid date or time format: {e}"})

    except Exception as e:
        print(f"Error occurred: {e}")
        return JsonResponse({'status': 'error', 'message': str(e)})
    
@login_required
def patienttable(request):
    patients = User.objects.filter(is_patient=True).prefetch_related('profile')
    disease_records = Medical.objects.all()  

    context = {
        'patients': patients,
        'disease_records': disease_records,
        'disease': disease_records,  
    }
    return render(request, 'doctor/patient_table.html', context)


@login_required
def patienttable(request):
    patients = User.objects.filter(is_patient=True).prefetch_related('profile')
    disease_records = Medical.objects.select_related('checked_by', 'patient')  

    if request.method == 'POST':
        record_id = request.POST.get('record_id')
        try:
            record = Medical.objects.get(id=record_id)
            record.checked_by = request.user  
            record.save()
           
        except Medical.DoesNotExist:
            messages.error(request, "Record not found.")

    context = {
        'patients': patients,
        'disease_records': disease_records,
        'disease': disease_records,
    }
    return render(request, 'doctor/patient_table.html', context)

from django.contrib.auth import logout
from django.contrib.messages import get_messages
from django.shortcuts import redirect

def logout_view(request):
    logout(request)

    storage = get_messages(request)
    for _ in storage:
        pass

    return redirect('login')

from django.contrib import messages

def some_view(request):
    messages.success(request, "Your profile has been updated successfully.")
    return redirect('profile')

def mark_done(request, pk):
    if request.method == 'POST':
        ment = get_object_or_404(Ment, pk=pk)
        ment.done = True
        ment.save()
        messages.success(request, "Appointment marked as done successfully.")
    return redirect('meet_list')

from django.views.decorators.csrf import csrf_exempt
from django.http import JsonResponse
import json

@csrf_exempt
def edit_medicine(request, disease_id):
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
            new_medicine = data.get('medicine')

            if not new_medicine:
                return JsonResponse({'status': 'error', 'message': 'Medicine cannot be empty.'})

            disease = Medical.objects.get(id=disease_id)
            disease.medicine = new_medicine
            disease.save()

            return JsonResponse({'status': 'success', 'message': 'Medicine updated successfully.'})
        except Medical.DoesNotExist:
            return JsonResponse({'status': 'error', 'message': 'Disease not found.'})
        except Exception as e:
            return JsonResponse({'status': 'error', 'message': str(e)})
    return JsonResponse({'status': 'error', 'message': 'Invalid request method.'})

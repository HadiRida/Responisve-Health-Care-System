from django.urls import path
from . import views
from .views import form
from django.contrib.auth import views as auth_views


urlpatterns = [
    path('', views.home, name="home"),
    path('register/', views.registerView, name="reg"),
    path('reg_user/', views.registerUser, name='reg_user'),
    path('login/', views.loginView, name='login'),
    path('patient/', views.patient_home, name='patient'),
    path('create_profile/', views.create_profile, name='create_profile'),
    path('diagnosis/', views.diagnosis, name='diagnosis'),
    path('diagnosis/predict/', views.MakePredict, name='predict'),
    path('result/', views.patient_result, name='result'),
    path('result/ment/', views.MakeMent, name='ment'),
    path('ment/', views.patient_ment, name='ment_list'),
    path('logout/', views.logoutView, name='logout'),
    path('doctor/', views.doctor_home, name='doctor'),
    path('commend/', views.doctor_commend, name='commend'),
    path('commend/predict/', views.MakeMend, name='mend'),
    path('meet/', views.doctor_ment, name='meet_list'),
    path('meet/save/', views.SaveMent, name='savement'),
    path('about/', views.about, name='about'),
    path('doctors/', views.doctor_list, name='doctors'),
    path('appointment_request.html',views.form, name='appointment_request'),
    path('terms.html', views.terms_of_service, name='terms_of_service'),
    path('privacy.html', views.privacy, name='privacy'),
    path('department.html', views.department, name='department'),
    path('patient/<int:patient_id>/', views.patient_profile, name='patient_profile'),
    path('findhospital.html', views.hospital_search, name='hospital_search'),
    path('create_doctorprofile.html', views.create_doctorprofile, name='create_doctorprofile'),   
    path('doctors.html', views.filter_doctors, name='filter_doctors'),
    path('patient_table.html', views.patienttable, name='patient_table'),
    path('password_reset/', auth_views.PasswordResetView.as_view(template_name='PasswordReset/password_reset_form.html'), name='password_reset'),
    path('password_reset_done/',auth_views.PasswordResetDoneView.as_view(template_name='PasswordReset/password_reset_done.html'),name='password_reset_done',),
    path('password_reset_confirm/<uidb64>/<token>/',auth_views.PasswordResetConfirmView.as_view(template_name='PasswordReset/password_reset_confirm.html'),name='password_reset_confirm',),
    path('password_reset_complete/',auth_views.PasswordResetCompleteView.as_view(template_name='PasswordReset/password_reset_complete.html'),name='password_reset_complete', ),
    path('approve-disease/<int:disease_id>/', views.approve_disease, name='approve_disease'),
    path('add-doctor-diagnosis/<int:disease_id>/', views.add_doctor_diagnosis, name='add_doctor_diagnosis'),
    path('generate-profile-pdf/<int:profile_id>/', views.generate_profile_pdf, name='generate_profile_pdf'),
    path('edit-patient-profile/<int:patient_id>/', views.edit_patient_profile, name='edit_patient_profile'),
    path('make-ment/', views.MakeMent, name='MakeMent'),
    path('SaveMent/', views.SaveMent, name='SaveMent'),
    path('mark_done/<int:pk>/', views.mark_done, name='mark_done'),
    path('edit-medicine/<int:disease_id>/', views.edit_medicine, name='edit_medicine'),

]


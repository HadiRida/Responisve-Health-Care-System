from django.db import models
from django.contrib.auth.models import AbstractUser
from datetime import date

class User(AbstractUser):
    is_patient = models.BooleanField(default=False)
    is_doctor = models.BooleanField(default=False)
    phonenumber = models.CharField(max_length=200, null=True)

class Medical(models.Model):
    s1 = models.CharField(max_length=255, null=True, blank=True)
    s2 = models.CharField(max_length=255, null=True, blank=True)
    s3 = models.CharField(max_length=255, null=True, blank=True)
    s4 = models.CharField(max_length=255, null=True, blank=True)
    s5 = models.CharField(max_length=255, null=True, blank=True)
    additional_symptoms = models.JSONField(null=True, blank=True) 
    disease_by_doctor = models.CharField(max_length=255, null=True, blank=True)
    disease = models.CharField(max_length=200)
    medicine = models.CharField(max_length=200)
    patient = models.ForeignKey(
        User, related_name="patient", on_delete=models.CASCADE)
    doctor = models.ForeignKey(
        User, related_name="doctor", on_delete=models.CASCADE, null=True)
    created_on = models.DateTimeField(auto_now_add=True)
    full_name = models.CharField(max_length=200)
    checked_by = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, blank=True, related_name="checked_medicals")
    is_approved = models.BooleanField(default=False)  

    def __str__(self):
        return self.disease

class Ment(models.Model):
    approved = models.BooleanField(default=False)
    time = models.CharField(max_length=200, null=True)
    done = models.BooleanField(default=False)  
    patient = models.ForeignKey(
        User, related_name="pat", on_delete=models.CASCADE)
    doctor = models.ForeignKey(
        User, related_name="dor", on_delete=models.CASCADE, null=True)
    ment_day = models.DateTimeField(null=True)
    medical = models.ForeignKey(
        Medical, related_name="medical", on_delete=models.CASCADE, null=True)
    created_on = models.DateTimeField(auto_now_add=True)


    def __str__(self):
        return str(self.approved)

class Profile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    avatar = models.ImageField(upload_to='avatars/', blank=True, null=True)
    birth_date = models.DateField(null=True, blank=True)  
    region = models.CharField(max_length=255, default='')
    gender = models.CharField(max_length=255)
    country = models.CharField(max_length=255, default='Tanzania')
    medical_history = models.TextField(null=True, blank=True)
    symptoms = models.TextField(null=True, blank=True)
    allergies = models.TextField(null=True, blank=True)
    medications = models.TextField(null=True, blank=True)
    family_history = models.TextField(null=True, blank=True)
    lifestyle = models.TextField(null=True, blank=True)
    specialty = models.CharField(max_length=100)
    license_number = models.CharField(max_length=100)
    experience_years = models.IntegerField()
    medical_school = models.CharField(max_length=200)
    hospital_affiliation = models.CharField(max_length=200)
    contact_info = models.TextField()
    full_name = models.CharField(max_length=200)


    @property
    def age(self):
        """Calculate age based on birth_date."""
        if self.birth_date:
            today = date.today()
            age = today.year - self.birth_date.year - (
                (today.month, today.day) < (self.birth_date.month, self.birth_date.day)
            )
            return age
        return None

    def __str__(self):
        return self.country

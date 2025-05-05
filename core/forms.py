from django import forms
from core.models import Profile

class ProfileForm(forms.ModelForm):
    class Meta:
        model = Profile
        fields = [
            'full_name', 'contact_info', 'birth_date', 'region', 'gender',
            'country', 'medical_history', 'symptoms', 'allergies', 'medications',
            'family_history', 'lifestyle'
        ]
        widgets = {
            'birth_date': forms.DateInput(attrs={'type': 'date'}),
        }
# Generated by Django 3.2.25 on 2025-04-10 20:03

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0003_alter_profile_medical_school'),
    ]

    operations = [
        migrations.AlterField(
            model_name='profile',
            name='symptoms',
            field=models.TextField(blank=True, default='', null=True),
        ),
    ]

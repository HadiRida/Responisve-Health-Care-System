# Generated by Django 3.2.25 on 2025-04-14 20:33

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0004_alter_profile_symptoms'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='medical',
            name='symptoms',
        ),
        migrations.AlterField(
            model_name='medical',
            name='full_name',
            field=models.CharField(max_length=200),
        ),
        migrations.AlterField(
            model_name='profile',
            name='experience_years',
            field=models.IntegerField(),
        ),
        migrations.AlterField(
            model_name='profile',
            name='medical_school',
            field=models.CharField(max_length=200),
        ),
        migrations.AlterField(
            model_name='profile',
            name='symptoms',
            field=models.TextField(blank=True, null=True),
        ),
        migrations.CreateModel(
            name='Diagnosis',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('symptoms', models.TextField()),
                ('disease', models.CharField(max_length=255)),
                ('confidence', models.FloatField()),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
        ),
    ]

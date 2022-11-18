from django.db import models

class party(models.Model):
    party_id = models.BigIntegerField(primary_key=True)
    party_name = models.CharField(max_length=100)
    class Meta:
        db_table = "party"

class minister(models.Model):
    minister_id = models.BigIntegerField()
    name = models.CharField(max_length=100)
    term_year = models.BigIntegerField()
    prime_minister = models.CharField(max_length=100)
    # party_id = models.ForeignKey(party,on_delete=models.CASCADE)
    party_id = models.BigIntegerField()
    state_name = models.CharField(primary_key=True,max_length=100)
    class Meta:
        db_table = "minister"

class list_of_cities(models.Model):
    pincode = models.BigIntegerField(primary_key=True)
    state_name = models.CharField(max_length=100)
    # state_name = models.ForeignKey(minister,on_delete=models.CASCADE)
    city_name = models.CharField(max_length=100)
    class Meta:
        db_table = "list_of_cities"
    
class all_schools(models.Model):
    affiliation_no = models.BigIntegerField(primary_key=True)
    school_name = models.CharField(max_length=100)
    region = models.CharField(max_length=100)
    board = models.CharField(max_length=10)
    is_primary = models.BooleanField()
    # pincode = models.ForeignKey(list_of_cities)
    pincode = models.BigIntegerField()
    class Meta:
        db_table = "all_schools"
    
class student(models.Model):
    student_id = models.BigIntegerField(primary_key=True)
    name = models.CharField(max_length=100)
    age = models.BigIntegerField()
    gender = models.CharField(max_length=10)
    enrollment_year = models.BigIntegerField()
    cast_name = models.CharField(max_length=100)
    financial_background = models.CharField(max_length=100)
    gaurdian_name = models.CharField(max_length=100)
    pass_out = models.BooleanField()
    # affiliation_no = models.ForeignKey(all_schools)
    affiliation_no = models.BigIntegerField()
    class Meta:
        db_table = "student"
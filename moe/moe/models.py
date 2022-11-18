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

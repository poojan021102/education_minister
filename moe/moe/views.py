from django.shortcuts import render
from .models import party
from django.contrib import messages
from .models import minister
def main_page(request):
    return render(request,"index.html")

def Party(request):
    if request.method == "GET":
        p = party.objects.all()
        return render(request,"view_party.html",{"party":p})
    
def insert_party(request):
    if request.method == "POST":
        if request.POST.get("party_id") and request.POST.get("party_name"):
            new_obj = party(party_id=request.POST.get("party_id"),party_name=request.POST.get("party_name"))
            new_obj.save()
            messages.success(request,"The party with party ID "+request.POST.get("party_id")+" is saved successfully")
            return render(request,"insert_party.html",{"party":party.objects.all()})
        else:
            messages.error(request,"Invalid Inputs")
            return render(request,'insert_party.html')
    else:
        return render(request,'insert_party.html')

def delete_party(request,id):
    d = party.objects.get(party_id=id)
    d.delete()
    return render(request,"view_party.html",{"party":party.objects.all()})




def Minister(request):
    d = minister.objects.all()
    return render(request,"view_minister.html",{"minister":d})
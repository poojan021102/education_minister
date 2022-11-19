from django.shortcuts import render
from .models import party
from django.contrib import messages
from .models import minister
from .models import all_schools
from .models import student
from .student_form import Studentforms
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
    messages.success(request,"The party with party ID "+id+" is deleted Succesfully")
    return render(request,"view_party.html",{"party":party.objects.all()})




def Minister(request):
    d = minister.objects.all()
    return render(request,"view_minister.html",{"minister":d})


def School(request):
    d = all_schools.objects.all()
    return render(request,"school_view.html",{"school":d})

def Student(request):
    d = student.objects.all()
    return render(request,"student_view.html",{"student":d})

def delete_student(request,id):
    d = student.objects.get(student_id=id)
    d.delete()
    messages.success(request,'The student with student id '+str(id)+" is deleted Successfully")
    return render(request,"student_view.html",{"student":student.objects.all()})

def edit_student(request,id):
    if request.method == "POST":
        updatstudent = student.objects.get(student_id=id)
        form =Studentforms(request.POST,instance=updatstudent)
        if form.is_valid():
            form.save()
            messages.success(request,'Record Updated Successfully')
            return render(request,"edit_student_page.html",{'student':student.objects.get(student_id=id)})
        else:
            messages.error(request,"Unable to edit the record")
            return render(request,"edit_student_page.html",{"student":student.objects.get(student_id = id)})
    else:
        return render(request,"edit_student_page.html",{"student":student.objects.get(student_id=id)})

def insert_student(request):
    if request.method == "POST":
        new_student = student()
        new_student.student_id = request.POST.get("student_id")
        new_student.name = request.POST.get("name")
        new_student.age = request.POST.get("age")
        new_student.gender = request.POST.get('gender')
        new_student.standard = request.POST.get("standard")
        new_student.enrollment_year = request.POST.get('enrollment_year')
        new_student.cast_name = request.POST.get("cast_name")
        new_student.financial_background = request.POST.get('financial_background')
        new_student.gaurdian_name = request.POST.get("gaurdian_name")
        new_student.pass_out = request.POST.get("pass_out")
        new_student.affiliation_no = request.POST.get("affiliation_no")
        new_student.save()
        messages.success(request,"Student with studentID "+request.POST.get("student_id")+" is added successfully")
        return render(request,"insert_student.html")
    else:
        return render(request,"insert_student.html")

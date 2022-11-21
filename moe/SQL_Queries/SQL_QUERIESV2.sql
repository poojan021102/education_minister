-- To print out all the student name who are male
select name
from education_minister.student
where gender='Male'

-- To print the details of teachers who are female
select *
from education_minister.teacher
where gender='Female'

-- To print the details of education minsiter of Gujarat
select *
from education_minister.minister
where state_name='gujarat'

-- Find the number of all education minister belongs to party with party ID in descending order of count
select party_id,count(name)
from education_minister.minister
group by party_id
order by count(name) desc

-- Find the details of party whose party ID is 1
select *
from education_minister.party
where party_id = 1


-- To find the number of government schemes of a particular school with affiliation number in descending order
select affiliation_no, count(scheme_name)
from education_minister.government_schemes
group by affiliation_no
order by count(scheme_name) desc

-- To find the number of facilities of a particular school with affiliation number in ascending order
select affiliation_no, count(facility_name)
from education_minister.facilities
group by affiliation_no
order by count(facility_name) asc

-- To find the affiliation number of schools which have library facility
select affiliation_no
from education_minister.facilities
where facility_name = 'Library'

-- To find the details of school whose pincode is 388412
select *
from education_minister.all_schools
where affiliation_no=388412

-- To find the number of schools in urban and rural region
select region,count(affiliation_no)
from education_minister.all_schools
group by region

-- To find the No. of male, female and trans students in each school
create or replace view education_minister.male_std_count as
select s1.affiliation_no,count(s1.gender)
from education_minister.student as s1 join education_minister.all_schools as s2
on s2.affiliation_no = s1.affiliation_no
where s1.gender='Male' 
group by s1.affiliation_no

alter table education_minister.male_std_count
rename column affiliation_no to school_id


alter table education_minister.male_std_count
rename column count to Male

--
create or replace view education_minister.female_std_count as
select s1.affiliation_no,count(s1.gender)
from education_minister.student as s1 join education_minister.all_schools as s2
on s2.affiliation_no = s1.affiliation_no
where s1.gender='Female' 
group by s1.affiliation_no

alter table education_minister.female_std_count
rename column affiliation_no to school_id


alter table education_minister.female_std_count
rename column count to Female
--
create or replace view education_minister.trans_std_count as
select s1.affiliation_no,count(s1.gender)
from education_minister.student as s1 join education_minister.all_schools as s2
on s2.affiliation_no = s1.affiliation_no
where s1.gender='Trans' 
group by s1.affiliation_no

alter table education_minister.trans_std_count
rename column affiliation_no to school_id


alter table education_minister.trans_std_count
rename column count to Trans

SELECT s4.school_id,s4.male,s4.female,s3.trans
from (select s1.school_id,s1.male,s2.female from education_minister.male_std_count as s1 join education_minister.female_std_count as s2 on s1.school_id=s2.school_id) as s4
join education_minister.trans_std_count as s3
on s4.school_id=s3.school_id

-- To find student name, student id affiliated with each school
select s1.student_id,s1."name",s2.affiliation_no,s2.school_name
from education_minister.student as s1 join education_minister.all_schools as s2
on s1.affiliation_no = s2.affiliation_no

-- Count the number of facility in each school
se
select s1.school_name,count(s2.facility_name) as facilities
from education_minister.all_schools as s1 join education_minister.facilities as s2
on s1.affiliation_no = s2.affiliation_no
group by s1.school_name

--Count pass_out ratio in each school

select t1.affiliation_no,(cast(((t1.Pass_out/t2.total_count)*100) as double precision)||'%')
from(
select s1.affiliation_no,cast(count(pass_out) as double PRECISION) as Pass_Out
from education_minister.all_schools as s1 join education_minister.student as s2 
on  s1.affiliation_no = s2.affiliation_no
where s2.pass_out=true
group by s1.affiliation_no
) as t1 join
(
select affiliation_no, cast(count(affiliation_no) as double precision) as total_count
from education_minister.student
group by affiliation_no
) as t2 on t1.affiliation_no = t2.affiliation_no


--Show Education minister with it's respective party
SELECT s1.state_name,s1.minister_id,s1."name",s2.party_id,s2.party_name
from education_minister.minister as s1 join education_minister.party as s2
on s1.party_id = s2.party_id

-- --Percentage of student in rural vs urban in Gujrat state 
-- select s1.affiliation_no
-- from education_minister.list_of_all_cities as s1 natural join education_minister.all_schools as s2
-- on s1.pincode = s2.pincode
-- where s1.state_name='gujrat'

-- select s1.affiliation_no,s1.
-- from education_minister.all_schools as t1 natural join (
-- 	select s1.affiliation_no
-- from education_minister.list_of_all_cities as s1 inner join education_minister.all_schools as s2
-- on s1.pincode = s2.pincode
-- where s1.state_name='gujrat'
-- ) as t2
-- on t1.affiliation_no=t2.affiliation_no

--Find out how many schools are in each state in ascending order of the count of school.
select s2.state_name,count(s1.affiliation_no)
from education_minister.all_schools as s1 join education_minister.list_of_all_cities as s2
on s2.pincode = s1.pincode
group by s2.state_name
order by count(s1.affiliation_no)

--To get the count of how many schools are there in urban and rural region in each city
select t1.state_name as State,t1.rural,t2.urban
from(
	select s2.state_name,count(s1.region) as rural
	from education_minister.all_schools as s1 full join education_minister.list_of_all_cities as s2
	on s2.pincode = s1.pincode
	where s1.region='RURAL'
	group by s2.state_name)
as t1 full join (
	select s2.state_name,count(s1.region) as urban
	from education_minister.all_schools as s1 full join education_minister.list_of_all_cities as s2
	on s2.pincode = s1.pincode	
	where s1.region='URBAN'
	group by s2.state_name
) as t2
on t1.state_name=t2.state_name
--To get the ration of  schools  in urban and rural region in each state
CREATE OR REPLACE FUNCTION education_minister.rural_to_urban_ratio(rural double precision,urban double precision)
returns double precision
language 'plpgsql'
as
$BODY$
DECLARE ratio double precision;
BEGIN
	ratio = rural/urban;
	return ratio;
END
$BODY$ 

select t1.state_name as State,education_minister.rural_to_urban_ratio(cast(t1.rural as double precision),cast(t2.urban as double precision))
from(
	select s2.state_name,count(s1.region) as rural
	from education_minister.all_schools as s1 full join education_minister.list_of_all_cities as s2
	on s2.pincode = s1.pincode
	where s1.region='RURAL'
	group by s2.state_name)
as t1 full join (
	select s2.state_name,count(s1.region) as urban
	from education_minister.all_schools as s1 full join education_minister.list_of_all_cities as s2
	on s2.pincode = s1.pincode	
	where s1.region='URBAN'
	group by s2.state_name
) as t2
on t1.state_name=t2.state_name
--to count teachers in each state
select t2.state_name,count(t1.teacher_id)
from(
select s2.pincode,s1.teacher_id
from education_minister.teacher as s1 join education_minister.all_schools as s2
on s1.affiliation_no = s2.affiliation_no
) as t1 right join education_minister.list_of_all_cities as t2
on t1.pincode = t2.pincode
group by t2.state_name





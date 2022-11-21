-- Trigger and Function for inserting in cities
-- CREATE OR REPLACE FUNCTION education_minister.insert_cities()
-- returns trigger
-- language 'plpgsql'
-- as
-- $BODY$
-- DECLARE
-- BEGIN
	
--     if(new.pincode is null or new.state_name = 'null') 
-- 		THEN return old;
-- 	else return new;
-- 	end if;
-- END
-- $BODY$ 
-- -- 
-- create or replace trigger insert_in_cities
-- before insert on education_minister.list_of_all_cities
-- for each row
-- execute function education_minister.insert_cities();
-- 
-- Trigger and Function  for inserting in government schemes
-- CREATE OR REPLACE FUNCTION education_minister.insert_schemes()
-- returns trigger
-- language 'plpgsql'
-- as
-- $BODY$
-- DECLARE
-- BEGIN
	
--     if(new.affiliation_no is null or new.scheme_name is null ) 
-- 		THEN return old;
-- 	else return new;
-- 	end if;
-- END
-- $BODY$ 

-- create or replace trigger insert_in_schemes
-- before insert on education_minister.government_schemes
-- for each row
-- execute function education_minister.insert_schemes();

-- Trigger and Functions for inserting in Facilities
-- CREATE OR REPLACE FUNCTION education_minister.insert_facility()
-- returns trigger
-- language 'plpgsql'
-- as
-- $BODY$
-- DECLARE
-- BEGIN
	
--     if(new.affiliation_no is null or new.facility_name is null ) 
-- 		THEN return old;
-- 	else return new;
-- 	end if;
-- END
-- $BODY$ 

-- create or replace trigger insert_in_facility
-- before insert on education_minister.facilities
-- for each row
-- execute function education_minister.insert_facility();

-- -- 
-- CREATE OR REPLACE FUNCTION education_minister.insert_teacher()
-- returns trigger
-- language 'plpgsql'
-- as
-- $BODY$
-- DECLARE
-- BEGIN
	
--     if(new.affiliation_no is null or new.teacher_id is null ) 
-- 		THEN return old;
-- 	else return new;
-- 	end if;
-- END
-- $BODY$ 

-- create or replace trigger insert_in_teacher
-- before insert on education_minister.teacher
-- for each row
-- execute function education_minister.insert_teacher();

-- 
CREATE OR REPLACE FUNCTION education_minister.insert_student()
returns trigger
language 'plpgsql'
as
$BODY$
DECLARE
BEGIN
	
    if(new.affiliation_no is null or new.student_id is null or new.name is null ) 
		THEN return old;
	else return new;
	end if;
END
$BODY$ 

create or replace trigger insert_in_student
before insert on education_minister.student
for each row
execute function education_minister.insert_student();

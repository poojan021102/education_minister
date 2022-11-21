-- Creating the table for list_of_all_states
-- CREATE TABLE IF NOT EXISTS education_minister.list_of_all_state
-- (
--     state_name character varying COLLATE pg_catalog."default" NOT NULL,
--     CONSTRAINT list_of_all_state_pkey PRIMARY KEY (state_name)
-- )
--removing this table after normalization

-- Creating the table for party
create table if not exists education_minister.party(
	party_id bigint primary key,
	party_name character varying not null
)

-- Creating the table for minister
create table if not exists education_minister.minister(
	minister_id bigint unique,
	name character varying not null,
	term_year bigint not null,
	prime_minister character varying not null,
	party_id bigint not null,
	state_name character varying not null,
	primary key(state_name),
	foreign key(party_id) references education_minister.party(party_id)
	on delete set default on update cascade
)

-- Creating the table for list_of_all_cities
create table if not exists education_minister.list_of_all_cities(
	pincode bigint primary key,
	state_name character varying not null,
	city_name character varying not null,
	foreign key(state_name) references education_minister.minister(state_name) on delete set null
	on update cascade
)


-- Creating the table for all_schools
create table if not exists education_minister.all_schools(
	affiliation_no bigint primary key,
	school_name character varying not null,
	region character varying,
	board character varying,
	is_primary BOOLEAN,
	pincode bigint not null,
	foreign key(pincode) references education_minister.list_of_all_cities(pincode)
	on delete set default
)

-- Creating the table for government_schemes
create table if not exists education_minister.government_schemes(
	scheme_name character varying,
	affiliation_no bigint,
	primary key(scheme_name,affiliation_no),
	foreign key(affiliation_no) references education_minister.all_schools(affiliation_no)
	on delete cascade
	on update cascade
)

-- Creating the table for facilities
create table if not exists education_minister.facilities(
	facility_name character varying,
	affiliation_no bigint,
	primary key(facility_name,affiliation_no),
	foreign key(affiliation_no) references education_minister.all_schools(affiliation_no)
	on delete cascade
	on update cascade
)

-- Creating the table for teacher
create table if not exists education_minister.teacher(
	teacher_id bigint primary key,
	name character varying not null,
	gender character varying not null,
	affiliation_no bigint not null,
	foreign key(affiliation_no) references education_minister.all_schools(affiliation_no)
	on delete set default on update cascade
)

-- creating student table
CREATE TABLE IF NOT EXISTS education_minister.student
(
    student_id bigint NOT NULL,
    name character varying not null COLLATE pg_catalog."default",
    age bigint,
    gender character varying COLLATE pg_catalog."default",
    standard integer,
    enrollment_year bigint,
    cast_name character varying COLLATE pg_catalog."default",
    financial_background character varying COLLATE pg_catalog."default",
    gaurdian_name character varying COLLATE pg_catalog."default",
    pass_out boolean DEFAULT false,
    affiliation_no bigint,
    CONSTRAINT student_pkey PRIMARY KEY (student_id),
    CONSTRAINT student_affiliation_no_fkey FOREIGN KEY (affiliation_no)
        REFERENCES education_minister.all_schools (affiliation_no) MATCH SIMPLE
        ON UPDATE cascade
        ON DELETE set default
)
CREATE TABLE PUBLIC.PUBLIC.roles (
id INTEGER GENERATED BY DEFAULT AS IDENTITY(START WITH 1) PRIMARY KEY,
name VARCHAR(32)
);

CREATE TABLE PUBLIC.PUBLIC.user_accounts (
id INTEGER GENERATED BY DEFAULT AS IDENTITY(START WITH 1) PRIMARY KEY,
telephone VARCHAR(16) UNIQUE NOT NULL,
email VARCHAR(64) UNIQUE NOT NULL,
confirm_email BOOLEAN DEFAULT FALSE,
password VARCHAR(128),
role_id INTEGER,
session_id VARCHAR(64),
created_by DATE DEFAULT CURRENT_DATE,
FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE SET NULL
);

CREATE TABLE PUBLIC.PUBLIC.contragent (
id INTEGER GENERATED BY DEFAULT AS IDENTITY(START WITH 1) PRIMARY KEY,
name VARCHAR(16) NOT NULL,
surname VARCHAR(16) NOT NULL,
patronymic VARCHAR(16),
account_id INTEGER,
birtday DATE,
passport_series INTEGER,
passport_id INTEGER,
date_of_issue_of_passport VARCHAR(128),
registration_address_of_passport VARCHAR(128),
FOREIGN KEY (account_id) REFERENCES user_accounts(id)
);

CREATE TABLE PUBLIC.PUBLIC.position_staff (
id INTEGER GENERATED BY DEFAULT AS IDENTITY(START WITH 1) PRIMARY KEY,
name_position VARCHAR(32) UNIQUE NOT NULL
);

CREATE TABLE PUBLIC.PUBLIC.staff_master (
id INTEGER GENERATED BY DEFAULT AS IDENTITY(START WITH 1) PRIMARY KEY,
name VARCHAR(16) NOT NULL,
surname VARCHAR(16) NOT NULL,
patronymic VARCHAR(16),
account_id INTEGER UNIQUE NOT NULL,
FOREIGN KEY (account_id) REFERENCES user_accounts(id)
);

CREATE TABLE PUBLIC.PUBLIC.staff_mechanic (
id INTEGER GENERATED BY DEFAULT AS IDENTITY(START WITH 1) PRIMARY KEY,
name VARCHAR(16) NOT NULL,
surname VARCHAR(16) NOT NULL,
patronymic VARCHAR(16),
patron_id INTEGER,
FOREIGN KEY (patron_id) REFERENCES staff_master(id)
);

CREATE TABLE PUBLIC.PUBLIC.engine (
id INTEGER GENERATED BY DEFAULT AS IDENTITY(START WITH 1) PRIMARY KEY,
letter_designation VARCHAR(32) UNIQUE,
displacement DOUBLE,
injection_type VARCHAR(8),
power_kwt INTEGER,
power_hp INTEGER,
fuel_type VARCHAR(8)
);

CREATE TABLE PUBLIC.PUBLIC.transmission (
id INTEGER GENERATED BY DEFAULT AS IDENTITY(START WITH 1) PRIMARY KEY,
letter_designation VARCHAR(16) UNIQUE,
gear_number INTEGER,
type_tm VARCHAR(16),
oil BOOLEAN
);

CREATE TABLE PUBLIC.PUBLIC.brand_auto (
id INTEGER GENERATED BY DEFAULT AS IDENTITY(START WITH 1) PRIMARY KEY,
brand VARCHAR(32) UNIQUE
);

CREATE TABLE PUBLIC.PUBLIC.model_auto (
id INTEGER GENERATED BY DEFAULT AS IDENTITY(START WITH 1) PRIMARY KEY,
brand_id INTEGER,
model VARCHAR(32) UNIQUE,
CONSTRAINT id_fk_br FOREIGN KEY (brand_id) REFERENCES brand_auto(id)
);

CREATE TABLE PUBLIC.PUBLIC.body_auto (
id INTEGER GENERATED BY DEFAULT AS IDENTITY(START WITH 1) PRIMARY KEY,
body VARCHAR(32) UNIQUE
);

CREATE TABLE PUBLIC.PUBLIC.template_auto (
id INTEGER GENERATED BY DEFAULT AS IDENTITY(START WITH 1) PRIMARY KEY,
model_id INTEGER,
eng_id INTEGER,
trans_id INTEGER,
cost_standard_hour DOUBLE,
FOREIGN KEY (model_id) REFERENCES model_auto(id),
FOREIGN KEY (eng_id) REFERENCES engine(id),
FOREIGN KEY (trans_id) REFERENCES transmission(id),
);

CREATE TABLE PUBLIC.PUBLIC.list_of_labor (
id INTEGER GENERATED BY DEFAULT AS IDENTITY(START WITH 1) PRIMARY KEY,
name VARCHAR(128)
);

CREATE TABLE PUBLIC.PUBLIC.parts_order (
id INTEGER GENERATED BY DEFAULT AS IDENTITY(START WITH 1) PRIMARY KEY,
template_auto_id INTEGER,
part_id INT ARRAY[10],
amount_parts INT ARRAY[10],
labor_id INTEGER,
amount_standard_hour DOUBLE,
mileage INT ARRAY[11],
age_auto INT ARRAY[10],
FOREIGN KEY (template_auto_id) REFERENCES template_auto(id),
FOREIGN KEY (labor_id) REFERENCES list_of_labor(id)
);

CREATE TABLE PUBLIC.PUBLIC.contragent_auto (
id INTEGER GENERATED BY DEFAULT AS IDENTITY(START WITH 1) PRIMARY KEY,
contragent_id INTEGER,
template_auto_id INTEGER,
plate_number VARCHAR(16),
vin VARCHAR(17),
FOREIGN KEY (contragent_id) REFERENCES contragent(id),
FOREIGN KEY (template_auto_id) REFERENCES template_auto(id)
);

CREATE TABLE PUBLIC.PUBLIC.orders (
id INTEGER GENERATED BY DEFAULT AS IDENTITY(START WITH 1) PRIMARY KEY,
order_number VARCHAR(128) UNIQUE NOT NULL,
contragent_id INTEGER,
contragent_auto_id INTEGER,
mechanic_id INTEGER,
date_of_creation DATE DEFAULT CURRENT_DATE,
date_of_recording DATE,
hour_of_recording VARCHAR(5),
FOREIGN KEY (contragent_id) REFERENCES contragent(id),
FOREIGN KEY (contragent_auto_id) REFERENCES contragent_auto(id),
FOREIGN KEY (mechanic_id) REFERENCES staff_mechanic(id)
);

CREATE TABLE PUBLIC.PUBLIC.months (
id INTEGER GENERATED BY DEFAULT AS IDENTITY(START WITH 1) PRIMARY KEY,
name VARCHAR(9),
);

CREATE TABLE PUBLIC.PUBLIC.staff_work_schedule (
id INTEGER GENERATED BY DEFAULT AS IDENTITY(START WITH 1) PRIMARY KEY,
staff_id INTEGER,
year_ INTEGER,
month_id INTEGER,
working_days INT ARRAY [31],
working_times INT ARRAY [31],
working_hours OTHER,
FOREIGN KEY (staff_id) REFERENCES staff_mechanic(id),
FOREIGN KEY (month_id) REFERENCES months(id)
);

CREATE TABLE PUBLIC.PUBLIC.parts (
id INTEGER GENERATED BY DEFAULT AS IDENTITY(START WITH 1) PRIMARY KEY,
name VARCHAR(128),
price DOUBLE
);

CREATE TABLE PUBLIC.PUBLIC.time_matrix (
id INTEGER GENERATED BY DEFAULT AS IDENTITY(START WITH 1),
mechanic_id INTEGER,
year_ INTEGER,
month_id INTEGER,
"1" INTEGER ARRAY[24],
"2" INTEGER ARRAY[24],
"3" INTEGER ARRAY[24],
"4" INTEGER ARRAY[24],
"5" INTEGER ARRAY[24],
"6" INTEGER ARRAY[24],
"7" INTEGER ARRAY[24],
"8" INTEGER ARRAY[24],
"9" INTEGER ARRAY[24],
"10" INTEGER ARRAY[24],
"11" INTEGER ARRAY[24],
"12" INTEGER ARRAY[24],
"13" INTEGER ARRAY[24],
"14" INTEGER ARRAY[24],
"15" INTEGER ARRAY[24],
"16" INTEGER ARRAY[24],
"17" INTEGER ARRAY[24],
"18" INTEGER ARRAY[24],
"19" INTEGER ARRAY[24],
"20" INTEGER ARRAY[24],
"21" INTEGER ARRAY[24],
"22" INTEGER ARRAY[24],
"23" INTEGER ARRAY[24],
"24" INTEGER ARRAY[24],
"25" INTEGER ARRAY[24],
"26" INTEGER ARRAY[24],
"27" INTEGER ARRAY[24],
"28" INTEGER ARRAY[24],
"29" INTEGER ARRAY[24],
"30" INTEGER ARRAY[24],
"31" INTEGER ARRAY[24],
PRIMARY KEY (mechanic_id, year_, month_id),
FOREIGN KEY (mechanic_id) REFERENCES staff_mechanic(id),
FOREIGN KEY (month_id) REFERENCES months(id)
);

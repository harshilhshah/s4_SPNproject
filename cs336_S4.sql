CREATE SCHEMA cs336_s4;
USE cs336_s4;

CREATE TABLE student (
netid INT,
`password` VARCHAR(50),
s_name VARCHAR(100),
credits INT,
gpa DEC(4,2),
major VARCHAR(50),
PRIMARY KEY (netid));

CREATE TABLE professor (
p_id INT,
`password` VARCHAR(50),
p_name VARCHAR(100),
PRIMARY KEY (p_id));

CREATE TABLE department (
dept_id INT,
d_name VARCHAR(50),
PRIMARY KEY(dept_id));

CREATE TABLE course (
c_id INT,
dept_id INT,
c_name VARCHAR(50),
prereq_id INT,
PRIMARY KEY (c_id),
FOREIGN KEY (dept_id) REFERENCES department (dept_id)
ON DELETE cascade ON UPDATE cascade);

CREATE TABLE prereq (
prereq_id INT,
c_id INT,
PRIMARY KEY (prereq_id, c_id),
FOREIGN KEY (c_id) REFERENCES course (c_id)
ON DELETE cascade ON UPDATE cascade);

ALTER TABLE course ADD CONSTRAINT
FOREIGN KEY (prereq_id) REFERENCES prereq (prereq_id)
ON DELETE cascade ON UPDATE cascade;

CREATE TABLE class (
c_id INT,
capacity INT,
start_time time,
end_time time,
building VARCHAR(50),
room_num INT,
semester INT,
dept_id INT,
PRIMARY KEY (c_id, semester, dept_id),
FOREIGN KEY (c_id) REFERENCES course (c_id)
ON DELETE cascade ON UPDATE cascade,
FOREIGN KEY (dept_id) REFERENCES department (dept_id)
ON DELETE cascade ON UPDATE cascade);

CREATE TABLE teaching (
p_id INT,
c_id INT,
semester INT,
PRIMARY KEY (p_id, c_id, semester),
FOREIGN KEY (p_id) REFERENCES professor (p_id)
ON DELETE cascade ON UPDATE cascade,
FOREIGN KEY (c_id, semester) REFERENCES class (c_id, semester)
ON DELETE cascade ON UPDATE cascade);

CREATE TABLE enrolled (
netid INT,
c_id INT,
semester INT,
PRIMARY KEY (netid, c_id, semester),
FOREIGN KEY (c_id, semester) REFERENCES class (c_id, semester)
ON DELETE cascade ON UPDATE cascade,
FOREIGN KEY (netid) REFERENCES student (netid)
ON DELETE cascade ON UPDATE cascade);

CREATE TABLE taken (
netid INT,
grade INT,
c_id INT,
semester INT,
PRIMARY KEY (netid, c_id, semester),
FOREIGN KEY (netid) REFERENCES student (netid)
ON DELETE cascade ON UPDATE cascade);

CREATE TABLE permission (
c_id INT,
semester INT,
netid INT,
p_id INT,
spn INT,
`status` INT,
dept_id INT,
PRIMARY KEY(c_id, semester, dept_id, netid, spn),
UNIQUE KEY (spn),
FOREIGN KEY (c_id, semester) REFERENCES class (c_id, semester)
ON DELETE cascade ON UPDATE cascade,
FOREIGN KEY (dept_id) REFERENCES department (dept_id)
ON DELETE cascade ON UPDATE cascade,
FOREIGN KEY (netid) REFERENCES student (netid)
ON DELETE cascade ON UPDATE cascade);

-- When a SPN is updated, check if it is changed to a 'yes' (1). if so move to enrolled
DELIMITER //
CREATE TRIGGER `check_status` AFTER UPDATE ON permission
FOR EACH ROW BEGIN
IF NEW.`status` = 1 THEN 
INSERT INTO `enrolled` (netid, c_id, semester) VALUES (NEW.netid, NEW.c_id, NEW.semester);
END IF;
END //

-- After class completes, place into taken
DELIMITER //
CREATE TRIGGER `enrolled_to_taken` BEFORE DELETE ON enrolled
FOR EACH ROW BEGIN
INSERT INTO taken (netid, c_id, semester) VALUES (OLD.netid, OLD.c_id, OLD.semester);
END //


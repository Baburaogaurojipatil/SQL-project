    create database school_management_system;
    use school_management_system;
    CREATE TABLE Students (
    StudentID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DOB DATE,
    Gender ENUM('Male', 'Female', 'Other'),
    Address VARCHAR(255),
    PhoneNumber VARCHAR(15),
    Email VARCHAR(100),
    EnrollmentDate DATE
);
INSERT INTO Students (FirstName, LastName, DOB, Gender, Address, PhoneNumber, Email, EnrollmentDate)
VALUES
('John', 'Doe', '2005-05-15', 'Male', '123 Main St', '1234567890', 'john.doe@example.com', '2022-08-01'),
('Jane', 'Smith', '2006-03-22', 'Female', '456 Elm St', '0987654321', 'jane.smith@example.com', '2022-08-01');

CREATE TABLE Teachers (
    TeacherID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Subject VARCHAR(100),
    HireDate DATE,
    PhoneNumber VARCHAR(15),
    Email VARCHAR(100)
);
INSERT INTO Teachers (FirstName, LastName, Subject, HireDate, PhoneNumber, Email)
VALUES
('Alice', 'Johnson', 'Mathematics', '2018-09-01', '1122334455', 'alice.johnson@example.com'),
('Bob', 'Brown', 'Science', '2020-01-15', '2233445566', 'bob.brown@example.com');

CREATE TABLE Courses (
    CourseID INT PRIMARY KEY AUTO_INCREMENT,
    CourseName VARCHAR(100),
    Description TEXT,
    Credits INT
);
INSERT INTO Courses (CourseName, Description, Credits)
VALUES
('Mathematics', 'Basic math principles', 3),
('Science', 'Fundamentals of Physics and Chemistry', 4);

CREATE TABLE Classrooms (
    ClassroomID INT PRIMARY KEY AUTO_INCREMENT,
    RoomNumber VARCHAR(10),
    Capacity INT
);

INSERT INTO Classrooms (RoomNumber, Capacity)
VALUES
('A101', 30),
('B202', 25),
('C303', 40),
('D404', 35);

CREATE TABLE ClassSchedule (
    ScheduleID INT PRIMARY KEY AUTO_INCREMENT,
    CourseID INT,
    ClassroomID INT,
    TeacherID INT,
    DayOfWeek ENUM('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'),
    StartTime TIME,
    EndTime TIME,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID),
    FOREIGN KEY (ClassroomID) REFERENCES Classrooms(ClassroomID),
    FOREIGN KEY (TeacherID) REFERENCES Teachers(TeacherID)
);


INSERT INTO ClassSchedule (CourseID, ClassroomID, TeacherID, DayOfWeek, StartTime, EndTime)
VALUES
(1, 1, 1, 'Monday', '09:00:00', '10:30:00'), -- Mathematics in A101 by Alice
(2, 2, 2, 'Monday', '11:00:00', '12:30:00'), -- Science in B202 by Bob
(1, 3, 1, 'Wednesday', '10:00:00', '11:30:00'), -- Mathematics in C303 by Alice
(2, 4, 2, 'Friday', '13:00:00', '14:30:00'); -- Science in D404 by Bob

CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID INT,
    CourseID INT,
    EnrollmentDate DATE,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

INSERT INTO Enrollments (StudentID, CourseID, EnrollmentDate)
VALUES
(1, 1, '2024-01-10'), -- John enrolled in Mathematics
(1, 2, '2024-01-15'), -- John enrolled in Science
(2, 1, '2024-01-12'), -- Jane enrolled in Mathematics
(2, 2, '2024-01-20'); -- Jane enrolled in Science

SELECT * FROM Classrooms;

SELECT CourseName, Credits FROM Courses;

SELECT s.FirstName, s.LastName 
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
JOIN Courses c ON e.CourseID = c.CourseID
WHERE c.CourseName = 'Mathematics';

SELECT * 
FROM Classrooms
WHERE RoomNumber = 'A101';

SELECT RoomNumber, Capacity 
FROM Classrooms
WHERE Capacity > 30;

-- 1. SELECT with WHERE: Find students enrolled after '2024-01-15'
SELECT * 
FROM Students 
WHERE EnrollmentDate > '2024-01-15';

-- 2. UPDATE: Update the capacity of a specific classroom
UPDATE Classrooms 
SET Capacity = 50 
WHERE RoomNumber = 'A101';

-- 3. DELETE: Remove a student by their StudentID
DELETE FROM Students 
WHERE StudentID = 2;

-- 4. GROUP BY: Count students grouped by gender
SELECT Gender, COUNT(*) AS TotalStudents
FROM Students
GROUP BY Gender;

-- 5. ORDER BY: List all teachers ordered by their hire date
SELECT FirstName, LastName, HireDate 
FROM Teachers 
ORDER BY HireDate;

-- 6. ALTER TABLE: Add a new column for EmergencyContact to Students
ALTER TABLE Students 
ADD EmergencyContact VARCHAR(15);

-- 7. WHERE with IN: Find teachers teaching Mathematics or Science
SELECT FirstName, LastName 
FROM Teachers 
WHERE Subject IN ('Mathematics', 'Science');

-- 8. HAVING: Find courses with more than 1 enrolled student
SELECT c.CourseName, COUNT(e.StudentID) AS EnrolledStudents
FROM Courses c
JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY c.CourseName
HAVING COUNT(e.StudentID) > 1;

-- 9. SELECT with ORDER BY: List all courses sorted by credits (descending)
SELECT CourseName, Credits 
FROM Courses 
ORDER BY Credits DESC;

-- 10. DELETE: Remove all enrollments for a specific course
DELETE FROM Enrollments 
WHERE CourseID = 2;














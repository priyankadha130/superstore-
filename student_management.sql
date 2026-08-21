create database Student_Management_System;
use Student_Management_System;

-- 1. SQL basics
-- Q1. Display all student records.
select * from student_management_dataset;

-- Q2. Display only student ID, name and department.
SELECT Student_ID, Student_Name, Department
FROM student_management_dataset;

-- Q3. Display unique departments.
SELECT DISTINCT Department
FROM student_management_dataset;

-- Q4. Display unique courses.
SELECT DISTINCT Course
FROM student_management_dataset;


-- Q6. Display students who scored more than 75 marks.
SELECT Total_Marks,Student_Name
FROM student_management_dataset
WHERE Total_Marks > 75;

-- Q7. Display students who scored less than 40 marks.
SELECT Total_Marks,Student_Name
FROM student_management_dataset
WHERE Total_Marks < 40;

-- Q8. Display students whose attendance is below 75.
SELECT Student_Name,Attendance
FROM student_management_dataset
WHERE Attendance < 75;

-- Q9. Display students whose marks are between 60 and 80.
SELECT Student_Name,Total_Marks
FROM student_management_dataset
WHERE Total_Marks BETWEEN 60 AND 80;

-- Q10. Display students from the Data Science department.
SELECT Student_Name,department
FROM student_management_dataset
WHERE Department = 'Data Science';

-- Q11. Display students from Data Science or Computer Science.
SELECT department,Student_Name
FROM student_management_dataset
WHERE Department IN ('Data Science', 'Computer Science');

-- Q12. Display students whose names start with 'A'.
SELECT Student_Name
FROM student_management_dataset
WHERE Student_Name LIKE 'A%';

-- Q13. Display students whose names contain 'a'.
SELECT Student_Name
FROM student_management_dataset
WHERE Student_Name LIKE '%a%';

-- Q14. Display students who have good marks AND good attendance.
SELECT Student_Name,Total_Marks
FROM student_management_dataset
WHERE Total_Marks >= 75
AND Attendance >= 75;

--  ORDER BY
-- Q16. Display students according to marks from highest to lowest.
SELECT Student_Name,Total_Marks
FROM student_management_dataset
ORDER BY Total_Marks DESC;

  -- Q17. Display students according to marks from lowest to highest.
SELECT Student_Name,Total_Marks
FROM student_management_dataset
ORDER BY Total_Marks ASC;

-- Q18. Display students alphabetically by name.
SELECT Student_Name
FROM student_management_dataset
ORDER BY Student_Name ASC;

-- Q19. Sort students by department and then by marks.
SELECT Department,Total_Marks
FROM student_management_dataset
ORDER BY Department ASC, Total_Marks DESC;

-- Q20. Display the top 5 students.
SELECT Student_Name,Total_Marks
FROM student_management_dataset
ORDER BY Total_Marks DESC
LIMIT 5;

-- Aggregate Functions
-- Q21. Find the total number of students.
SELECT COUNT(*) AS Total_Students
FROM student_management_dataset;

-- Q22. Find the average marks of all students.
SELECT AVG(Total_Marks) AS Average_Marks
FROM student_management_dataset;

-- Q23. Find the highest marks.
SELECT MAX(Total_Marks) AS Highest_Marks
FROM student_management_dataset;

-- Q24. Find the lowest marks.
SELECT MIN(Total_Marks) AS Highest_Marks
FROM student_management_dataset;

--  Q25. Find the total fees collected.
SELECT SUM(Annual_Fees) as Total_fees
FROM student_management_dataset;

-- GROUP BY
-- Q26. Find department-wise number of students.
SELECT Department, COUNT(*) AS Total_Students
FROM student_management_dataset
GROUP BY Department;

-- Q27. Find course-wise number of students.
SELECT Course, COUNT(*) AS Total_Students
FROM student_management_dataset
GROUP BY Course;

-- HAVING
-- Q28. Find departments having more than 5 students.
SELECT Department,COUNT(*) AS Total_Students
FROM student_management_dataset
GROUP BY Department
HAVING COUNT(*) > 5;

-- 29. Find departments where average marks are greater than 60.
SELECT Department, AVG(Total_Marks) AS Average_Marks
FROM student_management_dataset
GROUP BY Department
HAVING AVG(Total_Marks) > 60;

-- 30. Find courses having more than 3 students.
SELECT Course, COUNT(*) AS Total_Students
FROM student_management_dataset
GROUP BY Course
HAVING COUNT(*) > 3;

-- UPDATE
-- 31.Update marks of student ID 1.
SET SQL_SAFE_UPDATES = 0;
UPDATE student_management_dataset
SET Total_Marks = 85
WHERE Student_ID = 1;

-- Q31. Update attendance of student ID 1.
UPDATE student_management_dataset
SET Attendance = 90
WHERE Student_ID = 3;

-- Q32. Update marks and attendance together.
UPDATE student_management_dataset
SET total_Marks = 88, Attendance = 92
WHERE Student_ID = 1;

-- Constraints
-- Q33. Create table with CHECK constraint.
CREATE TABLE Student_Marks_Test (
    Student_ID INT PRIMARY KEY,
    Marks INT CHECK (Marks BETWEEN 0 AND 100)
);

-- Q34. Create table with UNIQUE constraint.
CREATE TABLE Student_Email_Test (
    Student_ID INT PRIMARY KEY,
    Email VARCHAR(100) UNIQUE
);

-- Q35. Create Department table.
CREATE TABLE Department (
    Department_ID INT PRIMARY KEY,
    Department_Name VARCHAR(100) UNIQUE
);

-- JOIN Queries
-- Q36. Create Course table.
CREATE TABLE Courses (
    Course_ID INT PRIMARY KEY,
    Course_Name VARCHAR(100),
    Department_ID INT,
    Fees DECIMAL(10,2),
    FOREIGN KEY (Department_ID) REFERENCES Department(Department_ID));
    
-- Q36. INNER JOIN Student and Course.
SELECT s.Student_ID, s.Student_Name, c.Course_Name, c.Fees
FROM student_management_dataset s
INNER JOIN Course c ON s.Course = c.Course_Name;

-- Q37. LEFT JOIN.
SELECT s.Student_ID, s.Student_Name, c.Course_Name
FROM student_management_dataset s
LEFT JOIN Course c ON s.Course = c.Course_name
WHERE c.Course_name IS NOT NULL;

-- Q38. RIGHT JOIN 
SELECT s.Student_ID, s.Student_Name, c.Course_Name
FROM student_management_dataset s
LEFT JOIN Course c ON s.Course = c.Course_name
WHERE c.Course_name IS NOT NULL;

-- Single-Row Subquery
-- Q37. Find students who scored above the overall average.
SELECT Student_Name,Total_Marks 
FROM student_management_dataset
WHERE Total_Marks > (
    SELECT AVG(Total_Marks)
    FROM student_management_dataset
);

-- Multiple-Row Subquery
-- Q39. Find the student who scored the maximum marks.
SELECT Student_Name,department,Total_Marks
FROM student_management_dataset
WHERE Department IN (
    SELECT Department
    FROM student_management_dataset
    GROUP BY Department
    HAVING COUNT(*) > 5
);

 
 -- Q40. Find students whose department is one of the departments having average marks above 70.
 SELECT Student_Name,Department,Total_Marks
FROM student_management_dataset
WHERE Department IN (
    SELECT Department
    FROM student_management_dataset
    GROUP BY Department
    HAVING AVG(Total_Marks) > 50
); 

-- CASE Statement
-- Q41. Classify students based on marks.
SELECT Student_ID, Student_Name,Total_Marks,
    CASE
        WHEN Total_Marks >= 75 THEN 'Excellent'
        WHEN Total_Marks >= 60 THEN 'Good'
        WHEN Total_Marks >= 40 THEN 'Average'
        ELSE 'Fail'
    END AS Performance
FROM student_management_dataset;

-- Q42. Classify students based on attendance.
SELECT Student_Name, Attendance,
    CASE
        WHEN Attendance >= 75 THEN 'Eligible'
        WHEN Attendance >= 60 THEN 'Low Attendance'
        ELSE 'Very Low Attendance'
    END AS Attendance_Status
FROM student_management_dataset;

-- Q43. Give grades to students.
SELECT Student_Name,Total_Marks,
    CASE
        WHEN Total_Marks >= 90 THEN 'A+'
        WHEN Total_Marks >= 80 THEN 'A'
        WHEN Total_Marks >= 70 THEN 'B'
        WHEN Total_Marks >= 60 THEN 'C'
        WHEN Total_Marks >= 40 THEN 'D'
        ELSE 'F'
    END AS Grade
FROM student_management_dataset;

-- WINDOW FUNCTIONS
-- Q44. Find overall average marks for every student.
SELECT Student_Name,Total_Marks,
    AVG(Total_Marks) OVER() AS Overall_Average
FROM student_management_dataset;

-- Q46. Find department-wise average marks without GROUP BY.
SELECT Student_Name, Department, Total_Marks,
    AVG(Total_Marks) OVER(PARTITION BY Department) AS Department_Average
FROM student_management_dataset;

-- Q46. Calculate running total of fees.
SELECT Student_ID, Student_Name, Annual_Fees,
    SUM(Annual_Fees) OVER(ORDER BY Student_ID) AS Running_Total_Fees
FROM student_management_dataset;

-- Ranking Functions
-- Q47. Rank students according to marks.
SELECT Student_Name,Total_Marks,
     RANK() OVER(ORDER BY Total_Marks DESC) AS Student_Rank
FROM student_management_dataset;

-- Q48. Give every student a unique row number.
SELECT Student_Name,Total_Marks,
    ROW_NUMBER() OVER(ORDER BY Total_Marks DESC) AS Row_Number_Marks
FROM student_management_dataset;

-- Q49. Rank students using DENSE_RANK.
SELECT Student_Name,Total_Marks,
    DENSE_RANK() OVER(ORDER BY Total_Marks DESC) AS Row_Number_Marks
FROM student_management_dataset;

-- Value Window Functions
-- Q50. Display the previous student's marks.
SELECT Student_Name,Total_Marks,
    LAG(Total_Marks) OVER(ORDER BY Student_ID) AS Previous_Marks
FROM student_management_dataset;

-- Q51. Display the next student's marks.
SELECT Student_Name,Total_Marks,
    LEAD(Total_Marks) OVER(ORDER BY Student_ID) AS Previous_Marks
FROM student_management_dataset;

-- Q52. Find the top student in each department
SELECT Student_Name, Department, Total_Marks,
FIRST_VALUE(Student_Name) OVER(PARTITION BY Department ORDER BY Total_Marks DESC) AS Top_Student
FROM student_management_dataset;

-- Q55. Find the lowest-scoring student in each department.
SELECT Student_Name, Department, Total_Marks,
LAST_VALUE(Student_Name) OVER(
        PARTITION BY Department
        ORDER BY Total_Marks DESC
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND UNBOUNDED FOLLOWING
    ) AS Lowest_Student
FROM student_management_dataset;





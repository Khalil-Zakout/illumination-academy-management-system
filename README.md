# Illumination-Academy-Management-System

## Overview
**The Illumination Academy Management System** is a comprehensive tool designed to streamline administrative tasks for educational institutions, specifically focusing on student management, course enrollments, and instructor data.
The system allows academies to efficiently handle day-to-day operations such as enrolling students, managing courses, and assigning instructors while providing valuable insights into students data and enrollment trends.

Built with **`Python`** and **`PostgreSQL`**, this system integrates seamlessly with **`Excel`** for reporting and uses **`Matplotlib`** for **Data Visualization** to present actionable insights.

## Skills Demonstrated
**1) Python Mastery:** Demonstrates proficiency, including clean code practices, effective function and modules organization, and error handling.

**2) Data Validation:** Employs **`Regular Expressions`** and data validation techniques to ensure data integrity and prevent errors.

**3) Excel Integration:** Demonstrates proficiency in using **`Openpyxl`** to seamlessly export data to **`Excel`** for further analysis and reporting.

**4) Data Visualization:** Utilizes **`Matplotlib`** to create informative and visually appealing charts, effectively communicating data trends.

**5) Database Design:** Demonstrates robust database schema via meaningful relationships and attributes for efficient storing and managing data.

**6) SQL Proficiency:** Leverages **`SQL`** for full **`CRUD`** operations, extracting valuable insights from the database.

## Features
1) **`Student Management:`**
   
    * Add New Students: With basic information (name, major, birthday, email, phone number).      
    * Delete Students: Using their email (unique identifier).      
      
2) **`Instructor Management:`**
   
    * Add New Instructors: With basic information (name, birthday, hourly pay).
      
3) **`Course Management:`**
   
    * Add New Courses: With details (name, description, duration, skills).
    * Associate courses with instructors.
      
4) **`Enrollment Management:`**
    * Enroll students in existing courses.
      
5) **`Reporting:`**
    Generate various charts to visualize data using **`Matplotlib`**:
   
    * Enrollment counts by date.
    * Student counts per course.
    * Student counts per major.
   
7) **`Data Export:`**
    * Export information from tables to **`Excel`** sheets for easy record-keeping.


## Usage
**1. Clone the Repository:** First, clone this repository to your local machine:

``git clone https://github.com/yourusername/Illumination-Academy-Management-System.git``

``cd Illumination-Academy-Management-System``

**2. Set Up PostgreSQL Database:** Ensure you have PostgreSQL installed on your machine. If not, install it from PostgreSQL official website.

**3. Restore the Database:** Inside the project directory, there is a **`Data`** folder containing a dump of the database (**`illumination_academy.sql`**). Restore this database to your PostgreSQL server using the following command:

`psql -U your_postgresql_username -d your_database_name -f Data/illumination_academy.sql`

Replace **`your_postgresql_username`** and **`your_database_name`** with your PostgreSQL username and the name you want for the database.

**4. Install Dependencies:** Before running the system, install the required Python libraries using pip. The necessary libraries are listed in **`requirements.txt`**. To install them, run:

`pip install -r requirements.txt`

**5. Configure Database Connection:** Update the database connection settings in the code. Open the Python script where the PostgreSQL connection is defined and replace the placeholder values with your actual database credentials:

`connection = psycopg2.connect(
    host="localhost",
    database="your_database_name",
    user="your_postgresql_username",
    password="your_postgresql_password"
)`

**6. Running the System:** After setting up the database and installing dependencies, you can run the main program using:

`Illumination Academy.py`

**7. Exporting Data to Excel:** The system allows exporting data to Excel. Upon running the system, you will find exported files generated in the **`Sheets`** directory.

**8. Generating Reports:** Reports such as student enrollment trends and course statistics can be generated within the system using Matplotlib. The charts will be displayed directly, and saved to the **`Charts`** directory for future reference.




## Contact
For any inquiries or feedback, please reach out to zakoutkhalil@gmail.com

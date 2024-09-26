import psycopg2
import datetime
import tabulate
import openpyxl
from Modules.validation import validate_date,validate_email,validate_phone
from Modules.charts import enrollment_counts_by_date, student_counts_per_course_chart,student_counts_per_major_chart

conn = psycopg2.connect(
    dbname = 'illumination',
    host = 'localhost',
    port = 5432,
    user = 'manager',
    password = 'manager1212')

cursor = conn.cursor()



# Main Menu Features:
def add_student():
    first_name = input("Enter The First Name: ")
    last_name = input("Enter The Last Name: ")
    major = input("Enter The Major: ")

    #Data Validation:
    while True:
        birthday = input("Enter Birth Date (YYYY-MM-DD): ")
        if validate_date(birthday):
            break
        print("Please Enter a Date With The Correct Format !!\n")

    while True:
        email = input("Enter The Email: ")
        if validate_email(email):
            break
        print("Invalid Email !!\n")

    while True:
        phone_number = input("Enter Mobile Number: ")
        if validate_phone(phone_number):
            break
        print("Please Enter a Valid Number !!\n")


    try:
        cursor.execute("""
            INSERT INTO students ("first_name","last_name","major","birthday","email","phone_number")
            VALUES(%s,%s,%s,%s,%s,%s)""", (first_name.capitalize(),last_name.capitalize(),major.capitalize(),birthday,email.lower(),phone_number))
        conn.commit()
        print("\n--------------------------------\nStudent Added Successfully !\n--------------------------------\n")

    except(Exception,psycopg2.DatabaseError) as e:
        print(f"Error: {e}")



def delete_student():
    try:
        while True:
            email = input("Enter The Student's Email: ")

            if validate_email(email):
                cursor.execute("DELETE FROM students WHERE email = %s",(email.lower(),))

                if cursor.rowcount > 0:   # Check if any rows were deleted
                    conn.commit()
                    print("\n--------------------------------\nStudent Deleted Successfully!\n--------------------------------\n")
                    break
                else:
                    print("No Student Found With This Email !!\n")

            else:
                print("Please Enter a Valid Email !!\n")


    except(Exception,psycopg2.DatabaseError) as e:
        print(f"Error: {e}")



def add_instructor():
    first_name = input("Enter The First Name: ")
    last_name = input("Enter The Last Name: ")

    # Data Validation:
    while True:
        hourly_pay = input("Enter The Hourly Pay: ")
        if not hourly_pay.isdigit() or int(hourly_pay) <= 0:
            print("Please Enter an Integer !!\n")
        else:
            hourly_pay = int(hourly_pay)
            break

    while True:
        birthday = input("Enter The Birthday (YYYY-MM-DD): ")
        if validate_date(birthday):
            break
        print("Please Enter a Birthday With The Correct Format !!\n")


    try:
        cursor.execute("""
            INSERT INTO instructors ("first_name","last_name","hourly_pay","birthday")
            VALUES (%s,%s,%s,%s)""",(first_name.capitalize(),last_name.capitalize(),hourly_pay,birthday))

        conn.commit()
        print("\n--------------------------------\nInstructor Added Successfully !\n--------------------------------\n")

    except(Exception,psycopg2.DatabaseError) as e:
        print(f"Error : {e}")



def add_course():
    course_name = input("Enter The Course Name: ")
    description = input("Enter The Course Description: ")
    skills = []

    # Data Validation:
    try:

        # Validating The Duration:
        while True:
            duration = input("Enter The Duration of The Course (in Hours): ")
            if not duration.isdigit() or int(duration) <= 0:
                print("Please Enter a Valid Duration !!\n")
            else:
                duration = int(duration)
                break


        # Entering The Skills
        while True:
            skill = input("Enter a Skill (Q to Exit): ")
            if skill.lower() == 'q':
                print("Skills Added Successfully")
                break
            else:
                skills.append(skill)


        # Getting instructor_id Via first_name and last_name:
        while True:
            instructor_first_name = input("Enter The Instructor's First Name: ")
            instructor_last_name = input("Enter The Instructor's last Name: ")

            cursor.execute("Select instructor_id from instructors WHERE first_name = %s AND last_name = %s"
                           ,(instructor_first_name.capitalize(),instructor_last_name.capitalize(),))

            if cursor.rowcount == 1:    # Case(1): There is Only 1 Instructor With The Name
                instructor_id = cursor.fetchone()[0]    # instructor_id is found
                break


            elif cursor.rowcount > 1:   # Case(2): There are more than 1 Instructor With The Name
                print(f"There Are {cursor.rowcount} of Instructors With The Same Name\n")

                while True:     # Finding The Instructor With First Name & Last Name & Birthday
                    birthday = input("Please Enter The Instructor's Birthday: ")

                    if validate_date(birthday):
                        cursor.execute("""SELECT instructor_id FROM instructors
                         WHERE first_name = %s AND last_name = %s AND birthday = %s""",
                        (instructor_first_name.capitalize(),instructor_last_name.capitalize(),birthday,))

                        if cursor.rowcount == 1:    # If There is a Matching Instructor
                            instructor_id = cursor.fetchone()[0]    # instructor_id is found
                            break
                        else:
                            print("There is No Matching Birthday !!\n")
                    else:
                        print("Invalid Date !!\n")
                break

            else:   # Case(3): There is No Instructor With The Name
                print("There is No Instructor With This Name !!\n")


        cursor.execute("""
            INSERT INTO courses ("course_name","description","duration","skills","instructor_id")
            VALUES(%s,%s,%s,%s,%s)""",(course_name.capitalize(),description,duration,skills,instructor_id,))

        conn.commit()
        print("\n--------------------------------\nCourse Added Successfully !\n--------------------------------\n")

    except(Exception,psycopg2.DatabaseError) as e:
        print(f"Error: {e}")



def course_enrollment():
    try:

        # Getting std_id Via Email (Unique Key)
        while True:
            email = input("Enter The Student's Email: ")

            if validate_email(email):
                cursor.execute("""SELECT std_id FROM students WHERE email = %s""",(email.lower(),))
                if cursor.rowcount > 0:
                    std_id = cursor.fetchone()[0]
                    break
                else:
                    print("No Student Has This Email !!\n")
            else:
                print("Please Enter a Valid Email !\n")


        # Getting course_id Via course_name (For Easier Entry)
        while True:
            course_name = input("Enter The Course Name: ")

            cursor.execute("SELECT course_id from courses WHERE course_name = %s",(course_name.capitalize(),))
            if cursor.rowcount > 0:
                course_id = cursor.fetchone()[0]
                break
            else:
                print("There is No Course With This Name !\n")


        cursor.execute(""" INSERT INTO student_course ("std_id","course_id","enrollment_date") VALUES (%s,%s,%s)""",
                       (std_id,course_id,datetime.date.today()))
        conn.commit()
        print("\n--------------------------------\nEnrollment Done Successfully !\n--------------------------------\n")

    except(Exception,psycopg2.DatabaseError) as e:
        print(f"Error: {e}")



def show_charts():
    while True:
        print("\n1) Show Enrollments Counts Per Date\n2) Show Students Counts Per Course\n3) Show Students Counts Per Major\n")
        entry = input("What Chart Do You Want To See (Press Q to Exit): ")

        if entry == '1':
            enrollment_counts_by_date(cursor)

        elif entry == '2':
            student_counts_per_course_chart(cursor)

        elif entry == '3':
            student_counts_per_major_chart(cursor)

        elif entry.lower() == 'q':
            print("\n--------------------------------\n")
            break

        else:
            print("Please Enter a Valid Option\n")



def show_info():
    while True:
        print("\n1) Students Table\n2) Instructors Table\n3) Courses Table\n4) Courses Enrollment Table\n5) Exit\n")
        entry = input("What Table Do You Want To See? ")


        if entry == "1":    # Students Table
            cursor.execute("SELECT * FROM students")
            result = cursor.fetchall()
            headers = ["ID","First Name","Last Name","Mobile Number","Email","Major","Date of Birth"]
            print("\n"+ tabulate.tabulate(result, headers= headers, tablefmt="grid")+"\n")

            xlsx_file = f"./Sheets/Students Sheets/Students Table - {datetime.date.today()}.xlsx"
            export_to_excel(headers, result, xlsx_file)


        elif entry == "2":  # Instructors Table
            cursor.execute("SELECT * FROM instructors")
            result = cursor.fetchall()
            headers = ["ID","First Name","Last Name","Date of Birth","Hourly Pay"]
            print("\n"+ tabulate.tabulate(result, headers= headers, tablefmt="grid")+"\n")

            xlsx_file = f"./Sheets/Instructors Sheets/Instructors Table - {datetime.date.today()}.xlsx"
            export_to_excel(headers, result, xlsx_file)


        elif entry == "3":  # Courses Table
            cursor.execute("""SELECT courses.*, CONCAT(i.first_name,' ',i.last_name) as "Full_Name" FROM courses
                            INNER JOIN instructors as i using (instructor_id)""")
            result = cursor.fetchall()
            headers = ["ID","Course Name","Description","Duration","Skills","Instructor ID","Instructor Name"]
            print("\n"+ tabulate.tabulate(result, headers= headers, tablefmt="grid")+"\n")

            xlsx_file = f"./Sheets/Courses Sheets/Courses Table - {datetime.date.today()}.xlsx"
            processed_result = []   # To Be Able To Append The Skills List To Excel Sheet

            for row in result:
                row = list(row)     # Change The Tuple Into A List To Allow Modification (Tuple Are Immutable)
                row[4] = "- ".join(row[4])     # Change The Skills List Into String To Allow Appending To Excel
                processed_result.append(row)

            export_to_excel(headers, processed_result, xlsx_file)


        elif entry == "4":  # Courses' Enrollments Table
            cursor.execute("""SELECT sc.course_id, sc.std_id, CONCAT(s.first_name, ' ',s.last_name) as "Student Name",
                            c.course_name, sc.enrollment_date FROM student_course AS sc
                            INNER JOIN students AS s USING(std_id)
                            INNER JOIN courses AS c USING (course_id)""")

            result = cursor.fetchall()
            headers = ["Course ID","Student ID","Student Name","Course Name","Enrollment Date"]
            print("\n"+ tabulate.tabulate(result, headers= headers, tablefmt="grid")+"\n")

            xlsx_file = f"./Sheets/Courses' Enrollments Sheets/Courses' Enrollments Table - {datetime.date.today()}.xlsx"
            export_to_excel(headers, result, xlsx_file)


        elif entry == "5":
            break

        else:
            print("Please Enter a Valid Option !!\n")


def export_to_excel(headers, result, file_path):
    saving_choice = input("Do You Want To Transform It To Excel Sheet ? (Y/N): ")

    while True:
        if saving_choice.lower() == 'y':
            workbook = openpyxl.Workbook()
            sheet = workbook.active

            sheet.append(headers)
            for row in result:
                sheet.append(row)

            workbook.save(file_path)
            print("\n--------------------------------\nSheet Saved Successfully !!\n--------------------------------\n")
            break

        elif saving_choice.lower() == 'n':
            break
        else:
            print("Please Enter a Valid Option !!\n")



def main_menu():
    while True:
        print("1) Add Student\n2) Delete Student\n3) Add Instructor\n4) Add Course\n5) Enroll Student To a Course\n6) Charts\n7) Show Info\n8) Exit\n")
        entry = input("What Do You Want To Do? ")

        if entry == '1':
            print("\n        Adding Student\n--------------------------------")
            add_student()

        elif entry == '2':
            print("\n        Deleting Student\n--------------------------------")
            delete_student()

        elif entry == '3':
            print("\n        Adding Instructor\n--------------------------------")
            add_instructor()

        elif entry == '4':
            print("\n        Adding Course\n--------------------------------")
            add_course()

        elif entry == '5':
            print("\n  Enrolling a Student to Course\n--------------------------------")
            course_enrollment()

        elif entry == '6':
            print("\n            Charts\n--------------------------------")
            show_charts()

        elif entry == "7":
            print("\n          Information\n--------------------------------")
            show_info()

        elif entry == '8':
            print("\n          BYE BYE !!\n--------------------------------")
            break

        else:
            print("Please Enter a Valid Choice !!\n")


if __name__ == '__main__':
    main_menu()
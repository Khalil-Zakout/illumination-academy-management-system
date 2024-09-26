import matplotlib.pyplot as plt
import datetime


def enrollment_counts_by_date(cursor):
    cursor.execute("""SELECT enrollment_date, COUNT(std_id) FROM student_course
                      GROUP BY enrollment_date ORDER BY enrollment_date ASC""")
    result = cursor.fetchall()

    Dates = [item[0] for item in result]
    Counts = [item[1] for item in result]

    dates_num = len(Dates)
    height = max(10, int(dates_num * 0.5))      # Height is Set At Least 10 Or The Other Calculation

    plt.figure(figsize=(14,height))
    plt.barh(range(len(Dates)),Counts,tick_label=Dates,color="#2655b8")
    plt.xlabel('Number of Students')
    plt.title('Student Enrollment Counts by Date')
    plt.grid(axis='x')

    while True:
        saving_choice = input("Do You Want To Save This Chart? (Y/N): ")
        if saving_choice.lower() == 'y':
            plt.savefig(f"./Charts/Courses' Enrollments/Courses' Enrollments - {datetime.date.today()}.png")
            print("\n--------------------------------\nChart Saved Successfully !\n--------------------------------\n")
            break
        elif saving_choice.lower() == 'n':
            break
        else:
            print("Please Enter a Valid Option !!")

    plt.show()



def student_counts_per_course_chart(cursor):
    cursor.execute(
        """SELECT c.course_name , COUNT(std_id) FROM student_course
           INNER JOIN courses AS c USING (course_id) GROUP BY c.course_name ORDER BY COUNT(std_id)""")
    result = cursor.fetchall()

    Courses = [item[0] for item in result]
    Counts = [item[1] for item in result]

    courses_num = len(Courses)
    width = max(12,int(courses_num * 0.5))      # Width is Set At Least 10 Or The Other Calculation

    plt.figure(figsize=(width,6))
    plt.bar(range(len(Courses)),Counts,tick_label=Courses,color="#2655b8")
    plt.ylabel('Number of Students')
    plt.xlabel('Course')
    plt.xticks(rotation = 20)
    plt.title('Student Counts by Course')
    plt.grid(axis='y')

    while True:
        saving_choice = input("Do You Want To Save This Chart? (Y/N): ")
        if saving_choice.lower() == 'y':
            plt.savefig(f"./Charts/Students Counts Per Course/Students Counts Per Course - {datetime.date.today()}.png")
            print("\n--------------------------------\nChart Saved Successfully !\n--------------------------------\n")
            break
        elif saving_choice.lower() == 'n':
            break
        else:
            print("Please Enter a Valid Option !!")

    plt.show()



def student_counts_per_major_chart(cursor):
    cursor.execute(
        """SELECT major , COUNT(std_id) FROM students
           GROUP BY major ORDER BY COUNT(std_id)""")
    result = cursor.fetchall()

    Majors = [item[0] for item in result]
    Counts = [item[1] for item in result]

    majors_num = len(Majors)
    width = max(10, int(majors_num * 0.5))      # Width Is Set At Least 10 Or The Other Calculation

    plt.figure(figsize=(width + 3 ,6))
    plt.barh(Majors,Counts,color="#2655b8")
    plt.xlabel('Number of Students')
    plt.title('Student Counts by Major')
    plt.grid(axis='x')

    while True:
        saving_choice = input("Do You Want To Save This Chart? (Y/N): ")
        if saving_choice.lower() == 'y':
            plt.savefig(f"./Charts/Students Counts Per Major/Students Counts Per Major - {datetime.date.today()}.png")
            print("\n--------------------------------\nChart Saved Successfully !\n--------------------------------\n")
            break
        elif saving_choice.lower() == 'n':
            break
        else:
            print("Please Enter a Valid Option !!")

    plt.show()
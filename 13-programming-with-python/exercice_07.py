class Person:
    def __init__(self, first_name, last_name, age):
        self.first_name = first_name
        self.last_name = last_name
        self.age = age

    def print_name(self):
        print(f"{self.first_name} {self.last_name}")


class Student(Person):
    def __init__(self, first_name, last_name, age, lectures):
        super().__init__(first_name, last_name, age)
        self.lectures = lectures

    def list_lectures(self):
        for lecture in self.lectures:
            print(lecture)

    def attend_new_lecture(self, lecture):
        self.lectures.append(lecture)

    def leave_lecture(self, lecture):
        self.lectures.remove(lecture)


class Professor(Person):
    def __init__(self, first_name, last_name, age, subjects):
        super().__init__(first_name, last_name, age)
        self.subjects = subjects

    def list_subjects(self):
        for subject in self.subjects:
            print(subject)

    def add_subject(self, subject):
        self.subjects.append(subject)

    def remove_subject(self, subject):
        self.subjects.remove(subject)


class Lecture:
    def __init__(self, name, max_students, duration, professors):
        self.name = name
        self.max_students = max_students
        self.duration = duration
        self.professors = professors

    def print_lecture_info(self):
        print(f"Lecture name: {self.name}")
        print(f"Lecture duration: {self.duration} minutes")

    def add_professor(self, professor):
        self.professors.append(professor)

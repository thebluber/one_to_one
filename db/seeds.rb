#encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
if Rails.env == "development"
  last_semester = Semester.create(start: '2014-4-10')
  current_semester = Semester.create(start: '2014-10-10')

  users = [ User.create(first_name: 'John', last_name: 'Doe', email: 'john.doe@student.uni-tuebingen.de', password: '123456'),
            User.create(first_name: 'Jane', last_name: 'Doe', email: 'jane.doe@student.uni-tuebingen.de', password: '123456'),
            User.create(first_name: 'Harry', last_name: 'Potter', email: 'harry.potter@student.uni-tuebingen.de', password: '123456') ]


  courses = [
    #active courses
    Course.create(title: 'InformatikI', active: true),
    Course.create(title: 'MathematikI', active: true),
    Course.create(title: 'Einführung in die technische Informatik', active: true),
    Course.create(title: 'Praktikum ETI', active: true),
    Course.create(title: 'Informatik der Systeme', active: true),
    #inactive courses
    Course.create(title: 'InformatikII', active: false),
    Course.create(title: 'InformatikIII', active: false),
    Course.create(title: 'MathematikII', active: false),
    Course.create(title: 'MathematikIII', active: false),
    Course.create(title: 'DatenbanksystemI', active: false)
  ]

  users.first.make_admin!
  users.map do |user|
    user.student.new_course_bucket(last_semester)
    user.student.new_course_bucket(current_semester)


    #Add courses to bucket
    user.student.course_buckets.first.courses = courses.take(rand(8) + 1)

    #Add courses as mentor
    user.mentor.courses = courses.take(rand(3) + 1)
  end
end

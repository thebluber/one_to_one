#encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
if Rails.env == "development"
  User.create(first_name: 'John', last_name: 'Doe', email: 'john.doe@student.uni-tuebingen.de', password: '123456')
  User.create(first_name: 'Jane', last_name: 'Doe', email: 'jane.doe@student.uni-tuebingen.de', password: '123456')
  User.create(first_name: 'Harry', last_name: 'Potter', email: 'harry.potter@student.uni-tuebingen.de', password: '123456')


  #active courses
  Course.create(title: 'InformatikI', active: true)
  Course.create(title: 'MathematikI', active: true)
  Course.create(title: 'Einführung in die technische Informatik', active: true)
  Course.create(title: 'Praktikum ETI', active: true)
  Course.create(title: 'Informatik der Systeme', active: true)
  #inactive courses
  Course.create(title: 'InformatikII', active: false)
  Course.create(title: 'InformatikIII', active: false)
  Course.create(title: 'MathematikII', active: false)
  Course.create(title: 'MathematikIII', active: false)
  Course.create(title: 'DatenbanksystemI', active: false)
end

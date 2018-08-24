# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
admin = User.create(email: 'admin@admin.com', name: '관리자', password: 'password', password_confirmation: 'password', user_type: "3")
d = User.create(rating: 0.0, email: 'd@d.d', name: 'd', password: 111111, password_confirmation: 111111, user_type: "1")
f = User.create(rating: 0.0, email: 'f@f.f', name: 'f', password: 111111, password_confirmation: 111111, user_type: "2")
Mypage.create(user: admin)
Mypage.create(user: d)
Mypage.create(user: f)
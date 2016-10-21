# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(email: "super-manager@yopmail.com", password: '12345678', password_confirmation: '12345678' ) unless User.exists?(email: 'super-manager@yopmail.com')

User.find_by(email: "super-manager@yopmail.com").add_role("super_manager") unless User.find_by(email: "super-manager@yopmail.com").has_role?("super_manager")

AdminUser.create(email: 'super-manager@yopmail.com', password: '12345678', password_confirmation: '12345678') unless AdminUser.exists?(email: 'admin@example.com')
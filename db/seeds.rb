# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# * 管理者アカウント登録テスト
admin = Admin.new(email: "root", encrypted_password: "$2a$12$IvgqRY7n49BTSklW/Ro4GOtl6OnntXRBdTndTQbA.Klw6T9qn57Wa")
admin.save

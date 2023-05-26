# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# * カラム更新用SQL
User.update(id: 1, gender: "男", height: 180, weight: 58, age: 19, profile: "ghjkl", avatar: nil)

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Plan.delete_all
Plan.create(id: 1, name: 'Plano Básico - Mensal', code: 'basic-monthly', price: 3000)
Plan.create(id: 2, name: 'Plano Médio - Mensal', code: 'mid-monthly', price: 5000)
Plan.create(id: 3, name: 'Plano Avançado - Mensal', code: 'advanced-monthly', price: 9000)


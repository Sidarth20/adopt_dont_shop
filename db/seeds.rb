# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
pet_1 = shelter.pets.create!(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
pet_2 = shelter.pets.create!(adoptable: true, age: 3, breed: 'domestic pig', name: 'Babe', shelter_id: shelter.id)
pet_3 = shelter.pets.create!(adoptable: true, age: 4, breed: 'chihuahua', name: 'Elle', shelter_id: shelter.id)

application_1 = Application.create!(name:'Julius Caesar',
                                  street_address: '123 Copperfield Lane',
                                  city: 'Atlanta', state: 'GA',
                                  zip_code: '30301',
                                  description: 'I love dogs',
                                  application_status: 'Pending')

application_2 = Application.create!(name:'Test',
                                  street_address: '123 Copperfield Lane',
                                  city: 'Atlanta', state: 'GA',
                                  zip_code: '30301',
                                  description: 'I love dogs',
                                  application_status: 'Pending')

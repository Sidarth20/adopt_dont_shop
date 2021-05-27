require 'rails_helper'

RSpec.describe 'the admin shelters index' do
  it 'orders the shelters names in reverse alphabetical order' do
    # For this story, you should write your queries in raw sql. You can use the ActiveRecord find_by_sql method to execute raw sql queries: https://guides.rubyonrails.org/active_record_querying.html#finding-by-sql
    # Admin Shelters Index
    # As a visitor
    # When I visit the admin shelter index ('/admin/shelters')
    # Then I see all Shelters in the system listed in reverse alphabetical order by name
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    visit '/admin/shelters'

    expect(page).to have_content("Shelters in Reverse Alphabetical Order")
    expect(@shelter_2.name).to appear_before(@shelter_1.name)
  end

  it 'shows shelters with pending applications by name' do
    # For this story, you should fully leverage ActiveRecord methods in your query.
    # Shelters with Pending Applications
    # As a visitor
    # When I visit the admin shelter index ('/admin/shelters')
    # Then I see a section for "Shelter's with Pending Applications"
    # And in this section I see the name of every shelter that has a pending application
    shelter_4 = Shelter.create(name: 'Happy Pets', city: 'Aurora, CO', foster_program: false, rank: 9)
    shelter_5 = Shelter.create(name: 'Terrible Shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    pet_4 = shelter_4.pets.create!(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter_4.id)
    pet_5 = shelter_5.pets.create!(adoptable: true, age: 3, breed: 'domestic pig', name: 'Babe', shelter_id: shelter_5.id)
    pet_3 = shelter_4.pets.create!(adoptable: true, age: 4, breed: 'chihuahua', name: 'Elle', shelter_id: shelter_4.id)

    application_3 = Application.create!(name:'Julius Caesar',
                                      street_address: '123 Copperfield Lane',
                                      city: 'Atlanta', state: 'GA',
                                      zip_code: '30301',
                                      description: 'I love dogs',
                                      application_status: 'Pending')

    application_4 = Application.create!(name:'Miles Davis',
                                      street_address: 'Main St',
                                      city: 'Memphis', state: 'TN',
                                      zip_code: '75239',
                                      description: 'I love cats',
                                      application_status: 'In Progress')

    ApplicationPet.create!(pet: pet_4, application: application_3)
    ApplicationPet.create!(pet: pet_5, application: application_4)

    visit '/admin/shelters'

    expect(page).to have_content("Shelter's with Pending Applications")
    within("#pending-#{shelter_4.id}") do
     expect(page).to have_content(shelter_4.name)
    end
  end
end

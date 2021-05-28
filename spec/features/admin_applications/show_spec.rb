require 'rails_helper'

RSpec.describe AdminApplication do
  describe 'show page' do
    it 'can approve a Pet for adoption' do
      shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
      shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
      pet_1 = shelter.pets.create!(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
      pet_2 = shelter_2.pets.create!(adoptable: true, age: 3, breed: 'domestic pig', name: 'Babe', shelter_id: shelter.id)
      pet_3 = shelter.pets.create!(adoptable: true, age: 4, breed: 'chihuahua', name: 'Elle', shelter_id: shelter.id)

      application_1 = Application.create!(name:'Julius Caesar',
                                        street_address: '123 Copperfield Lane',
                                        city: 'Atlanta', state: 'GA',
                                        zip_code: '30301',
                                        description: 'I love dogs',
                                        application_status: 'Pending')

      application_2 = Application.create!(name:'Miles Davis',
                                        street_address: 'Main St',
                                        city: 'Memphis', state: 'TN',
                                        zip_code: '75239',
                                        description: 'I love cats',
                                        application_status: 'In Progress')

      ApplicationPet.create!(pet: pet_1, application: application_1)
      ApplicationPet.create!(pet: pet_2, application: application_1)

      visit "admin/applications/#{application_1.id}"

      expect(page).to have_link(pet_1.name)
      expect(page).to have_link(pet_2.name)
      expect(page).to have_button("Approve #{pet_1.name}")
      expect(page).to have_button("Approve #{pet_2.name}")

      click_button("Approve #{pet_1.name}")

      expect(current_path).to eq("/admin/applications/#{application_1.id}")
      
    end
  end
end

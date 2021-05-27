require 'rails_helper'

RSpec.describe 'show page' do
  it 'can see all attributes of application' do
    # Application Show Page
    # As a visitor
    # When I visit an applications show page
    # Then I can see the following:
    # - Name of the Applicant
    # - Full Address of the Applicant including street address, city, state, and zip code
    # - Description of why the applicant says they'd be a good home for this pet(s)
    # - names of all pets that this application is for (all names of pets should be links to their show page)
    # - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"

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
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = shelter.pets.create!(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
    pet_2 = shelter.pets.create!(adoptable: true, age: 3, breed: 'domestic pig', name: 'Babe', shelter_id: shelter.id)
    pet_3 = shelter.pets.create!(adoptable: true, age: 4, breed: 'chihuahua', name: 'Elle', shelter_id: shelter.id)

    ApplicationPet.create!(pet: pet_1, application: application_1)
    ApplicationPet.create!(pet: pet_2, application: application_1)
    visit "/applications/#{application_1.id}"

    expect(page).to have_content(application_1.name)
    expect(page).to have_content(application_1.street_address)
    expect(page).to have_content(application_1.city)
    expect(page).to have_content(application_1.state)
    expect(page).to have_content(application_1.zip_code)
    expect(page).to have_content(application_1.description)
    expect(page).to have_content(application_1.application_status)
    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_2.name)
  end

  it 'can search for pets for an application' do
    # Searching for Pets for an Application
    # As a visitor
    # When I visit an application's show page
    # And that application has not been submitted,
    # Then I see a section on the page to "Add a Pet to this Application"
    # In that section I see an input where I can search for Pets by name
    # When I fill in this field with a Pet's name
    # And I click submit,
    # Then I am taken back to the application show page
    # And under the search bar I see any Pet whose name matches my search
    application_1 = Application.create!(name:'Julius Caesar',
                                      street_address: '123 Copperfield Lane',
                                      city: 'Atlanta', state: 'GA',
                                      zip_code: '30301',
                                      description: 'I love dogs',
                                      application_status: 'In Progress')
    application_2 = Application.create!(name:'Test',
                                      street_address: '123 Copperfield Lane',
                                      city: 'Atlanta', state: 'GA',
                                      zip_code: '30301',
                                      description: 'I love dogs',
                                      application_status: 'Pending')
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = shelter.pets.create!(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
    pet_2 = shelter.pets.create!(adoptable: true, age: 3, breed: 'domestic pig', name: 'Babe', shelter_id: shelter.id)
    pet_3 = shelter.pets.create!(adoptable: true, age: 4, breed: 'chihuahua', name: 'Elle', shelter_id: shelter.id)

    visit "/applications/#{application_1.id}"

    expect(page).to have_content(application_1.name)
    expect(page).to have_content(application_1.street_address)
    expect(page).to have_content(application_1.city)
    expect(page).to have_content(application_1.state)
    expect(page).to have_content(application_1.zip_code)
    expect(page).to have_content(application_1.description)
    expect(page).to have_content(application_1.application_status)
    expect(page).to have_content("Add a Pet to this Application")

    fill_in('Search', with: 'Babe')
    click_button('Search')

    expect(page).to have_content('Babe')
    expect(current_path).to eq("/applications/#{application_1.id}")
  end

  it 'can add a pet for an application' do
    # Add a Pet to an Application
    # As a visitor
    # When I visit an application's show page
    # And I search for a Pet by name
    # And I see the names Pets that match my search
    # Then next to each Pet's name I see a button to "Adopt this Pet"
    # When I click one of these buttons
    # Then I am taken back to the application show page
    # And I see the Pet I want to adopt listed on this application
    application_1 = Application.create!(name:'Julius Caesar',
                                      street_address: '123 Copperfield Lane',
                                      city: 'Atlanta', state: 'GA',
                                      zip_code: '30301',
                                      description: 'I love dogs',
                                      application_status: 'In Progress')

    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = shelter.pets.create!(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
    pet_2 = shelter.pets.create!(adoptable: true, age: 3, breed: 'domestic pig', name: 'Babe', shelter_id: shelter.id)
    pet_3 = shelter.pets.create!(adoptable: true, age: 4, breed: 'chihuahua', name: 'Elle', shelter_id: shelter.id)

    visit "/applications/#{application_1.id}"

    expect(page).to have_content(application_1.name)
    expect(page).to have_content(application_1.street_address)
    expect(page).to have_content(application_1.city)
    expect(page).to have_content(application_1.state)
    expect(page).to have_content(application_1.zip_code)
    expect(page).to have_content(application_1.description)
    expect(page).to have_content(application_1.application_status)
    expect(page).to have_content("Add a Pet to this Application")
    fill_in('Search', with: 'Babe')
    click_button('Search')

    expect(page).to have_link("Pet Name: Babe")
    expect(current_path).to eq("/applications/#{application_1.id}")
    expect(page).to have_button('Adopt this Pet')

    click_button('Adopt this Pet')

    expect(current_path).to eq("/applications/#{application_1.id}")
    expect(page).to have_content(pet_2.name)
    expect(page).to have_link("#{pet_2.name}")
    expect(page).to have_content(pet_2.breed)
    expect(page).to have_content(pet_2.age)
  end

  it 'can submit an application' do
    # Submit an Application
    # As a visitor
    # When I visit an application's show page
    # And I have added one or more pets to the application
    # Then I see a section to submit my application
    # And in that section I see an input to enter why I would make a good owner for these pet(s)
    # When I fill in that input
    # And I click a button to submit this application
    # Then I am taken back to the application's show page
    # And I see an indicator that the application is "Pending"
    # And I see all the pets that I want to adopt
    # And I do not see a section to add more pets to this application
    application_1 = Application.create!(name:'Julius Caesar',
                                      street_address: '123 Copperfield Lane',
                                      city: 'Atlanta', state: 'GA',
                                      zip_code: '30301',
                                      description: 'I love dogs',
                                      application_status: 'In Progress')

    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = shelter.pets.create!(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
    pet_2 = shelter.pets.create!(adoptable: true, age: 3, breed: 'domestic pig', name: 'Babe', shelter_id: shelter.id)
    pet_3 = shelter.pets.create!(adoptable: true, age: 4, breed: 'chihuahua', name: 'Elle', shelter_id: shelter.id)

    visit "/applications/#{application_1.id}"

    expect(page).to have_content(application_1.name)
    expect(page).to have_content(application_1.street_address)
    expect(page).to have_content(application_1.city)
    expect(page).to have_content(application_1.state)
    expect(page).to have_content(application_1.zip_code)
    expect(page).to have_content(application_1.description)
    expect(page).to have_content(application_1.application_status)
    expect(page).to have_content("Add a Pet to this Application")

    fill_in('Search', with: 'Babe')
    click_button('Search')

    expect(page).to have_link("Pet Name: Babe")
    expect(current_path).to eq("/applications/#{application_1.id}")
    expect(page).to have_button('Adopt this Pet')

    click_button('Adopt this Pet')

    expect(current_path).to eq("/applications/#{application_1.id}")
    expect(page).to have_content(pet_2.name)
    expect(page).to have_link("#{pet_2.name}")
    expect(page).to have_content(pet_2.breed)
    expect(page).to have_content(pet_2.age)

    fill_in('Search', with: 'Bare')
    click_button('Search')

    expect(page).to have_link("Pet Name: Bare-y Manilow")
    expect(current_path).to eq("/applications/#{application_1.id}")
    expect(page).to have_button('Adopt this Pet')

    click_button('Adopt this Pet')

    expect(current_path).to eq("/applications/#{application_1.id}")
    expect(page).to have_content(pet_1.name)
    expect(page).to have_link("#{pet_1.name}")
    expect(page).to have_content(pet_1.breed)
    expect(page).to have_content(pet_1.age)

    expect(page).to have_content("Submit Application")
    expect(page).to have_button("Submit Application")
    fill_in(:description, with: 'I want a pet that will keep me company & I have a yard')
    click_button('Submit Application')

    expect(current_path).to eq("/applications/#{application_1.id}")
    expect(page).to have_content("Good Home Description: I want a pet that will keep me company & I have a yard")
    expect(page).to have_content("Application Status: Pending")
    expect(page).to have_content("Pets in Application")
    expect(page).to have_link("Pet Name: #{pet_1.name}")
    expect(page).to have_link("Pet Name: #{pet_2.name}")
    expect(page).to have_no_content("Add a Pet to this Application")
  end

  it 'has no pets on an application' do
    # No Pets on an Application
    # As a visitor
    # When I visit an application's show page
    # And I have not added any pets to the application
    # Then I do not see a section to submit my application
    application_1 = Application.create!(name:'Julius Caesar',
                                      street_address: '123 Copperfield Lane',
                                      city: 'Atlanta', state: 'GA',
                                      zip_code: '30301',
                                      description: 'I love dogs',
                                      application_status: 'In Progress')

    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = shelter.pets.create!(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
    pet_2 = shelter.pets.create!(adoptable: true, age: 3, breed: 'domestic pig', name: 'Babe', shelter_id: shelter.id)
    pet_3 = shelter.pets.create!(adoptable: true, age: 4, breed: 'chihuahua', name: 'Elle', shelter_id: shelter.id)

    visit "/applications/#{application_1.id}"

    expect(page).to have_content(application_1.name)
    expect(page).to have_content(application_1.street_address)
    expect(page).to have_content(application_1.city)
    expect(page).to have_content(application_1.state)
    expect(page).to have_content(application_1.zip_code)
    expect(page).to have_content(application_1.description)
    expect(page).to have_content(application_1.application_status)
    expect(page).to have_content("Add a Pet to this Application")
    expect(page).to have_button("Search")
  end
end

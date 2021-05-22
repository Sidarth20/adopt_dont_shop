require 'rails_helper'

RSpec.describe 'new page' do
  it 'can fill out a form' do
    # Starting an Application
    # As a visitor
    # When I visit the pet index page
    # Then I see a link to "Start an Application"
    # When I click this link
    # Then I am taken to the new application page where I see a form
    # When I fill in this form with my:
    #   - Name
    #   - Street Address
    #   - City
    #   - State
    #   - Zip Code
    # And I click submit
    # Then I am taken to the new application's show page
    # And I see my Name, address information, and description of why I would make a good home
    # And I see an indicator that this application is "In Progress"
    application = Application.create!(name:'Julius Caesar',
                                      street_address: '123 Copperfield Lane',
                                      city: 'Atlanta', state: 'GA',
                                      zip_code: '30301',
                                      description: 'I love dogs',
                                      application_status: 'Pending')
    visit '/applications/new'

    fill_in('name', with: 'Carlos')
    fill_in('street_address', with: '123 Cherry Rd')
    fill_in('city', with: 'Denver')
    fill_in('state', with: 'CO')
    fill_in('zip_code', with: '80216')
    click_button('Submit')
    new_application_id = Application.last.id
    expect(current_path).to eq("/applications/show")
    expect(page).to have_content("Carlos")
    expect(page).to have_content("123 Cherry Rd")
    expect(page).to have_content("Denver")
    expect(page).to have_content("CO")
    expect(page).to have_content("80216")
  end
end

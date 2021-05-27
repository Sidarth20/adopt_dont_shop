require 'rails_helper'

RSpec.describe AdminShelter, type: :feature do
  describe 'has an index page' do
    it 'can see all shelters listed in reverse alphabetical order by name' do
      # For this story, you should write your queries in raw sql. You can use the ActiveRecord find_by_sql method to execute raw sql queries: https://guides.rubyonrails.org/active_record_querying.html#finding-by-sql
      # Admin Shelters Index
      # As a visitor
      # When I visit the admin shelter index ('/admin/shelters')
      # Then I see all Shelters in the system listed in reverse alphabetical order by name
      @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
      @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

      visit '/admin/shelters'
      save_and_open_page
      expect(@shelter_3.name).to appear_before(@shelter_1.name)
    end
  end
end

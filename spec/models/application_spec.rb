require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it {should have_many :application_pets}
    it {should have_many(:pets).through(:application_pets)}
  end

  describe 'class methods' do
    describe '#search' do
      it 'returns partial matches' do
      # Partial Matches for Pet Names
      # As a visitor
      # When I visit an application show page
      # And I search for Pets by name
      # Then I see any pet whose name PARTIALLY matches my search
      # For example, if I search for "fluff", my search would match pets with names "fluffy", "fluff", and "mr. fluff"
        @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
        @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
        @pet_3 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)

        expect(Pet.search("Claw")).to eq([@pet_2])
      end

      it 'returns case insensitivie matches' do
        # Case Insensitive Matches for Pet Names
        # As a visitor
        # When I visit an application show page
        # And I search for Pets by name
        # Then my search is case insensitive
        # For example, if I search for "fluff", my search would match pets with names "Fluffy", "FLUFF", and "Mr. FlUfF"
        @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
        @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
        @pet_3 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)

        expect(Pet.search("cLaW")).to eq([@pet_2])
      end
    end

    describe '#pending_applications' do
      it 'shows shelters with pending applications by name' do
        # For this story, you should fully leverage ActiveRecord methods in your query.
        # Shelters with Pending Applications
        # As a visitor
        # When I visit the admin shelter index ('/admin/shelters')
        # Then I see a section for "Shelter's with Pending Applications"
        # And in this section I see the name of every shelter that has a pending application
        @shelter = Shelter.create(name: 'Happy Pets', city: 'Aurora, CO', foster_program: false, rank: 9)
        @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
        @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
        @pet_1 = @shelter.pets.create!(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: @shelter.id)
        @pet_2 = @shelter_2.pets.create!(adoptable: true, age: 3, breed: 'domestic pig', name: 'Babe', shelter_id: @shelter_2.id)
        @pet_3 = @shelter.pets.create!(adoptable: true, age: 4, breed: 'chihuahua', name: 'Elle', shelter_id: @shelter.id)

        @application_1 = Application.create!(name:'Julius Caesar',
                                          street_address: '123 Copperfield Lane',
                                          city: 'Atlanta', state: 'GA',
                                          zip_code: '30301',
                                          description: 'I love dogs',
                                          application_status: 'Pending')

        @application_2 = Application.create!(name:'Miles Davis',
                                          street_address: 'Main St',
                                          city: 'Memphis', state: 'TN',
                                          zip_code: '75239',
                                          description: 'I love cats',
                                          application_status: 'In Progress')

        ApplicationPet.create!(pet: @pet_1, application: @application_1)
        ApplicationPet.create!(pet: @pet_2, application: @application_2)

        expect(Application.pending_applications.first.name).to eq(@shelter.name)
      end
    end
  end

  describe 'instance methods' do
    it 'should default application_status to in progress' do
      application = Application.new
      application.save
      application.application_status.should == 'In Progress'
    end

    it 'can check for incomplete form text fields' do
      application = Application.new(name: 'Peter', city: ' ')
      application.save
      application.form_incomplete?.should == true
    end
  end
end

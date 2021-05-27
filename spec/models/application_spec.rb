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

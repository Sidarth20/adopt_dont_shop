class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.reverse_alphabetical_order
  end
end

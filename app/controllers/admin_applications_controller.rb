class AdminApplicationsController < ApplicationController
  def show
    # @application_pets = ApplicationPet.pet_applications
    @application = Application.find(params[:id])
    @pets = @application.pets

  end
end

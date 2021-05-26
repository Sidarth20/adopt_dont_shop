class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])

    if params[:adopt_pet] && !@application.pets.include?(Pet.find(params[:adopt_pet]))
      @pets_in_application = @application.add_pet(Pet.find(params[:adopt_pet]))
    elsif params[:search]
      @pets_search = Pet.search(params[:search])
    elsif @application.application_status == 'Pending'
      @pets = @application.pets
    end
  end

  def new
  end

  def create
    @application = Application.create!(
      name: params[:name],
      street_address: params[:street_address],
      city: params[:city],
      state: params[:state],
      zip_code: params[:zip_code],
      description: params[:description]
    )
    if @application.form_incomplete?
      flash[:notice] = 'Please fill in all fields'
      redirect_to "/applications/new"
    else
      @application.save
      redirect_to "/applications/#{@application.id}"
    end
  end

  def update
    application = Application.find(params[:id])
    application.application_status = params[:status]
    application.description = params[:description]
    application.save!
    redirect_to "/applications/#{application.id}"
  end
end

class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
    if params[:search]
      @pets = Pet.where(name: params[:search])
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
    pet = Pet.find(params[:pet_id])
    application.pets << pet
    application.pets.update(
      name: params[:name]
    )
    redirect_to "/applications/#{application.id}"
  end
end

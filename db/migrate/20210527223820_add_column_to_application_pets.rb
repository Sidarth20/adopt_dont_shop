class AddColumnToApplicationPets < ActiveRecord::Migration[5.2]
  def change
    add_column :application_pets, :pending_status, :string, default: "Pending"
  end
end

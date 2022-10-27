class ModifyCoordinatesNameAndUpdateClients < ActiveRecord::Migration[7.0]
  def change
    add_column :clients, :lat, :float
    add_column :clients, :lng, :float
    rename_column :establishments, :long, :lng
  end
end

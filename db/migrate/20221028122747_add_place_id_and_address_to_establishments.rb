class AddPlaceIdAndAddressToEstablishments < ActiveRecord::Migration[7.0]
  def change
    add_column :establishments, :place_id, :text
    add_column :establishments, :address, :text
  end
end

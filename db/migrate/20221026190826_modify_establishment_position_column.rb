class ModifyEstablishmentPositionColumn < ActiveRecord::Migration[7.0]
  def change
    remove_column :establishments, :position
    add_column :establishments, :lat, :float
    add_column :establishments, :long, :float
  end
end

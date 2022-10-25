class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.belongs_to :client, index: { unique: true }, foreign_key: true
      t.belongs_to :slot, index: { unique: true }, foreign_key: true
    end
  end
end

class CreateRatings < ActiveRecord::Migration[7.0]
  def change
    create_table :ratings do |t|
      t.integer :rating
      t.text :comment
      t.references :establishment, null: false, foreign_key: true
      t.references :client, null: false, foreign_key: true
    end
  end
end

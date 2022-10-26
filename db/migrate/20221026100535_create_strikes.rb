class CreateStrikes < ActiveRecord::Migration[7.0]
  def change
    create_table :strikes do |t|
      t.string :usercellphone
      t.integer :count
      t.references :provider, null: false, foreign_key: true
    end
  end
end

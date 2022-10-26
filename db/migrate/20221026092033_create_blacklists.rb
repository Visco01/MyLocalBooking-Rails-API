class CreateBlacklists < ActiveRecord::Migration[7.0]
  def change
    create_table :blacklists do |t|
      t.string :usercellphone
      t.references :providers, null: false, foreign_key: true
    end
  end
end

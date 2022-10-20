class CreateProviders < ActiveRecord::Migration[7.0]
  def change
    create_table :providers do |t|
      t.belongs_to :app_user, index: { unique: true }, foreign_key: true
      t.boolean :isverified
      t.integer :maxstrikes
      t.string :companyname
    end
  end
end

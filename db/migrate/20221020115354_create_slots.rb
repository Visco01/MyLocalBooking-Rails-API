class CreateSlots < ActiveRecord::Migration[7.0]
  def change
    create_table :slots do |t|
      t.string :password_digest
      t.date :date
      t.belongs_to :app_user, index: { unique: true }, foreign_key: true
    end
  end
end

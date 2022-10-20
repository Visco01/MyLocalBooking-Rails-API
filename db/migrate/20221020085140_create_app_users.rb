class CreateAppUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :app_users do |t|
      t.string :cellphone
      t.string :password_digest
      t.string :email
      t.string :firstname
      t.string :lastname
      t.date :dob
    end
  end
end

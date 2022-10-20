class CreateClients < ActiveRecord::Migration[7.0]
  def change
    create_table :clients do |t|
      t.belongs_to :app_user, index: { unique: true }, foreign_key: true
    end
  end
end

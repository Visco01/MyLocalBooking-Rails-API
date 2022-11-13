class AddUniqueIndexToCellphone < ActiveRecord::Migration[7.0]
  def change
    add_index :app_users, :cellphone, unique: true
  end
end

class StrikeCountDefaultValue < ActiveRecord::Migration[7.0]
  def change
    change_column :strikes, :count, :integer, default: 1
  end
end

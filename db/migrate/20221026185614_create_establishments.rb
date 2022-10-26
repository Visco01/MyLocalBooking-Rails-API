class CreateEstablishments < ActiveRecord::Migration[7.0]
  def change
    execute <<~SQL
      create type coordinates as (
          lat float,
          long float
      );
    SQL
    create_table :establishments do |t|
      t.string :name
      t.column :position, :coordinates
      # t.integer :position
      t.references :provider, null: false, foreign_key: true
    end
  end
end

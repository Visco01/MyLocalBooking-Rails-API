class RenameProvidersIdBlacklists < ActiveRecord::Migration[7.0]
  def change
    rename_column :blacklists, :providers_id, :provider_id
  end
end

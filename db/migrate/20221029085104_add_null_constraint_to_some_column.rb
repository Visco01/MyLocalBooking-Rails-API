class AddNullConstraintToSomeColumn < ActiveRecord::Migration[7.0]
  def change
    change_column_null :reservations, :slot_id, false
    change_column_null :reservations, :client_id, false
    change_column_null :slots, :app_user_id, false
  end
end

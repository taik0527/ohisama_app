class ChangeNotNullToInvitations < ActiveRecord::Migration[6.1]
  def change
    change_column_null :invitations, :expired_at, false
  end
end

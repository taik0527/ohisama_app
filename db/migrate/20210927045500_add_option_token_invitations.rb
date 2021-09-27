class AddOptionTokenInvitations < ActiveRecord::Migration[6.1]
  def change
    add_index :invitations, :token, unique: true
  end
end

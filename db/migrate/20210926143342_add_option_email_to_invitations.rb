class AddOptionEmailToInvitations < ActiveRecord::Migration[6.1]
  def change
    add_index :invitations, :email, unique: true
  end
end

# frozen_string_literal: true

class AddExpiredAtToInvitations < ActiveRecord::Migration[6.1]
  def change
    add_column :invitations, :expired_at, :datetime, null: true
  end
end

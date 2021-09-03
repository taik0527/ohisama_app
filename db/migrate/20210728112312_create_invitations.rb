# frozen_string_literal: true

class CreateInvitations < ActiveRecord::Migration[6.1]
  def change
    create_table :invitations do |t|
      t.string :token, null: false
      t.string :email, null: false

      t.timestamps
    end
  end
end

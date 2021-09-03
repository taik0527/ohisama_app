# frozen_string_literal: true

class CreateUserRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :user_records do |t|
      t.references  :user, index: true, foreign_key: true
      t.references  :record, index: true, foreign_key: true

      t.timestamps
    end
  end
end

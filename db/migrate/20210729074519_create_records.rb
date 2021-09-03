# frozen_string_literal: true

class CreateRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :records do |t|
      t.text :body, null: false
      t.string :classroom, null: false

      t.timestamps
    end
  end
end

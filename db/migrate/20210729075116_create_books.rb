# frozen_string_literal: true

class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.string :google_books_api_id, null: false
      t.boolean :storage, default: false, null: false

      t.timestamps
    end
  end
end

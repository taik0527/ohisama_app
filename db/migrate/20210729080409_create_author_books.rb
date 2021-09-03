# frozen_string_literal: true

class CreateAuthorBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :author_books do |t|
      t.references  :book, index: true, foreign_key: true
      t.references  :author, index: true, foreign_key: true

      t.timestamps
    end
  end
end

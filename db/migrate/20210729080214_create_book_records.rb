# frozen_string_literal: true

class CreateBookRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :book_records do |t|
      t.references  :book, index: true, foreign_key: true
      t.references  :record, index: true, foreign_key: true

      t.timestamps
    end
  end
end

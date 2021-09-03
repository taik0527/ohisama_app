# frozen_string_literal: true

class AddPublisherToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :publisher, :string, null: false
  end
end

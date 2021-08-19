# frozen_string_literal: true

class ChangeNotNullToAuthors < ActiveRecord::Migration[6.1]
  def change
    change_column_null :authors, :name, false
  end
end

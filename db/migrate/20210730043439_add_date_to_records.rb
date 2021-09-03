# frozen_string_literal: true

class AddDateToRecords < ActiveRecord::Migration[6.1]
  def change
    add_column :records, :date, :date
  end
end

# frozen_string_literal: true

class RemoveTimeRequiredFromBook < ActiveRecord::Migration[6.1]
  def change
    remove_column :books, :time_required, :string
  end
end

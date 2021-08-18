class AddTimeRequiredToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :time_required, :string
  end
end

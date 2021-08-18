class ChangeNotNullToRecords < ActiveRecord::Migration[6.1]
  def change
    change_column_null :records, :date, false
  end
end

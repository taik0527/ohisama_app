class AddOptionGoogleBooksApiIdToBooks < ActiveRecord::Migration[6.1]
  def change
    add_index :books, :google_books_api_id, unique: true
  end
end

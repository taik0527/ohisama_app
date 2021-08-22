# frozen_string_literal: true

puts 'Start inserting seed "books" ...'
search_google_books = SearchGoogleBooks.new(keyword: '絵本')
books = GoogleBook.search(search_google_books.keyword)
books.each do |book|
  google_book = GoogleBook.new_from_id(book.google_books_api_id)
  google_book.save
  puts "\"#{google_book.title}\" has created!"
end

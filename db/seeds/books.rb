puts 'Start inserting seed "books" ...'
search_form = SearchBooksForm.new(keyword: "rails")
result_books = GoogleBook.search(search_form.keyword)
result_books.each do |result_book|
  google_book = GoogleBook.new_from_id(result_book.google_books_api_id)
  book = Book.new(title: google_book.title,
    publisher: google_book.publisher,
    google_books_api_id: google_book.google_books_api_id,
    storage: true)
  image_url = google_book.image
  if image_url.present?
    file = URI.open(image_url)
    book.image.attach(io: file, filename: "profile_image.#{file.content_type_parse.first.split("/").last}", content_type: file.content_type_parse.first)
  else
    book.image.attach(io: File.open(Rails.root.join('app/assets/images/no_image.jpeg')), filename: 'no_image.jpeg')
  end
  book.save

  authors = google_book.authors
  if authors.present?
    authors.map do |author|
      author.delete!("　")
      author.delete!(" ")
    end
    authors.each do |author|
      if Author.where(name: author).count >= 1
        duplicate_author = Author.where(name: author)
        book.authors << duplicate_author
      else
        author = Author.new(name: author)
        author.save
        book.authors << author
      end
    end
  end
  puts "\"#{book.title}\" has created!"
end
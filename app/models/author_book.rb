# frozen_string_literal: true

# == Schema Information
#
# Table name: author_books
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  author_id  :bigint
#  book_id    :bigint
#
# Indexes
#
#  index_author_books_on_author_id  (author_id)
#  index_author_books_on_book_id    (book_id)
#
# Foreign Keys
#
#  fk_rails_...  (author_id => authors.id)
#  fk_rails_...  (book_id => books.id)
#
class AuthorBook < ApplicationRecord
  belongs_to :book, optional: true
  belongs_to :author, optional: true
end

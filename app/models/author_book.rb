class AuthorBook < ApplicationRecord
  belongs_to :book, optional: true
  belongs_to :author, optional: true
end

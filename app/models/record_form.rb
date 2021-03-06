# frozen_string_literal: true

class RecordForm
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations

  attribute :date, :date
  attribute :classroom, :string
  attribute :image
  attribute :body, :string
  attribute :user_ids
  attribute :google_books_api_ids

  validates :user_ids, presence: true
  validates :google_books_api_ids, presence: true
  validates :body, presence: true
  validates :date, presence: true
  validates :classroom, presence: true

  def save
    return false unless valid?

    record = build_record

    ActiveRecord::Base.transaction do
      record.save!

      users = User.find(user_ids)
      record.users = users

      google_books_api_ids.each do |google_books_api_id|
        if Book.exists?(google_books_api_id: google_books_api_id)
        else
          google_book = GoogleBook.new_from_id(google_books_api_id)
          google_book.save
        end
        book = Book.find_by(google_books_api_id: google_books_api_id)
        record.books << book
      end
    end
    true
  end

  private

  def build_record
    Record.new(
      date: date,
      classroom: classroom,
      body: body,
      image: image
    )
  end
end

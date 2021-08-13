class RecordForm
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations

  attribute :date, :date
  attribute :classroom, :string
  attribute :images
  attribute :body, :string
  attribute :user_ids
  attribute :google_books_api_ids

  def save
    record = build_record
    ActiveRecord::Base.transaction do
      record.save
      user_ids.each do |user_id|
        user = User.find(user_id)
        record.users << user
      end
      google_books_api_ids.each do |google_books_api_id|
        # 既存かどうかの判定
        if Book.exists?(google_books_api_id: google_books_api_id)
          book = Book.find_by(google_books_api_id: google_books_api_id)
          record.books << book
        else
          google_book = GoogleBook.new_from_id(google_books_api_id)
          # 保存処理
          google_book.save
          book = Book.find_by(google_books_api_id: google_books_api_id)
          record.books << book
        end
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
      images: images
    )
  end

end
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
  end

end
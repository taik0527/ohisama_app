# frozen_string_literal: true

require 'google_books_api'
require 'open-uri'
class GoogleBook
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations

  attribute :google_books_api_id, :string
  attribute :authors
  attribute :publisher, :string
  attribute :image, :string
  attribute :title, :string

  validates :google_books_api_id, presence: true
  validates :title, presence: true

  class << self
    include GoogleBooksApi

    def new_from_item(item)
      @item = item
      @volume_info = @item['volumeInfo']
      new(
        google_books_api_id: @item['id'],
        authors: @volume_info['authors'],
        publisher: @volume_info['publisher'],
        image: image_url,
        title: @volume_info['title']
      )
    end

    def new_from_id(google_books_api_id)
      url = url_of_creating_from_id(google_books_api_id)
      item = get_json_from_url(url)
      new_from_item(item)
    end

    def search(keyword)
      url = url_of_searching_from_keyword(keyword)
      json = get_json_from_url(url)
      items = json['items']
      return [] unless items

      items.map do |item|
        GoogleBook.new_from_item(item)
      end
    end

    private

    def image_url
      if @volume_info['imageLinks'].present?
        @volume_info['imageLinks']['smallThumbnail']
      else
        '/no_image.jpeg'
      end
    end
  end

  def save
    book = build_book
    if image != '/no_image.jpeg'
      file = URI.open(image)
      book.image.attach(io: file, filename: "profile_image.#{file.content_type_parse.first.split('/').last}",
                        content_type: file.content_type_parse.first)
    else
      book.image.attach(io: File.open(Rails.root.join('app/assets/images/no_image.jpeg')), filename: 'no_image.jpeg')
    end
    ActiveRecord::Base.transaction do
      book.save
      authors_space_delete if authors.present?
      authors_save(book) if authors.present?
    end
    true
  end

  private

  def authors_space_delete
    authors.map do |author|
      author.delete!('　')
      author.delete!(' ')
    end
  end

  def authors_save(book)
    authors.each do |author|
      author = Author.find_or_create_by(name: author)
      book.authors << author
    end
  end

  def build_book
    Book.new(
      google_books_api_id: google_books_api_id,
      publisher: publisher,
      title: title
    )
  end
end

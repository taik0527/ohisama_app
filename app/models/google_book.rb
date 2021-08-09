require 'google_books_api'

class GoogleBook
    include ActiveModel::Model
    include ActiveModel::Attributes
    include ActiveModel::Validations
  
    attribute :google_books_api_id, :string
    attribute :authors
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
          image: image_url,
          title: @volume_info['title'],
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
          return '/assets/no_image.jpeg'
        end
      end
    end
  
    def find_book_or_save
      if Book.find_by(google_books_api_id: google_books_api_id) || save
        Book.find_by(google_books_api_id: google_books_api_id)
      else
        false
      end
    end
  end
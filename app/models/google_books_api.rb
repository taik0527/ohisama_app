# frozen_string_literal: true

require 'net/https'
require 'json'
require 'addressable/uri'

module GoogleBooksApi
  def url_of_creating_from_id(google_books_api_id)
    "https://www.googleapis.com/books/v1/volumes/#{google_books_api_id}"
  end

  def url_of_searching_from_keyword(keyword)
    "https://www.googleapis.com/books/v1/volumes?q=#{keyword}&country=JP"
  end

  def get_json_from_url(url)
    JSON.parse(Net::HTTP.get(URI.parse(Addressable::URI.encode(url))))
  end
end

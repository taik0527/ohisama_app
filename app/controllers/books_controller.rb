require 'net/http'
require 'uri'
require 'json'
require 'httparty'
require 'open-uri'
class BooksController < ApplicationController
  def index
    @books = Book.where(storage: true)
    @authors = Author.all
  end

  def new
    @search_form = SearchBooksForm.new(search_books_params)
    @books = GoogleBook.search(@search_form.keyword)
    @title = params[:title] if params[:title].present?
    @google_books_api_id = params[:google_books_api_id] if params[:google_books_api_id].present?
    @authors = params[:authors] if params[:authors].present?
    @image = params[:image] if params[:image].present?
  end
  
  def search
    @search_form = SearchBooksForm.new(search_books_params)
    @books = GoogleBook.search(@search_form.keyword)
    render :new
  end

  def create
    @book = Book.new(book_params)
    @book.storage = true
    @author = Author.new(authors_params)
    image_url = params[:image]
    file = URI.open(image_url)
    @book.image.attach(io: file, filename: "profile_image.#{file.content_type_parse.first.split("/").last}", content_type: file.content_type_parse.first)

    if @book.save && @author.save
      #Book.author_save(@author) #中間テーブルに保存する処理を書きたい
      redirect_to books_path, success: '蔵書に登録しました'
    else
      redirect_to new_book_path, notice: '登録できません'
    end
  end

  def destroy
  end

  private

  def book_params
    params.permit(:title, :google_books_api_id)
  end

  def authors_params
    params.permit(:name)
  end

  def search_books_params
    params.permit(:keyword)
  end

end
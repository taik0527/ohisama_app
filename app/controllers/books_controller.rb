require 'net/http'
require 'uri'
require 'json'
require 'httparty'
class BooksController < ApplicationController
  def index
  end

  def new
    @search_form = SearchBooksForm.new(search_books_params)
    @books = GoogleBook.search(@search_form.keyword)
    @title = params[:title] if params[:title].present?
    @code = params[:google_books_api_id] if params[:google_books_api_id].present?
    @authors = params[:authors] if params[:authors].present?
    @image = params[:image] if params[:image].present?
  end
  
  def search
    @search_form = SearchBooksForm.new(search_books_params)
    @books = GoogleBook.search(@search_form.keyword)
    render :new
  end

  def create
    #booksテーブルに保存する
    @book = Book.new(book_params)
    byebug
    redirect_to books_path, success: 'ユーザーを招待しました'
  end

  def destroy
  end

  private

  def book_params
    params.require(:book).permit(:title, :authors, :image, :google_books_api_id)
  end

  def search_books_params
    params.permit(:keyword)
  end

end
require 'open-uri'
class BooksController < ApplicationController
  def index
    @books = Book.where(storage: true).page(params[:page]).per(10)
  end

  def new
    @search_form = SearchBooksForm.new
    @books = GoogleBook.new
  end
  
  def search
    @search_form = SearchBooksForm.new(search_books_params)
    @books = GoogleBook.search(@search_form.keyword)
  end

  def select
    @google_book = GoogleBook.new_from_id(params[:google_books_api_id])
  end

  def create
    # 本が既存かどうかのを判定
    if Book.exists?(google_books_api_id: params[:google_books_api_id])
      @book = Book.find_by(google_books_api_id: params[:google_books_api_id])
      # 既存の本が蔵書かどうかを判定
      if @book.storage
        redirect_to new_book_path, alert: '登録済みです'
      else 
        @book.storage = true
        @book.save
        redirect_to books_path, notice: '蔵書に登録しました'
      end
    else
      @google_book = GoogleBook.new_from_id(params[:google_books_api_id])
      # 保存処理
      if @google_book.save
        @book = Book.find_by(google_books_api_id: params[:google_books_api_id])
        @book.storage = true
        @book.save
        redirect_to books_path, notice: '蔵書に登録しました'
      else 
        redirect_to new_book_path, alert: '登録できません'
      end
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path, notice: "蔵書「#{@book.title}」を削除しました。"
  end

  private

  def search_books_params
    params.require(:search_books_form).permit(:keyword)
  end

end
# frozen_string_literal: true

class BooksController < ApplicationController
  def index
    @search_form = SearchForm.new
    @books = Book.where(storage: true).page(params[:page]).per(10)
  end

  def new
    @search_form = SearchForm.new
    @books = GoogleBook.new
  end

  def create
    if @book = Book.find_by(google_books_api_id: params[:google_books_api_id])
      if @book.storage
        redirect_to books_path, alert: '登録済みです'
      else
        @book.storage = true
        @book.save
        redirect_to books_path, notice: '蔵書に登録しました'
      end
    else
      @google_book = GoogleBook.new_from_id(params[:google_books_api_id])
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

  def search_google
    @search_form = SearchForm.new(search_form_params)
    @books = GoogleBook.search(@search_form.keyword)
  end

  def select
    @google_book = GoogleBook.new_from_id(params[:google_books_api_id])
  end

  def search
    @search_form = SearchForm.new(search_form_params)
    @books = Book.storage.includes(:authors).references(:authors).search(@search_form.keyword).page(params[:page]).per(10)
    render :index
  end

  private

  def search_form_params
    params.require(:search_form).permit(:keyword)
  end
end

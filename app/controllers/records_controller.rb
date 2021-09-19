# frozen_string_literal: true

class RecordsController < ApplicationController

  def index
    @records = Record.all.order(date: 'DESC').page(params[:page]).per(10)
    @search_form = SearchForm.new
  end

  def new
    @record_form = RecordForm.new
    @search_form = SearchForm.new
  end

  def create
    @record_form = RecordForm.new(record_form_params)
    if @record_form.save
      redirect_to records_path, notice: '記録を投稿しました'
    else
      @search_form = SearchForm.new
      flash.now[:danger] = '投稿できません'
      render :new
    end
  end

  def show
    @record = Record.find(params[:id])
  end

  def edit
    @record = Record.find(params[:id])
    @search_form = SearchForm.new
  end

  def update
    @record = Record.find(params[:record_id])
    user_ids = params[:user_ids]
    userrecords = UserRecord.where(record_id: params[:record_id])
    if user_ids.present? && @record.update(record_params)
      userrecords.each(&:destroy)
      user_ids.each do |user_id|
        user = User.find(user_id)
        @record.users << user
      end
      redirect_to record_path, notice: '記録を更新しました'
    else
      @search_form = SearchForm.new
      flash.now[:danger] = '更新できません'
      render :edit
    end
  end

  def destroy
    @record = Record.find(params[:id])
    @record.destroy
    redirect_to records_path, notice: '記録を削除しました。'
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
    @records = Record.includes(:books, :users).references(:books,
                                                          :users).search(@search_form.keyword).order(date: 'DESC').page(params[:page]).per(10)
    render :index
  end

  def edit_search_google
    @search_form = SearchForm.new(keyword: params[:keyword])
    @books = GoogleBook.search(@search_form.keyword)
    @record = Record.find(params[:record_id])
  end

  def edit_select
    @record = Record.find(params[:record_id])
    if Book.exists?(google_books_api_id: params[:google_books_api_id])
      book = Book.find_by(google_books_api_id: params[:google_books_api_id])
      if BookRecord.exists?(book_id: book.id, record_id: @record.id)
        flash.now[:danger] = '保存済みです'
      else
        @record.books << book
      end
    else
      @google_book = GoogleBook.new_from_id(params[:google_books_api_id])
      @google_book.save
      book = Book.find_by(google_books_api_id: params[:google_books_api_id])
      @record.books << book
    end
  end

  def destroy_book
    record_book = BookRecord.find_by(record_id: params[:record_id], book_id: params[:book_id])
    record_book.destroy
    @record = Record.find(params[:record_id])
  end

  private

  def record_form_params
    params.require(:record_form).permit(:date, :classroom, :body, :image, google_books_api_ids: [], user_ids: [])
  end

  def record_params
    params.permit(:date, :classroom, :body, :image)
  end

  def search_form_params
    params.require(:search_form).permit(:keyword)
  end

  def set_search_form
    @search_form = SearchForm.new
  end
end

class RecordsController < ApplicationController
  def index
    @record = Record.all
  end

  def new
    @record = Record.new
    @users = User.all
    @search_form = SearchBooksForm.new
    @books = GoogleBook.new
  end

  def search
    @search_form = SearchBooksForm.new(search_books_params)
    @books = GoogleBook.search(@search_form.keyword)
  end

  def select
    @title = params[:title] # if params[:title].present?
    @google_books_api_id = params[:google_books_api_id] # if params[:google_books_api_id].present?
    @image = params[:image] # if params[:image].present?
  end

  def create
    render :index
  end
  
  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def record_params
    params.permit(:date, :classroom, :images, :body)
  end

  def search_books_params
    params.permit(:keyword)
  end
end

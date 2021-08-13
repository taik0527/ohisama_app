require 'open-uri'
class RecordsController < ApplicationController
  before_action :set_record, only: %i[show update edit destroy]
  def index
    @records = Record.all.order(date: "DESC")
  end

  def new
    @record_form = RecordForm.new
    @search_form = SearchBooksForm.new
    @books = GoogleBook.new
  end

  def search
    @search_form = SearchBooksForm.new(search_books_params)
    @books = GoogleBook.search(@search_form.keyword)
  end

  def select
    @title = params[:title]
    @google_books_api_id = params[:google_books_api_id]
    @image = params[:image]
    if @image.nil?
      @image = '/assets/no_image.jpeg'
    end
  end

  def create
    @record_form = RecordForm.new(record_form_params)
    if @record_form.save
      redirect_to records_path, notice: '記録を投稿しました'
    else
      @record = Record.new
      @search_form = SearchBooksForm.new
      @users = User.all
      flash.now[:danger] = "投稿できません"
      render :edit
    end
  end
  
  def show
  end

  def edit
    @users = User.all
    @search_form = SearchBooksForm.new
    @books = GoogleBook.new
  end

  def update
    if @record.update(record_params)
      #　ここで本の更新と読み手の更新も行わないといけない
      user_ids.each do |user_id|
        user = User.find(user_id)
        @record.users << user
      end
      redirect_to record_path(@record), notice: "記録を更新しました。"
    else
      flash.now[:danger] = "更新できません"
      render :edit
    end
  end

  def destroy
    @record.destroy
    redirect_to records_path, notice: "記録を削除しました。"
  end

  private

  def record_form_params
    params.require(:record_form).permit(:date, :classroom, :body, google_books_api_ids: [], user_ids: [], images: [])
  end

  def search_books_params
    params.require(:search_books_form).permit(:keyword)
  end

  def set_record
    @record = Record.find(params[:id])
  end
end

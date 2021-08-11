require 'open-uri'
class RecordsController < ApplicationController
  before_action :set_record, only: %i[show update edit destroy]
  def index
    @records = Record.all.order(date: "DESC")
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
    @title = params[:title]
    @google_books_api_id = params[:google_books_api_id]
    @image = params[:image]
    if @image.nil?
      @image = '/assets/no_image.jpeg'
    end
  end

  def create
    # recordのインスタンス作る
    @record = Record.new(record_params)
    # user_ids受け取る
    user_ids = params[:user_ids]
    google_books_api_ids = params[:google_books_api_ids]

    # recordの保存
    if @record.save
      # user_idをそれぞれ@recordに紐付ける
      user_ids.each do |user_id|
        user = User.find(user_id)
        @record.users << user
      end
      # google_books_api_idsの数だけ回す
      google_books_api_ids.each do |google_books_api_id|
        # もしapi_idがレコードにあったらそれと紐づける
        if Book.where(google_books_api_id: google_books_api_id).count >= 1
          book = Book.where(google_books_api_id: google_books_api_id)
          @record.books << book # 被ってる
        else
          @google_book = GoogleBook.new_from_id(google_books_api_id)
          @book = Book.new(title: @google_book.title, publisher: @google_book.publisher, google_books_api_id: google_books_api_id)
          image_url = @google_book.image
          # 表紙画像があればそれを入れる
          if image_url.present?
            file = URI.open(image_url)
            @book.image.attach(io: file, filename: "profile_image.#{file.content_type_parse.first.split("/").last}", content_type: file.content_type_parse.first)
          # なければno_imageを入れる
          else
            @book.image.attach(io: File.open(Rails.root.join('app/assets/images/no_image.jpeg')), filename: 'no_image.jpeg')
          end
          # bookを保存
          if @book.save
            authors = @google_book.authors
            # もし著者が空でなければ
            if authors.present?
              # authorの空白を削除
              authors.map do |author|
                author.delete!("　")
                author.delete!(" ")
              end
              authors.each do |author|
                # もし同じ著者がいたら保存せずにそのレコードを紐付ける
                if Author.where(name: author).count >= 1
                  duplicate_author = Author.where(name: author)
                  @book.authors << duplicate_author
                # 同じ著者がいなければ保存して紐付ける
                else
                  author = Author.new(name: author)
                  author.save
                  @book.authors << author
                end
              end
            end
          # recordとbookの紐付け
          @record.books << @book #被ってる
          end
        end
      end
      redirect_to records_path, notice: '記録を投稿しました'
    else
      @search_form = SearchBooksForm.new
      @users = User.all
      render :new
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

  def record_params
    params.permit(:date, :classroom, :images, :body)
  end

  # def record_form_params
    # params.require(:record_form).permit(:date, :classroom, :images, :body, :user_ids, :google_books_api_ids)
  # end

  def search_books_params
    params.require(:search_books_form).permit(:keyword)
  end

  def set_record
    @record = Record.find(params[:id])
  end
end

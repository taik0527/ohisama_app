require 'open-uri'
class BooksController < ApplicationController
  def index
    @books = Book.where(storage: true)
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
    @title = params[:title]
    @authors = params[:authors]
    @google_books_api_id = params[:google_books_api_id]
    @image = params[:image]
  end

  def create
    # 定義
    google_books_api_id = params[:google_books_api_id]
    @google_book = GoogleBook.new_from_id(google_books_api_id)

    # もしレコードに同じ本があれば既に登録済みですとエラーを出す
    if Book.where(google_books_api_id: google_books_api_id).count >= 1
      @book = Book.find_by(google_books_api_id: google_books_api_id)
      # storageがtrueだったら登録済み
      if @book.storage
        redirect_to new_book_path, notice: '既に登録済みです'
      # storageがfalseだったらtrueにして保存
      else
        @book.storage = true
        @book.save
        redirect_to books_path, notice: '蔵書に登録しました'
      end
    # bookとauthorの保存処理
    else
      @book = Book.new(title: @google_book.title, google_books_api_id: google_books_api_id, storage: true)
      authors = @google_book.authors
      image_url = @google_book.image
      if image_url != '/assets/no_image.jpeg'
        file = URI.open(image_url)
        @book.image.attach(io: file, filename: "profile_image.#{file.content_type_parse.first.split("/").last}", content_type: file.content_type_parse.first)
      else
        @book.image.attach(io: File.open(Rails.root.join('app/assets/images/no_image.jpeg')), filename: 'no_image.jpeg')
      end
      if @book.save
        if authors.present?
          authors.map do |author|
            author.delete!("　")
            author.delete!(" ")
          end
          authors.each do |author|
            if Author.where(name: author).count >= 1
              duplicate_author = Author.where(name: author)
              @book.authors << duplicate_author
            else
              author = Author.new(name: author)
              author.save
              @book.authors << author
            end
          end
        end
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
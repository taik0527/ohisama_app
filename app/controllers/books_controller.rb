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
    @google_book = GoogleBook.new_from_id(params[:google_books_api_id])
    @book = Book.new(title: @google_book.title, google_books_api_id: params[:google_books_api_id], storage: true)
    authors = @google_book.authors
    if authors.present?
      authors.map do |author|
        author.delete!("　")
        author.delete!(" ")
      end
    end
    image_url = @google_book.image
    # 表紙画像があればそれを保存
    if image_url.present?
      file = URI.open(image_url)
      @book.image.attach(io: file, filename: "profile_image.#{file.content_type_parse.first.split("/").last}", content_type: file.content_type_parse.first)
    # なければno_imageを保存
    else
      @book.image.attach(io: File.open(Rails.root.join('app/assets/images/no_image.jpeg')), filename: 'no_image.jpeg')
    end
    # もし本がsaveできたら
    if @book.save
      # 著者を分割して保存する処理
      # データベースを参照してもし同じ著者がいたらそのレコードを紐付ける処理を書きたい
      if authors.present?
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
      # 一覧にリダイレクト
      redirect_to books_path, success: '蔵書に登録しました'
    else
      redirect_to new_book_path, notice: '登録できません'
    end
  end

  def destroy
  end

  private

  def search_books_params
    params.permit(:keyword)
  end

end
class V1::UserBooksController < ApplicationController
  before_action :set_user_book, only: %i(show destroy)

  # GET /v1/user_books
  def index
    @user_books = current_user.user_books
    render :index, status: :ok
  end

  # GET /v1/user_books/:google_id
  def show
    render :show, status: :ok
  end

  # POST /v1/user_books
  def create
    @book = Book.find_by(google_id: params[:google_id])

    if @book && current_user.books.include?(@book)
      @user_book = UserBook.find_by(book_id: @book.id)
      @user_book.assign_attributes(status: params[:status])
    else
      unless @book
        @book = Book.create(
          google_id: params[:google_id],
          title: params[:title],
          subtitle: params[:subtitle]
        )
      end

      @user_book = current_user.user_books.new(
        book_id: @book.id,
        status: params[:status]
      )
    end

    @user_book.save ? head(:ok) : render_json_errors(@user_book)
  end

  # DELETE /v1/user_books/:google_id
  def destroy
    @user_book.destroy ? head(:no_content) : head(:bad_request)
  end

  private

  def set_user_book
    book = current_user.books.find_by(google_id: params[:google_id])
    @user_book = UserBook.find_by(book_id: book.id)
  end
end

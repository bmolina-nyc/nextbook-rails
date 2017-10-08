class V1::UserBooksController < ApplicationController
  before_action :set_user_book, only: %i(show update destroy)

  # GET /v1/user_books
  def index
    @user_books = current_user.user_books
    render :index, status: :ok
  end

  # GET /v1/user_books/:id
  def show
    render :show, status: :ok
  end

  # POST /v1/user_books
  def create
    @book = find_or_create_book
    @user_book = current_user.user_books.create do |ub|
      ub.status = params[:status]
      ub.google_id = @book.id
    end
    if @user_book
      render :show, status: :ok
    else
      render_json_errors @user_book
    end
  end

  # PUT/PATCH /v1/user_books
  def update
    if @user_book.update status: params[:status]
      render :show, status: :ok
    else
      render_json_errors @user_book
    end
  end

  # DELETE /v1/user_books/:id
  def destroy
    @user_book.destroy ? head(:no_content) : head(:bad_request)
  end

  private

  def book_params
    params.require(:book).permit(:title, :subtitle, :google_id)
  end

  def find_or_create_book
    Book.find(book_params[:google_id])
  rescue ActiveRecord::RecordNotFound
    Book.create(book_params)
  end

  def set_user_book
    @user_book ||= UserBook.find(params[:id])
  end
end

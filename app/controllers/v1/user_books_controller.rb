class V1::UserBooksController < ApplicationController
  before_action :set_user_book, only: %i(show create update destroy)

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
    @user_book = current_user.user_books.new(user_params)

    if @user.save
      render :create, status: :created
    else
      render_json_errors(@user)
    end
  end

  # PUT/PATCH /v1/user_books/:id
  def update
    if @user_book.update(status: user_books_params[:status])
      render :create, status: :ok
    else
      render_json_errors(@user)
    end
  end

  # DELETE /v1/user_books/:google_id
  def destroy
    @user_book.destroy ? head(:no_content) : head(:bad_request)
  end

  private

  def set_user_book
    @user_book = UserBook.find(user_books_params[:google_id])
  end

  def user_books_params
    params.require(:user_book).permit(:status, :google_id)
  end
end

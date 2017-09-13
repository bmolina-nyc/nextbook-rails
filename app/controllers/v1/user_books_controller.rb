class V1::UserBooksController < ApplicationController
  before_action :set_user_book, only: %i(show update destroy)

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
    begin
      @user_book = UserBook.find(user_book_params[:google_id])
    rescue ActiveRecord::RecordNotFound
      @user_book = current_user.user_books.new(user_book_params)
    else
      @user_book.assign_attributes(status: user_book_params[:status])
    ensure
      @user_book.save ? render(:create, status: :ok)
                      : render_json_errors(@user_book)
    end
  end

  # PUT/PATCH /v1/user_books/:google_id
  def update
    if @user_book.update(status: user_book_params[:status])
      render :create, status: :ok
    else
      render_json_errors(@user_book)
    end
  end

  # DELETE /v1/user_books/:google_id
  def destroy
    @user_book.destroy ? head(:no_content) : head(:bad_request)
  end

  private

  def set_user_book
    @user_book = UserBook.find(params[:google_id])
  end

  def user_book_params
    params.require(:user_book).permit(:status, :google_id)
  end
end

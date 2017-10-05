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

  end

  # DELETE /v1/user_books/:google_id
  def destroy
    @user_book.destroy ? head(:no_content) : head(:bad_request)
  end

  private

  def set_user_book
  end
end

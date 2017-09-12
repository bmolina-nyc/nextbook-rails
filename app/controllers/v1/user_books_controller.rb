class V1::UserBooksController < ApplicationController

  # POST /v1/user_books
  def create
  end

  # DELETE /v1/user_books
  def destroy
  end

  private

  def user_books_params
    params.require(:user_book).permit(:status, :google_id)
  end
end

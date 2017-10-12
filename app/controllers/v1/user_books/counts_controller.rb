class V1::UserBooks::CountsController < ApplicationController

  # GET v1/user_books/counts
  def show
    counts = current_user.user_books.group(:status).count
    render json: counts, status: :ok
  end
end

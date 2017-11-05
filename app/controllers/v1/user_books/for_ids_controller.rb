class V1::UserBooks::ForIdsController < ApplicationController

  # GET v1/user_books/for_ids
  def show
    @user_books = params[:ids]&.map do |id|
      current_user.user_books.find_by(google_id: id)
    end
    @user_books.compact! if @user_books
    render 'v1/user_books/index', status: :ok
  end
end

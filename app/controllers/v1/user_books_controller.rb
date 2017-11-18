class V1::UserBooksController < ApplicationController
  before_action :set_user_book, only: [:show, :destroy]

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
    @book = find_or_create_book
    if @user_book = find_user_book(book_params[:id])
      @user_book.update status: params[:status]
      fetch_if_liked
      render :show, status: :ok
    elsif @user_book = create_user_book
      fetch_if_liked
      render :show, status: :ok
    else
      render_json_errors @user_book
    end
  end

  # DELETE /v1/user_books/:google_id
  def destroy
    @user_book.destroy ? head(:no_content) : head(:bad_request)
  end

  private

  def fetch_if_liked
    @user_book.status == 'liked' && fetch_recommendations
  end

  def fetch_recommendations
    return nil if current_user.recommender_job
    if current_user.can_fetch_recommendations?
      FetchRecommendationsJob.set(wait: 5.seconds).perform_later(current_user)
    else
      date = 5.minutes.since(current_user.last_request_date)
      FetchRecommendationsJob.set(wait_until: date).perform_later(current_user)
    end
  end

  def create_user_book
    current_user.user_books.create do |ub|
      ub.status = params[:status]
      ub.google_id = @book.google_id
    end
  end

  def book_params
    permitted = %i(title subtitle id published_date page_count)
    params.require(:book).permit(permitted)
  end

  def find_or_create_book
    book = Book.find_by(google_id: book_params[:id])
    return book if book
    Book.create do |b|
      b.title = book_params[:title]
      b.subtitle = book_params[:subtitle]
      b.google_id = book_params[:id]
      b.published_date_string = book_params[:published_date]
      b.published_date = Book.published_date(book_params[:published_date])
      b.page_count = book_params[:page_count]
    end
  end

  def set_user_book
    @user_book ||= find_user_book(params[:google_id])
  end

  def find_user_book(google_id)
    current_user.user_books.find_by(google_id: google_id)
  end
end

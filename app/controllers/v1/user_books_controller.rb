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
    @user_book = create_user_book
    if @user_book
      @user_book.status == 'liked' && fetch_recommendations
      render :show, status: :ok
    else
      render_json_errors @user_book
    end
  end

  # PUT/PATCH /v1/user_books
  def update
    if @user_book.update status: params[:status]
      @user_book.status == 'liked' && fetch_recommendations
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
    params.require(:book).permit(:title, :subtitle, :google_id, :date_published)
  end

  def find_or_create_book
    book = Book.find_by(google_id: book_params[:google_id])
    return book if book
    Book.create(book_params)
  end

  def set_user_book
    @user_book ||= UserBook.find(params[:id])
  end
end

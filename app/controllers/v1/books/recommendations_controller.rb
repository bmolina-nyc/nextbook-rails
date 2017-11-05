class V1::Books::RecommendationsController < V1::BooksController

  # GET v1/books/recommendations
  def index
    data = {
      books: lookup_books(book_ids),
      last_request_date: current_user.last_request_date,
      pending_date: pending_date,
      count: filtered_books.count
    }
    render json: data, status: :ok
  end

  private

  def filtered_books
    @books ||= current_user.recommendations
  end

  def pending_date
    job = Delayed::Job.find_by(id: current_user.recommender_job)
    job.run_at if job
  end
end

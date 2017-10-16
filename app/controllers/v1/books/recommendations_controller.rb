class V1::Books::RecommendationsController < ApplicationController

  # GET v1/books/recommendations
  def index
    data = {
      books: recommendations,
      last_request_date: current_user.last_request_date,
      pending_date: pending_date
    }
    render json: data, status: :ok
  end

  private

  def pending_date
    job = Delayed::Job.find_by(id: current_user.recommender_job)
    job.run_at if job
  end

  def recommendations
    recommendation_ids.map { |id| google_books_lookup(id) }
  end

  def google_books_lookup(id)
    GoogleBooksApi::Lookup.new(id, current_user).call
  end

  def recommendation_ids
    current_user.user_books.recommended
    .order(updated_at: 'DESC')
    .pluck :google_id
  end
end

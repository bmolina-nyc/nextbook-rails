class V1::BooksController < ApplicationController

  # GET /v1/books
  def show
    book = google_books_lookup(params[:id])
    render json: book, status: :ok
  end

  private

  def google_books_lookup(id)
    GoogleBooksApi::Lookup.new(id, current_user).call
  end

  def lookup_books(book_ids)
    book_ids.map { |id| google_books_lookup(id) }
  end

  def sort(sort, sort_dir)
    case sort
    when 'added'
      "user_books.created_at #{sort_dir || 'DESC'}"
    when 'updated'
      "user_books.updated_at #{sort_dir || 'DESC'}"
    when 'title'
      "title #{sort_dir || 'ASC'}"
    when 'page_count'
      "page_count #{sort_dir || 'DESC'}"
    when 'published'
      "published_date #{sort_dir || 'DESC'}"
    end
  end

  def book_ids
    filtered_books
    .order(sort(books_params[:sort], params[:dir]))
    .limit(books_params[:max])
    .offset((books_params[:page] - 1) * books_params[:max])
    .pluck(:google_id)
  end

  def books_params
    @params ||= {
      page: params[:page]&.to_i || 1,
      sort: params[:sort] || 'added',
      max: params[:max]&.to_i || 18
    }
  end
end

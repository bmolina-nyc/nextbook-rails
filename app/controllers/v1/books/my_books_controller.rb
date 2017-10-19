class V1::Books::MyBooksController < ApplicationController

  # GET v1/books/my_books
  def index
    data = {
      books: my_books,
      count: books.count
    }
    render json: data, status: :ok
  end

  private

  def sort_by(filter, sort_dir)
    !filter && filter = 'date_added'
    case filter
    when 'date_added'
      !sort_dir && sort_dir = 'DESC'
      "user_books.created_at #{sort_dir}"
    when 'date_updated'
      !sort_dir && sort_dir = 'DESC'
      "user_books.updated_at #{sort_dir}"
    when 'title'
      !sort_dir && sort_dir = 'ASC'
      "title #{sort_dir}"
    when 'date_published'
      !sort_dir && sort_dir = 'DESC'
      "published_date #{sort_dir}"
    end
  end

  def my_books
    my_books_ids.map { |id| google_books_lookup(id) }
  end

  def google_books_lookup(id)
    GoogleBooksApi::Lookup.new(id, current_user).call
  end

  def filtered_books(filter)
    case filter
    when 'all'
      current_user.marked_books
    when 'liked' || 'disliked' || 'want_to_read' || 'already_read'
      current_user.books_by_status(filter)
    end
  end

  def books
    params.key?(:status_filter) ? filtered_books(params[:status_filter]) : current_user.marked_books
  end

  def my_books_ids
    books
    .limit(18)
    .offset(params.key?(:page) ? (params[:page].to_i - 1) * 15 : 0)
    .order(sort_by(params[:sort_by], params[:sort_dir]))
    .pluck(:google_id)
  end
end

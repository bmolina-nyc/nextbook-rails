class V1::Books::MyBooksController < ApplicationController

  # GET v1/books/my_books
  def index
    render json: my_books, status: :ok
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
    when 'published_date'
      !sort_dir && sort_dir = 'ASC'
      "published_date #{sort_dir}"
    end
  end

  def my_books
    my_books_ids.map { |id| google_books_lookup(id) }
  end

  def google_books_lookup(id)
    GoogleBooksApi::Lookup.new(id, current_user).call
  end

  def my_books_ids
    current_user.marked_books
    .limit(15)
    .offset(params.key?(:page) ? (params[:page].to_i - 1) * 15 : 0)
    .order(sort_by(params[:sort_by], params[:sort_dir]))
    .pluck(:google_id)
  end
end

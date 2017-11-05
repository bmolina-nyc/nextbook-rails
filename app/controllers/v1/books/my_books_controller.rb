class V1::Books::MyBooksController < V1::BooksController

  # GET v1/books/my_books[/:status]
  def index
    data = {
      books: lookup_books(book_ids),
      count: filtered_books.count
    }

    render json: data, status: :ok
  end

  private

  def filtered_books
    @books ||= current_user.marked_books
  end
end

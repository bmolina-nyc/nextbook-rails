class V1::Books::MyBooks::WantToReadController < V1::Books::MyBooksController

  # GET v1/books/my_books/want_to_read
  # def index
  # end

  private

  def filtered_books
    @books ||= current_user.want_to_read_books
  end
end

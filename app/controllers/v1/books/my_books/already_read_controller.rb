class V1::Books::MyBooks::AlreadyReadController < V1::Books::MyBooksController

  # GET v1/books/my_books/already_read
  # def index
  # end

  private

  def filtered_books
    @books ||= current_user.already_read_books
  end
end

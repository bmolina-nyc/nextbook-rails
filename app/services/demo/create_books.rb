class Demo::CreateBooks
  def call
    Demo::Data::BOOKS.each do |book|
      Book.create(book_params(book))
    end
  end

  private

  def book_params(book)
    {
      google_id: book[:google_id],
      title: book[:title],
      subtitle: book[:subtitle],
      page_count: book[:page_count],
      published_date_string: book[:published_date_string],
      published_date: Book.published_date(book[:published_date_string])
    }
  end

end

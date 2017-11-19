class GoogleBooksApi::UrlGenerator::Recommendation < GoogleBooksApi::UrlGenerator::Base

  def initialize(title, author)
    @title = title
    @author = author
  end

  private

  def params_hash
    super.merge({
      q: "intitle:#{title}+inauthor:#{author}",
      printType: PRINT_TYPE,
      maxResults: 1
    })
  end

  def fields
    "items(id)"
  end

  attr_reader :title, :author
end

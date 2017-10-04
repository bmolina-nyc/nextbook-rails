class GoogleBooksApi::UrlGenerator::Recommendation < GoogleBooksApi::UrlGenerator::Base

  def initialize(title, author)
    @title = title
    @author = author
  end

  private

  def get_params_hash
    super.merge({
      q: "intitle:#{title}+inauthor:#{author}",
      printType: PRINT_TYPE,
      maxResults: 1
    })
  end

  def get_fields
    "items(#{items_fields})"
  end

  def items_fields
    "id,volumeInfo(#{volume_info_fields})"
  end

  def volume_info_fields
    ['title', 'subtitle'].join(',')
  end

  attr_reader :title, :author
end

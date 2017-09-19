class GoogleBooksApi::UrlGenerator::Recommendation < GoogleBooksApi::UrlGenerator::Base
  include PreviewFields

  def initialize(title)
    @title = title
  end

  private

  def get_params_hash
    super.merge({
      q: "intitle:'#{title}'",
      printType: PRINT_TYPE,
      maxResults: 1
    })
  end

  attr_reader :title
end

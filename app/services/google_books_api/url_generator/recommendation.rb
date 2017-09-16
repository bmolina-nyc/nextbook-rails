class GoogleBooksApi::UrlGenerator::Recommendation < GoogleBooksApi::UrlGenerator::Base
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

  def get_fields
    "items(id,volumeInfo(#{volume_info_preview_fields}))"
  end

  attr_reader :title
end

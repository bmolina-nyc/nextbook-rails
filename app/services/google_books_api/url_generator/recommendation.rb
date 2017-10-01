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
    "items(#{items_fields})"
  end

  def items_fields
    "id,searchInfo/textSnippet,volumeInfo(#{volume_info_fields})"
  end

  def volume_info_fields
    (VOLUME_INFO_FIELDS - ['description']).join(',')
  end

  attr_reader :title
end

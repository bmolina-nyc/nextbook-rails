class GoogleBooksApi::UrlGenerator::Search < GoogleBooksApi::UrlGenerator::Base
  def initialize(query, page=nil)
    @query = query
    @page = page
  end

  private

  # Search Constant
  DEFAULT_MAX = 9

  def get_params_hash
    hash = super.merge({
      q: query,
      printType: PRINT_TYPE,
      maxResults: DEFAULT_MAX
    })
    page ? hash.merge(startIndex: calculate_start_index) : hash
  end

  def calculate_start_index
    (page.to_i - 1) * DEFAULT_MAX
  end

  def get_fields
    "totalItems,items(id,searchInfo/textSnippet,volumeInfo(#{get_volume_info_fields}))"
  end

  def get_volume_info_fields
    'title,subtitle,imageLinks/thumbnail,publishedDate,averageRating,pageCount,authors,categories'
  end

  attr_reader :query, :page
end

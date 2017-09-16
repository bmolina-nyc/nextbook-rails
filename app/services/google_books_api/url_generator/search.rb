class GoogleBooksApi::UrlGenerator::Search < GoogleBooksApi::UrlGenerator::Base
  def initialize(query, max_results: DEFAULT_MAX, start_index: nil)
    @query = query
    @max_results = max_results
    @start_index = start_index
  end

  private

  # Search Constant
  DEFAULT_MAX = 8

  def get_params_hash
    hash = super.merge({
      q: query,
      printType: PRINT_TYPE,
      maxResults: max_results
    })
    start_index ? hash.merge(startIndex: start_index) : hash
  end

  def get_fields
    "totalItems,items(id,searchInfo/textSnippet,volumeInfo(#{get_volume_info_fields}))"
  end

  def get_volume_info_fields
  'title,subtitle,imageLinks/thumbnail,publishedDate,averageRating,pageCount,authors,categories'
  end

  attr_reader :query, :max_results, :start_index
end

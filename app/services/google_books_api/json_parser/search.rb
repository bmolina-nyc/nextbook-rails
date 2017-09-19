class GoogleBooksApi::JsonParser::Search < GoogleBooksApi::JsonParser::Base
  def call
    get_hash
  end

  private

  def get_hash
    {
      total_items: get_total_items,
      items: get_items_array
    }
  end

  def get_items_array
    response['items'].map { |item| get_item_hash(item) }
  end

  def get_item_hash(item)
    super.merge(preview: get_preview(item))
  end

  def get_total_items
    response['totalItems']
  end

  attr_reader :response
end

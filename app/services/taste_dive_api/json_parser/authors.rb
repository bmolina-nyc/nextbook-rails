class TasteDiveApi::JsonParser::Authors < TasteDiveApi::JsonParser::Base
  def call
    get_authors_array
  end

  private

  def get_authors_array
    results.map { |item| get_name(item) }
  end
end

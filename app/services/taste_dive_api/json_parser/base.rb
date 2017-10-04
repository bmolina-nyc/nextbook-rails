class TasteDiveApi::JsonParser::Base
  def initialize(response)
    @results = response['Similar']['Results']
  end

  private

  def get_name(item)
    item['Name']
  end

  attr_reader :results
end

class TasteDiveApi::JsonParser
  def initialize(response)
    @response = response
  end

  def call
    get_titles_array
  end

  private

  def get_titles_array
    response['Similar']['Results'].map { |book| book['Name'] }
  end

  attr_reader :response
end

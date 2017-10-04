class TasteDiveApi::ResponseBuilder::Authors
  def initialize(authors)
    @authors = authors
  end

  private

  attr_reader :authors
end

class TasteDiveApi::UrlGenerator::Books < TasteDiveApi::UrlGenerator::Base
  private

  TYPE = 'books'

  def get_params_hash
    super.merge(
      type: TYPE,
      verbose: 1
    )
  end
end

class TasteDiveApi::UrlGenerator::Authors < TasteDiveApi::UrlGenerator::Base
  private

  TYPE = 'authors'

  def get_params_hash
    super.merge(
      type: TYPE
    )
  end
end

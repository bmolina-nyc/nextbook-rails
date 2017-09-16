class GoogleBooksApi::UrlGenerator::Lookup < GoogleBooksApi::UrlGenerator::Base
  def initialize(google_id, update=false)
    @google_id = google_id
    @update = update
  end

  private

  def get_base_url
    "#{BASE_URL}/#{google_id}"
  end

  def get_fields
    update ? "id,volumeInfo(#{volume_info_update_fields})" :
             "id,volumeInfo(#{volume_info_full_fields})"
  end

  def volume_info_update_fields
    'averageRating,ratingsCount'
  end

  attr_reader :google_id, :update
end

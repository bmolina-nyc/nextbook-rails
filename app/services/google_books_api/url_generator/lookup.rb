class GoogleBooksApi::UrlGenerator::Lookup < GoogleBooksApi::UrlGenerator::Base
  def initialize(google_id)
    @google_id = google_id
  end

  private

  def get_base_url
    "#{BASE_URL}/#{google_id}"
  end

  def get_fields
    "id,volumeInfo(#{volume_info_full_fields})"
  end

  attr_reader :google_id
end

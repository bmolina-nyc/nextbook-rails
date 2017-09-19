class GoogleBooksApi::UrlGenerator::Lookup < GoogleBooksApi::UrlGenerator::Base
  def initialize(google_id)
    @google_id = google_id
  end

  private

  def get_base_url
    "#{BASE_URL}/#{google_id}"
  end

  def get_fields
    "id,volumeInfo(#{VOLUME_INFO_FIELDS.join(',')})"
  end

  attr_reader :google_id
end

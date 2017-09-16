class GoogleBooksApi::Requester::Lookup < RequesterBase
  def initialize(google_id, update=false)
    @google_id = google_id
    @update = update
  end

  private

  def generate_url
    GoogleBooksApi::UrlGenerator::Lookup.new(google_id, update).call
  end

  attr_reader :google_id, :update
end

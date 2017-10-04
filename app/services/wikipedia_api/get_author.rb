class WikipediaApi::GetAuthor
  def initialize(wiki_page)
    @wiki_page = wiki_page
  end

  def call
    response = get_response
    parse_author(response.to_s)
  end

  private

  API_BASE_URL = 'https://en.wikipedia.org/w/api.php'
  API_PARAMS_BASE= "action=query&prop=revisions&rvprop=content&format=json&rvsection=0"
  REGEX = /author\s+=\s+\[\[([\w\s.-]+)\]\](\\|\s+and)/

  def get_response
    url = "#{API_BASE_URL}?#{API_PARAMS_BASE}&titles=#{wiki_page}"
    Rails.cache.fetch("testingwiki#{wiki_page}") do
      Requester.new(url).call
    end
  end

  def parse_author(response)
    response.scan(REGEX).to_s.gsub(/[^a-zA-Z\s.-]/, '').strip
  end

  attr_reader :wiki_page
end

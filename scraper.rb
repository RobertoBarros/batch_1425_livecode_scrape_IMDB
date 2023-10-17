require 'open-uri'
require 'nokogiri'

USER_AGENT = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36"

def fetch_top_movie_urls
  top_movies_url = 'https://www.imdb.com/chart/top/'
  html_file = URI.open(top_movies_url, 'Accept-Language' => 'en-US', 'User-Agent' => USER_AGENT).read
  html_doc = Nokogiri::HTML(html_file)

  # TODO: return top movies URLs
  links = []
  html_doc.search('.ipc-metadata-list-summary-item__tc a').first(5).each do |link|
    links << 'https://www.imdb.com' + link.attributes['href'].value.gsub(/\?.*$/,'')
  end

  links

end

def scrape_movie(url)
  html_file = URI.open(url, 'Accept-Language' => 'en-US', 'User-Agent' => USER_AGENT).read
  html_doc = Nokogiri::HTML(html_file)

  # TODO: return movie info hash
  {
    title: html_doc.search('h1').text,
    year: html_doc.search('.sc-afe43def-4.kdXikI a').first.text.to_i,
    storyline: html_doc.search('.sc-466bb6c-0.kJJttH').text
  }
end

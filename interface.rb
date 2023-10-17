require 'yaml'
require 'json'
require_relative 'scraper'

urls = fetch_top_movie_urls

movies = []
urls.each do |url|
  data = scrape_movie(url)
  # puts data[:title]
  # puts data[:year]
  # puts data[:storyline]
  # puts '-' * 50
  movies << data
end

File.open('movies.yml', 'wb') do |file|
  file.write(movies.to_yaml)
end

File.open('movies.json', 'wb') do |file|
  file.write(JSON.generate({ movies: movies }))
end

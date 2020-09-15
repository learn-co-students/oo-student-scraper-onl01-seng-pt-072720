require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  attr_reader :name, :location, :profile_url
   
    index_url = "https://learn-co-curriculum.github.io/student-scraper-test-page/index.html"
    uri = URI.parse(url) 
    
  # def self.scrape_index_page(index_url)
  #   doc = Nokogiri::HTML(open(index_url))
    
  #   name = doc.css()
  #   location = doc.css()
  #   profile_url = doc.css()

    
  end
  # binding.pry

  def self.scrape_profile_page(profile_url)
    
  end

end


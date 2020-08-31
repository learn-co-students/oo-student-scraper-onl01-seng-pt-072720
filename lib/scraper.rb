require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
        doc.css('.student-card').map do |student| 
          {
            :name => student.css('.student-name').text, 
            :location => student.css('.student-location').text, 
            :profile_url => student.css('a').first['href']
          }
        end
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

# student_card = doc.css('.student-card')
# student_names = student_card.css('.student-name').text
# student_locations = student_card.css('.student-location').text
# student_profile = student_card.css('a').first[href]

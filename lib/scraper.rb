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
    profile = Nokogiri::HTML(open(profile_url))
    student = {}
    social_arr = profile.css('.social-icon-container').children.css('a').map { |i| i.attribute('href').value}
    social_arr.each do |l|
      if l.include?('twitter')
        student[:twitter] = l
      elsif l.include?('linkedin')
        student[:linkedin] = l
      elsif l.include?('github')
        student[:github] = l
      else
        student[:blog] = l
      end
    end
    student[:profile_quote] = profile.css('.profile-quote').text
    student[:bio] = profile.css('.description-holder p').text
    student
  end

end


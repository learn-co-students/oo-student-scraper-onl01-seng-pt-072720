require 'nokogiri'
require 'open-uri'
require 'pry'

#"https://learn-co-curriculum.github.io/student-scraper-test-page/"

class Scraper


  def self.scrape_index_page(index_url)	  
    
    doc = Nokogiri::HTML(open(index_url))
    student_array = []
    doc2 = doc.css(".roster-cards-container .student-card")
    doc2.each do |student_card_div|
      student_array << { 
        :name => student_card_div.css(".student-name").text.strip,
        :location => student_card_div.css(".student-location").text.strip,
        :profile_url => student_card_div.css("a").attribute("href").value
      }
    end
    student_array
    end


  def self.scrape_profile_page(profile_url)	  

    doc = Nokogiri::HTML(open(profile_url))
    profile_hash = {}
    doc2 = doc.css(".social-icon-container")
    doc2array = doc2.css("a").map { |el| el.attribute('href').value}
    doc2array.each do |link|
      if link.include?("twitter.com")
        profile_hash[:twitter] = link
      elsif link.include?("linkedin.com")
        profile_hash[:linkedin] = link
      elsif link.include?("github.com")
        profile_hash[:github] = link 
      else
        profile_hash[:blog] = link
      end
    end
    profile_hash[:profile_quote] = doc.css(".profile-quote").text #if doc.css(".profile-quote").text
    profile_hash[:bio] = doc.css(".description-holder p").text #if doc.css(".description-holder p").text
    profile_hash
    end

end


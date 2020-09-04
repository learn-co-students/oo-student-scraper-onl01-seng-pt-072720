require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    student_cards = doc.css(".student-card a") 
    student_cards.collect do |element|
      {:name => element.css(".student-name").text,
      :location => element.css(".student-location").text,
      :profile_url => element.attr('href')}
    end
    
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    hashes = {}
    social = doc.css(".social-icon-container a").collect{|icon| icon.attribute('href').value}
    social.each do |element|
      if element.include?("twitter")
        hashes[:twitter] = element
      elsif element.include?("linkedin")
        hashes[:linkedin] = element
      elsif element.include?("github")
        hashes[:github] = element
      elsif element.include?(".com")
        hashes[:blog] = element
      end
    end
    hashes[:profile_quote] = doc.css(".profile-quote").text
    hashes[:bio] = doc.css("div.description-holder p").text
    return hashes 
  end

end


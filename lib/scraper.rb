require 'open-uri'
require 'pry'
require "nokogiri"

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    #scraped
    scraped_arr = []
    
    doc.css(".student-card").each do |student|
      scraped_arr << {
        name: student.css("h4.student-name").text,
        location: student.css("p.student-location").text,
        profile_url: "#{student.css("a").attribute("href").value}"
      }
    end
    scraped_arr
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    final = {}
    #binding.pry
    socials = doc.css("div.social-icon-container a").collect do |student|
      student.attribute("href").value
    end
    
    socials.each do |social|
      if social.include?("twitter") 
        final[:twitter] = social
      elsif social.include?("linkedin")
        final[:linkedin] = social
      elsif social.include?("github")
        final[:github] = social
      else social.include?("blog")
        final[:blog] = social
      end
    end
    
    final[:bio] = doc.css("div.description-holder p").text
    final[:profile_quote] = doc.css(".profile-quote").text
    #binding.pry
    final
  end

end

#Scraper.scrape_profile_page("https://learn-co-curriculum.github.io/student-scraper-test-page/students/ryan-johnson.html")
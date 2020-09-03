require 'open-uri'
require 'pry'

class Scraper
  # https://learn-co-curriculum.github.io/student-scraper-test-page/
  
  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    index_page = []
    
    doc.css("div.student-card").each do |student|
      index_page << {
        name: student.css("h4.student-name").text,
        location: student.css("p.student-location").text,
        profile_url: student.css("a").attribute("href").value
      }
    end 

    index_page 
  end

  def self.scrape_profile_page(profile_url)
    # profile_url = "https://learn-co-curriculum.github.io/student-scraper-test-page/students/ryan-johnson.html"
    doc = Nokogiri::HTML(open(profile_url))
    
    social_links = doc.css("div.social-icon-container a").collect do |link|
      link.attribute("href").value
    end 

    social_hash = {}

    social_links.map do |link|
      if link.include?("twitter")
        social_hash[:twitter] = link
      elsif link.include?("linkedin")
        social_hash[:linkedin] = link
      elsif link.include?("github")
        social_hash[:github] = link
      elsif link.include?("youtube")
        social_hash[:youtube] = link 
      else 
        social_hash[:blog] = link 
      end 
    end 

    social_hash [:profile_quote] = doc.css("div.profile-quote").text.strip
    social_hash [:bio] = doc.css("div.description-holder p").text.strip 
    
    social_hash 
  end

end
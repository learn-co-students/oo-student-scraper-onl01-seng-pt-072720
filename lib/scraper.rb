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

    profile_url = "https://learn-co-curriculum.github.io/student-scraper-test-page/students/ryan-johnson.html"
    doc = Nokogiri::HTML(open(profile_url))
    
    social_links = doc.css("div.social-icon-container a").collect do |link|
      link.attribute("href").value
    end 

    social_links.map do |link|
      if link.include?("twitter")
        { twitter: link }
      elsif link.include?("linkedin")
        { linkedin: link }
      elsif link.include?("github")
        { github: link }
      elsif link.include?("youtube")
        { youtube: link } 
      end 
    end 

    more_social_links = {
      profile_quote: doc.css("div.profile-quote").text.strip,
      bio: doc.css("div.description-holder p").text.strip 
    }
  end

  binding.pry 

end
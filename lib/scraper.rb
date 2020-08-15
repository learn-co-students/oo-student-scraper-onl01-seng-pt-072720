# require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = [] #array of all students scraped from the site. Each student represented by student hash below

    doc.css("div.student-card").each do |p|
          name = p.css(".student-name").text
          location = p.css(".student-location").text
          profile = p.css("a").attribute("href").value
          student = {:name => name, :location => location, :profile_url => profile}
        students << student
        end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url)) 
    students = {} #store links to this hash
    
    site_links = doc.css(".social-icon-container a").collect{|links| links.attribute("href").value} #=>["https://twitter.com/jmburges", "https://www.linkedin.com/in/jmburges", "https://github.com/jmburges", "http://joemburgess.com/"]
    site_links.each do |social_media| #accounts for whether or not the profile has all social accounts
      if social_media.include?("twitter")
        students[:twitter] = social_media
      elsif social_media.include?("linkedin")
        students[:linkedin] = social_media
      elsif social_media.include?("github")
        students[:github] = social_media
      else 
        students[:blog] = social_media
      end
    end #ends container.each 
    students[:profile_quote] = doc.css(".profile-quote").text
    students[:bio] = doc.css("div.description-holder p").text
    students
  end

end


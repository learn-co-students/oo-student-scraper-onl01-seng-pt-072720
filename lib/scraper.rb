require 'open-uri'
require 'pry'
require 'nokogiri'
require 'awesome_print'


class Scraper

  def self.scrape_index_page(index_url)
    # index_page = "./fixtures/student-site/index.html"
    doc = Nokogiri::HTML(open(index_url))

    students = []

    doc.css(".student-card a").each do |card|
      student_name = card.css(".student-name").text
      student_location = card.css(".student-location").text
      student_profile_url = card.attribute("href").value
      students << {name: student_name, location: student_location, profile_url: student_profile_url}
    end

    students

  end

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))
    
    student_hash = {}

    social_media_links = page.css(".social-icon-container").children.css("a").map {|a| a.attribute("href").value }
    social_media_links.each do |link|
      if link.include?("twitter")
        student_hash[:twitter] = link
      elsif link.include?("linkedin")
        student_hash[:linkedin] = link
      elsif link.include?("github")
        student_hash[:github] = link 
      else 
        student_hash[:blog] = link
      end
    end

    student_hash[:profile_quote] = page.css(".vitals-text-container div.profile-quote").text
    student_hash[:bio] = page.css(".description-holder p").text

    student_hash
  end

end
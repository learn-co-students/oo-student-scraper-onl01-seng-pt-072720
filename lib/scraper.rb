require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    scrapped_students = []

    scrapped_students = []


    doc = Nokogiri::HTML(open(index_url))
    doc.css("div.student-card").each do |temp|
      student = {}
      student = {name: temp.css("h4.student-name").text, location: temp.css("p.student-location").text, profile_url: temp.css("a").first["href"]}
      scrapped_students << student
    end
    scrapped_students
  end

  def self.scrape_profile_page(profile_url)

    student_info = {}

    profile_page = Nokogiri::HTML(open(profile_url))
    social_media_hrefs = profile_page.css("div.social-icon-container a").map {|link| link['href']}


    student_info = {profile_quote: 
    profile_page.css('div.profile-quote').text, bio:
    profile_page.css("div.description-holder p").text}

    social_media_hrefs.each do |temp|
      if temp.include?("twitter")
        student_info[:twitter] = temp
      elsif temp.include?("linkedin")
        student_info[:linkedin] = temp
      elsif temp.include?("github")
        student_info[:github] = temp
      else
        student_info[:blog] = temp
      end
    end
    student_info

    
  end

end


require 'nokogiri'
require 'open-uri'
require 'pry'


class Scraper

  
  
  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
      students = []
      doc.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        student_name = student.css('.student-name').text
        student_location = student.css('.student-location').text
        student_profile_url = "#{student.attr('href')}"
        students << {name: student_name, location: student_location, profile_url: student_profile_url}
      end
    end
    students
  end
    
  def self.scrape_profile_page(profile_url)
    student = {}
    profile = Nokogiri::HTML(open(profile_url))
    social = profile.css("div.social-icon-container")
    links = profile.css(".social-icon-container").children.css("a").map { |el| el.attribute('href').value}
    links.each do |link|
      if link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      elsif link.include?("twitter")
        student[:twitter] = link
      else
        student[:blog] = link
      end
    end
    student[:profile_quote] = profile.css("div.vitals-text-container div.profile-quote").text
    if profile.css("div.vitals-text-container")
    student[:bio] = profile.css("div.bio-content.content-holder div.description-holder p").text
    if profile.css("div.bio-content.content-holder div.description-holder p")
    student
  end

end
 
  end

end


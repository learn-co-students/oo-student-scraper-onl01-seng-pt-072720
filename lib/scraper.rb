
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_array = []
    doc = Nokogiri::HTML(open(index_url))
    doc.css("div.student-card").each do |student|
      student_details = {}
      student_details[:name] = student.css("h4.student-name").text
      student_details[:location] = student.css("p.student-location").text
      student_details[:profile_url] = student.css("a").attribute("href").text

      student_array << student_details
    end 
    student_array
  end

  def self.scrape_profile_page(profile_url)
    student_attr = {}
    doc = Nokogiri::HTML(open(profile_url))
    doc.css("div.main-wrapper.profile .social-icon-container a"). each do |social|
      if social.attribute("href").value.include?("twitter")
        student_attr[:twitter] = social.attribute("href").value
      elsif social.attribute("href").value.include?("linkedin")
        student_attr[:linkedin] = social.attribute("href").value
      elsif social.attribute("href").value.include?("github")
        student_attr[:github] = social.attribute("href").value
      else  
        student_attr[:blog] = social.attribute("href").value
      end 
    end 
    student_attr[:profile_quote] = doc.css("div.main-wrapper.profile .vitals-text-container .profile-quote").text
    student_attr[:bio] = doc.css("div.main-wrapper.profile .description-holder p").text
    student_attr
  end
end
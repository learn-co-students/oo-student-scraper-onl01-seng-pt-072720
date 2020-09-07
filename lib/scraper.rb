require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student = []
    html = open(index_url)
    profile = Nokogiri::HTML(html) #converts to nodesets
    profile.css('div.student-card').each do |s|
      student_info = {}
      student_info[:name] = s.css("h4.student-name").text
      student_info[:location] = s.css("p.student-location").text
      student_info[:profile_url] = s.css("a").attribute("href").value #anchor tag
      student << student_info
    end
    student

  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    profile = Nokogiri::HTML(html) #converts to nodesets
    student_info = {}

    data = profile.css('div.social-icon-container a').map{|item| item.attribute('href').value}
    
    data.each do |link|
      
      if link.include?("twitter")
        student_info[:twitter] = link 
      elsif link.include?("linkedin")
        student_info[:linkedin] = link
      elsif link.include?("github") 
        student_info[:github] = link
      else
        student_info[:blog] = link
      end
    end
    student_info[:profile_quote] = profile.css('.profile-quote').text
    student_info[:bio] = profile.css('.description-holder p').text
    student_info
  end

end

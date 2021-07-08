require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    webpage = Nokogiri::HTML(open(index_url))
    students = []
    
    webpage.css("div.roster-cards-container").each do |profile|
      profile.css(".student-card a").each do |student|
        profile_link = "#{student.attr('href')}"
        location = student.css('.student-location').text
        name = student.css('.student-name').text
        students << {name: name, location: location, profile_url: profile_link}
      end
    end
    students
    
  end

  def self.scrape_profile_page(profile_url)
    student = {}
    student_profile = Nokogiri::HTML(open(profile_url))
    urls = student_profile.css(".social-icon-container").children.css("a").map {|i| i.attribute('href').value}
    urls.each do |url|
      if url.include?("twitter")
        student[:twitter] = url
      elsif url.include?('linkedin')
        student[:linkedin] = url
      elsif url.include?('github')
        student[:github] = url
      else
        student[:blog] = url
      end
    end
    student[:profile_quote] = student_profile.css("div.vitals-text-container div").text if student_profile.css("div.vitals-text-container div")
    student[:bio] = student_profile.css("div.bio-content.content-holder div.description-holder p").text if student_profile.css("div.bio-content.content-holder div.description-holder p")
    student
    # binding.pry
  end
end


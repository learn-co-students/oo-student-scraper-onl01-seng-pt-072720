require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))
    students = []
    page.css("div.roster-cards-container").each do |card| 
      card.css("div.student-card a").each do |student|
        profile_url = "#{student.attr('href')}"
        location = student.css('p.student-location').text
        name = student.css('h4.student-name').text
        students << {name: name, location: location, profile_url: profile_url}
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))
    attributes = {}
    links = page.css(".social-icon-container").children.css("a").map { |social| social.attribute('href').value}
    links.each do |link|
      if link.include?("twitter")
        attributes[:twitter] = link
      elsif link.include?("github")
        attributes[:github] = link
      elsif link.include?("linkedin")
        attributes[:linkedin] = link
      else
        attributes[:blog] = link
      end
    end
      attributes[:profile_quote] = page.css("div.profile-quote").text
      attributes[:bio] = page.css("div.description-holder p").text
    attributes
  end

end


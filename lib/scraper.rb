require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    hashes = []
    doc = Nokogiri::HTML(open(index_url))

    doc.css("div.student-card").each do | student |
      name = student.css(".student-name").text
      location = student.css(".student-location").text
      profile = student.css("a").attribute("href").value
      student_info = {:name => name, :location => location, :profile_url => profile}
      hashes << student_info
    end

    hashes
  end

  def self.scrape_profile_page(profile_url)
    student = {}
    doc = Nokogiri::HTML(open(profile_url))

    array = doc.css(".social-icon-container a").collect {|icon| icon.attribute("href").value}

    array.each do | link |
      if link.include?("twitter")
        student[:twitter] = link
      elsif link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      elsif link.include?(".com")
        student[:blog] = link
      end
    end
    student[:profile_quote] = doc.css(".profile-quote").text
    student[:bio] = doc.css("div.description-holder p").text
    student
  end
end


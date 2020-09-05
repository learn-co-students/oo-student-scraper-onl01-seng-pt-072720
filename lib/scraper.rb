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
    
    #  profile_url = "https://learn-co-curriculum.github.io/student-scraper-test-page/students/ryan-johnson.html"

    doc = Nokogiri::HTML(open(profile_url))
  
    profile_student = {}
    
    # binding.pry
    student_social = doc.css("div.social-icon-container").children.css("a").collect {|sm| sm.attribute("href").value}
      student_social.each do |s| 
         if s.include?("twitter")
            profile_student[:twitter] = s
         elsif s.include?("linkedin")
          profile_student[:linkedin] = s
         elsif s.include?("github")
         profile_student[:github] = s
         else
            profile_student[:blog] = s
        end
      end
      profile_student[:profile_quote] = doc.css(".profile-quote").text
      profile_student[:bio] = doc.css("p").text
    
    profile_student
    
  end

end



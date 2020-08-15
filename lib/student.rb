require 'pry'
class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    #OPTION 1
    # @name = student_hash[:name]
    # @location = student_hash[:location]
    # @twitter = student_hash[:twitter]
    # @linkedin = student_hash[:linkedin]
    # @github = student_hash[:github]
    # @blog = student_hash[:blog]
    # @profile_quote = student_hash[:profile_quote]
    # @bio = student_hash[:bio]
    # @profile_url = student_hash[:profile_url]
 
    #OPTION 2 
    # def initialize(student_hash)
    #   student_hash.each do |attribute, value|
    #     self.send("#{attribute}=", value)
    #   end
    #   @@all << self
    # end

    student_hash.each do |k, v|
      self.instance_variable_set("@#{k}", v) 
    end
    @@all << self
  end

  #This class method should take in an array of hashes. In fact, we will call Student.create_from_collection with the return value of the 
  #Scraper.scrape_index_page method as the argument. The #create_from_collection method should iterate over the array of hashes and create 
  #a new individual student using each hash. 
  
  def self.create_from_collection(students_array) 
    students_array.each do |new_student|
      Student.new(new_student)
    # new_student = self.new()
    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |attribute, value|
      self.send("#{attribute}=", value)
    end
    self
  end

  def self.all
    @@all
  end
end


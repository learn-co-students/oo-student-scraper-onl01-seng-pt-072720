class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    @name = student_hash[:name]
    @location = student_hash[:location]
    self.class.all << self
  end

  def self.create_from_collection(students_array)
    students_array.each {|info| self.new(info)}
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each {|k, v| self.send("#{k}=", v)}
    self 
  end

  def self.all
    @@all    
  end
end


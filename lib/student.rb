class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
  #takes in the argument "student_hash"
    student_hash.each do |key, value|
    #applies each loop to "student_hash" iterating keys/values
      self.send("#{key}=", value)
      #.send method assigns instance attributes dynamically. It will take each key/value from student_hash.each and basically do this:
      # s = Student.new
      # s.name="John"
      # s.location="NYC"
      # Note: .send logic looks like:
      # s.send("name=", "John")
      # s.send("location=", "NYC")
    end
    @@all << self
    #pushes self, i.e. everything .send generated, to the all array, storing it as a class instance.
  end

  def self.create_from_collection(students_array)
    students_array.each do |student_hash|
      Student.new(student_hash)
    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |key, value|
      self.send("#{key}=", value)
    end
    self
  end

  def self.all
    @@all
  end

end

# One of the most useful feature I think with .send method is that it can dynamically call on method. This can save you a lot of typing. One of the most popular use of .send method is to assign attributes dynamically. For example:
#
# class Car
#   attr_accessor :make, :model, :year
# end
# To assign attributes regularly one would need to
#
# c = Car.new
# c.make="Honda"
# c.model="CRV"
# c.year="2014"
# Or using .send method:
#
# c.send("make=", "Honda")
# c.send("model=", "CRV")
# c.send("year=","2014")
# But it can all be replaced with the following:
#
# Assuming your Rails app needs to assign attributes to your car class from user input, you can do
#
# c = Car.new()
# params.each do |key, value|
#   c.send("#{key}=", value)
# end
# Through googling I found this wiki page which has more information on .send method https://code.google.com/p/ruby-security/wiki/Guide#send()_-_invoking_methods_dynamically

# class Course
#   attr_accessor :title, :schedule, :description
#
#   @@all = []
#
#   def initialize
#     @@all << self
#   end
#
#   def self.all
#     @@all
#   end
#
#   def self.reset_all
#     self.all.clear
#   end
#
# end
#
# # rspec spec/course_spec.rb

# require 'pry'
# require 'nokogiri'

# projects: kickstarter.css("li.project.grid_4")
# title: project.css("h2.bbcard_name strong a").text
# image link: project.css("div.project-thumbnail a img").attribute("src").value
# description: project.css("p.bbcard_blurb").text
# location: project.css("ul.project-meta li a span.location-name").text
# percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i

# def create_project_hash
#   html = File.read('fixtures/kickstarter.html')
#   kickstarter = Nokogiri::HTML(html)
#   projects = {}
#
#   kickstarter.css("li.project.grid_4").each do |project|
#     title = project.css("h2.bbcard_name strong a").text
#     projects[title.to_sym] = {
#       :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
#       :description => project.css("p.bbcard_blurb").text,
#       :location => project.css("ul.project-meta span.location-name").text,
#       :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
#     }
#   end
#
#   return projects
#
#   binding.pry
# end
#
# create_project_hash
#

require 'open-uri'
require 'pry'
# require 'nokogiri'


class Scraper

  def self.scrape_index_page(index_url)
    # class method takes in index_url as argument
    student_hashes = []
    # data is pushed into array student_hash
    doc = Nokogiri::HTML(open(index_url))
    # assigns Nokogiri's HTML scrape to doc variable
      doc.css("div.roster-cards-container").each do |card|
      # parses doc looking at each item labeled ("card")
        card.css(".student-card a").each do |student|
        # parses each card looking at each sub HTML via "a"
          url = "./fixtures/student-site/#{student.attr('href')}"
          # to path, apply student HTML file from loop and apply student's URL using .attr('href') method. Save as variable named "url".
          location = student.css('.student-location').text
          # save the entire text of a student's location as variable "location"
          name = student.css('.student-name').text
          # save the entire text of a student's name as variable "name"

          student_hashes << {name: name, location: location, profile_url: url}
          # push scraped data in the form of a hash, with keys corresponding to attr_accessors denoted in Student class
        end
      end
    student_hashes
    # Finally, return student_hashes 
  end

  def self.scrape_profile_page(profile_url)
    student = {}
    profile = Nokogiri::HTML(open(profile_url))
    links = profile.css(".social-icon-container").children.css("a").map { |x| x.attribute('href').value}
    links.each do |url|
      if url.include?("linkedin")
        student[:linkedin] = url
      elsif url.include?("github")
        student[:github] = url
      elsif url.include?("twitter")
        student[:twitter] = url
      else
        student[:blog] = url
      end
    end
    if profile.css(".profile-quote")
      student[:profile_quote] = profile.css(".profile-quote").text
    end
    if profile.css("div.bio-content.content-holder div.description-holder p")
      student[:bio] = profile.css("div.bio-content.content-holder div.description-holder p").text
    end
    student
  end

end



# require 'open-uri'
#
# class Scraper
#
#   def self.scrape_index_page(index_url)
#     index_page = Nokogiri::HTML(open(index_url))
#     students = []
#     index_page.css("div.roster-cards-container").each do |card|
#       card.css(".student-card a").each do |student|
#         student_profile_link = "./fixtures/student-site/#{student.attr('href')}"
#         student_location = student.css('.student-location').text
#         student_name = student.css('.student-name').text
#         students << {name: student_name, location: student_location, profile_url: student_profile_link}
#       end
#     end
#     students
#   end
#
#   def self.scrape_profile_page(profile_slug)
#     student = {}
#     profile_page = Nokogiri::HTML(open(profile_slug))
#     links = profile_page.css(".social-icon-container").children.css("a").map { |el| el.attribute('href').value}
#     links.each do |link|
#       if link.include?("linkedin")
#         student[:linkedin] = link
#       elsif link.include?("github")
#         student[:github] = link
#       elsif link.include?("twitter")
#         student[:twitter] = link
#       else
#         student[:blog] = link
#       end
#     end
#     # student[:twitter] = profile_page.css(".social-icon-container").children.css("a")[0].attribute("href").value
#     # # if profile_page.css(".social-icon-container").children.css("a")[0]
#     # student[:linkedin] = profile_page.css(".social-icon-container").children.css("a")[1].attribute("href").value if profile_page.css(".social-icon-container").children.css("a")[1]
#     # student[:github] = profile_page.css(".social-icon-container").children.css("a")[2].attribute("href").value if profile_page.css(".social-icon-container").children.css("a")[2]
#     # student[:blog] = profile_page.css(".social-icon-container").children.css("a")[3].attribute("href").value if profile_page.css(".social-icon-container").children.css("a")[3]
#     student[:profile_quote] = profile_page.css(".profile-quote").text if profile_page.css(".profile-quote")
#     student[:bio] = profile_page.css("div.bio-content.content-holder div.description-holder p").text if profile_page.css("div.bio-content.content-holder div.description-holder p")
#
#     student
#   end
#
# end

# require 'nokogiri'
# require 'open-uri'
# require 'pry'
#
# require_relative './course.rb'
#
# class Scraper
#
#   def get_page
#     doc = Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
#     # doc.css(".post").each do |post|
#     #   course = Course.new
#     #   course.title = post.css("h2").text
#     #   course.schedule = post.css(".date").text
#     #   course.description = post.css("p").text
#     # end
#   end
#
#   def get_courses
#     self.get_page.css(".post")
#   end
#
#   def make_courses
#     self.get_courses.each do |post|
#       course = Course.new
#       course.title = post.css("h2").text
#       course.schedule = post.css(".date").text
#       course.description = post.css("p").text
#     end
#   end
#
#   def print_courses
#     self.make_courses
#       Course.all.each do |course|
#       if course.title
#         puts "Title: #{course.title}"
#         puts "  Schedule: #{course.schedule}"
#         puts "  Description: #{course.description}"
#       end
#     end
#   end
#
# end
#
# Scraper.new.get_page
#
#

require 'open-uri'
require 'pry'


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
    # creates local student hash
    profile = Nokogiri::HTML(open(profile_url))
    # gets HTML results of method argument "profile_url" and saves them to var "profile"
    links = profile.css(".social-icon-container").children.css("a").map { |x| x.attribute('href').value}
    # on "profile" map creates a new array containing the values returned by the block. It's looking at the "a" tagged children of ".social-icon-container". Then the block collects takes the "href" value from each, returning them in an array saved in variable "links"
    # Then we take links and cycle them through conditionals, assigning values to the student instance
    links.each do |url|
      if url.include?("linkedin")
        student[:linkedin] = url
        #if a link contains linkedin, save it to the student instance, etc., etc.
      elsif url.include?("github")
        student[:github] = url
      elsif url.include?("twitter")
        student[:twitter] = url
      else
        student[:blog] = url
      end
    end
    # Once that's complete, go back to "profile" var and continue with more conditionals
    if profile.css(".profile-quote")
      # if there's a quote present:
      student[:profile_quote] = profile.css(".profile-quote").text
    end
    # sets the instance's :profile_quote to text scraped from ".profile-quote"
    if profile.css("div.bio-content.content-holder div.description-holder p")
      # if there's a bio present:
      student[:bio] = profile.css("div.bio-content.content-holder div.description-holder p").text
      # set student instance's :bio to the text scraped from "div.bio..."
    end
    student
    # return student
  end

end

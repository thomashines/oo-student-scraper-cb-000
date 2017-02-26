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
    # class method taking in "students_array" and running .each, looking at each "student_hash". Creates a new student instance with each student_hash.
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |key, value|
      self.send("#{key}=", value)
      # takes in a hash of student attributes. iterates over each of their key/value pairs, then sends the pairs to self.
    end
    self
    # finally, it returns self.
  end

  def self.all
    @@all
    # allows @@all class variable to be accessed from outside the class.
  end

end

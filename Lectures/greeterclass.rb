class Greeter
  attr_accessor :name
  def initialize(name = "Mark")
    @name = name
  end
  def hi
    puts "hello #{@name}"
  end
  def bye
    puts "bye #{@name}"
  end
end

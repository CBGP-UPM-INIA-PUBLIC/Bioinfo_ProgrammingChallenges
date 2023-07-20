class Patient

  attr_accessor :name  # create an "attribute accessor" (read and write) for "name"
  
  def initialize (name: "Some Person") # get a name from the "new" call, or set a default
      @name = name  
  end

  # details about the class go here...
end

module Mdw_objects
	class Patient

	    attr_accessor :name  # create an "attribute accessor" (read and write) for "name"
  
 	   def initialize (thisname = "Some Person") # get a name from the "new" call, or set a default
      		@name = thisname  
 	   end

	  # details about the class go here...
	end
end

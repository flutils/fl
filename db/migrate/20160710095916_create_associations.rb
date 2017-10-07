class CreateAssociations < ActiveRecord::Migration::Current
  include ActiveRecord::Concerns::Base

  #########################################
  #########################################

    # Up
    def up
      create_table table, options do |t|
    		t.references  :associatiable, { polymorphic: true } # => http://stackoverflow.com/a/29257570/1143732
    		t.references  :associated, 	  { polymorphic: true } # => http://stackoverflow.com/a/29257570/1143732
    		t.timestamps
    	end
    end

  #########################################
  #########################################

end

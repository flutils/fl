class CreateNodes < ActiveRecord::Migration::Current
  include ActiveRecord::Concerns::Base

  #########################################
  #########################################

    # => Up
    def up
      create_table table, options do |t| # => users stored through "associations"
        t.references :user
        t.string		 :type
        t.string     :slug
        t.string 		 :ref
        t.text		   :val, length: 4294967295
        t.timestamps
      end
    end

  #########################################
  #########################################

end

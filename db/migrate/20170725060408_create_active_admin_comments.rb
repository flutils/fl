class CreateActiveAdminComments < ActiveRecord::Migration::Current
  include ActiveRecord::Concerns::Base

  #########################################
  #########################################

    # => Up
    def up
      create_table table, options do |t|
        t.references :resource, polymorphic: true
        t.references :author,   polymorphic: true
        t.string     :namespace
        t.text       :body
        t.timestamps
      end
      add_index table, [:namespace]
    end

  #########################################
  #########################################

end

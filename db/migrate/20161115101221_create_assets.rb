class CreateAssets < ActiveRecord::Migration::Current
  include ActiveRecord::Concerns::Base

  #########################################
  #########################################

    # => Up
    def up
      create_table table, options do |t|
        t.references  :assetable, polymorphic: true
        t.string      :data_file_name, null: false
        t.integer     :data_file_size
        t.string      :data_content_type # => needs to be different than content_type otherwise infinite recursion
        t.string      :data_fingerprint
        t.integer     :width
        t.integer     :height
        t.timestamp   :data_updated_at
        t.timestamps
      end
    end

  #########################################
  #########################################

end

class CreateAssets < ActiveRecord::Migration::Current
  include ActiveRecord::Concerns::Base

  #########################################
  #########################################

    # => Up
    def up
      create_table table, options do |t|
        t.references  :user # => Allows for different users to upload images
        t.references  :assetable, polymorphic: true
        t.string      :data_file_name, null: false
        t.integer     :data_file_size
        t.string      :data_content_type # => needs to be different than content_type otherwise infinite recursion
        t.string      :data_fingerprint
        t.text        :notes
        t.string      :remote_url # => used for remote URL of image (needs work to bring into system)
        t.integer     :width
        t.integer     :height
        t.timestamp   :data_updated_at
        t.timestamps
      end
    end

  #########################################
  #########################################

end

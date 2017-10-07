class CreateProfiles < ActiveRecord::Migration::Current
  include ActiveRecord::Concerns::Base

    # Up
    def up
      create_table table, options do |t|

        # => General
        t.references :user, { references: :user } # => Should be used to create custom references but always adds "_id" to name
        t.string     :slug
        t.string     :name
        t.integer    :role, default: 0

        # => Extras
        t.boolean    :public, default: 0
        t.boolean    :is_destroyable

        # => Timestamps
        t.timestamps
      end
    end

  #########################################
  #########################################

end

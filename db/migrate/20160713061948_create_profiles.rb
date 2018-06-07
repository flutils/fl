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

        # => Sound
        t.integer    :sound_fx ,     default: 60, limit: 1
        t.integer    :ambient_sound, default: 60, limit: 1

        # => Extras
        t.boolean    :public, default: false
        t.boolean    :is_destroyable

        # => Timestamps
        t.timestamps
      end
    end

  #########################################
  #########################################

end

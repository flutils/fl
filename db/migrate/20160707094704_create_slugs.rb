class CreateSlugs < ActiveRecord::Migration::Current
  include ActiveRecord::Concerns::Base

  #########################################
  #########################################

    # Table
    def table
      FriendlyId::Slug.table_name
    end

  #########################################
  #########################################

    # Up
    def up
      create_table table, options do |t|
        t.string   :slug,           :null  => false
        t.integer  :sluggable_id,   :null  => false
        t.string   :sluggable_type, :limit => 50
        t.string   :scope
        t.datetime :created_at
      end
      add_index table, :sluggable_id
      add_index table, [:slug, :sluggable_type]
      add_index table, [:slug, :sluggable_type, :scope], unique: true
      add_index table, :sluggable_type
    end

  #########################################
  #########################################

end

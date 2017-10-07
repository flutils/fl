module ActiveRecord
  module Concerns
    module Base

      ## This is used to provide base functionality to migrations
      #########################################
      #########################################

        # Adapter
        def adapter
          ENV["DATABASE_ADAPTER"]
        end

      #########################################
      #########################################

        # Down
        def down
         drop_table table, if_exists: true
        end

        # UUID
        def options(key=:id)
          case adapter
          when "mysql2"
            { options: 'DEFAULT CHARSET=utf8' }
          else
            {}
          end
        end

        # Table
        def table
          self.class.name.gsub!("Create", "").underscore
        end

      #########################################
      #########################################

      private

        # http://stackoverflow.com/a/5665974/1143732
        # Set "plugin" for UUID BEFORE using it
        def setup_uuid
         case adapter
           when "mysql2"
             execute("DROP TRIGGER IF EXISTS before_insert_#{table};") #http://stackoverflow.com/a/5945220/1143732
             execute("CREATE TRIGGER before_insert_#{table} BEFORE INSERT ON associations FOR EACH ROW SET new.uuid = uuid();")
           when "sqlite3"
             # Nothing to do
           when "postgresql"
             enable_extension 'uuid-ossp' # => http://theworkaround.com/2015/06/12/using-uuids-in-rails.html#postgresql
         else
           raise NotImplementedError, "Unknown adapter type '#{adapter}'"
         end
        end

      #########################################
      #########################################

    end
  end
end

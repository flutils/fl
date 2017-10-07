module FL
  class SassVarsGenerator < Rails::Generators::Base

    # => Description
    desc "Creates SASS Vars YML/Config File"

    # => Source
    source_root File.join(File.dirname(__FILE__), 'templates')

    # Generator Code. Remember this is just suped-up Thor so methods are executed in order
    def copy
      copy_file "sass.yml", "config/sass.yml"
    end

  end
end

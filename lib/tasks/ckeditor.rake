#################################################
#################################################
##   _____  _   __ _____    _ _ _              ##
##  /  __ \| | / /|  ___|  | (_) |             ##
##  | /  \/| |/ / | |__  __| |_| |_ ___  _ __  ##
##  | |    |    \ |  __|/ _` | | __/ _ \| '__| ##
##  | \__/\| |\  \| |__| (_| | | || (_) | |    ##
##   \____/\_| \_/\____/\__,_|_|\__\___/|_|    ##
#################################################
#################################################

## Libs ##
require 'fileutils'

#################################################
#################################################

## CKEditor ##
namespace :ckeditor do
  desc 'Create nondigest versions of all ckeditor digest assets'
  task nondigest: :environment do
    fingerprint = /\-[0-9a-f]{32,64}\./
    path = File.join(Rails.root, "public", Ckeditor.base_path, "**", "*") # =>  This is used to allow non-slash requirements etc

    Dir[path].each do |file|
      next unless file =~ fingerprint
      nondigest = file.sub fingerprint, '.'

      if !File.exist?(nondigest) || File.mtime(file) > File.mtime(nondigest)
        FileUtils.cp file, nondigest, verbose: true, preserve: true
      end
    end
  end
end

#################################################
#################################################

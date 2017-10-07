##############################################
##############################################
##     _____          _                     ##
##    |  ___|        (_)                    ##
##    | |_ __ ___   ___  ___ ___  _ __      ##
##    |  _/ _` \ \ / / |/ __/ _ \| '_ \     ##
##    | || (_| |\ V /| | (_| (_) | | | |    ##
##    \_| \__,_| \_/ |_|\___\___/|_| |_|    ##
##                                          ##
##############################################
##############################################

## Libs ##
require 'fileutils'

##############################################
##############################################

## Declarations ##
asset   = Rails.root.join("app", "assets", "images", "favicon.ico")
favicon = Rails.root.join("public", "favicon.ico")

##############################################
##############################################

## New ##
Rake::Task["assets:precompile"].enhance do
  FileUtils.cp asset, favicon, verbose: true, preserve: true if File.exist?(asset) && (!File.exist?(favicon) || File.mtime(asset) > File.mtime(favicon))
end

## Destroy ##
Rake::Task["assets:clobber"].enhance do
  FileUtils.rm favicon, verbose: true if File.exist? favicon
end

##############################################
##############################################

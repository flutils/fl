##############################
##############################
#https://gist.github.com/unixmonkey/323198
#https://gist.github.com/evandrodutra/177372
##############################
##############################
#
# production:
#   color: 'blue'                #result: !color = blue
#   host: 'http://example.com'   #result: !host = http://example.com
# development:
#   color: 'red'
#   host: 'http://localhost:3000'
# test:
#   color: 'gray' #result: !color = gray
#   host: 'http://localhost:3000'
#
##############################
##############################
#
# Notes
# -> If you include several instances of the same variable, only the last one will be saved
# -> Whilst you can use the environment-based defintiions as above, you can also define variables on their own
# -> You can also include "groups" which allow you to create variables based on the grouped identity for them all
#
##############################
##############################

# Declarations
INPUT  = File.join(Rails.root, "config", "sass.yml")
OUTPUT = File.join(Rails.root, "vendor", "assets", "stylesheets", "_variables.sass")

##############################
##############################

begin
  File.open(OUTPUT, 'w+') do |file|
    file.write FL::AssetHelper.sass INPUT
  end
rescue => e
  puts e
end

##############################
##############################

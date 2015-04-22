require 'csv'
require 'json'
require 'yaml'
require './run_command'

num = 0
gems = {}

File.open("gems.txt").each_line do |line|
  gemname = line.split(/\s/).first.strip
  gem_info = JSON.parse(run "curl https://rubygems.org/api/v1/gems/#{gemname}.json")
  num +=1
  gems.merge!({ gem_info["name"] => { downloads: gem_info["downloads"].to_i,
                                      version: gem_info["version"],
                                      src: gem_info["source_code_uri"]}})
  break if num == 1000
end

gems = gems.sort_by{|k, v| v[:downloads] }.reverse.first(100).to_h
file = File.open("gems.yml", "w")
file.write( gems.to_yaml)
file.close
puts "#{num} gem info was written."

# 1000 gem info was written.

# real  9m31.625s
# user  0m14.732s
# sys 0m9.613s
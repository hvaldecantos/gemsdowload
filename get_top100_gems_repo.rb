require 'csv'
require 'json'
require 'yaml'
require './run_command'

gems = {}
run("gem list --remote").each_line do |line|
  gemname = line.split(/\s/).first.strip
  gem_info = JSON.parse(run "curl https://rubygems.org/api/v1/gems/#{gemname}.json")
  gems.merge!({ gem_info["name"] => { downloads: gem_info["downloads"].to_i,
                                      version: gem_info["version"],
                                      src: gem_info["source_code_uri"]}})
end

gems = gems.sort_by{|k, v| v[:downloads] }.reverse.first(100).to_h
file = File.open("gems.yml", "w")
file.write( gems.to_yaml)
file.close

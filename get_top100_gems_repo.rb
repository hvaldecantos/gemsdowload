require 'csv'
require 'json'
require 'yaml'
require './run_command'
require 'logger'

num = 0
gems = {}

logger = Logger.new('logfile_top100.log')
File.open("gems.txt").each_line do |line|
  gemname = line.split(/\s/).first.strip
  begin
    gem_info = JSON.parse(run "curl https://rubygems.org/api/v1/gems/#{gemname}.json")
    num +=1
    gems.merge!({ gem_info["name"] => { downloads: gem_info["downloads"].to_i,
                                        version: gem_info["version"],
                                        src: gem_info["source_code_uri"]}})
    logger.info("#{num} gem info collected") if num%100 == 0
  rescue => e
    logger.error("Cannot clone #{gemname}: #{e}")
  end
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
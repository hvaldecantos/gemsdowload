require 'csv'
require 'open3'
require 'json'
require 'yaml'

begin
  gems = YAML.load(File.open("gems.yml"))
  gems.each do |gemname, info|
    puts gemname
    puts info[:src]
  end
rescue ArgumentError => e
  puts "Could not parse YAML: #{e.message}"
end

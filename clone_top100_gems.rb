require 'csv'
require 'open3'
require 'json'
require 'yaml'

begin
  gems = YAML.load(File.open("gems.yml"))
  puts gems
rescue ArgumentError => e
  puts "Could not parse YAML: #{e.message}"
end

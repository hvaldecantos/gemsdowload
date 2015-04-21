require 'csv'
require 'json'
require 'yaml'
require './run_command'

num = 0
file = File.open("gems.txt", "w")
run("gem list --remote").each_line do |line|
  file.write line
  num += 1
end
file.close
puts "#{num} gem names and versions were written."

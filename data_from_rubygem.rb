require './run_command'
require 'pp'
require 'json'

gems = ['simplecov', 'bundler', 'docile']
# gems = ['rails', 'actionmailer']

gems.each do |gemname|
  gem_info = JSON.parse(run "curl https://rubygems.org/api/v1/gems/#{gemname}.json")
  pp gem_info
  puts
end

require 'open3'
require 'yaml'
require './run_command'
require 'logger'

begin
  cwd = Dir.getwd
  gems = YAML.load(File.open("gems.yml"))
  logger = Logger.new('logfile_clone.log')

  Dir.mkdir(cwd + '/../clonedgems/')
  Dir.chdir(cwd + '/../clonedgems/')

  gnum = 0
  gcloned = 0

  gems.each do |gemname, info|
    gnum += 1
    if info[:src]
      begin
        if info[:src].match(/github.com/).nil? == false
          run "git clone #{info[:src]}"
          gcloned += 1
          logger.info("Gem #{gemname} successful cloned. [num: #{gnum}, cloned: #{gcloned}]")
        else
          logger.warn("Gem #{gemname} uri is notq from github. [num: #{gnum}]")
        end
      rescue => e
        logger.error("Cannot clone #{gemname}: #{e.message}")
      end
    else
      logger.warn("Gem #{gemname} no URI repo found. [num: #{gnum}]")
    end
    break if gcloned == 100
  end

rescue ArgumentError => e
  logger.error("Could not parse YAML: #{e}")
ensure
  Dir.chdir cwd
  logger.info("Clonning done.")
end

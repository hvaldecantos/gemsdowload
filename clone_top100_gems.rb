require 'open3'
require 'yaml'
require './run_command'
require 'logger'

begin
  cwd = Dir.getwd
  gems = YAML.load(File.open("gems.yml"))
  logger = Logger.new('logfile.log')

  Dir.chdir(cwd + '/../clonedgems/')

  gems.each do |gemname, info|
    if info[:src]
      begin
        # puts "git clone #{info[:src]}" if info[:src].match(/github.com/)
        run "git clone #{info[:src]}" if info[:src].match(/github.com/)
        logger.info("Gem #{gemname} successful cloned.")
      rescue => e
        logger.error("Cannot clone #{gemname}: #{e}")
      end
    end
  end

rescue ArgumentError => e
  logger.error("Could not parse YAML: #{e}")
ensure
  Dir.chdir cwd
end

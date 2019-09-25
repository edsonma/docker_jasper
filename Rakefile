#
# Ruby Makefile for Tasks
#
# Created by: Edson Lek Hong Ma - edsonma@gmail.com
#
#   27/05/2019 - Initial Version of Rakefile for sicorp-jasper project (empty)
#   17/06/2019 - Tasks for docker-compose
#
#

task :default => :start

desc "Starts jasperserver and mysql containers"
task :start do
  puts "[INFO] Starting jasperserver and mysql database"
  puts `docker-compose up -d`
end

desc "Builds new images of jasperserver and mysql containers"
task :build do
  puts "[INFO] Building new images for jasperserver and mysql database"
  puts `docker-compose build`
end

desc "Stops jasperserver and mysql containers"
task :stop do
  puts "[INFO] Stopping jasperserver and mysql database"
  puts `docker-compose stop`
end

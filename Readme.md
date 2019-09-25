
#Use Rake tasks! (Piece of cake!)
 Shows all tasks: Rake -T

 Builds new Images of Jasperserver and Mysql Containers: rake build

 Starts Jasperserver and Mysql Containers: rake start

 Stops Jasperserver and Mysql Containers: rake stop


#About docker pods setup
  You can check docker-compose.yml file for its networks, ports, containers, images.

#About dockerfiles
  We have two files: db.dockerfile (for mysql database) and jasper.dockerfile (for jasperserver). Check it out!

#Legacy Docs
  Original instalation documents you can find it on docs folder

#If you wanna run manually your own database, use the commands bellow

##Build mysql database
 docker build -t edsonma/jasperdb:v5.5 -f db.dockerfile .

##Run your mysql 
 docker run -d --name jasperdb -p 3307:3306 -p 8080:8080 -e MYSQL_ROOT_PASSWORD=root edsonma/jasperdb:v5.5

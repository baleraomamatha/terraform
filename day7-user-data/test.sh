 #!/bin/bash/
 yum update -y
 sudo yum install httpd -y
 sudo service httpd start
 chkconfig httpd on
 cd /var/www/html
 echo "test usserdata" > /var/www/html/index.html

 
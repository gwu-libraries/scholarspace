# ScholarSpace

This is the (new) repository for the George Washington University Libraries' Sufia-based
application.  The repository for the Sufia 4 based app is located at
https://github.com/gwu-libraries/gw-sufia/ .

Installation
------------

### Dependencies

* Install ubuntu package dependencies:

        % sudo apt-get update
        % sudo apt-get install git postgresql libpq-dev redis-server unzip openjdk-7-jre clamav-daemon curl imagemagick libapache2-mod-shib2

* Install RVM (for installation via SSL and other RVM installation information, refer to https://rvm.io/rvm/install)

        % curl -L https://get.rvm.io | bash -s stable
        % source ~/.rvm/scripts/rvm
        % rvm install ruby-2.2.1

* Install Rails

        % gem install rails -v 4.1.8

### Install

* Get the gw-sufia code:

        % git clone https://github.com/gwu-libraries/scholarspace.git

* Install gems

        % cd scholarspace
        % bundle install
        % rails generate sufia:install -f

* Create a postgresql user and three databases (e.g. scholarspace_dev, scholarspace_test, scholarspace_prod)

        % sudo su - postgres
        (postgres)% psql
        postgres=# create user YOURSFMDBUSERNAME with createdb password 'YOURSFMDBPASSWORD';
        CREATE ROLE
        postgres=# \q
        (postgres)% createdb -O YOURSFMDBUSERNAME YOURDEVDBNAME
        (postgres)% createdb -O YOURSFMDBUSERNAME YOURTESTDBNAME
        (postgres)% createdb -O YOURSFMDBUSERNAME YOURPRODDBNAME
        (postgres)% exit

* Create the database.yml file

        % cd config
        % cp database.yml.template database.yml

        Edit database.yml to add your specific database names and credentials

* Create the solr.yml file

        % cd config
        % cp solr.yml.template solr.yml

        Edit solr.yml to add your specific names and credentials

* Create the fedora.yml file

        % cd config
        % cp fedora.yml.template fedora.yml

        Edit fedora.yml to add your specific Fedora repository names and credentials

* Create the secure secret key.  In production, put this in your environment, not in the file.

        % cd config
        % cp secrets.yml.template secrets.yml
        % rake secret

        Paste the secret key into the secrets.yml file (for dev and test)

* Run the database migrations

        % rake db:migrate

* Get a copy of hydra-jetty (if installing solr and fedora locally)

  (If jetty is already running on the same port (default 8983), it will need to be stopped using sudo service jetty stop)

        % rake jetty:clean
        % rake sufia:jetty:config
        % rake jetty:start

* Install fits.sh (check [FITS](http://projects.iq.harvard.edu/fits/downloads) for the latest download)

        % cd /usr/local/bin
        % sudo curl http://projects.iq.harvard.edu/files/fits/files/fits-0.8.6_1.zip -o fits.zip
        % sudo unzip fits.zip
        % cd fits-0.8.6
        % sudo chmod a+x fits*.sh

### Start a Redis RESQUE pool

        & sudo chmod a+x script/restart_resque.sh
        % script/restart_resque.sh

### Run the application

        % rails s -p <PORT NUMBER>
        
Installation with Apache, Tomcat 7, and Passenger
------------

### Dependencies

* Install ubuntu package dependencies:

        % sudo apt-get update
        % sudo apt-get install git postgresql libpq-dev redis-server unzip openjdk-7-jre clamav-daemon curl imagemagick libapache2-mod-shib2, tomcat7
        
* Install RVM for multi-users (for installation via SSL and other RVM installation information, refer to https://rvm.io/rvm/install) Installs RVM to /usr/local/rvm

        % curl -L https://get.rvm.io | sudo bash -s stable
        % source ~/.rvm/scripts/rvm
        % rvm install ruby-2.2.1
        % sudo nano /etc/group
        
        Add users to the rvm group.

* Install Rails

        % gem install rails -v 4.2.0
        
* Create the necessary directories

        % mkdir /opt/scholarspace
        % mkdir /opt/solr
        % mkdir /opt/fedora
        % mkdir /opt/install
        % mkdir /opt/fuseki
        
* Create the necessary user groups and assign folder permissions

        % sudo groupadd scholarspace
        % sudo nano /etc/group
        Add users to the new group
        % sudo chown tomcat7:tomcat7 /opt/solr
        % sudo chown tomcat7:tomcat7 /opt/fedora
        % sudo chown $USER:scholarspace /opt/scholarspace
        
* Setup Solr

        % cd /opt/install
        % wget http://archive.apache.org/dist/lucene/solr/4.10.4/solr-4.10.4.tgz
        % tar xzvf solr-4.10.4.tgz
        % cd solr-4.10.4
        % sudo cp -R example/solr/* /opt/solr
        % sudo cp -R dist /opt/solr
        Replace the schema.xml and solrconfig.xml in /opt/solr/collection1/conf/ with the ones from the repo
        Replace the solr.xml file in /opt/solr with the one from the repo
        % sudo cp dist/solr-4.10.4.war /var/lib/tomcat7/webapps/solr.war
        % sudo cp example/lib/ext/* /var/lib/tomcat7/webapps/solr/WEB-INF/lib
        
* Setup fcrepo-message-consumer

        % cd /opt/install
        % wget http://central.maven.org/maven2/org/fcrepo/fcrepo-message-consumer-webapp/4.2.0/fcrepo-message-consumer-webapp-4.2.0.war
        % sudo cp fcrepo-message-consumer-webapp-4.2.0 /var/lib/tomcat7/webapps/fcrepo-message-consumer.war
        Replace or create the indexer-core.xml file in /var/lib/tomcat7/webapps/fcrepo-message-consumer/WEB-INF/class/spring/indexer-core.xml with the one from the repo
        
* Setup fcrepo

        % cd /opt/install
        % wget https://repo1.maven.org/maven2/org/fcrepo/fcrepo-webapp/4.2.0/fcrepo-webapp-4.2.0.war
        % cp fcrepo-webapp-4.2.0.war /var/lib/tomcat7/webapps/fcrepo-webapp-4.2.0.war
        Replace the web.xml file in /var/lib/tomcat7/webapps/fcrepo-webapp-4.2.0/WEB-INF/web.xml with the one from the repo

* Restart Tomcat7 Server

        % sudo service tomcat7 restart

* Install Fuseki

        % cd /opt/install
        % wget http://www.apache.org/dist/jena/binaries/apache-jena-2.13.0.tar.gz
        % tar xzvf apache-jena-2.13.0.tar.gz -C /usr/local/bin/
        % cd /usr/local/bin/apache-jena-2.13.0
        Start Fuseki Server
        % nohup ./fuseki-server --update --loc /opt/fuseki /fcrepo-4.2.0 &
        
### Install

* Get the gw-sufia code:

        % git clone https://github.com/gwu-libraries/scholarspace.git

* Install gems

        % cd scholarspace
        % bundle install
        % rails generate sufia:install -f

* Create a postgresql user and three databases (e.g. scholarspace_dev, scholarspace_test, scholarspace_prod)

        % sudo su - postgres
        (postgres)% psql
        postgres=# create user YOURSFMDBUSERNAME with createdb password 'YOURSFMDBPASSWORD';
        CREATE ROLE
        postgres=# \q
        (postgres)% createdb -O YOURSFMDBUSERNAME YOURDEVDBNAME
        (postgres)% createdb -O YOURSFMDBUSERNAME YOURTESTDBNAME
        (postgres)% createdb -O YOURSFMDBUSERNAME YOURPRODDBNAME
        (postgres)% exit

* Create the database.yml file

        % cd config
        % cp database.yml.template database.yml

        Edit database.yml to add your specific database names and credentials

* Create the solr.yml file

        % cd config
        % cp solr.yml.template solr.yml

        Edit solr.yml to add your specific names and credentials

* Create the blacklight.yml file

        % cd config
        % cp blacklight.yml.template blacklight.yml

        Edit blacklight.yml to add your specific names and credentials

* Create the fedora.yml file

        % cd config
        % cp fedora.yml.template fedora.yml

        Edit fedora.yml to add your specific Fedora repository names and credentials

* Create the secure secret key.  In production, put this in your environment, not in the file.

        % cd config
        % cp secrets.yml.template secrets.yml
        % rake secret

        Paste the secret key into the secrets.yml file (for dev and test)

* Run the database migrations

        % rake db:migrate

* Install fits.sh (check [FITS](http://projects.iq.harvard.edu/fits/downloads) for the latest download)

        % cd /usr/local/bin
        % sudo curl http://projects.iq.harvard.edu/files/fits/files/fits-0.8.6_1.zip -o fits.zip
        % sudo unzip fits.zip
        % cd fits-0.8.6
        % sudo chmod a+x fits*.sh

### Start a Redis RESQUE pool

        & sudo chmod a+x script/restart_resque.sh
        % script/restart_resque.sh


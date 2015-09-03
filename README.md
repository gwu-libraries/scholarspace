# GW ScholarSpace [![Build Status](https://travis-ci.org/gwu-libraries/scholarspace.png?branch=master)](https://travis-ci.org/gwu-libraries/scholarspace)
=================

This is the (new) repository for the George Washington University Libraries' Sufia-based
application.  The repository for the Sufia 4 based app is located at
https://github.com/gwu-libraries/gw-sufia/ .

Installation for Development
----------------------------

(For a recommended Production configuration, scroll down to [Installation with Apache, Tomcat 7, and Passenger](#prod-install))

### Dependencies

* Install ubuntu package dependencies:

        % sudo apt-get update
        % sudo apt-get install git postgresql libpq-dev redis-server unzip openjdk-7-jre clamav-daemon curl imagemagick libapache2-mod-shib2

* Install RVM (for installation via SSL and other RVM installation information, refer to https://rvm.io/rvm/install)

        % curl -L https://get.rvm.io | bash -s stable
        % source ~/.rvm/scripts/rvm
        
  In the WRLC context, installing RVM via curl may require the following instead:
  
        % echo insecure >> ~/.curlrc
        % \curl -sSL --CAcert /etc/ssl/certs/ca-certificates.crt --CApath /etc/ssl/certs https://get.rvm.io | bash -s stable --ruby
        % source ~/.rvm/scripts/rvm
        
* Install Ruby 

        % rvm install ruby-2.2.1

* Install Rails

        % gem install rails -v 4.2.3 -N

### Install

* Get the gw-sufia code:

        % git clone https://github.com/gwu-libraries/scholarspace.git

* Install gems

        % cd scholarspace
        % bundle install

* Create a postgresql user

        % sudo su - postgres
        (postgres)% psql
        postgres=# create user YOURDBUSERNAME with createdb password 'YOURSFMDBPASSWORD';

  The result should be:

        CREATE ROLE

* Create three databases (e.g. scholarspace_dev, scholarspace_test, scholarspace_prod)

        postgres=# \q
        (postgres)% createdb -O YOURDBUSERNAME YOURDEVDBNAME
        (postgres)% createdb -O YOURDBUSERNAME YOURTESTDBNAME
        (postgres)% createdb -O YOURDBUSERNAME YOURPRODDBNAME
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
  
  Hydra-Jetty requires Java 8.  These [Java 8 installation steps for Ubuntu Linux](http://www.webupd8.org/2012/09/install-oracle-java-8-in-ubuntu-via-ppa.html) are [recommended by ubuntu.com](https://help.ubuntu.com/community/Java#Oracle_Java_8) . 

        % rake jetty:clean
        % rake sufia:jetty:config
        % rake jetty:start

* Install fits.sh (check [FITS](http://projects.iq.harvard.edu/fits/downloads) for the latest download)

        % cd /usr/local/bin
        % sudo curl http://projects.iq.harvard.edu/files/fits/files/fits-0.8.6_1.zip -o fits.zip
        % sudo unzip fits.zip
        % cd fits-0.8.6
        % sudo chmod a+x fits*.sh

### Configure Contact form emailing

  In order to enable the contact form page to send email when the user clicks Send,
set the following properties in config/initializers/sufia.rb :
  * config.action_mailer.contact_email
  * config.action_mailer.from_email

Copy config/initializers/setup_mail.rb.template to config/initializers/setup_mail.rb .
Set the SMTP credentials for the user as whom the app will send email.

### Start a Redis RESQUE pool

        % cd scholarspace
        % script/restart_resque.sh development
   (or ```script/restart_resque.sh production``` as the case may be)

### (Optional) Populate the initial content blocks

  Run the rake task that takes the content of the HTML files in config/locales/content_blocks and populates the associated content blocks.  Note that for an existing instance, running this rake task will overwrite any chnages you've made to the content blocks!
  
        % rake gwss:populate_content_blocks

### Run the application

        % rails s -p <PORT NUMBER> -b 0.0.0.0

Installation with Apache, Tomcat 7, and Passenger <a id="prod-install"></a>
------------
Note: Solr, Fedora, PostgreSQL and the GW ScholarSpace application can all be deployed on different servers if desired.  If doing so, ensure that firewall ports are opened between the necessary servers and the GW ScholarSpace application server.

### Dependencies

* Install ubuntu 14.04 LTS package dependencies:

        % sudo apt-get update
        % sudo apt-get install git postgresql libpq-dev redis-server unzip clamav-daemon curl imagemagick libapache2-mod-shib2 tomcat7 libreoffice libcurl4-openssl-dev

* Install Java 8 for 14.04

        % sudo apt-add-repository ppa:webupd8team/java
        % sudo apt-get update
        % sudo apt-get install oracle-java8-installer
        % sudo apt-get install oracle-java8-set-default
       
* Install RVM for multi-users (for installation via SSL and other RVM installation information, refer to https://rvm.io/rvm/install) Installs RVM to /usr/local/rvm

        % curl -L https://get.rvm.io | sudo bash -s stable
        % source ~/.rvm/scripts/rvm
        % rvm install ruby-2.2.1
        % sudo nano /etc/group
        
        Add users to the rvm group

* Install Rails

        % gem install rails -v 4.2.3 -N
        
* Create the necessary directories

        % mkdir /opt/scholarspace
        % mkdir /opt/solr
        % mkdir /opt/fedora
        % mkdir /opt/install
        % mkdir /opt/xsendfile
        % sudo mkdir /var/log/solr
        
* Create the necessary user groups and assign folder permissions

        % sudo groupadd scholarspace
        % sudo nano /etc/group
        Add users to the new group
        % sudo chown tomcat7:tomcat7 /opt/solr
        % sudo chown tomcat7:tomcat7 /opt/fedora
        % sudo chown $USER:scholarspace /opt/scholarspace
        % sudo chown www-data:www-data /opt/xsendfile
        % sudo chown tomcat7:tomcat7 /var/log/solr
        
* Setup tomcat7
        Replace the /etc/default/tomcat7 file with the tomcat7 file from the repo.  This will set solr Home, fcrepo home, and java path.
        
* Setup Solr

        % cd /opt/install
        % wget http://archive.apache.org/dist/lucene/solr/4.10.4/solr-4.10.4.tgz
        % tar xzvf solr-4.10.4.tgz
        % cd solr-4.10.4
        % sudo cp -R example/solr/* /opt/solr
        % sudo cp -R dist /opt/solr
        % sudo cp -R contrib /opt/solr
        % sudo cp -R /opt/solr/collection1 /opt/solr/development-core
        % sudo cp -R /opt/solr/collection1 /opt/solr/test-core
        Replace the schema.xml and solrconfig.xml in /opt/solr/collection1/conf/ with the ones from the repo
        Replace the solr.xml file in /opt/solr with the one from the repo
        % sudo cp dist/solr-4.10.4.war /var/lib/tomcat7/webapps/solr.war
        % sudo cp -R example/lib/ext/* /var/lib/tomcat7/webapps/solr/WEB-INF/lib
        % sudo cp -R contrib /var/lib/tomcat7/webapps/solr/WEB-INF/lib/
        Create the log4j.properties file in /var/lib/tomcat7/webapps/solr/WEB-INF/classes/ with the one from the repo
        
        Setup log rotation by creating a /etc/logrotate.d/solr file with the following:
        % sudo nano /etc/logrotate.d/solr
        /var/log/solr/solr.log { copytruncate daily rotate 5 compress missingok create 640 tomcat7 tomcat7 }
        
* Setup fcrepo-message-consumer

        % cd /opt/install
        % wget http://central.maven.org/maven2/org/fcrepo/fcrepo-message-consumer-webapp/4.3.0/fcrepo-message-consumer-webapp-4.3.0.war
        % sudo cp fcrepo-message-consumer-webapp-4.3.0.war /var/lib/tomcat7/webapps/fcrepo-message-consumer.war
        Replace or create the indexer-core.xml file in /var/lib/tomcat7/webapps/fcrepo-message-consumer/WEB-INF/classes/spring/indexer-core.xml with the one from the repo
        
* Setup fcrepo

        % cd /opt/install
        % wget https://repo1.maven.org/maven2/org/fcrepo/fcrepo-webapp/4.3.0/fcrepo-webapp-4.3.0.war
        % cp fcrepo-webapp-4.3.0.war /var/lib/tomcat7/webapps/fcrepo-webapp-4.3.0.war
        Replace the web.xml file in /var/lib/tomcat7/webapps/fcrepo-webapp-4.2.0/WEB-INF/web.xml with the one from the repo

* Setup authentication to fcrepo

        % cd /etc/tomcat7
        Replace tomcat_users.xml with the tomcat_users.xml file from the repo
        % sudo nano tomcat_users.xml
        Replace the "dummypasswords" with your secure passwords

* Restart Tomcat7 Server

        % sudo service tomcat7 restart

### Install

* Get the gw-sufia code:

        % git clone https://github.com/gwu-libraries/scholarspace.git

* Install gems

        % cd scholarspace
        % bundle install

* Create a postgresql user

        % sudo su - postgres
        (postgres)% psql
        postgres=# create user YOURDBUSERNAME with createdb password 'YOURSFMDBPASSWORD';

  The result should be:

        CREATE ROLE

* Create three databases (e.g. scholarspace_dev, scholarspace_test, scholarspace_prod)

        postgres=# \q
        (postgres)% createdb -O YOURDBUSERNAME YOURDEVDBNAME
        (postgres)% createdb -O YOURDBUSERNAME YOURTESTDBNAME
        (postgres)% createdb -O YOURDBUSERNAME YOURPRODDBNAME
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

        % rake db:migrate RAILS_ENV=production
        
* Setup .jar files for full-text indexing
 
        % rake sufia:jetty:config

* Move the .jar files to your Solr instance

  If your Solr instance is on the same server as the GW ScholarSpace application do the following:
        
        % mv /opt/solr/contrib/extraction /opt/solr/contrib/extraction_bak
        % cp -R jetty/solr/lib/contrib/extraction /opt/solr/contrib/
        % sudo service tomcat7 restart

  If your Solr instance is on a different server from the GW ScholarSpace application do the following:

        Download the /opt/scholarspace/jetty/solr/lib/contrib/extraction folder via SFTP
        % mv /opt/solr/contrib/extraction /opt/solr/contrib/extraction_bak
        Upload the extraction folder to the server with your Solr instance into: /opt/solr/contrib/
        % sudo service tomcat7 restart
        
* Install fits.sh (check [FITS](http://projects.iq.harvard.edu/fits/downloads) for the latest download)

        % cd /usr/local/bin
        % sudo curl http://projects.iq.harvard.edu/files/fits/files/fits-0.8.6_1.zip -o fits.zip
        % sudo unzip fits.zip
        % cd fits-0.8.6
        % sudo chmod a+x fits*.sh

### Configure Contact form emailing

  In order to enable the contact form page to send email when the user clicks Send,
set the following properties in config/initializers/sufia.rb :
  * config.action_mailer.contact_email
  * config.action_mailer.from_email

Copy config/initializers/setup_mail.rb.template to config/initializers/setup_mail.rb .
Set the SMTP credentials for the user as whom the app will send email.

### Start a Redis RESQUE pool

        % script/restart_resque.sh production

### (Optional) Populate the initial content blocks

  Run the rake task that takes the content of the HTML files in config/locales/content_blocks and populates the associated content blocks.  Note that for an existing instance, running this rake task will overwrite any chnages you've made to the content blocks!

        % rake gwss:populate_content_blocks RAILS_ENV=production

### Configure Passenger and Apache2

* Setup the Passenger

        % gem install passenger
        % passenger-install-apache2-module
        Select Ruby from the list of languages
        
* Edit Apache for Passenger

  Copy the passenger.conf file from /opt/scholarspace/apache2_conf folder to /etc/apache2/conf-available/passenger.conf
   
* Enable the passenger.conf file     

        % sudo a2enconf passenger.conf
        % sudo service apache2 restart

* Create and enable an Apache2 virtual host

  Copy the scholarspace.conf file from the /opt/scholarspace/apache2_conf folder to /etc/apache2/sites-available/scholarspace.conf
  
        % sudo a2ensite scholarspace.conf
        
* Install mod_xsendfile

        % cd /opt/install
        % git clone https://github.com/nmaier/mod_xsendfile.git
        % cd mod_xsendfile
        % sudo apxs2 -cia mod_xsendfile.c
        % sudo service apache2 restart

### Final Deployment

* Prepare databases and assets for production

        % cd /opt/scholarspace
        % rake assets:precompile RAILS_ENV=production 
        % sudo service apache2 restart

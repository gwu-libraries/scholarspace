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

### Create the user roles

  Run the rake task that creates user roles called `admin` and `content-admin`:

        % rake gwss:create_roles

  At the rails console, add an initial user to the `admin` role.  Make sure that your admin user
has logged in at least once.

        % rails c
        > r = Role.find_by_name('admin')
        > r.users << User.find_by_user_key('YOUR_ADMIN_USER_EMAIL@gwu.edu')
        > r.save 

  We will [add the content-admin users](#dev-add-content-admin) shortly through the /roles UI.

### (Optional) Populate the initial content blocks

  Run the rake task that takes the content of the HTML files in config/locales/content_blocks and populates the associated content blocks.  Note that for an existing instance, running this rake task will overwrite any chnages you've made to the content blocks!
  
        % rake gwss:populate_content_blocks

### Run the application

        % rails s -p <PORT NUMBER> -b 0.0.0.0

### (Optional) Add content-admin users <a id="dev-add-content-admin"></a>

* Ask each of the content-admin users to log in to the application at least once.  Right now they will have read-only rights.

* Log in as an admin user, and navigate to /roles

* Select the content-admin role, and add each of the users to whom you wish to grant content-admin rights.  These users should now be able
to upload items and edit the items that they have uploaded (plus items transferred or proxied to them).

* Note that removing users from roles through the /roles interface is currently broken, and must be accomplished through the rails console.



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

* (Optional) Set up Shibboleth integartion

  Please refer to https://github.com/gwu-libraries/shibboleth for the recommended steps for setting up the Shibboleth integration.

* Install Rails

        % gem install rails -v 4.2.3 -N
        
* Create the directory structure

  On the GW ScholarSpace server:

        % mkdir /opt/scholarspace
        % mkdir /opt/install
        % mkdir /opt/xsendfile
        
  On the Solr/Fedora server (if deploying on a separate server - otherwise on the same server):
        
        % mkdir /opt/install
        % mkdir /opt/solr
        % mkdir /opt/fedora
        % sudo mkdir /var/log/solr
        
* Create the necessary user groups and assign folder permissions

  On the GW ScholarSpace server:

        % sudo groupadd scholarspace
        
        Edit /etc/group and add users (including www-data) to the new group
        
        % sudo chown $USER:scholarspace /opt/scholarspace
        % sudo chown www-data:www-data /opt/xsendfile
        
* Set up tomcat7 (on the Solr/Fedora server)

  Replace the /etc/default/tomcat7 file with the tomcat7 file from the /tomcat_conf folder in this repo.  This will set solr home, fcrepo home, and java path.

  Set the owner of the /opt/fedora directory:
        
        % sudo chown tomcat7:tomcat7 /opt/fedora

* Set up Solr (on the Solr server)

        % cd /opt/install
        % wget http://archive.apache.org/dist/lucene/solr/4.10.4/solr-4.10.4.tgz
        % tar xzvf solr-4.10.4.tgz
        % cd solr-4.10.4
        % sudo cp -R example/solr/* /opt/solr
        % sudo cp -R dist /opt/solr
        % sudo cp -R contrib /opt/solr
        % sudo cp -R /opt/solr/collection1 /opt/solr/development-core
        % sudo cp -R /opt/solr/collection1 /opt/solr/test-core
        % sudo chown -R tomcat7:tomcat7 /opt/solr
        % sudo chown tomcat7:tomcat7 /var/log/solr
        
  To configure Solr:
  
   - Edit /opt/solr/development-core/core.properties to set `name=development-core`

   - Edit /opt/solr/test-core/core.properties to set `name=test-core`

   - Replace the schema.xml and solrconfig.xml in /opt/solr/collection1/conf/ with the ones from the solr_conf folder in the repo.

   - Replace the solr.xml file in /opt/solr with the one from the solr_conf folder in the repo.
  
  Now to deploy Solr to run in Tomcat.  From the /opt/install/solr-4.10.4 directory:
        
        % sudo cp dist/solr-4.10.4.war /var/lib/tomcat7/webapps/solr.war
        % sudo cp -R example/lib/ext/* /var/lib/tomcat7/webapps/solr/WEB-INF/lib
        % sudo cp -R contrib /var/lib/tomcat7/webapps/solr/WEB-INF/lib/
        
  Create the log4j.properties file in /var/lib/tomcat7/webapps/solr/WEB-INF/classes/ with the one from the tomcat_conf/solr folder in the repo.
        
  Set up log rotation by editing /etc/logrotate.d/solr and setting its contents to the following:
   
        /var/log/solr/solr.log { copytruncate daily rotate 5 compress missingok create 640 tomcat7 tomcat7 }
        
* Set up fcrepo-message-consumer

        % cd /opt/install
        % wget http://central.maven.org/maven2/org/fcrepo/fcrepo-message-consumer-webapp/4.3.0/fcrepo-message-consumer-webapp-4.3.0.war
        % sudo cp fcrepo-message-consumer-webapp-4.3.0.war /var/lib/tomcat7/webapps/fcrepo-message-consumer.war
        
  Replace or create the indexer-core.xml file in /var/lib/tomcat7/webapps/fcrepo-message-consumer/WEB-INF/classes/spring/indexer-core.xml with the one from the tomcat_conf/fcrepo-message-consumer folder in the repo.  Edit indexer-core.xml and set the `fedoraUsername` and the `fedoraPassword` values.
        
* Set up fcrepo

        % cd /opt/install
        % wget https://repo1.maven.org/maven2/org/fcrepo/fcrepo-webapp/4.3.0/fcrepo-webapp-4.3.0.war
        % cp fcrepo-webapp-4.3.0.war /var/lib/tomcat7/webapps/fcrepo-webapp-4.3.0.war

  Replace the web.xml file in /var/lib/tomcat7/webapps/fcrepo-webapp-4.3.0/WEB-INF/web.xml with the one from the tomcat_conf/fcrepo-webapp folder in the repo

* Ensure tomcat7 library files are (still) all owned by tomcat7

        % sudo chown -R tomcat7:tomcat7 /var/lib/tomcat7

* Set up authentication to fcrepo

        % cd /etc/tomcat7
        
  Replace tomcat-users.xml with the tomcat-users.xml file from tomcat_conf folder in the repo.
  
  Edit tomcat-users.xml and replace the "dummypasswords" with your secure passwords.

* Restart Tomcat7 Server

        % sudo service tomcat7 restart

### Install

* Get the gw-sufia code:

        % git clone https://github.com/gwu-libraries/scholarspace.git

* Install gems

        % cd scholarspace
        % bundle install --without development

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
        
* Download the hydra-jetty jar files.  While we won't be running Solr and Fedora from hydra-jetty, we need to copy some of the jar files to the Solr deployment in order for full text indexing to work.
 
        % rake sufia:jetty:config

* Move the extraction .jar files from hydra-jetty to your Solr instance (needed for full text indexing)

  If your Solr instance is on the same server as the GW ScholarSpace application, replace the ```/opt/solr/contrib/extraction``` folder with a copy of ```/opt/scholarspace/jetty/solr/lib/contrib/extraction```:
        
        % rm -rf /opt/solr/contrib/extraction
        % cp -R jetty/solr/lib/contrib/extraction /opt/solr/contrib/
        % sudo service tomcat7 restart

  If your Solr instance is on a different server from the GW ScholarSpace application do the following:

        Download the /opt/scholarspace/jetty/solr/lib/contrib/extraction folder from the GW ScholarSpace application server via SFTP.
        On the Solr server, remove the /opt/solr/contrib/extraction directory that was installed with Solr 4.10.4:
        
        % rm -rf /opt/solr/contrib/extraction
        
        Upload the extraction folder from hydra-jetty to the server with your Solr instance into: /opt/solr/contrib/
        
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

### Create the user roles

  Run the rake task that creates user roles called `admin` and `content-admin`:

        % rake gwss:create_roles RAILS_ENV=production

  At the rails console, add an initial user to the `admin` role.  Make sure that your admin user
has logged in at least once.

        % rails c
        > r = Role.find_by_name('admin')
        > r.users << User.find_by_user_key('YOUR_ADMIN_USER_EMAIL@gwu.edu')
        > r.save 

  We will [add the content-admin users](#prod-add-content-admin) later through the /roles UI.

### (Optional) Populate the initial content blocks

  Run the rake task that takes the content of the HTML files in config/locales/content_blocks and populates the associated content blocks.  Note that for an existing instance, running this rake task will overwrite any chnages you've made to the content blocks!

        % rake gwss:populate_content_blocks RAILS_ENV=production

### Configure Passenger and Apache2

* Set up Passenger

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
        
* Install mod_xsendfile (on the GW Scholarspace application server, if deploying on separate servers)

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

### (Optional) Add content-admin users <a id="prod-add-content-admin"></a>

* Ask each of the content-admin users to log in to the application at least once.  Right now they will have read-only rights.

* Log in as an admin user, and navigate to /roles

* Select the content-admin role, and add each of the users to whom you wish to grant content-admin rights.  These users should now be able
to upload items and edit the items that they have uploaded (plus items transferred or proxied to them).

* Note that removing users from roles through the /roles interface is currently broken, and must be accomplished through the rails console.

### (Optional) Add Google Analytics

* Enable Google Analytics in config/initializers/sufia.rb by editing the following lines:

         # Enable displaying usage statistics in the UI
         # Defaults to FALSE
         # Requires a Google Analytics id and OAuth2 keyfile.  See README for more info
         config.analytics = true
        
         # Specify a Google Analytics tracking ID to gather usage statistics
         config.google_analytics_id = 'UA-99999999-1'

         # Specify a date you wish to start collecting Google Analytic statistics for.
         config.analytic_start_date = DateTime.new(2014,9,10)

* Copy the analytics.yml.template file in config

        % cp config/analytics.yml.template config/analytics.yml

* Populate the anaylitcs.yml file with your Google Anaylitcs credentials.  See: https://github.com/projecthydra/sufia#analytics-and-usage-statistics for setup details.  Note that sufia seems to expect the .p12 file version of the private key, rather than the json version.



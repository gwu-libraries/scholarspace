	config/solr.yml
	jetty/

nothing added to commit but untracked files present
kerchner@gwsufia-test2:/opt/scholarspace$ git status -s
?? config/database.yml
?? config/fedora.yml
?? config/solr.yml
?? jetty/
kerchner@gwsufia-test2:/opt/scholarspace$ git status
On branch master
Your branch is ahead of 'origin/master' by 2 commits.
  (use "git push" to publish your local commits)

Untracked files:
  (use "git add <file>..." to include in what will be committed)

	config/database.yml
	config/fedora.yml
	config/solr.yml
	jetty/

nothing added to commit but untracked files present (use "git add" to track)
kerchner@gwsufia-test2:/opt/scholarspace$ cp README.md README.sav
kerchner@gwsufia-test2:/opt/scholarspace$ git reset --hard
HEAD is now at 79a408d Merge branch 'master' of https://github.com/gwu-libraries/scholarspace
kerchner@gwsufia-test2:/opt/scholarspace$ git status -s
?? README.sav
?? config/database.yml
?? config/fedora.yml
?? config/solr.yml
?? jetty/
kerchner@gwsufia-test2:/opt/scholarspace$ vi README.md

# scholarspace

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


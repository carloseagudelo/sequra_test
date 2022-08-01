# Sequra technical test
* * * 

This is the coding challenge for people who applied to a backend developer position at SeQura. It's been designed to be a simplified version of the same problems we deal with.

[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](http://localhost:3000/)

## Lenguage and Platform
  - **Language**: Ruby version 3.1.0
  - **Framework**: Rails version 7.0.3
  - **Database**: SQLite 

## Gettind Started

This steps explains the configuration project using Linux Base Operative System 16+.

### 1. **Install RVM**
Open a terminal and run:
```console
sudo apt-add-repository -y ppa:rael-gc/rvm
sudo apt-get update
sudo apt-get install rvm
```
Check out you RVM installed
```console
rvm --version
```
For **Mac Os** follow the next [steps](https://usabilityetc.com/articles/ruby-on-mac-os-x-with-rvm/)
### 2. **Install Ruby Version**
Using RVM we will to install 2.5.5 Ruby version.
```console
rvm install 2.5.5
```
### 3. **Create Gemset**
Using RVM we will to create a gemset called gemset_rentul_defense, when all gems all installed.
```console
rvm use ruby-2.5.5@<NAME_OF_GEMSET> --create
```
### 4. **Use created Gemset**
You consoleold be sure that you're using Ruby specific version and the Gemset created, use the next commands. You consoleold use this command for check you current ruby version
```console
ruby --version
```
If, promp say other version, you need set the installed version.
```console
rvm use ruby-3.1.0
```
Now, you need check you current gemset thay you are using, use this command.
```console
rvm gemset list
```
If your corrent gemset is other different that you created, use this command.
```console
rvm gemset use <NAME_OF_GEMSET>
```
### 5. **Install and run redis and sidekiq**
We use sidekiq for some processes in the app, and need redis installed and running. You can install it and run it following next steps:
*  brew install redis
*  redis-server

Then, start the sidekiq server
*  bundle exec sidekiq

### 6. **Download project**
You can get the using using clone from the repository, if you want make that rin this:
```console
git clone https://cagudelo@bitbucket.org/carloskikea/portare.git
```
So, you consoleold navigate to the projecto using:
```console
cd portare
```
### 7. **Install gems**
On the project, you need the next command for install and gems and deppends necesaries, run this:
```console
bundle install
```
After that, you have on you gemset, all deppendencies for tun the project installed
### 8. **Database configuration**
Use the next comnmands for create database and Entities. Is necesary chnages credential on the file config/database.yml
```console
rake db:create #CREATE DATABASE
rake db:migrate #RUN MIGRATIONS
rake db:seed #LOAD INITIAL DATA
```
### 9. **Configurate test**
For using test set on the project you need use the next configuration:
```console
rails test
```
### 10. **Run project**
After all, you can use the project, just need run the project using the next command and ou can consoleow the project on the $HOST and $PORT specified.
```console
./bin rails s
```

## Documentation

## Started Date
  - July 2022
## Started Place
  - Medellin, Colombia
## Contact:
  - Carlos Agudelo Software Engineer
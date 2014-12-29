# Update repo
sudo apt-get update

# install dependencies
sudo apt-get install build-essential libssl-dev libyaml-dev libreadline-dev openssl curl git-core zlib1g-dev bison libxml2-dev libxslt1-dev libcurl4-openssl-dev nodejs libsqlite3-dev sqlite3 gcc make mysql-server mysql-client libmysqlclient-dev -y

# make a directory and change directory to it
mkdir ~/ruby
cd ~/ruby

#download ruby from source
wget http://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.3.tar.gz

# Decompress
tar -xzf ruby-2.1.3.tar.gz

# switch to that extracted folder
cd ruby-2.1.3

# Configure, make and make install
./configure
make
sudo make install

# remove temp 
rm -rf ~/ruby

#install a PGP key
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7

# Create an APT source file
sudo touch /etc/apt/sources.list.d/passenger.list
sudo echo "deb https://oss-binaries.phusionpassenger.com/apt/passenger trusty main" > /etc/apt/sources.list.d/passenger.list

# change permessions
sudo chown root: /etc/apt/sources.list.d/passenger.list
sudo chmod 600 /etc/apt/sources.list.d/passenger.list

#update repo again
sudo apt-get update

# finally install nginx and passenger
sudo apt-get install nginx-extras passenger -y

# This step will overwrite our Ruby version to an older one. To resolve this, simply remove the incorrect Ruby location and create a new symlink to the correct Ruby binary file
sudo rm /usr/bin/ruby
sudo ln -s /usr/local/bin/ruby /usr/bin/ruby

sed -i 's/# passenger_root \/usr\/lib\/ruby\/vendor_ruby\/phusion_passenger\/locations.ini;/passenger_root \/usr\/lib\/ruby\/vendor_ruby\/phusion_passenger\/locations.ini;/g' /etc/nginx/nginx.conf
sed -i 's/# passenger_ruby \/usr\/bin\/ruby;/passenger_ruby \/usr\/bin\/ruby;/g' /etc/nginx/nginx.conf

# head back home
cd ~
pwd

# install rails
sudo gem install --no-rdoc --no-ri rails

echo "All done, enjoy your brand new rails server"
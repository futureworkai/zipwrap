# Install CKAN Components from Source
# http://docs.ckan.org/en/2.9/maintaining/installing/install-from-source.html
# NOTE: Python 3 Pathway
sudo apt-get install python3-dev postgresql libpq-dev python3-pip python3-venv git-core solr-jetty openjdk-8-jdk redis-server
# Make the Special VENV Folder
mkdir -p ~/ckan/lib
sudo ln -s ~/ckan/lib /usr/lib/ckan
mkdir -p ~/ckan/etc
sudo ln -s ~/ckan/etc /etc/ckan
sudo mkdir -p /usr/lib/ckan/default
sudo chown `whoami` /usr/lib/ckan/default
python3 -m venv /usr/lib/ckan/default
# Now Use It and Add SetupTools/pip
. /usr/lib/ckan/default/bin/activate
pip install setuptools==44.1.0
pip install --upgrade pip
# Install Stable
pip install -e 'git+https://github.com/ckan/ckan.git#egg=ckan[requirements]'
# Refresh VENV to make sure this path is used.
deactivate
. /usr/lib/ckan/default/bin/activate
# Do the DB Piece
# TODO:
# Create Configuration Files
sudo mkdir -p /etc/ckan/default
sudo chown -R `whoami` /etc/ckan/
ckan generate config /etc/ckan/default/ckan.ini
# NOW EDIT THE FILE

# SymLinks etc ...
ln -s /usr/lib/ckan/default/src/ckan/who.ini /etc/ckan/default/who.ini

# Init the DB
cd /usr/lib/ckan/default/src/ckan
ckan -c /etc/ckan/default/ckan.ini db init

# Run It Now ... Port 5000
cd /usr/lib/ckan/default/src/ckan
ckan -c /etc/ckan/default/ckan.ini run
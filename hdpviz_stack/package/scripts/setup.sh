#!/bin/bash
set -e 
#e.g. /root
export INSTALL_DIR=$1
#e.g. sandbox.hortonworks.com
export HOST=$2
#e.g. 9091
export PORT=$3

echo "Installing nodejs and npm"
cd $INSTALL_DIR
curl https://bintray.com/sbt/rpm/rpm > $INSTALL_DIR/bintray-sbt-rpm.repo
mv $INSTALL_DIR/bintray-sbt-rpm.repo /etc/yum.repos.d/
yum install -y  nodejs npm

git clone https://github.com/dp1140a/HDP-Viz.git
cd $INSTALL_DIR/HDP-Viz

echo "Installing npm packages"
npm install grunt --save-dev
npm install -g grunt-cli 
npm install -g bower

npm install time-grunt
npm install load-grunt-tasks
npm install grunt-autoprefixer
npm install grunt-concurrent
npm install grunt-contrib-clean
npm install grunt-contrib-concat
npm install grunt-contrib-connect
npm install grunt-contrib-copy
npm install grunt-contrib-cssmin
npm install grunt-contrib-htmlmin
npm install grunt-contrib-imagemin
npm install grunt-contrib-jshint
npm install grunt-contrib-uglify
npm install grunt-contrib-watch
npm install grunt-exec
npm install grunt-hapi
npm install grunt-mocha
npm install grunt-newer
npm install grunt-rev
npm install grunt-svgmin
npm install grunt-usemin
npm install grunt-wiredep
npm install jshint-stylish
echo "Completed install of npm packages"

echo "Running bower install..."
bower install --allow-root --config.interactive=false
echo "Running grunt build..."
set +e 
grunt build  --force
set -e

sed -i "s/hadoop.host = 192.168.104.144/hadoop.host = $HOST/g" $INSTALL_DIR/HDP-Viz/server/server.properties
sed -i "s/server.port = 9001/server.port = $PORT/g" $INSTALL_DIR/HDP-Viz/server/server.properties

echo "Running npm install..."
cd $INSTALL_DIR/HDP-Viz/dist 
npm install --production


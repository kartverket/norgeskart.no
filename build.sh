#!/bin/bash

# confirm submodules are correct, initialized and up to date - but don't commit automatically
git submodule init   || exit 1
git submodule update || exit 1

# build every anathem configuration into htdocs
cd lib/src/anathem
git pull origin norgeskart || exit 1

for i in $(cd themes && ls *.yaml); do 
  export name=$(echo $i|sed -e 's/\..*//g');
  echo "building $name..."
  #mkdir -p ../$name
  echo "python26 anathem.py $name > ../../../htdocs/$name.html;"
  python26 anathem.py $name > ../../../htdocs/$name.html;
done 
cd ../../..

# copy all anathem libraries into htdocs/js
# -u update flag only copies newer files
cp -u lib/src/anathem/lib/js/*.js htdocs/js/ || exit 1

# build openlayers custom 
cd lib/src/openlayers
git pull origin master     || exit 1 
cd build
python build.py kartverket || exit 1
cd ../../../..

# copy openlayers build into htdocs/js
cp lib/src/openlayers/build/OpenLayers.js htdocs/js/openlayers.min.js || exit 1



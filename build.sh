#!/bin/bash

# confirm submodules are correct, initialized and up to date - but don't commit automatically
git submodule init   || exit 1
git submodule update || exit 1

# build every anathem configuration into htdocs
cd lib/src/anathem
git pull origin tilgjengelighet || exit 1

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
mkdir -p htdocs/js
cp -ur lib/src/anathem/lib/js/*.* htdocs/js/ || exit 1
cp -ur lib/src/sosi.js/dist/SOSI.min.js htdocs/js/ || exit 1
cp -ur lib/src/sosi.js/lib/underscore-min.js htdocs/js/ || exit 1

# build openlayers custom 
cd lib/src/openlayers
git pull origin tilgjengelighet     || exit 1
cd build
./build.sh kartverket || exit 1
cd ../../../..

# copy openlayers build into htdocs/js
cp lib/src/openlayers/build/OpenLayers.js htdocs/js/openlayers.min.js || exit 1
# copy openlayers themes into htdocs/js/openlayers/theme
cp -r lib/src/openlayers/theme htdocs || exit 1
cp -r lib/src/openlayers/img htdocs || exit 1


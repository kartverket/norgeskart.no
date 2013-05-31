http://beta.norgeskart.no
=============

This is the joint repository for building the norgeskart map client, mostly drawing on dependencies from other repositories.

The content of norgeskart.no and this repository is available under the following licenses:

* Kartverkets logo and font: (C) Kartverket. 
* OpenLayers and all contributions to openlayers, included at /lib/src/openlayers: BSD style - see https://github.com/kartverket/openlayers/blob/master/license.txt
* Everything else: Public Domain.

The solution uses web services from Kartverket which are subject to their own licenses (mostly CC-BY 3.0 Norway) and the Norwegian Geodata law. See http://kartverket.no/Kart/Kartverksted/Lisens/ for the license terms and http://kartverket.no/Kart/Kartverksted/ for details on the web services.

Installation
============

    git clone https://github.com/kartverket/norgeskart.no.git
    cd norgeskart.no
    time ./build.sh 
    
(You may have to adapt the build script to match your python interpreter.)

You should now have a complete map application in your htdocs/ folder. 
The entire site is "static" html + ajax. 
Serve with your web server of least distrust.

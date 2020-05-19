TITLE Flipper COUCH
cd ..\HmiCouch
call ant run -Drun.main.class=eu.couch.hmi.starters.FlipperStarter -Drun.argline="-flipperprops couchflipper.properties"  -Dlogback.configurationFile=logconf.xml
cd ..\Launchers
TIMEOUT /T -1

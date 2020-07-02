TITLE ASAPRealizer COUCH No Android
cd ..\intent-planner
call ant run -Drun.main.class=eu.couch.hmi.starters.AsapCouchStarter -Dlogback.configurationFile=logconf.xml -Drun.argline="-audioport 6669 -launchspecfile couchlaunch.json"
cd ..\Launchers
TIMEOUT /T -1

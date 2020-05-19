TITLE ASAP BmlWindow COUCH
cd ..\HmiCouch
call ant run -Drun.main.class=eu.couch.hmi.starters.BmlWindowStarter -Drun.argline="-title \"ASAP BML CONTROL\" -requesttopic COUCH/BML/REQUEST/ASAP -feedbacktopic COUCH/BML/FEEDBACK/ASAP -scriptdir couchdemobml"
TIMEOUT /T -1
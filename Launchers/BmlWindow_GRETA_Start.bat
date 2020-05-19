TITLE GRETA BmlWindow COUCH
cd ..\HmiCouch
call ant run -Drun.main.class=eu.couch.hmi.starters.BmlWindowStarter -Drun.argline="-title \"GRETA/CAMILLE BML CONTROL\" -requesttopic COUCH/BML/REQUEST/CAMILLE -feedbacktopic COUCH/BML/FEEDBACK/CAMILLEdummy -scriptdir couchdemobml"
TIMEOUT /T -1

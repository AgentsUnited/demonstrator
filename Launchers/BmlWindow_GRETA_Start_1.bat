TITLE GRETA BmlWindow COUCH
cd ..\HmiCouch
call ant run -Drun.main.class=eu.couch.hmi.starters.BmlWindowStarter -Drun.argline="-title \"GRETA 1 BML CONTROL\" -requesttopic couch.bml.request.GRETA1 -feedbacktopic couch.bml.feedback.GRETAdummy -scriptdir couchdemobml"
TIMEOUT /T -1

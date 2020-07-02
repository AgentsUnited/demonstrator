TITLE GRETA BmlWindow COUCH
cd ..\intent-planner
call ant run -Drun.main.class=eu.couch.hmi.starters.BmlWindowStarter -Drun.argline="-title \"GRETA 2 BML CONTROL\" -requesttopic couch.bml.request.GRETA2 -feedbacktopic couch.bml.feedback.GRETAdummy -scriptdir couchdemobml"
TIMEOUT /T -1

FOR INTERNAL (UT) USE ONLY: Fork of Council of Coaches Technical demonstrator, for testing and teaching purposes at University of Twente. 

This is a sandbox repository to upload anything that is needed to build the Technical Demonstrator.
The Technical Demonstrator is an initial attempt at integrating all the existing coaching platforms and modules as they stand now.
It is independent (although it can be used as reference or provide input) from the different prototypes to be developed.
There is no predefined structure for this repository, feel free to upload whatever is needed, but try to maintain coherence.

-------------------
Step by step instructions to install & run this monstrosity (version - MB - 11 Sep. 2018)
Tested and it works (for me), but let me know if anything in the instructions can be improved...

-------------------
**Latest fixes and troubleshooting:**
* By default the Demonstrator requires Windows TTS US voices: Mark, David, Zira. install them from Windows TTS Settings and check out how to set them up with [this wiki](https://github.com/hmi-utwente/HmiASAPWiki/wiki/MS-API-Voices). If you do not have a particular voice installed, the agents should use the default selected voice in "Windows Settings -> Time & Language -> Speech -> Voices" settings instead.
* The code in `{installation}\UT_HMI\HmiCouch` not only requires "ant resolve". You have to "ant clean", "ant resolve" and "ant compile"
* The recommended Flipper script is `Flipper_Superior_Couch_Start.bat` 

To test the Windows voices: What you can try is run ASAP_Superior_Couch_Start_NoAndroid.bat and the Unity scene (do not run Flipper!). Once these are connected you run BmlWindow_ASAP_Start.bat which opens a window where you can input BML and send it to ASAP. 
If all is well the agent should talk. If not, try a couple more times and check the console windows for any errors or warnings.
For example:

```
<bml id="sp1"  xmlns="http://www.bml-initiative.org/bml/bml-1.0" characterId="COUCH_M_1">
              <speech start="0"  id = "speech1">
                <text>Hello there!</text>
              </speech>          
</bml>
```

-------------------

Needed (some guesses here):
- (Windows only)
- Unity3D (version known to work 2017.3.1f1, other 2017.x versions might work, versions known to NOT work 2018.x): https://unity3d.com/get-unity/download/archive
- Docker: https://www.docker.com/
- Java: http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html
- Ant: https://ant.apache.org/
- Enough disk space (I guess about 10GB)


Installation:
1. If you haven't already... Clone this repo (it can take a while... about 5GB). (Note that on windows the longpaths parameter needs to be set, using "git config --system core.longpaths true" (without qoutes)
    a. After cloning, also init and update the submodules: `git submodule update --init --recursive`
2. Start docker (it will need access the the harddrive, fix this in the settings of docker)
    a. Start power-shell, move to the folder \DAF\
    b. Type: docker-compose pull
        Can take a while, about ?GB
3. Start command prompt (Start-key, type cmd) 
    a. Navigate to the folder \UT_HMI\HmiCouch\
    b. Type: ant resolve
        ...wait patiently, this can take a while (about 2GB, depending on what is needed)... 
4. Open the unity3d project first time.
    a. To open de project, open Unity, select 'Open', and navigate to and select the folder: \UT_HMI\UnityProject\ASAPUnityProject
        The first time this can take some time.
    b. Open the scene. 
        In the project assets (standard location of this panel is at the left, bottom), navigate to \Assets\Couch\
        Double click on the scene (standard location of the panel is at bottom): CouchMain.unity
        Now you should see 1 standing female agent (greta), three chairs, and a white screen behind them. 
        Next time you open the unity project, it should automatically load the correct project scene.

Running:
1. Start docker (note that you might need to increase the memory that docker can use for the virtual machines, if you get weird docker errors this might be something to try, 4GB works).
    a. Start power-shell, move to the folder \DAF\
    b. Type: docker-compose up
        Note that if you have ActiveMQ or Apollo as a service on the host machine, docker will not come up. It will complain about ports & sockets being in use
    c. Wait for the docker containers with DGEP to come up. The order of the console output for DGEP is not fixed, but ready is indicated by:
            Connected to external ActiveMQ
            Dialogue and Argumentation Framework ready
2. Run ASAP, the behaviour planner, from \UT_HMI\Launchers\ASAP_Superior_Couch_Start_NoAndroid.bat
    Ready looks like: h.u.loader.UnityEmbodimentLoader - Waiting for AgentSpec...
3. Open the unity3d project.
    a. Press play and wait for three additional ASAP agents to appear and take position standing inside the chairs.
4. Run Flipper from \UT_HMI\Launchers\Flipper_Superior_Couch_Start.bat
    Flipper initiates the dialogue game in DGEP (you should see some output in DGEP console) and positions the ASAP agents in a sitting pose, while they each introduce themselves.
    You should also see an overlay UI appear in the Unity scene. The dialogue automatically progresses until it is the user's turn to make a move.
    Note: currently Flipper cannot restart the interaction. To restart the dialog you need to restart (only) Flipper. 
    
Stopping:
1. Unity: press the play button again (and close the unity editor).
2. ASAP: select the cmd prompt window with ASAP and press ctrl+c
3. Flipper: select the cmd prompt window with Flipper and press ctrl+c
4. Docker: select the PowerShell window with Docker and press ctrl+c, wait for docker containers to quit. (you can now also quit docker (in the system tray)).

Settings:
- To change the demo between 'auto play', where the agents perform their own conversation without user input, or user input, where the user can play the role of patient (i.e. activate the UI):
    - In the flipper template file: \UT_HMI\HmiCouch\resource\couchtemplates\DialogueLoader.xml
    - Change in the information state the variable "uidefaults" and update the identifier to set the agent that should be controlled through the interface
        `"uidefaults": {"actors": [{ "identifier":"User", "controlledBy": ["unityTest", "tablet"] }]}`
    - Restart Flipper

- The role of the user can be altered. The user takes the role of one of the characters in the DGEP dialogue. Currently it is set up as the patient (which makes sense in the context of this project). To alter the role of the user (i.e. the moves of the agent that the UI will show):
    - Open de file: \UT_HMI\HmiCouch\resource\couchtemplates\DialogueLoader.xml
    - Alter the dialogueActors variable to change roles assigned to any of the agents or the user
        ```
        "dialogueActors" : [
			{ "bml_name":"COUCH_CAMILLE", "engine":"greta", "role":"Camille",    "identifier":"COUCH_CAMILLE", "dialogueActorClass":"UIControllableActor", "priority": 0.5 },
			{ "bml_name":"COUCH_M_1", "engine":"ASAP", "role":"Marc",    "identifier":"COUCH_M_1", "dialogueActorClass":"UIControllableActor", "priority": 0.0 },
			{ "bml_name":"COUCH_M_2", "engine":"ASAP", "role":"Ben",     "identifier":"COUCH_M_2", "dialogueActorClass":"UIControllableActor", "priority": 0.5 },
			{ "bml_name":"COUCH_F_1", "engine":"ASAP", "role":"Sarah",     "identifier":"COUCH_F_1", "dialogueActorClass":"UIControllableActor", "priority": 0.5 },
			{ "bml_name":"COUCH_M_Android_1", "engine":"ASAP", "role":"Gordon",     "identifier":"COUCH_M_Android_1", "dialogueActorClass":"UIControllableActor", "priority": 0.5 },
			{ "bml_name":"",		  "engine":"ASAP", "role":"User",    "identifier":"User",		"dialogueActorClass":"UIControllableActor", "priority": 1.0 }
		]
		```
    - Obviously, restart Flipper

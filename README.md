The Agents United Open Platform allows you to build a system of multiple virtual embodied conversational agents.
This repository contains a demonstrator af several coaching agents for different health domains.
The Agents United platform and this demonstrator are the outcome of the [Council of Coaches european research project](https://council-of-coaches.eu/)

The following instructions will guide you through setting up and running the demonstrator. You can find a list of the latest hotfixes and solutions for possible problems you may come across at the end of this Readme.

## Pre-requisites

* **Windows 10 TTS Voices** (Instructions here are only for Windows 10 Pro)
    - You will need the default US voices for Text-To-Speech: Mark, David, and Zira. These can be installed from Settings, Text-to-Speech. Check this wiki for further instructions and troubleshooting: https://github.com/hmi-utwente/HmiASAPWiki/wiki/MS-API-Voices
* **Unity3D** (version 2017.4.24f1. Other 2017.x versions might work, versions 2018.x or later do NOT).
    - https://unity3d.com/get-unity/download/archive.  
    - In the installer, include the Android, iOS, tvOS, macOS build supports 
* **Docker** (Should work with any current version of Docker, including Community for Windows)
    - https://www.docker.com/
* **Java 8 JDK** (Update 211)
    - https://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html.
    - Make sure you add Java to your Path environment variable.
* **Ant build system** (Latest version)
    - https://ant.apache.org/
    - Make sure you add Ant to your Path environment variable.
* **Visual C++ Redistributable for Visual Studio** (versions 2013 and/or 2015)
    - https://support.microsoft.com/en-gb/help/2977003/the-latest-supported-visual-c-downloads 
    - This is recommended for Unity, although your Windows installation may already have this
* Approximately 10GB of disk space and at least 8GB RAM (recommended)

## Installation

1. **Clone this repository**. We will refer to its folder as `{demonstrator}`.
    - Note that on Windows the longpaths parameter needs to be set, using `git config --system core.longpaths true`
    - You may need to init and get the linked submodules with `git submodule update --init --recursive`
    - Instead of using Git, you can manually download the code. If you do so, download and place the submodules as well.
2. **Setup the Dialogue and Argumentation Framework (DAF).**
    1. Start Docker. Right click the tray icon and go to Settings. Go to Shared Drives and share the main drive. Go to Advanced and set Memory to 4GB (Recommended).
    2. Open a command line shell, go to `{demonstrator}\daf` and type the command `docker-compose pull`
3. **Setup the Conversational Intent Planner.**
    1. Open a command line shell, go to `{demonstrator}\hmicouch` and execute the following commands:
    2. `ant clean`
    3. `ant resolve`
    4. `ant compile`
4. **Install *Mary TTS* **
    1. Download *Mary TTS* from http://mary.dfki.de/download/index.html, Runtime Package, and unpack the contents in any folder you want. We will refer to this folder as `{marytts}` from now on.
    2. Go to `{marytts}/bin` and run `maryttscomponent-installer.bat`. From that tool, install the following languages:
    - `enUS/cmu-slt`
    - `en-US/cmu-bdl`
    - `fr/enst-camille`
    - `fr/enst-camille-hsmm`
5. **Setup Greta agents.**
    1. Open a command line shell, go to `{demonstrator}\greta` and execute the command `ant build`
    2. Go to `{demonstrator}\greta\bin` and edit the files `vib.ini` and `Modular.xml` to replace `./Environments/Empty.xml` with `./Environments/Projects/Council of Coaches/TechnicalDemonstrator.xml`.
    3. Also in `vib.ini`, replace `<MARY_SERVER_DIRECTORY>` with `{marytts}\bin`.
6. **Setup the Unity scene.**
    1. The demonstrator scene uses some commercial 3rd party assets that cannot be made available in this repository. Please purchase and/or download these assets from the Unity Asset store and place them in  `{demonstrator}\unityprojet\COUCHUnityProject\Assets\Borg\3rdParty`:
    - devtid
    - DigitalKonstrukt
    - o3n
    - RecompileDisabler
    - RootMotion
    2. Start Unity. Select Open project, and then select the folder `{demonstrator}\unityprojet\COUCHUnityProject`. (You may get a warning dialog depending on your exact version of Unity. Ignore it and Continue).
    3. In the Project assets panel (usually bottom-left), navigate to `\Assets\Couch` and double-click the scene `CouchMain.unity`

## Running
1. **Run OpenMary TTS**: Open a command line shell, go to `{marytts}\bin` and execute `marytts-server.bat`. Wait until it is up and running on port 59125
2. **Start Docker**
3. **Run the Dialogue and Argumentation Framework (DAF)**: Open a command line shell, go to `{demonstrator}\daf` and type the command `docker-compose up`. Wait until it is up and running.
4. **Run ASAP Agent Manager**: Open a command line shell, go to `{demonstrator}\Launchers` and run `ASAP_Superior_Couch_Start_NoAndroid.bat`. Wait until you see the message `“Waiting for AgentSpec…”`.
5. **Run Greta**: Open a command line shell, go to `{demonstrator}\greta\bin` and type the command `java –jar Modular.jar`. The Greta user interface window will open. From its menus, select File > Open and go to `{demonstrator}\greta\bin\Configurations\GretaUnity\Projects\Council of Coaches`, and select `Council of Coaches - TechnicalDemonstrator.xml`.
6. **Run the Unity scene**: Open the `COUCHUnityProject` in Unity and open the `CouchMain` scene. Press the Play button (usually at the top) and wait for the agents to take their place (you may be asked to allow firewall access).
7. **Run the Conversational Intent Planner**: Open a command line shell, go to `{demonstrator}\Launchers` and run `Flipper_Superior_Couch_Start.bat`. Wait until the scenario begins.
8. **Run the demo**: When the demo begins, the coaches will start talking. An overlay in the Unity scene will display the moves available to the user, from which you can choose how to proceed.
9. To restart the dialog, you need to restart only the Conversational Intent Planner (ctrl+c, then run it again).
    
## Stopping
1. Unity: press the Play button again (and close the Unity editor).
2. Command line windows: press ctrl+c
3. DAF: In addition to ctrl+c in its command line window, wait for Docker containers to quit, then type the command `docker-compose down`. (you can now also stop Docker).

## Settings
- To change the demo between 'auto play', where the agents perform their own conversation without user input, or user input, where the user can play the role of patient (i.e. activate the UI):
    - In the flipper template file: `\UT_HMI\HmiCouch\resource\couchtemplates\DialogueLoader.xml`
    - Change in the information state the variable "uidefaults" and update the identifier to set the agent that should be controlled through the interface
        `"uidefaults": {"actors": [{ "identifier":"User", "controlledBy": ["unityTest", "tablet"] }]}`
    - Restart Conversational Intent Planner

- The role of the user can be changed. The user takes the role of one of the characters in the dialogue. Currently it is set up as the patient. To change the role of the user (i.e. the moves of the agent that the UI will show):
    - Open the file: `\UT_HMI\HmiCouch\resource\couchtemplates\DialogueLoader.xml`
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
    - Restart Conversational Intent Planner

**Latest fixes and troubleshooting:**
* By default the Demonstrator requires Windows TTS US voices: Mark, David, Zira. install them from Windows TTS Settings and check out how to set them up with [this wiki](https://github.com/hmi-utwente/HmiASAPWiki/wiki/MS-API-Voices). If you do not have a particular voice installed, the agents should use the default selected voice in "Windows Settings -> Time & Language -> Speech -> Voices" settings instead.
* To test the Windows voices: What you can try is run `ASAP_Superior_Couch_Start_NoAndroid.bat` and the Unity scene (do not run Conversational Intent Planner!). Once these are connected you run `BmlWindow_ASAP_Start.bat` which opens a window where you can input BML and send it to ASAP. 
If all is well the agent should talk. If not, try a couple more times and check the console windows for any errors or warnings.
For example:

```
<bml id="sp1"  xmlns="http://www.bml-initiative.org/bml/bml-1.0" characterId="COUCH_M_1">
              <speech start="0"  id = "speech1">
                <text>Hello there!</text>
              </speech>          
</bml>
```

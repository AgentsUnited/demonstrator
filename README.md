The Agents United Open Platform allows you to build a system of multiple virtual embodied conversational agents.
This repository contains a demonstrator af several coaching agents for different health domains.
The Agents United platform and this demonstrator are the outcome of the [Council of Coaches european research project](https://council-of-coaches.eu/)

#### Repositories

Each of the different modules that compose the Agents United platform has its own repository. Some modules are hosted and maintained here in Agents United while others are external, developed and hosted in 3rd party repositories.

Modules hosted in Agents United:
* DAF: The Dialogue and Argumentation Framework modules
* Intent-Planner: The Conversational Intent Planner modules
* UnityProject: Unity3D scenes for the agents user interface
* Demonstrator: This repository, which also contains a collection of executable scripts
* Topic-Selection-Engine: The Topic Selection Engine module
* universAAL: Modules for connecting to the universAAL IoT platform

Other modules hosted elsewhere:
* [Greta](https://github.com/isir/greta): Socio-emotional virtual characters for agents by ISIR - University of Sorbonne
* [HMI Build](https://github.com/ArticulatedSocialAgentsPlatform/hmibuild): Multi-platform build system by HMI - University of Twente
* [WOOL Web Service](https://github.com/woolplatform/wool/tree/master/java/WoolWebService): Knowledge base and dialogue management web service of the [WOOL Platform](https://github.com/woolplatform)

#### Architecture

If you are interested in figuring out how the entire Agents United platform works you can check out the architecture documentation and diagrams in the [Architecture repository](https://github.com/AgentsUnited/architecture)

#### License

The modules hosted in Agents United are licensed under the GNU Lesser General Public License v3.0 (LGPL 3.0) except when otherwise is stated. External modules linked here have their own licenses.

#### Instructions

The following instructions will guide you through setting up and running the demonstrator. You can find a list of the latest hotfixes and solutions for possible problems you may come across at the end of this Readme.

## Pre-requisites

* **Windows 10 TTS Voices** (Instructions here are only for Windows 10 Pro)
    - You will need the default US voices for Text-To-Speech: Mark, David, and Zira. These can be installed from Settings, Text-to-Speech. Check this wiki for further instructions and troubleshooting: https://github.com/hmi-utwente/HmiASAPWiki/wiki/MS-API-Voices
* [**Unity3D**](https://unity3d.com/get-unity/download/archive) (version 2017.4.24f1. Other 2017.x versions might work, versions 2018.x or later do NOT).
    - In the installer, include the Android, iOS, tvOS, macOS build supports 
* [**Docker**](https://www.docker.com/) (Should work with any current version of Docker, including Community for Windows)
    - Select Linux containers during installation
* [**Java 8 JDK**](https://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html) (Update 211)
    - Make sure you add the Java bin folder to your PATH environment variable.
    - Make sure you set the JAVA_HOME environment variable.
* [**Ant build system**](https://ant.apache.org/) (Latest version)
    - Make sure you add the Ant bin folder to your PATH environment variable.
    - Make sure you set the ANT_HOME environment variable.
* [**Visual C++ Redistributable for Visual Studio**](https://support.microsoft.com/en-gb/help/2977003/the-latest-supported-visual-c-downloads) (versions 2013 and/or 2015)
    - This is recommended for Unity, although your Windows installation may already have this
* Approximately 10GB of disk space and at least 8GB RAM (recommended)

## Installation

<details><summary>Clone this repository</summary>

- Note that on Windows the longpaths parameter needs to be set, using `git config --system core.longpaths true`
- clone the repository: `git clone https://github.com/AgentsUnited/demonstrator.git` (we will refer to its folder as `{demonstrator}`)
  ![Screenshot of the git clone command](https://github.com/AgentsUnited/documentation/blob/master/screenshots/demonstrator/git_clone.png?raw=true)
- Init and get the linked submodules with `git submodule update --init --recursive`
  ![Screenshot of the git sumbodule command](https://github.com/AgentsUnited/documentation/blob/master/screenshots/demonstrator/sumbodule_update.png?raw=true)
- Instead of using Git, you can manually download the code. If you do so, download and place the submodules as well.
</details>
<details><summary>Setup the Dialogue and Argumentation Framework (DAF)</summary>

1. Start Docker. Right click the tray icon and go to Settings. Go to Shared Drives and share the main drive. Go to Advanced and set Memory to 4GB (Recommended).
2. Open a command line shell, go to `{demonstrator}\daf` and type the command `docker-compose pull`
3. Then type the command `docker-compose build` to build the various containers. When finished it should look similar to this:
   ![Screenshot of docker-compose build command](https://github.com/AgentsUnited/documentation/blob/master/screenshots/demonstrator/daf/build.png?raw=true)
</details>
<details><summary>Setup ASAP and the Intent Planner</summary>

1. Open a command line shell, go to `{demonstrator}\intent-planner` and execute the following commands:
2. `ant clean`
3. `ant resolve` - this downloads all dependencies for this project (including libs native to your operating system, 32/64 bit). This process may take a while. When finished it should state `BUILD SUCCESSFUL` without any errors.
   ![Screenshot of ant resolve](https://github.com/AgentsUnited/documentation/blob/master/screenshots/demonstrator/intent-planner/resolving.png?raw=true)
4. `ant compile` - this compiles all java source files.
   ![Screenshot of ant compile](https://github.com/AgentsUnited/documentation/blob/master/screenshots/demonstrator/intent-planner/compiling.png?raw=true)
</details>
<details><summary>Install Mary TTS</summary>

1. Download *Mary TTS* from http://mary.dfki.de/download/index.html, Runtime Package, and unpack the contents in any folder you want. We will refer to this folder as `{marytts}` from now on.
2. Go to `{marytts}/bin` and run `maryttscomponent-installer.bat`. From that tool, install the following languages:
	- `enUS/cmu-slt`
	- `en-US/cmu-bdl`
	- `fr/enst-camille`
	- `fr/enst-camille-hsmm`
</details>
<details><summary>Setup Greta agents</summary>

1. Open a command line shell, go to `{demonstrator}\greta` and execute the command `ant build`
2. Go to `{demonstrator}\greta\bin` and edit the files `vib.ini` and `Modular.xml` to replace `./Environments/Empty.xml` with `./Environments/Projects/Council of Coaches/TechnicalDemonstrator.xml`.
3. Also in `vib.ini`, replace `<MARY_SERVER_DIRECTORY>` with `{marytts}\bin`.
</details>
<details><summary>Setup the Unity scene</summary>

1. Start Unity. Select Open project, and then select the folder `{demonstrator}\unityprojet\AgentsUnitedDemo`. (You may get a warning dialog depending on your exact version of Unity. Ignore it and Continue).
1. In the Project assets panel (usually bottom-left), navigate to `\Assets\AgentsUnited\Scenes` and double-click the scene `MainScene.unity`. Unity will now import and set up all assets for your system (this may take a while). When finished your scene in the editor should look similar to this:
   ![Screenshot of the Unity editor](https://github.com/AgentsUnited/documentation/blob/master/screenshots/demonstrator/unityproject/editor.png?raw=true)
</details>

## Running
<details><summary>Run OpenMary TTS</summary>

Open a command line shell, go to `{marytts}\bin` and execute `marytts-server.bat`. Wait until it is up and running on port 59125
</details>
<details><summary>Run the Dialogue and Argumentation Framework (DAF)</summary>

1. Start Docker
2. Open a command line shell, go to `{demonstrator}\daf` and type the command `docker-compose up`. Wait until it is up and running.
   The console should print `Dialogue and Argumentation Framework ready` and look similar to this:
   ![Screenshot of the DAF console](https://github.com/AgentsUnited/documentation/blob/master/screenshots/demonstrator/daf/console_running.png?raw=true)
   If you prefer to use the Docker dashboard, it should look similar to this:
   ![Screenshot of the Docker dashboard](https://github.com/AgentsUnited/documentation/blob/master/screenshots/demonstrator/daf/gui_running.png?raw=true)

</details>
<details><summary>Run ASAP Agent Manager</summary>

On Windows: double click the `{demonstrator}\Launchers\ASAP_Superior_Couch_Start_NoAndroid.bat` from your File Explorer. This opens a command line shell. Wait until you see the message `Waiting for AgentSpec…`.

![Screenshot of ASAP waiting to connect to Unity](https://github.com/AgentsUnited/documentation/blob/master/screenshots/demonstrator/intent-planner/asap_not_connected.png?raw=true)
</details>
<details><summary>Run Greta</summary>

Open a command line shell, go to `{demonstrator}\greta\bin` and type the command `java –jar Modular.jar`. The Greta user interface window will open. From its menus, select File > Open and go to `{demonstrator}\greta\bin\Configurations\GretaUnity\Projects\Council of Coaches`, and select `Council of Coaches - TechnicalDemonstrator.xml`.
</details>
<details><summary>Run the Unity scene</summary>

Open the `AgentsUnitedDemo` project in Unity and open the `MainScene` scene. Press the Play button (usually at the top). You may be asked for firewall access.
The agents briefly appear overlapping in the center of the table.

![Screenshot of agents in Unity before connecting with ASAP](https://github.com/AgentsUnited/documentation/blob/master/screenshots/demonstrator/unityproject/running_not_connected.png?raw=true)

ASAP and Unity will now automatically create a connection and exchange details about the embodiment of the agents, as shown in the ASAP console window.

![Screenshot of ASAP after connecting with Unity](https://github.com/AgentsUnited/documentation/blob/master/screenshots/demonstrator/intent-planner/asap_connected.png?raw=true)

The agents in the Unity scene will reposition behind the table on the chairs. Note that the agents are now still standing and are overlapping with the chairs, this is normal.

![Screenshot of agents in Unity after connecting with ASAP](https://github.com/AgentsUnited/documentation/blob/master/screenshots/demonstrator/unityproject/running_connected.png?raw=true)
</details>
<details><summary>Run the Intent Planner</summary>

On Windows: double click the `{demonstrator}\Launchers\Flipper_Superior_Couch_Start.bat` from your File Explorer.
A small login window opens. The default username and password should work for connecting to the default [Wool Web Service](https://github.com/woolplatform/wool/tree/master/java/WoolWebService) used in the demonstrator. If you are hosting your own service you will need to enter different login information.

![Screenshot of login window](https://github.com/AgentsUnited/documentation/blob/master/screenshots/demonstrator/intent-planner/login.png?raw=true)
</details>
<details><summary>Run the demo</summary>

Click the `Login` button. You are now logged in to the Wool Web Service, and your authentication key is automatically shared with the Topic Selection Engine and the Dialogue and Argumentation Framework modules.

After logging in, the demonstrator dialogue is automatically initiated. The coaches in Unity will start by saying "Hi", and will sit down on their chair. An overlay in the Unity scene will display the moves available to the user, from which you can choose how to proceed.

![Screenshot of Unity with a running dialogue](https://github.com/AgentsUnited/documentation/blob/master/screenshots/demonstrator/unityproject/dialogue_in_progress.png?raw=true)

The DAF console will now output information about the ongoing state of the dialogue.

![Screenshot of Unity with a running dialogue](https://github.com/AgentsUnited/documentation/blob/master/screenshots/demonstrator/daf/dialogue_in_progress.png?raw=true)

To restart the dialog, you need to restart only the Conversational Intent Planner (press `ctrl+c` in the console window, then `y` to confirm, then run the `Flipper_Superior_Couch_Start.bat` file again).
</details>

## Stopping
1. Unity: press the Play button again (and close the Unity editor).
2. Command line windows: press `ctrl+c` and then `y` to confirm.
3. DAF: In addition to ctrl+c in its command line window, wait for Docker containers to quit, then type the command `docker-compose down`. (you can now also stop Docker).

## Settings
### Enabling user input
To change the demo between 'auto play', where the agents perform their own conversation without user input, or user input, where the user can play the role of patient (i.e. activate the UI):
- In the Flipper template file: `{demonstrator}\intent-planner\resource\couchtemplates\DialogueLoader.xml`
- Change in the information state the variable "uidefaults" and update the identifier to set the agent that should be controlled through the interface
`"uidefaults": {"actors": [{ "identifier":"User", "controlledBy": ["unityTest", "tablet"] }]}`
- Restart Conversational Intent Planner

### Changing the role of the user
The role of the user can be changed. The user takes the role of one of the characters in the dialogue. Currently it is set up as the patient. To change the role of the user (i.e. the moves of the agent that the UI will show):
- Open the file: `{demonstrator}\intent-planner\resource\couchtemplates\DialogueLoader.xml`
- Alter the `dialogueActors` variable to change roles assigned to any of the agents or the user
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
- Restart Intent Planner
	

## Latest fixes and troubleshooting
* By default the Demonstrator requires Windows TTS US voices: Mark, David, Zira. install them from Windows TTS Settings and check out how to set them up with [this wiki](https://github.com/hmi-utwente/HmiASAPWiki/wiki/MS-API-Voices). If you do not have a particular voice installed, the agents should use the default selected voice in "Windows Settings -> Time & Language -> Speech -> Voices" settings instead.
* To test the Windows voices: What you can try is run `ASAP_Superior_Couch_Start_NoAndroid.bat` from the Launchers folder and the Unity scene (do not run Conversational Intent Planner!). Once these are connected you run `BmlWindow_ASAP_Start.bat` which opens a window where you can input BML and send it to ASAP. 
If all is well the agent should talk. If not, try a couple more times and check the console windows for any errors or warnings.
For example, the following BML will make one of the agents speak "Hello there!":

```
<bml id="sp1"  xmlns="http://www.bml-initiative.org/bml/bml-1.0" characterId="COUCH_M_1">
              <speech start="0"  id = "speech1">
                <text>Hello there!</text>
              </speech>          
</bml>
```
* If you had installing teh DAF module before and are having problems with empty moves, you may have to clear the Move cache with: `docker exec -it mongodb mongo couch_content --eval “db.move_cache.remove({})”`

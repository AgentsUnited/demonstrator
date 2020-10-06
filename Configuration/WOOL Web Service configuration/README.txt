==========================================
WOOL Web Service setup for demonstrator
==========================================

1. Set up the WOOL Web Service as described in its README.
2. Add the users.xml file in this folder to the directory that is set for 'woolconfigDataDir' in the gradle.properties of the WOOL Web Service.
3. Create a folder in the 'woolconfigDataDir' called 'varstore' (if it does not exist yet) and copy the jsons from the 'usermodels' folder in there.
4. Add the dialogue files in the dialogues subfolder to the 'src/main/resources/dialogues/en/' folder
5. Run the updateConfig and build cargoRedeployRemote gradle commands (as described in the WOOL Web Service README).
6. If you want to reset the variables for a user remotely, you can send the contents of the '-resetJson' text files to the setVariables endpoint (or copy that Json into the field in the Swagger interface).
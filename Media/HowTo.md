Audio wav file for button sound is from: https://mixkit.co/free-sound-effects/technology/

Steps to incorporate sound file into this project loosely based on https://stackoverflow.com/questions/10576312/use-wave-file-from-project/47960211#47960211

1 - Click Delphi (12) main menu item "Project | Resources and Images..."

2 - Enter "WAVE" as Resource type when importing the wav file, and name the resource.

3 - Build the project

4 - Play the sound with:     PlaySound(<resource name>, 0, SND_RESOURCE or SND_ASYNC);



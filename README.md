![image](https://forthebadge.com/images/badges/works-on-my-machine.svg)
![image](https://forthebadge.com/images/badges/code-it-test-it-break-it.svg)

# Project Vienna Builder (batch)
Batch file which downloads all necessary files and install Project Vienna into the current directory. It is recommended that you have Docker pre-installed on your computer, however this script will check for that. Git and wget will be installed as well; if you don't need Git and wget after running the script, they can be uninstalled.
**NOTE**: only for Windows, might bring it to Linux/macOS, not sure though.

# Instructions
1. Make a new folder, with no spaces and unusual characters, such as Ă, Î etc.
2. Place the downloaded batch file in that folder, then run it. If you don't have Docker installed, run it as administrator.
3. Confirm the prompts, then let it download all the files and programs required.
4. Get your local ip by running (Win Key + R) the following command: `cmd /k ipconfig`. Find the line with `IPv4 Address: ` and note that IP. You will type it in `Folder\vienna-docker\settings.txt`, where `Folder` is the one you created and ran the script from.
5. After the files are moved, a prompt should automatically show up on your screen. If everything went well, you should receive a notification confirming everything was done correctly.

You can also check if the container is alive in Docker, as this script will automatically register it.

# Additional steps you *might* need to do:
If you want to play the game while outside, you will need to put your public IPv4 IP address in settings.txt instead of the local one.

# Things to be added
1. Automatically change the IP in settings.txt with local IP and also display it on the screen.
2. Error handling.

# Bugs or features?
Make a new issue request and I'll look into it. Thanks for the support!

# Credit
Credit for Project Vienna goes to micheal65536. You can find out more at https://github.com/Project-Genoa/Vienna-docker & https://github.com/Project-Genoa/Vienna-data. The script uses those repositories to download the needed data.

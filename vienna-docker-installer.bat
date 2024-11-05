@echo off
REM SETTING ENVIRONMENT
set location=%~dp0
echo Note: Docker will need to be installed in order to set up Vienna.
echo The rest of the packages will be installed automatically.
echo Dependencies which will be installed: Git, wget.
echo The working directory for this script is defined as %location%.
echo By proceeding, Project Vienna will be installed in the directory listed above.
:choice
set /P r=Are you sure you want to continue? [y/n] 
if /I "%r%" EQU "y" goto :yep
if /I "%r%" EQU "n" goto :no
goto :choice

:no
exit


:yep

REM ENSURING DOCKER, GIT AND WGET ARE INSTALLED
powershell "get-package docker* | %% { $_.metadata['installlocation'] }" | find "get-package" && (
echo Docker wasn't found.
:dockerAsk
set /P d=Would you like to install the program? 
if /I "%d%" EQU "y" goto :installDocker
if /I "%d%" EQU "n" goto :noInstallDocker
goto :dockerAsk

:installDocker
echo.
echo Enabling virtual machine platform...
Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform
echo Downloading installer...
echo Install the program using the default options, then restart your computer.
echo After booting, run the script again. It should detect the program.
winget install Docker.DockerDesktop --allow-reboot
timeout /t -1 -nobreak

:noInstallDocker
echo.
echo Will continue running the script, however, you might run into issues along the way.
timeout /t -1
) || (
echo Docker was found. Continuing installation...
)
echo.
echo Installing wget...
winget install wget --no-upgrade
echo.
echo Installing Git...
winget install --id Git.Git -e --source winget --no-upgrade

REM Downloading data...
echo.
echo Cloning the repositories...
git clone https://github.com/Project-Genoa/Vienna-docker
git clone https://github.com/Project-Genoa/Vienna-data
wget "https://web.archive.org/web/20210624200250if_/https://cdn.mceserv.net/availableresourcepack/resourcepacks/dba38e59-091a-4826-b76a-a08d7de5a9e2-1301b0c257a311678123b9e7325d0d6c61db3c35" --no-check-certificate
echo Data has been downloaded.
timeout /t -1

REM Starting the process
echo.
echo.
echo Preparing environment...
echo Moving resourcepack...
echo If prompted, press F on your keyboard in order to move the resourcepack.
move "dba38e59-091a-4826-b76a-a08d7de5a9e2-1301b0c257a311678123b9e7325d0d6c61db3c35" Vienna-docker\resourcepack\resourcepack
echo Moving static data...
for /D %%D in ("Vienna-data\*.*") do (
    move "%%~D" "Vienna-docker\static"
)
echo Starting Docker Container...
start Vienna-docker\up.bat
echo Finished process! :)
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Information; $notify.Visible = $true; $notify.ShowBalloonTip(0, 'Project Vienna', 'Installation has been finished succesfully! :)', [System.Windows.Forms.ToolTipIcon]::None)}"
pause
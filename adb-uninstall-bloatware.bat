@echo off
:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------
echo "############################"
echo "Performing preliminary commands to shut-down and restart any previous ADB services..." > CON
adb kill-server > CON
adb devices > CON
echo "Completed preliminary commands..." > CON
echo "############################"
SET LOGFILE=adb-uninstall-bloatware.log
call :Logit >> %LOGFILE%
exit /b 0
:Logit
echo "############################"
echo "Date of Log:" > CON
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mydate=%%c-%%a-%%b)
For /f "tokens=1-2 delims=/:" %%a in ("%TIME%") do (set mytime=%%a%%b)
echo %mydate%_%mytime% > CON
GOTO :Choice
:Choice
set /P c=Hello, Welcome to ADB Bloatware Removal! Are you sure you want to continue[Y/N]? > CON
if /I "%c%" EQU "Y" GOTO :Start
if /I "%c%" EQU "N" GOTO :End
echo "############################"
:Start
echo "Stopping Previous ADB Services with, adb kill-server" > CON
adb kill-server > CON
echo "Starting ADB Services with, adb devices" > CON
adb devices > CON
set /P c=Please Confirm that the phone has prompted you for USB Debugging Permissions, you may need to Revoke permissions in Developer Options. [Y] to continue, [N] to start again. > CON
if /I "%c%" EQU "Y" GOTO :Continue
if /I "%c%" EQU "N" GOTO :Start
:Continue
echo "############################" > CON
echo "Uninstalling Amazon packages" > CON
echo "############################" > CON
echo "Uninstalling Amazon Process" > CON
adb shell "pm uninstall --user 0 com.amazon.fv" > CON
echo "Uninstalling Amazon Shop" > CON
adb shell "pm uninstall --user 0 com.amazon.mShop.android" > CON
echo "Uninstalling Amazon Kindle" > CON
adb shell "pm uninstall --user 0 com.amazon.kindle" > CON
echo "Uninstalling Audible" > CON
adb shell "pm uninstall --user 0 com.audible.application" > CON
echo "############################" > CON
echo "Uninstalling Android packages" > CON
echo "############################" > CON
echo "Uninstalling Voicemail" > CON
adb shell "pm uninstall --user 0 com.coremobility.app.vnotes" > CON
echo "Uninstalling Calendar Widget" > CONc
adb shell "pm uninstall --user 0 com.sec.android.widgetapp.SPlannerAppWidget"
echo "Uninstalling Calendar" > CON
adb shell "pm uninstall --user 0 com.android.calendar" > CON
echo "############################" > CON
echo "Uninstalling Flipboard packages" > CON
echo "############################" > CON
echo "Uninstalling Flipboad App" > CON
adb shell "pm uninstall --user 0 flipboard.app" > CON
echo "Uninstalling Flipboard Boxer App" > CON
adb shell "pm uninstall --user 0 flipboard.boxer.app" > CON
echo "############################" > CON
echo "Uninstalling Google packages" > CON
echo "############################" > CON
echo "Uninstalling Google+ App" > CON
adb shell "pm uninstall --user 0 com.google.android.apps.plus" > CON
echo "Uninstalling Google Search App" > CON
adb shell "pm uninstall --user 0 com.google.android.googlequicksearchbox" > CON
echo "Uninstalling Google YouTube" > CON
adb shell "pm uninstall --user 0 com.google.android.youtube" > CON
echo "Uninstalling Google Magazines" > CON
adb shell "pm uninstall --user 0 com.google.apps.magazines" > CON
adb shell "pm uninstall --user 0 com.google.android.apps.magazines" > CON
echo "Uninstalling Google Play Books" > CON
adb shell "pm uninstall --user 0 com.google.apps.books" > CON
echo "Uninstalling Google Gmail" > CON
adb shell "pm uninstall --user 0 com.google.android.gm" > CON
echo "Uninstalling Google Hangouts" > CON
adb shell "pm uninstall --user 0 com.google.android.talk" > CON
echo "Uninstalling Google Play Games" > CON
adb shell "pm uninstall --user 0 com.google.android.play.games" > CON
echo "Uninstalling Google Play Music" > CON
adb shell "pm uninstall --user 0 com.google.android.music" > CON
echo "Uninstalling Google Play Movies" > CON
adb shell "pm uninstall --user 0 com.google.android.videos" > CON
echo "Uninstalling Google Play Books" > CON
adb shell "pm uninstall --user 0 com.google.android.apps.books" > CON
echo "Uninstalling Google Docs/Drive" > CON
adb shell "pm uninstall --user 0 com.google.apps.docs" > CON
adb shell "pm uninstall --user 0 com.google.android.apps.docs" > CON
echo "Uninstalling Google Maps" > CON
adb shell "pm uninstall --user 0 com.google.android.apps.maps" > CON
echo "############################" > CON
echo "Uninstalling Misc. packages" > CON
echo "############################" > CON
echo "Uninstalling Peel Smart Remote" > CON
adb shell "pm uninstall --user 0 tv.peel.smartremote" > CON
echo "Uninstalling Dropbox." > CON
adb shell "pm uninstall --user 0 com.dropbox.android" > CON
echo "Uninstalling IMDB" > CON
adb shell "pm uninstall --user 0 com.imdb.mobile" > CON
echo "Uninstalling Slacker Radio" > CON
adb shell "pm uninstall --user 0 com.slacker.radio" > CON
echo "Uninstalling NFL Game Center" > CON
adb shell "pm uninstall --user 0 com.gotv.nflgamecenter.us.lite" > CON
echo "Uninstalling Polaris Office 5" > CON
adb shell "pm uninstall --user 0 com.infraware.polarisoffice5" > CON
echo "############################" > CON
echo "Uninstalling Samsung packages" > CON
echo "############################" > CON
echo "Uninstalling S Health" > CON
adb shell "pm uninstall --user 0 com.sec.android.app.shealth" > CON
echo "Uninstalling S Health Remote" > CON
adb shell "pm uninstall --user 0 com.sec.android.app.shealth:remote" > CON
echo "Uninstalling S Voice" > CON
adb shell "pm uninstall --user 0 com.vlingo.midas" > CON
echo "Uninstalling Samsung +" > CON
adb shell "pm uninstall --user 0 com.samsung.oh" > CON
echo "Uninstalling Samsung Voice Recorder" > CON
adb shell "pm uninstall --user 0 com.sec.android.app.voicenote" > CON
echo "Uninstalling Galaxy S Finder" > CON
adb shell "pm uninstall --user 0 com.samsung.android.app.galaxyfinder" > CON
echo "Uninstalling Galaxy Apps" > CON
adb shell "pm uninstall --user 0 com.sec.android.app.samsungapps" > CON
echo "Uninstalling Galaxy Apps Widget" > CON
adb shell "pm uninstall --user 0 com.samsung.android.widget.galaxyfinder" > CON
echo "Uninstalling Galaxy Quick connect" > CON
adb shell "pm uninstall --user 0 com.samsung.android.sconnect" > CON
echo "Uninstalling Samsung DM Sync Service ('Handsfree Activation') > CON
adb shell "pm uninstall --user 0 com.samsung.syncservice" > CON
echo "############################" > CON
echo "Uninstalling Sprint packages" > CON
echo "############################" > CON
echo "Uninstalling Carrier Call Utility/CoreZone/My Sprint" > CON
adb shell "pm uninstall --user 0 com.sprint.zone" > CON
echo "Uninstalling Sprint Spot" > CON
adb shell "pm uninstall --user 0 com.sprint.fng" > CON
echo "Uninstalling Device Self Service" > CON
adb shell "pm uninstall --user 0 com.sprint.dsa" > CON
echo "Uninstalling Carrier Hub" > CON
adb shell "pm uninstall --user 0 com.sprint.ms.smf.services" > CON
echo "############################" > CON
echo "Uninstalling Verizon packages" > CON
echo "############################" > CON
echo "Uninstalling MyVerizon" > CON
adb shell "pm uninstall --user 0 com.vzw.hss.myverizon" > CON
echo "Uninstalling go90" > CON
adb shell "pm uninstall --user 0 com.verizonmedia.go90.enterprise" > CON
echo "Uninstalling Verizon Navigator" > CON
adb shell "pm uninstall --user 0 com.vznavigator.Generic" > CON
echo "Uninstalling Verizon Messaging" > CON
adb shell "pm uninstall --user 0 com.verizon.messaging.vzmsgs" > CON
echo "Uninstalling Verizon Cloud" > CON
echo "############################" > CON
echo "Uninstalling more packages..." > CON
echo "############################" > CON
adb shell "pm uninstall --user 0 com.vcast.mediamanager" > CON
adb shell "pm uninstall --user 0 com.cequint.ecid" > CON
adb shell "pm uninstall --user 0 com.vzw.hss.myverizon" > CON
adb shell "pm uninstall --user 0 com.android.email" > CON
adb shell "pm uninstall --user 0 com.samsung.spg" > CON
adb shell "pm uninstall --user 0 com.vlingo.midas" > CON
adb shell "pm uninstall --user 0 com.samsung.vvm" > CON
adb shell "pm uninstall --user 0 com.sec.android.app.setupwizard" > CON
adb shell "pm uninstall --user 0 com.samsung.everglades.video" > CON
adb shell "pm uninstall --user 0 com.samsung.helphub" > CON
adb shell "pm uninstall --user 0 com.samsung.android.app.memo" > CON
adb shell "pm uninstall --user 0 com.android.mms" > CON
adb shell "pm uninstall --user 0 com.qti.backupagent" > CON
adb shell "pm uninstall --user 0 com.samsung.android.scloud.backup" > CON
adb shell "pm uninstall --user 0 com.sprint.ms.smf.services" > CON
adb shell "pm uninstall --user 0 com.sprint.psdg.sw" > CON
adb shell "pm uninstall --user 0 com.sec.android.widgetapp.digitalclock" > CON
adb shell "pm uninstall --user 0 com.sec.android.widgetapp.digitalclockeasy" > CON
adb shell "pm uninstall --user 0 com.android.contacts" > CON
adb shell "pm uninstall --user 0 com.sec.android.widgetapp.dualclockdigital" > CON
adb shell "pm uninstall --user 0 com.android.mms" > CON
adb shell "pm uninstall --user 0 com.android.email" > CON
adb shell "pm uninstall --user 0 com.sec.kidsplat.installer" > CON
adb shell "pm uninstall --user 0 com.sec.android.app.music" > CON
adb shell "pm uninstall --user 0 com.samsung.android.sm" > CON
adb shell "pm uninstall --user 0 com.sec.android.widget.samsungapps" > CON
adb shell "pm uninstall --user 0 com.sec.android.service.health" > CON
adb shell "pm uninstall --user 0 com.asurion.android.verizon.vms" > CON

echo END OF LOG > CON
echo End of  Uninstall Script > CON
:End
echo Press 'spacebar' to exit command prompt. Your current ADB session will remain active. > CON
pause



 #!/bin/bash
#setup all the mac

echo "Do you have at least xcode and xcode cli tools installed?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) break;;
        No ) xcode-select --install;exit;;
    esac
done

mkdir ~/temp

#request root
echo "Gimme da root"
sudo -v
#keep root
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


echo "Do NOT mess with the computer while this is being completed."
echo "Like seriously"
echo "Unless it prompts you for something, then go ahead"
echo "BTW: disk drives are going to all be unmounted.  Don't attempt to remount until this is done"
echo "Ignore any detach failure messages"

trap ctrl_c INT

function ctrl_c() {
        echo "** Trapped CTRL-C, nice try!!  But rly this needs to finish dont stahp it."
        open -a Safari -g -n http://www.youtube.com/watch?v=dQw4w9WgXcQ
}

echo "Setting some permissions for homebrew."
sudo chown -R $(whoami):admin /usr/local/bin
sudo chown -R $(whoami):admin /usr/local/share/man/man1
sudo chown -R $(whoami):admin /usr/local/lib
sudo chown -R $(whoami):admin /usr/local/share

python -c 'import subprocess;subprocess.call(["hdiutil", "detach", "/dev/disk2s1"]);subprocess.call(["hdiutil", "detach", "/dev/disk2s2"]);subprocess.call(["hdiutil", "detach", "/dev/disk3s1"]);subprocess.call(["hdiutil", "detach", "/dev/disk3s1"]);subprocess.call(["hdiutil", "detach", "/dev/disk4s1"]);subprocess.call(["hdiutil", "detach", "/dev/disk5s1"]);subprocess.call(["hdiutil", "detach", "/dev/disk6s1"]);subprocess.call(["hdiutil", "detach", "/dev/disk7s1"]);subprocess.call(["hdiutil", "detach", "/dev/disk8s1"]);subprocess.call(["hdiutil", "detach", "/dev/disk9s1"]);'

#Change computer name (as done via Sysprefs > Sharing)
echo "Do you wish to change your computer name to something random?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) $newname=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1);sudo scutil --set ComputerName $newname;sudo scutil --set HostName $newname;sudo scutil --set LocalHostName $newname;sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string $newname; break;;
        No ) break;;
    esac
done

#homebrew time!
echo "installing homebrew..."
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Updating homebrew"
brew update
brew upgrade --all
echo "Installing packages"
brew install aalib
brew link aalib
brew install ack
brew link ack
brew install aircrack-ng
brew link aircrack-ng
brew install bash
brew link bash
brew install bash-completion2
brew link bash-completion2
brew install bfg
brew link bfg
brew install binutils
brew link binutils
brew install binwalk
brew link binwalk
brew install cifer
brew link cifer
brew install coreutils
brew link coreutils
brew install cowsay
brew link cowsay
brew install dark-mode
brew link dark-mode
brew install dex2jar
brew link dex2jar
brew install dns2tcp
brew link dns2tcp
brew install dpkg
brew link dpkg
brew install elinks
brew link elinks
brew install fcrackzip
brew link fcrackzip
brew install findutils
brew link findutils
brew install foremost
brew link foremost
brew install fortune
brew link fortune
brew install gawk
brew link gawk
brew install git
brew link git
brew install git-lfs
brew link git-lfs
brew install gnu-sed --with-default-names
brew link gnu-sed --with-default-names
brew install gnu-tar
brew link gnu-tar
brew install hashpump
brew link hashpump
brew install homebrew/dupes/grep
brew link homebrew/dupes/grep
brew install homebrew/dupes/openssh
brew link homebrew/dupes/openssh
brew install homebrew/dupes/screen
brew link homebrew/dupes/screen
brew install homebrew/php/php55 --with-gmp
brew link homebrew/php/php55 --with-gmp
brew install hydra
brew link hydra
brew install imagemagick --with-webp
brew link imagemagick --with-webp
brew install john
brew link john
brew install knock
brew link knock
brew install lua
brew link lua
brew install lynx
brew link lynx
brew install moreutils
brew link moreutils
brew install mpg123
brew link mpg123
brew install mplayer
brew link mplayer
brew install narwhal
brew link narwhal
brew install netpbm
brew link netpbm
brew install nmap
brew link nmap
brew install p7zip
brew link p7zip
brew install pigz
brew link pigz
brew install pngcheck
brew link pngcheck
brew install pv
brew link pv
brew install rename
brew link rename
brew install rhino
brew link rhino
brew install ringojs
brew link ringojs
brew install sfnt2woff
brew link sfnt2woff
brew install sfnt2woff-zopfli
brew link sfnt2woff-zopfli
brew install sl
brew link sl
brew install socat
brew link socat
brew install sqlmap
brew link sqlmap
brew install ssh-copy-id
brew link ssh-copy-id
brew install tcpflow
brew link tcpflow
brew install tcpreplay
brew link tcpreplay
brew install tcptrace
brew link tcptrace
brew install tree
brew link tree
brew install ucspi-tcp
brew link ucspi-tcp
brew install vim --override-system-vi
brew link vim --override-system-vi
brew install webkit2png
brew link webkit2png
brew install wget --with-iri
brew link wget --with-iri
brew install woff2
brew link woff2
brew install xz
brew link xz
brew install zopfli
brew link zopfli
brew tap bramstein/webfonttools
brew tap homebrew/versions
sleep 0.4

echo "Installing another one, press enter for all 4 prompts"
cpan Acme::Term256::Animation

echo "Removing some stuff from menu, adding others"
for domain in ~/Library/Preferences/ByHost/com.apple.systemuiserver.*; do
    defaults write "${domain}" dontAutoLoad -array \
        "/System/Library/CoreServices/Menu Extras/TimeMachine.menu" \
        "/System/Library/CoreServices/Menu Extras/Volume.menu" \
        "/System/Library/CoreServices/Menu Extras/User.menu"
done
defaults write com.apple.systemuiserver menuExtras -array \
    "/System/Library/CoreServices/Menu Extras/Bluetooth.menu" \
    "/System/Library/CoreServices/Menu Extras/AirPort.menu" \
    "/System/Library/CoreServices/Menu Extras/Battery.menu" \
    "/System/Library/CoreServices/Menu Extras/Clock.menu"
sleep 0.4

echo "Shrinking sidebar icons"
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 1
sleep 0.4

echo "Forcing scrollbar to always show"
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"
sleep 0.4

echo "Speeding up window resize"
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001
sleep 0.4

echo "Forcing save and print panels to expand"
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true
sleep 0.4

echo "iLife will save to disk by default"
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
sleep 0.4

echo "Printer app quits on successful print (lol)"
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true
sleep 0.4

echo "Yea we are always sure we want to open this application"
defaults write com.apple.LaunchServices LSQuarantine -bool false
sleep 0.4

echo "removing duplicates in 'open with'"
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user
sleep 0.4

echo "no longer keeping windows on restart"
defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false
sleep 0.4

echo "not gonna terminate inactive apps"
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true
sleep 0.4

echo "No floating help windows"
defaults write com.apple.helpviewer DevMode -bool true
sleep 0.4

echo "Show system info when you click clock in login window"
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName
sleep 0.4

echo "If freeze, restart"
sudo systemsetup -setrestartfreeze on
sleep 0.4

echo "Sleep is for the weak...disabling sleep mode"
sudo systemsetup -setcomputersleep Off > /dev/null
sleep 0.4

echo "Checking for software updates every day"
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1
sleep 0.4

echo "NO SMART QUOTES AND DASHES FOR CODE PLS"
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
sleep 0.4

echo "Do you have a SSD?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) sudo pmset -a sms 0;sudo tmutil disablelocal;sudo pmset -a hibernatemode 0;sudo rm -f /private/var/vm/sleepimage;sudo touch /private/var/vm/sleepimage;sudo chflags uchg /private/var/vm/sleepimage; break;;
        No ) echo "you should get one, they are pretty nice"; break;;
    esac
done

echo "Tap to click"
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
sleep 0.4

echo "disable weird scrolling"
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
sleep 0.4

echo "Better sound on bluetooth"
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40
sleep 0.4

echo "Full kb access everywhere (i.e. tab in modal)"
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
sleep 0.4

echo "GTFO autocorrect"
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
sleep 0.4

echo "ask for pass after wake from screensaver"
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0
sleep 0.4

echo "saving screenshots to desktop in png"
defaults write com.apple.screencapture location -string "${HOME}/Desktop"
defaults write com.apple.screencapture type -string "png"
defaults write com.apple.screencapture disable-shadow -bool true
sleep 0.4

echo "Making fonts sexier"
defaults write NSGlobalDomain AppleFontSmoothing -int 2
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true
sleep 0.4

echo "Making finder quitable"
defaults write com.apple.finder QuitMenuItem -bool true
sleep 0.4

echo "Disabling finder window animations"
defaults write com.apple.finder DisableAllAnimations -bool true
sleep 0.4

echo "Make finder open in ~"
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"
sleep 0.4

echo "Show icons for hdds, servers, etc on desktop"
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
sleep 0.4

echo "Hidden files are now shown"
defaults write com.apple.finder AppleShowAllFiles -bool true
sleep 0.4

echo "Showing extensions"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
sleep 0.4

echo "Showing status and path bar in finder"
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder ShowPathbar -bool true
sleep 0.4

echo "Allow text selection in quick look"
defaults write com.apple.finder QLEnableTextSelection -bool true
sleep 0.4

echo "Show full POSIX path as title"
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
sleep 0.4

echo "Disable warning for file extension change"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
sleep 0.4

echo "Skip dmg verification"
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true
sleep 0.4

echo "no ds store on network volumes"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
sleep 0.4

echo "show file info near icon on desktop etc"
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
sleep 0.4

echo "Better airdrop"
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true
sleep 0.4

echo "Allow macbook air super drive on all macs"
sudo nvram boot-args="mbasd=1"
sleep 0.4

echo "Show ~/Library folder"
chflags nohidden ~/Library
sleep 0.4

echo "rm dropbox's green checks"
file=/Applications/Dropbox.app/Contents/Resources/emblem-dropbox-uptodate.icns
[ -e "${file}" ] && mv -f "${file}" "${file}.bak"
sleep 0.4

echo "make dock smallllll"
defaults write com.apple.dock tilesize -int 16
sleep 0.4

echo "better mini/maximize"
defaults write com.apple.dock mineffect -string "suck"
defaults write com.apple.dock launchanim -bool false
sleep 0.4

echo "minimize into app icon"
defaults write com.apple.dock minimize-to-application -bool true
sleep 0.4

echo "Better mission control"
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.dock expose-group-by-app -bool false
sleep 0.4

echo "No dashboard"
defaults write com.apple.dashboard mcx-disabled -bool true
defaults write com.apple.dock dashboard-in-overlay -bool true
sleep 0.4

echo "Better spaces"
defaults write com.apple.dock mru-spaces -bool false
sleep 0.4

echo "make hidden application's dock icon transparent"
defaults write com.apple.dock showhidden -bool true
sleep 0.4

echo "Add iOS simulator to launchpad"
sudo ln -sf "/Applications/Xcode.app/Contents/Developer/Applications/iOS Simulator.app" "/Applications/iOS Simulator.app"
sleep 0.4

echo "bottom left hot corner -> screensaver"
defaults write com.apple.dock wvous-bl-corner -int 5
defaults write com.apple.dock wvous-bl-modifier -int 0
sleep 0.4

echo "Safari: dont send searches to apple"
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true
sleep 0.4

echo "Tab to highlight items on page"
defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true
sleep 0.4

echo "Show full url (not scheme) in url bar"
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true
sleep 0.4

echo "Stop safari from auto-opening:"
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false
sleep 0.4

echo "add safari menus"
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
sleep 0.4

echo "make safari developer-friendly"
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
sleep 0.4

echo "mail:"
echo "Disable animations"
defaults write com.apple.mail DisableReplyAnimations -bool true
defaults write com.apple.mail DisableSendAnimations -bool true
sleep 0.4

echo "copy email properly"
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false
sleep 0.4

echo "cmd+enter will send email"
defaults write com.apple.mail NSUserKeyEquivalents -dict-add "Send" -string "@\\U21a9"
sleep 0.4

echo "Threading mail"
defaults write com.apple.mail DraftsViewerAttributes -dict-add "DisplayInThreadedMode" -string "yes"
defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortedDescending" -string "yes"
defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortOrder" -string "received-date"
sleep 0.4

echo "no inline attatchments, only icons"
defaults write com.apple.mail DisableInlineAttachmentViewing -bool true
sleep 0.4

echo "optimizing spotlight"
defaults write com.apple.spotlight orderedItems -array \
    '{"enabled" = 1;"name" = "APPLICATIONS";}' \
    '{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
    '{"enabled" = 1;"name" = "DIRECTORIES";}' \
    '{"enabled" = 1;"name" = "PDF";}' \
    '{"enabled" = 1;"name" = "FONTS";}' \
    '{"enabled" = 0;"name" = "DOCUMENTS";}' \
    '{"enabled" = 0;"name" = "MESSAGES";}' \
    '{"enabled" = 0;"name" = "CONTACT";}' \
    '{"enabled" = 0;"name" = "EVENT_TODO";}' \
    '{"enabled" = 0;"name" = "IMAGES";}' \
    '{"enabled" = 0;"name" = "BOOKMARKS";}' \
    '{"enabled" = 0;"name" = "MUSIC";}' \
    '{"enabled" = 0;"name" = "MOVIES";}' \
    '{"enabled" = 0;"name" = "PRESENTATIONS";}' \
    '{"enabled" = 0;"name" = "SPREADSHEETS";}' \
    '{"enabled" = 0;"name" = "SOURCE";}' \
    '{"enabled" = 0;"name" = "MENU_DEFINITION";}' \
    '{"enabled" = 0;"name" = "MENU_OTHER";}' \
    '{"enabled" = 0;"name" = "MENU_CONVERSION";}' \
    '{"enabled" = 0;"name" = "MENU_EXPRESSION";}' \
    '{"enabled" = 0;"name" = "MENU_WEBSEARCH";}' \
    '{"enabled" = 0;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}'
sleep 0.4

echo "relaunch spotlight"
killall mds > /dev/null 2>&1
sudo mdutil -i on / > /dev/null
sudo mdutil -E / > /dev/null
sleep 0.4
echo "Warning: spotlight will hog a lot of cpu for a while depending on how large your disk is.  Don't worry, it will go back to normal"
sleep 0.4

echo "time machine wont ask to use each disk plugged in"
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true
sleep 0.4

echo "optimize time machine"
hash tmutil &> /dev/null && sudo tmutil disablelocal
sleep 0.4

echo "Activicty monitor: optimizing"
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true
defaults write com.apple.ActivityMonitor ShowCategory -int 0
defaults write com.apple.ActivityMonitor SortColumn -string "cpUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0
sleep 0.4

echo "enabling system wide dev options"
defaults write com.apple.addressbook ABShowDebugMenu -bool true
defaults write com.apple.dashboard devmode -bool true
defaults write com.apple.iCal IncludeDebugMenu -bool true
defaults write com.apple.TextEdit RichText -int 0
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4
defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
defaults write com.apple.DiskUtility advanced-image-options -bool true
defaults write com.apple.appstore WebKitDeveloperExtras -bool true
defaults write com.apple.appstore ShowDebugMenu -bool true
sleep 0.4

echo "messages text replacement (smart quotes, emoji)"
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticEmojiSubstitutionEnablediMessage" -bool false
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false
sleep 0.4

echo "Chrome optimization"
defaults write com.google.Chrome ExtensionInstallSources -array "https://gist.githubusercontent.com/" "http://userscripts.org/*"
defaults write com.google.Chrome.canary ExtensionInstallSources -array "https://gist.githubusercontent.com/" "http://userscripts.org/*"
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome.canary AppleEnableSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome AppleEnableMouseSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome.canary AppleEnableMouseSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome DisablePrintPreview -bool true
defaults write com.google.Chrome.canary DisablePrintPreview -bool true
defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true
defaults write com.google.Chrome.canary PMPrintingExpandedStateForPrint2 -bool true
sleep 0.4

echo "Transmission.app"
sleep 0.4

echo "save uncomplete downloads in ~/Documents"
defaults write org.m0k.transmission UseIncompleteDownloadFolder -bool true
defaults write org.m0k.transmission IncompleteDownloadFolder -string "${HOME}/Documents/Torrents"
sleep 0.4

echo "dont prompt to download"
defaults write org.m0k.transmission DownloadAsk -bool false
defaults write org.m0k.transmission DeleteOriginalTorrent -bool true
sleep 0.4

echo "Hide annoying messages"
defaults write org.m0k.transmission WarningDonate -bool false
defaults write org.m0k.transmission WarningLegal -bool false
sleep 0.4

echo "Twitter.app"
sleep 0.4

echo "No smart quotes"
defaults write com.twitter.twitter-mac AutomaticQuoteSubstitutionEnabled -bool false
sleep 0.4

echo "Show app menu when clicking on menu bar icon"
defaults write com.twitter.twitter-mac MenuItemBehavior -int 1
sleep 0.4

echo "unhiding dev menu"
defaults write com.twitter.twitter-mac ShowDevelopMenu -bool true
sleep 0.4

echo "Links open in bg"
defaults write com.twitter.twitter-mac openLinksInBackground -bool true
sleep 0.4

echo "esc closes new tweet dialog"
defaults write com.twitter.twitter-mac ESCClosesComposeWindow -bool true
sleep 0.4

echo "Show full names"
defaults write com.twitter.twitter-mac ShowFullNames -bool true
sleep 0.4

echo "Hide in background"
defaults write com.twitter.twitter-mac HideInBackground -bool true
sleep 0.4

echo "---"
echo "1Password"
echo "---"
sleep 0.4

echo "Updates: check for betas"
defaults write 2BUA8C4S2C.com.agilebits.onepassword4-helper CheckForSoftwareUpdatesEnabled -int 1
defaults write 2BUA8C4S2C.com.agilebits.onepassword4-helper CheckForSoftwareUpdatesIncludeBetas -int 1
sleep 0.4

echo '---'
echo 'Global'
echo '---'
sleep 0.4

echo 'Autocorrect custom'
echo 'PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4NCjwhRE9DVFlQRSBwbGlzdCBQVUJMSUMgIi0vL0FwcGxlLy9EVEQgUExJU1QgMS4wLy9FTiIgImh0dHA6Ly93d3cuYXBwbGUuY29tL0RURHMvUHJvcGVydHlMaXN0LTEuMC5kdGQiPg0KPHBsaXN0IHZlcnNpb249IjEuMCI+DQo8ZGljdD4NCgk8a2V5Pk5TVXNlckRpY3Rpb25hcnlSZXBsYWNlbWVudEl0ZW1zPC9rZXk+DQoJPGFycmF5Pg0KCQk8ZGljdD4NCgkJCTxrZXk+b248L2tleT4NCgkJCTxpbnRlZ2VyPjE8L2ludGVnZXI+DQoJCQk8a2V5PnJlcGxhY2U8L2tleT4NCgkJCTxzdHJpbmc+Z292J3Q8L3N0cmluZz4NCgkJCTxrZXk+d2l0aDwva2V5Pg0KCQkJPHN0cmluZz5nb3Zlcm1lbnQ8L3N0cmluZz4NCgkJPC9kaWN0Pg0KCQk8ZGljdD4NCgkJCTxrZXk+b248L2tleT4NCgkJCTxpbnRlZ2VyPjE8L2ludGVnZXI+DQoJCQk8a2V5PnJlcGxhY2U8L2tleT4NCgkJCTxzdHJpbmc+b213PC9zdHJpbmc+DQoJCQk8a2V5PndpdGg8L2tleT4NCgkJCTxzdHJpbmc+b24gbXkgd2F5PC9zdHJpbmc+DQoJCTwvZGljdD4NCgkJPGRpY3Q+DQoJCQk8a2V5Pm9uPC9rZXk+DQoJCQk8aW50ZWdlcj4xPC9pbnRlZ2VyPg0KCQkJPGtleT5yZXBsYWNlPC9rZXk+DQoJCQk8c3RyaW5nPnBrbW48L3N0cmluZz4NCgkJCTxrZXk+d2l0aDwva2V5Pg0KCQkJPHN0cmluZz5Qb2vDqG1vbjwvc3RyaW5nPg0KCQk8L2RpY3Q+DQoJCTxkaWN0Pg0KCQkJPGtleT5vbjwva2V5Pg0KCQkJPGludGVnZXI+MTwvaW50ZWdlcj4NCgkJCTxrZXk+cmVwbGFjZTwva2V5Pg0KCQkJPHN0cmluZz5zdGc8L3N0cmluZz4NCgkJCTxrZXk+d2l0aDwva2V5Pg0KCQkJPHN0cmluZz5zbWlsZXl0ZWNoZ3V5PC9zdHJpbmc+DQoJCTwvZGljdD4NCgkJPGRpY3Q+DQoJCQk8a2V5Pm9uPC9rZXk+DQoJCQk8aW50ZWdlcj4xPC9pbnRlZ2VyPg0KCQkJPGtleT5yZXBsYWNlPC9rZXk+DQoJCQk8c3RyaW5nPnNsPC9zdHJpbmc+DQoJCQk8a2V5PndpdGg8L2tleT4NCgkJCTxzdHJpbmc+bHM8L3N0cmluZz4NCgkJPC9kaWN0Pg0KCQk8ZGljdD4NCgkJCTxrZXk+b248L2tleT4NCgkJCTxpbnRlZ2VyPjE8L2ludGVnZXI+DQoJCQk8a2V5PnJlcGxhY2U8L2tleT4NCgkJCTxzdHJpbmc+c2hydWdnaWU8L3N0cmluZz4NCgkJCTxrZXk+d2l0aDwva2V5Pg0KCQkJPHN0cmluZz7Cr1xfKOODhClfL8KvPC9zdHJpbmc+DQoJCTwvZGljdD4NCgkJPGRpY3Q+DQoJCQk8a2V5Pm9uPC9rZXk+DQoJCQk8aW50ZWdlcj4xPC9pbnRlZ2VyPg0KCQkJPGtleT5yZXBsYWNlPC9rZXk+DQoJCQk8c3RyaW5nPmxlbm55PC9zdHJpbmc+DQoJCQk8a2V5PndpdGg8L2tleT4NCgkJCTxzdHJpbmc+KCDNocKwIM2cypYgzaHCsCk8L3N0cmluZz4NCgkJPC9kaWN0Pg0KCQk8ZGljdD4NCgkJCTxrZXk+b248L2tleT4NCgkJCTxpbnRlZ2VyPjE8L2ludGVnZXI+DQoJCQk8a2V5PnJlcGxhY2U8L2tleT4NCgkJCTxzdHJpbmc+d2VpcmRzbWlsZTwvc3RyaW5nPg0KCQkJPGtleT53aXRoPC9rZXk+DQoJCQk8c3RyaW5nPuODhDwvc3RyaW5nPg0KCQk8L2RpY3Q+DQoJCTxkaWN0Pg0KCQkJPGtleT5vbjwva2V5Pg0KCQkJPGludGVnZXI+MTwvaW50ZWdlcj4NCgkJCTxrZXk+cmVwbGFjZTwva2V5Pg0KCQkJPHN0cmluZz5yZWRkPC9zdHJpbmc+DQoJCQk8a2V5PndpdGg8L2tleT4NCgkJCTxzdHJpbmc+cmVkZGl0PC9zdHJpbmc+DQoJCTwvZGljdD4NCgkJPGRpY3Q+DQoJCQk8a2V5Pm9uPC9rZXk+DQoJCQk8aW50ZWdlcj4xPC9pbnRlZ2VyPg0KCQkJPGtleT5yZXBsYWNlPC9rZXk+DQoJCQk8c3RyaW5nPmVubDwvc3RyaW5nPg0KCQkJPGtleT53aXRoPC9rZXk+DQoJCQk8c3RyaW5nPmVubGlnaHRlbm1lbnQ8L3N0cmluZz4NCgkJPC9kaWN0Pg0KCQk8ZGljdD4NCgkJCTxrZXk+b248L2tleT4NCgkJCTxpbnRlZ2VyPjE8L2ludGVnZXI+DQoJCQk8a2V5PnJlcGxhY2U8L2tleT4NCgkJCTxzdHJpbmc+cmVzPC9zdHJpbmc+DQoJCQk8a2V5PndpdGg8L2tleT4NCgkJCTxzdHJpbmc+cmVzaXN0YW5jZTwvc3RyaW5nPg0KCQk8L2RpY3Q+DQoJPC9hcnJheT4NCjwvZGljdD4NCjwvcGxpc3Q+DQo=' | base64 --decode | defaults import NSGlobalDomain -
echo "gov't: government"
echo "omw: on my way"
echo "pkmn: Pokèmon"
echo "stg: smileytechguy"
echo "sl: ls"
echo "shruggie: ¯\_(ツ)_/¯"
echo "lenny:  (͡° ͜ʖ ͡°)"
echo "weirdsmile: ツ"
echo "redd: reddit"
echo "enl: enlightenment"
echo "res: resistance"
sleep 0.4

echo "Installing fonts"
sleep 0.4

echo "Ubuntu Font Family"
curl -# http://font.ubuntu.com/download/ubuntu-font-family-0.80.zip > ~/temp/ubuntufonts.zip
unzip -q ~/temp/ubuntufonts.zip -d ~/temp/ubuntufonts
sudo cp /Users/$(whoami)/temp/ubuntufonts/ubuntu-font-family-0.80/*.ttf /Library/Fonts
echo "Ubuntu font family installed!"
sleep 0.4

echo "Making launchpad better"
defaults write com.apple.dock springboard-rows -int 8
defaults write com.apple.dock springboard-columns -int 8
defaults write com.apple.dock ResetLaunchPad -bool TRUE;killall Dock
sleep 0.4

echo "Installing applications"
sleep 0.4

file=/Applications/Sublime\ Text.app/Contents/MacOS/Sublime\ Text

if [ ! -e "$file" ]
then 
    echo "Installing sublime text 3"
    curl -# http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%20Build%203083.dmg > ~/temp/sub3.dmg
    hdiutil attach ~/temp/sub3.dmg > /dev/null
    sudo cp /Volumes/Sublime\ Text/Sublime\ Text.app /Applications
    python -c 'import subprocess;subprocess.call(["hdiutil", "detach", "/dev/disk2s1"]);subprocess.call(["hdiutil", "detach", "/dev/disk2s2"]);subprocess.call(["hdiutil", "detach", "/dev/disk3s1"]);subprocess.call(["hdiutil", "detach", "/dev/disk3s1"]);subprocess.call(["hdiutil", "detach", "/dev/disk4s1"]);subprocess.call(["hdiutil", "detach", "/dev/disk5s1"]);subprocess.call(["hdiutil", "detach", "/dev/disk6s1"]);subprocess.call(["hdiutil", "detach", "/dev/disk7s1"]);subprocess.call(["hdiutil", "detach", "/dev/disk8s1"]);subprocess.call(["hdiutil", "detach", "/dev/disk9s1"]);'
fi
sleep 0.4

echo "Network Utility.app"
sudo cp -r /System/Library/CoreServices/Applications/Network\ Utility.app /Applications
sleep 0.4

echo "Feedback Assistant.app"
sudo cp -r /System/Library/CoreServices/Applications/Feedback\ Assistant.app /Applications
sleep 0.4

echo "Directory Utility.app"
sudo cp -r /System/Library/CoreServices/Applications/Directory\ Utility.app /Applications 
sleep 0.4

file=/Applications/TeamViewer.app/Contents/MacOS/TeamViewer

if [ ! -e "$file" ]
then
    echo "Installing TeamViewer 10"
    curl -# http://downloadus2.teamviewer.com/download/TeamViewer.dmg > ~/temp/teamv.dmg
    hdiutil attach ~/temp/teamv.dmg > /dev/null
    sudo installer -pkg /Volumes/TeamViewer/Install\ TeamViewer.pkg -target /
    echo "TeamViewer installed"
    echo "Do NOT interfere with any windows that may have opened"
    osascript -e 'quit app "TeamViewer"' > /dev/null
    sudo osascript -e 'quit app "TeamViewer"' > /dev/null
    python -c 'import subprocess;subprocess.call(["hdiutil", "detach", "/dev/disk2s1"]);subprocess.call(["hdiutil", "detach", "/dev/disk2s2"]);subprocess.call(["hdiutil", "detach", "/dev/disk3s1"]);subprocess.call(["hdiutil", "detach", "/dev/disk3s1"]);subprocess.call(["hdiutil", "detach", "/dev/disk4s1"]);subprocess.call(["hdiutil", "detach", "/dev/disk5s1"]);subprocess.call(["hdiutil", "detach", "/dev/disk6s1"]);subprocess.call(["hdiutil", "detach", "/dev/disk7s1"]);subprocess.call(["hdiutil", "detach", "/dev/disk8s1"]);subprocess.call(["hdiutil", "detach", "/dev/disk9s1"]);'
fi
sleep 0.4

file=/Applications/Keka.app/Contents/MacOS/Keka

if [ ! -e "$file" ]
then
    echo "Installing Keka 1.0.4"
    curl -# http://www.kekaosx.com/release/Keka-1.0.4-intel.dmg > ~/temp/keka.dmg
    hdiutil attach ~/temp/keka.dmg > /dev/null
    sudo cp /Volumes/Keka/Keka.app /Applications
    python -c 'import subprocess;subprocess.call(["hdiutil", "detach", "/dev/disk2s1"]);subprocess.call(["hdiutil", "detach", "/dev/disk2s2"]);subprocess.call(["hdiutil", "detach", "/dev/disk3s1"]);subprocess.call(["hdiutil", "detach", "/dev/disk3s1"]);subprocess.call(["hdiutil", "detach", "/dev/disk4s1"]);subprocess.call(["hdiutil", "detach", "/dev/disk5s1"]);subprocess.call(["hdiutil", "detach", "/dev/disk6s1"]);subprocess.call(["hdiutil", "detach", "/dev/disk7s1"]);subprocess.call(["hdiutil", "detach", "/dev/disk8s1"]);subprocess.call(["hdiutil", "detach", "/dev/disk9s1"]);'
fi
sleep 0.4

file=/Applications/Transmission.app/Contents/MacOS/Transmission

if [ ! -e "$file" ]
then
    echo "Installing Transmission 2.84"
    curl -# http://download.transmissionbt.com/files/Transmission-2.84.dmg > ~/temp/transm.dmg
    hdiutil attach ~/temp/transm.dmg > /dev/null
    sudo cp /Volumes/Transmission/Transmission.app /Applications
    python -c 'import subprocess;subprocess.call(["hdiutil", "detach", "/dev/disk2s1"]);subprocess.call(["hdiutil", "detach", "/dev/disk2s2"]);subprocess.call(["hdiutil", "detach", "/dev/disk3s1"]);subprocess.call(["hdiutil", "detach", "/dev/disk3s1"]);subprocess.call(["hdiutil", "detach", "/dev/disk4s1"]);subprocess.call(["hdiutil", "detach", "/dev/disk5s1"]);subprocess.call(["hdiutil", "detach", "/dev/disk6s1"]);subprocess.call(["hdiutil", "detach", "/dev/disk7s1"]);subprocess.call(["hdiutil", "detach", "/dev/disk8s1"]);subprocess.call(["hdiutil", "detach", "/dev/disk9s1"]);'
fi
sleep 0.4

file=/Applications/GIMP.app/Contents/MacOS/GIMP

if [ ! -e "$file" ]
then
    echo "Installing Gimp 2.8.14 outside of X11"
    curl -# http://download.gimp.org/pub/gimp/v2.8/osx/gimp-2.8.14.dmg > ~/temp/gimp.dmg
    hdiutil attach ~/temp/gimp.dmg > /dev/null
    sudo cp -r /Volumes/Gimp\ 2.8.14/GIMP.app/ /Applications/GIMP.app
    python -c 'import subprocess;subprocess.call(["hdiutil", "detach", "/dev/disk2s1"]);subprocess.call(["hdiutil", "detach", "/dev/disk2s2"]);subprocess.call(["hdiutil", "detach", "/dev/disk3s1"]);subprocess.call(["hdiutil", "detach", "/dev/disk3s1"]);subprocess.call(["hdiutil", "detach", "/dev/disk4s1"]);subprocess.call(["hdiutil", "detach", "/dev/disk5s1"]);subprocess.call(["hdiutil", "detach", "/dev/disk6s1"]);subprocess.call(["hdiutil", "detach", "/dev/disk7s1"]);subprocess.call(["hdiutil", "detach", "/dev/disk8s1"]);subprocess.call(["hdiutil", "detach", "/dev/disk9s1"]);'
fi
sleep 0.4

echo "Installing pip"
curl -# https://bootstrap.pypa.io/get-pip.py | sudo -H python
sleep 0.4

file=/opt/local/bin/port
sleep 0.4

if [ ! -e "$file" ]
then
    echo "Installing MacPorts"
    curl -# https://distfiles.macports.org/MacPorts/MacPorts-2.3.3-10.10-Yosemite.pkg > ~/temp/macports.pkg
    sudo installer -pkg /Users/$(whoami)/temp/macports.pkg -target /
    echo "MacPorts installed"
fi
sleep 0.4

echo "Installing (more) packages"
sleep 0.4

echo "Installing tweepy"
sudo -H pip install tweepy
sleep 0.4

echo "Installing requests"
sudo -H pip install requests
sleep 0.4

echo "Installing virtualenv"
sudo -H pip install virtualenv
sleep 0.4

echo "Installing requests"
sudo -H pip install requests
sleep 0.4

echo "Installing beautifulsoup"
sudo -H pip install beautifulsoup
sleep 0.4

echo "Installing sqlalchemy"
sudo -H pip install sqlalchemy
sleep 0.4

echo "Installing pillow"
sudo -H pip install pillow
sleep 0.4

echo "Installing lxml"
sudo -H pip install lxml
sleep 0.4

echo "Installing jinga"
sudo -H pip install jinga
sleep 0.4

echo "Installing pyments"
sudo -H pip install pyments
sleep 0.4

echo "Installing flask"
sudo -H pip install flask
sleep 0.4

echo "Installing bottle"
sudo -H pip install bottle
sleep 0.4

echo "Installing django"
sudo -H pip install django
sleep 0.4

echo "Installing fabric"
sudo -H pip install fabric
sleep 0.4

echo "Installing binplist"
sudo -H pip install binplist

echo "Downloading c++ code"
curl -# http://smileytechguy.com/downloads/setgetscreenres.m > ~/temp/setgetscreenres.m

echo "compiling"
c++ ~/temp/setgetscreenres.m -framework ApplicationServices -o ~/temp/setgetscreenres > /dev/null
echo "Done!"

echo "Your screen will flicker and bounce for a sec"
~/temp/setgetscreenres 15120 12880
sleep 1.6

echo "Do you want this screen resolution or a slightly smaller one (still bigger than the original one)"
select yn in "Bigger" "Biggest"; do
    case $yn in
        Bigger ) killall Dock; echo 'done.'; break;;
        Biggest ) echo 'Whenever you reboot you will need to open Terminal in order to change the resolution back';  echo "Press enter to confirm that you know this information"; echo -e '\n~/setgetscreenres 15120 12880' > ~/.bash_profile; cp ~/temp/setgetscreenres ~; read -p "$*"; break;;
    esac
done
sleep 0.4

echo "Creating a root user account (so you can login to it from the login menu etc)"
echo "User password is YOUR password, root password is password for new root user"
echo "If you dont want it, mistype the password each time."
dsenableroot
sleep 0.4

rm -r ~/temp
sleep 0.4

for app in "Activity Monitor" "Address Book" "Calendar" "Contacts" "cfprefsd" \
    "Dock" "Finder" "Google Chrome" "Google Chrome Canary" "Mail" "Messages" \
    "Opera" "Safari" "SizeUp" "Spectacle" "SystemUIServer" "Terminal" \
    "Transmission" "Twitter" "iCal" "Sublime Text" "Xcode" "Xcode-beta" "Reminders" \
    "Photos" "iPhoto" "App Store" "iTunes" "Maps" "Notes" "Pages" "Keynote" \
    "Keynote" "Numbers" "Chess"; do
    killall "${app}";sleep 0.4; > /dev/null 2>&1
done

echo "Done!"
echo "You will need to reboot...so yeah do that NOW"





















































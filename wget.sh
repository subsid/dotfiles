echo Treat this as a do nothing script. Download this stuff.
echo "iterm" wget -nc "https://iterm2.com/downloads/stable/iTerm2-3_0_15.zip" -P ~/Downloads/software/
echo "sizeup" wget -nc "https://www.irradiatedsoftware.com/download/SizeUp.zip" -P ~/Downloads/software/
echo "chrome" wget -nc "https://dl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg" -P ~/Downloads/software/
echo "dropbox" wget -nc -O "dropbox.dmg" "https://www.dropbox.com/download?plat=mac"; mv "dropbox.dmg" ~/Downloads/software/;
echo "google drive" wget -nc "https://dl.google.com/drive/installgoogledrive.dmg" -P ~/Downloads/software/
echo "alfred" wget -nc "https://cachefly.alfredapp.com/Alfred_3.3.2_818.dmg" -P ~/Downloads/software/
echo "dash" wget -nc "https://singapore.kapeli.com/downloads/v3/Dash.zip" -P ~/Downloads/software/
echo "vlc" wget -nc "http://get.videolan.org/vlc/2.2.5.1/macosx/vlc-2.2.5.1.dmg" -P ~/Downloads/software/
echo "docker" wget -nc "https://download.docker.com/mac/stable/Docker.dmg" -P ~/Downloads/software
echo "skype" wget -nc "https://get.skype.com/go/getskype-macosx" -P ~/Downloads/software
echo "android file transfer" wget -nc "https://dl.google.com/dl/androidjumper/mtp/current/androidfiletransfer.dmg" -P ~/Downloads/software
echo "firefox" wget -nc "https://download-installer.cdn.mozilla.net/pub/firefox/releases/54.0/mac/en-US/Firefox%2054.0.dmg" -P ~/Downloads/software
echo "Rescuetime" wget -nc "https://www.rescuetime.com/installers/RescueTimeInstaller.dmg" -P ~/Downloads/software
echo "Rstudio" wget -nc "https://download1.rstudio.org/RStudio-1.1.414.dmg" -P ~/Downloads/software
echo "Intellij"

if hash nvm 2>/dev/null;
then
  echo "nvm" wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash
else
  echo "nvm already exists, not retrieving"
fi


wget -nc "https://iterm2.com/downloads/stable/iTerm2-3_0_15.zip" -P ~/Downloads/software/
wget -nc "https://www.irradiatedsoftware.com/download/SizeUp.zip" -P ~/Downloads/software/
wget -nc "https://dl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg" -P ~/Downloads/software/
wget -nc -O dropbox.dmg "https://www.dropbox.com/download?plat=mac" -P ~/Downloads/software/
wget -nc "https://dl.google.com/drive/installgoogledrive.dmg" -P ~/Downloads/software/
wget -nc "https://cachefly.alfredapp.com/Alfred_3.3.2_818.dmg" -P ~/Downloads/software/
wget -nc "https://singapore.kapeli.com/downloads/v3/Dash.zip" -P ~/Downloads/software/

if hash nvm 2>/dev/null;
then
  wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash
else
  echo "nvm already exists, not retrieving"
fi


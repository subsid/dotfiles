for file in ~/.{gitconfig,git-completion.bash,vimrc,vimrc.bundles,aliases,bash_profile,bash_prompt,path,exports}; do
  cp $file .
done

folders=("$HOME/bin")
for folder in "${folders[@]}"; do
  cp -r $folder .
done

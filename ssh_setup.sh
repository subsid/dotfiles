echo cp /path/to/my/key/id_rsa ~/.ssh/id_rsa
echo cp /path/to/my/key/id_rsa.pub ~/.ssh/id_rsa.pub
echo "# change permissions on file"
echo sudo chmod 600 ~/.ssh/id_rsa
echo sudo chmod 600 ~/.ssh/id_rsa.pub
echo "# start the ssh-agent in the background"
echo "eval \$(ssh-agent -s)"
echo "# make ssh agent to actually use copied key"
echo ossh-add ~/.ssh/id_rsa

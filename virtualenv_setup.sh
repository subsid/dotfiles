# Install virtualenv, nice guide: http://python-guide-pt-br.readthedocs.io/en/latest/dev/virtualenvs/
echo pip install virtualenv
echo pip install virtualenvwrapper
echo source /usr/local/bin/virtualenvwrapper.sh
echo mkvirtualenv global --python="/usr/local/bin/python3"
echo touch ~/.env
echo "source ~/.virtualenvs/global/bin/activate" > ~/.env


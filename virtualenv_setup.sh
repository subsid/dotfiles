# Install virtualenv, nice guide: http://python-guide-pt-br.readthedocs.io/en/latest/dev/virtualenvs/
pip install virtualenv
pip install virtualenvwrapper
source /usr/local/bin/virtualenvwrapper.sh
mkvirtualenv global --python="/usr/local/bin/python3"
touch ~/.env
echo "source ~/.virtualenvs/global/bin/activate" > ~/.env


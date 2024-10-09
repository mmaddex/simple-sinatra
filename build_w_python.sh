#!/bin/bash
# https://www.npmjs.com/package/phantomjs-prebuilt
# https://www.npmjs.com/package/casperjs
#npm install phantomjs-prebuilt casperjs

#./casperjs_env.sh
#source ~/.bashrc
#casperjs --version
#phantomjs --version
curl https://pyenv.run | bash
## Load pyenv automatically by appending
## the following to 
## ~/.bash_profile if it exists, otherwise ~/.profile (for login shells)
## and ~/.bashrc (for interactive shells) :

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Restart your shell for the changes to take effect.
exec bash

pyenv install 3.8.3

pyenv versions

pyenv global 3.8.3

pyenv prefix

python -V

# Load pyenv-virtualenv automatically by adding
# the following to ~/.bashrc:

#eval "$(pyenv virtualenv-init -)"

## matts stab at it
#touch ~/.bashrc
#echo 'eval "$(pyenv virtualenv-init -)"' > ~/.bashrc


echo "RENDER IS BUILDING FROM..."
echo $RENDER_INSTANCE_ID

echo $RENDER_PROJECT_CACHE_DIRS

echo lsing
ls
echo cronning
ls cron


echo "listing $XDG_CACHE_HOME"
ls $XDG_CACHE_HOME
echo "mkdir"
mkdir "$XDG_CACHE_HOME"
touch $XDG_CACHE_HOME/frombuild.txt


bundle install
touch ~/.irbrc_build && echo "IRB.conf[:USE_AUTOCOMPLETE] = false" >> ~/.irbrc_build

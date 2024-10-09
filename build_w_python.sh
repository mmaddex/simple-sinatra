#!/bin/bash
# https://www.npmjs.com/package/phantomjs-prebuilt
# https://www.npmjs.com/package/casperjs
#npm install phantomjs-prebuilt casperjs

#./casperjs_env.sh
#source ~/.bashrc
#casperjs --version
#phantomjs --version

# Variables
PYTHON_VERSION="3.8.17"  # You can adjust the specific Python 3.8.x version here

# Step 1: Install pyenv (if it's not installed)
if ! command -v pyenv &> /dev/null; then
    echo "pyenv not found, installing..."
    curl https://pyenv.run | bash
fi

# Step 2: Update .bashrc or .zshrc (whichever is used)
if ! grep -q 'export PYENV_ROOT' ~/.bashrc; then
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
    echo 'eval "$(pyenv init --path)"' >> ~/.bashrc
    echo 'eval "$(pyenv init -)"' >> ~/.bashrc
    source ~/.bashrc
fi

# Step 3: Install Python 3.8 using pyenv
pyenv install "$PYTHON_VERSION"

# Step 4: Set Python 3.8 as the default version
pyenv global "$PYTHON_VERSION"

# Step 5: Verify installation
python --version
pyenv versions

echo "Python $PYTHON_VERSION installed successfully via pyenv."


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

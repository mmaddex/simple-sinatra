#!/bin/bash
# https://www.npmjs.com/package/phantomjs-prebuilt
# https://www.npmjs.com/package/casperjs
#npm install phantomjs-prebuilt casperjs

#./casperjs_env.sh
#source ~/.bashrc
#casperjs --version
#phantomjs --version

# Variables
#PYTHON_VERSION="3.8.17"  # Adjust the specific Python 3.8.x version here
PYENV_ROOT="$HOME/project/python"  # Custom installation directory

# Step 1: Install pyenv (if it's not installed)
if [ ! -d "$PYENV_ROOT" ]; then
    echo "pyenv not found at $PYENV_ROOT, installing..."
    curl https://pyenv.run | bash
fi

# Step 2: Update .bashrc or .zshrc (whichever is used)
if ! grep -q 'export PYENV_ROOT' ~/.bashrc; then
    echo 'export PYENV_ROOT="$HOME/project/python"' >> ~/.bashrc
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
    echo 'eval "$(pyenv init --path)"' >> ~/.bashrc
    echo 'eval "$(pyenv init -)"' >> ~/.bashrc
    source ~/.bashrc
fi

# Step 3: Install Python 3.8 using pyenv at the custom directory
"$PYENV_ROOT/bin/pyenv" install "$MYTHON_VERSION"

# Step 4: Set Python 3.8 as the default version for this environment
"$PYENV_ROOT/bin/pyenv" global "$MYTHON_VERSION"

# Step 5: Verify installation
"$PYENV_ROOT/bin/python" --version
"$PYENV_ROOT/bin/pyenv" versions

echo "Python $MYTHON_VERSION installed successfully at $PYENV_ROOT."


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

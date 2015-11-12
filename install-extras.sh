#!/usr/bin/env sh

set -e

pminstall () {
    if [ "$(uname)" = "Darwin" ]; then
        if which brew > /dev/null; then
            if brew install "$@"; then
                echo "$* Packages installed.";
                return 0;
            else
                return 1;
            fi
        else
            echo 'Error: brew required to install packages in OS X';
            return 1;
        fi

    elif [ "$(echo uname -s | cut -c 1-5)" = "Linux" ]; then
        if which apt-get > /dev/null; then
            if sudo apt-get install "$@"; then
                echo "$* Packages installed.";
                return 0;
            else
                return 1;
            fi
        else
            echo 'Error: apt-get required to install packages in Linux';
            return 1;
        fi
    fi
    # No support for windows yet.
    # elif [ "$(echo uname -s | cut -c 1-10)" == "MINGW32_NT" ]; then
}

packages=(git zsh shellcheck)

if pminstall "${packages[@]}"; then
    echo 'Packages installed.';
else
    echo 'Error installing packages';
    exit 1;
fi

# Install nvm
if [ ! -d ~/.nvm ]; then
    git clone https://github.com/creationix/nvm.git ~/.nvm;
    cd ~/.nvm;
    git checkout "$(git describe --abbrev=0 --tags)";
    ~/.nvm/install.sh
fi

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

which npm > /dev/null || (echo 'Error: npm not found.' && exit 1)

# Update to latest npm
npm update -g npm

# json: Handy json parsing tool
# replace: replace/search CLI tool
# grunt
# supervisor
# vim-cli-wrapper: Tool that adds `edit`command to open files on mvim.
# serve: host static files
tools=(json replace grunt-cli supervisor vim-cli-wrapper mocha serve)

# eslint + babel
eslint=(eslint babel-eslint react-tools eslint-plugin-react syntastic-react)

# jshint
jshint=(jshint)

npm i -g ${tools[@]} ${eslint[@]} ${jshint[@]}

# Git commit config
printf 'Name for git commits (ie. John Foo): '
read GIT_NAME
printf 'Email for git commits (john.foo@example.com): '
read GIT_EMAIL

printf "Set git config to use %s <%s>? [y/n]: " "$GIT_NAME" "$GIT_EMAIL"
read reply
if [[ $reply =~ ^[Yy]$ ]]
then
    git config --global user.name "$GIT_NAME"
    git config --global user.email "$GIT_EMAIL"
fi

# TODO Add: https://github.com/mathiasbynens/dotfiles/blob/master/.osx
# TODO Add: global .gitignore: git config --global core.excludesfile '~/.gitignore'

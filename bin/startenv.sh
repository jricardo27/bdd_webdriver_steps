#!/bin/bash -e
# Start the virtualenv for the current project
#
# If no virtualenv has been installed this script will:
#  - Install `pyenv` if not installed already.
#  - Download the required version of Python.
#  - Initialize a new virtualenv.
#
# This script only works with Python 3.

PYTHON_VERSION=3.6.1
PYENV_ROOT="$HOME/.pyenv"
VIRTUALENV_DIR="./.python_env$PYTHON_VERSION"


function export_pyenv_variables() {
    export PYENV_ROOT=$PYENV_ROOT
    export PATH="$PYENV_ROOT/bin:$PATH"
}

function is_sudo_enabled() {
    if sudo -S -p '' echo -n < /dev/null 2> /dev/null; then
        # Sudo is enabled.
        return 0
    fi

    # Sudo is not enabled.
    return 1
}

# Install a package if it's not present
# Usage: install_package binary [package]
# Checks if "which binary" is successful, if not, installs the package
# If package isn't given, defaults to the same name as binary
function install_package {
    BINARY=$1
    PACKAGE=${2:-$BINARY}
    if [ -z "$(which $BINARY 2>/dev/null)" ]
    then
        case "$PACKAGE" in
            pyenv)
                echo "Installing pyenv"
                curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash
                pyenv init -
                pyenv update
                ;;
            brew)
                ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
                export PATH=$PATH:/usr/local/bin
                ;;
            *)
                if [ "$(uname -s)" = "Darwin" ]
                then
                    brew install $PACKAGE
                else
                    found=$(dpkg -l $PACKAGE | grep -qv "no packages found matching" || echo 1)

                    if [ ! $found = "" ]; then
                        echo "Installing $PACKAGE"

                        if ! is_sudo_enabled
                        then
                            echo "Please enter your password to continue with the installation."
                            echo "Ctrl+C to exit."
                        fi

                        sudo apt-get -y -qq install $PACKAGE
                    fi
                fi
                ;;
        esac
    else
        case "$PACKAGE" in
            pyenv)
                eval "$(pyenv init -)"
                ;;
        esac
    fi
}


function install_python_dependencies() {
    if [ "$(uname -s)" = "Darwin" ]; then
        install_package brew
        install_package readline
        install_package xz
    else
        sudo apt-get install -y \
            make \
            build-essential \
            libssl-dev \
            zlib1g-dev \
            libbz2-dev \
            libreadline-dev \
            libsqlite3-dev \
            wget \
            curl \
            llvm \
            libncurses5-dev \
            libncursesw5-dev \
            xz-utils \
            tk-dev \
            libffi-dev \
            liblzma-dev
    fi
}

function install_python(){
    install_package pyenv

    if ( pyenv versions --bare | grep -E \^$PYTHON_VERSION\$ ) >& /dev/null; then
        echo "Python version $PYTHON_VERSION is already installed. Skip installation."
    else
        echo "Installing python version $PYTHON_VERSION ..."

        if [ "$(uname -s)" = "Darwin" ]; then
            # If on Mac, installing python versions can have issues with pyenv
            # not knowing where the openssl and/or sqlite packages are located.

            CFLAGS="-I$(brew --prefix openssl)/include \
                -I$(brew --prefix sqlite)/include" \
                LDFLAGS="-L$(brew --prefix openssl)/lib \
                -L$(brew --prefix sqlite)/lib" \
                pyenv install $PYTHON_VERSION
        else
            env PYTHON_CONFIGURE_OPTS="--enable-shared" pyenv install $PYTHON_VERSION
        fi
    fi

    # This ensures installed python versions and binaries properly shimmed.
    pyenv rehash

    pyenv shell $PYTHON_VERSION

    echo "Current active python version" $(pyenv shell).
}

function install_virtualenv() {
    python -m venv $VIRTUALENV_DIR
}

################################################################################
# Execution starts here.
################################################################################

# Export pyenv paths so that the binary can be found.
export_pyenv_variables

if [ -z $VIRTUAL_ENV ]; then
    if [ -f "$VIRTUALENV_DIR/bin/activate" ]; then
        . $VIRTUALENV_DIR/bin/activate
    else
        install_python
        install_virtualenv

        . $VIRTUALENV_DIR/bin/activate
    fi

    # Update pip.
    pip install --upgrade pip

    if [ -e package.json ]; then
        export PATH=$PATH:`npm bin`
    fi
else
    echo "Already in a virtualenv. Not doing anything!"
fi


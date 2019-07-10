#!/bin/bash

CMD_PYENV=pyenv

PYTHON_VERSIONS="2.7.11 3.5.0"

PYTHON_VERSION_FOR_TOX="2.7.11"

PYTHON_REQUIREMENTS="tox tox-pyenv"


# Install python version using pyenv.
# Usage: install_python_version [python_version]
install_python_version() {
    VERSION=$1

    if ( $CMD_PYENV versions --bare | grep -E \^$VERSION\$ ) >& /dev/null; then
        echo "Python version $VERSION is already installed. Skip installation."
    else
        echo "Installing python version $VERSION ..."
        $CMD_PYENV install $VERSION
    fi
}

export_pyenv_variables() {
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
}

init_pyenv() {
    eval "$($CMD_PYENV init -)"
}

# Export pyenv paths so that the binary can be found.
export_pyenv_variables

# Check pyenv installation.
if [[ -z `command -v $CMD_PYENV` ]]; then
    echo "$CMD_PYENV is not installed."
    echo "Installing $CMD_PYENV..."
    curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash
    init_pyenv
    pyenv update
else
    init_pyenv
    echo "$CMD_PYENV found. Skip installation."
fi

# This is for terminal to be able output unicode.
export LANG=en_AU.UTF-8

echo "Install python versions for all tox environments."
for python_version in ${PYTHON_VERSIONS}
do
    install_python_version $python_version
done

$CMD_PYENV shell $PYTHON_VERSION_FOR_TOX

# Install Python requirements.
for package in ${PYTHON_REQUIREMENTS}
do
    if ! ( pip freeze | grep $package ) >& /dev/null; then
        echo "$package is not installed. Installing ..."
        pip install $package
    fi
done

# This ensures installed python versions and binaries properly shimmed
echo "Rehashing pyenv"
$CMD_PYENV rehash

# Set available python versions
echo "Set available Python versions to ${PYTHON_VERSION_FOR_TOX} ${PYTHON_VERSIONS}"
$CMD_PYENV local $PYTHON_VERSION_FOR_TOX $PYTHON_VERSIONS

echo "Current active python version" $($CMD_PYENV shell).

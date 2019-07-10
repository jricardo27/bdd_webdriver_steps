#!/bin/bash

# Initialise virtual environment for tox.
. bin/starttestenv.sh

# Run tox.
TOX_COMMAND="tox $@"

echo "Running tox command '$TOX_COMMAND' ..."
${TOX_COMMAND}

echo "Reporting coverage"
${TOX_COMMAND} -e run_coverage

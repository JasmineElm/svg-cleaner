#!/usr/bin/env bash

###  DEBUG          ###########################################################
set -e -o errtrace -o pipefail
trap "echo ""errexit: line $LINENO. Exit code: $?"" >&2" ERR
IFS=$'\n\t'

###  GLOBALS        ###########################################################
source config/globals
### VARIABLES       ###########################################################
_CONFIG_DIR="config"
_REQUIREMENTS_FILE="$_CONFIG_DIR/requirements.txt"
_NODE_REQUIREMENTS_FILE="$_CONFIG_DIR/node_requirements.txt"
_BOLD=$(
  tput setaf 2
  tput bold
)
_NORMAL=$(tput sgr0)
_BOLD_RED=$(
  tput setaf 1
  tput bold
)
_STARS="********************************************************************"

###  DESCRIPTION    ###########################################################
# set up and vpype with useful plugins and svgo

_binary_exists() {
  command -v "$1" >/dev/null 2>&1
}

_check_venv() {
  # if $_VEN_DIR exists, remove it
  if [ -d "$_VENV_DIR" ]; then
    # if we have a command deactivate, run it
    command -v deactivate >/dev/null 2>&1 &&
      deactivate
    rm -rf "$_VENV_DIR"
  fi
}

_create_venv() {
  if [ ! -d "$_VENV_DIR" ]; then
    python3 -m venv "$_VENV_DIR"
  fi
  source "$_VENV_DIR/bin/activate"
}

_activate_venv() {
  source "$_VENV_DIR/bin/activate"
}

_install_python_modules() {
  python3 -m pip install --upgrade pip
  python3 -m pip install -r "$_REQUIREMENTS_FILE"
}

_install_node_modules() {
  # source "$_NODE_ENV_DIR/bin/activate"
  nodeenv -p --requirements=$_NODE_REQUIREMENTS_FILE --force
}

_test_binaries() {
  # svgo and vpype  should have the $_VENV_DIR/bin in their path
  for binary in svgo vpype; do
    if [[ $(which $binary) != *$_VENV_DIR* ]]; then
      echo "❌ $binary not found in virtual environment"
    else 
      echo "✔ $binary found in virtual environment"
    fi
  done
}

_main() {
  printf "%s\n$_STARS$_BOLD\nSetting up virtual environment$_NORMAL\n"
  _binary_exists "python3" || {
    printf "%s\n$_BOLD_RED\npython3 not found\n$_NORMAL" && exit 1
  }
  printf "%s\n$_STARS$_BOLD\nremoving $_VENV_DIR if it exists\n$_NORMAL"
  _check_venv
  printf "%s\n$_STARS$_BOLD\ncreating virtual environment:$_VENV_DIR$_NORMAL\n"
  _create_venv
  _activate_venv
  printf "%s\n$_STARS$_BOLD\ninstalling python modules\n$_NORMAL\n"
  _install_python_modules
  printf "%s\n$_STARS$_BOLD\ninstalling node modules\n$_NORMAL\n"
  _install_node_modules
  printf "%s\n$_STARS$_BOLD\nsetup complete! Testing we have svgo and vpype\n$_NORMAL\n"
  _test_binaries
}
_main

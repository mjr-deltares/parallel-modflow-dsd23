#!/bin/bash

# terminate if any command fails 
set -eo pipefail

# set local variables
OS_NAME=$(uname -s)
ARCH=$(uname -m)
if [ "${OS_NAME}" = Darwin ]; then
	MINICONDA_VERSION="Miniconda3-latest-MacOSX-${ARCH}.sh"
else
	MINICONDA_VERSION="Miniconda3-latest-${OS_NAME}-${ARCH}.sh"
fi
MINICONDA_DIR=$HOME/miniconda3
MINICONDA_ENV=mf6xtd
INITIAL_DIR=$(pwd)
ROOT_DIR=../../
REPO_NAME=$(basename `git rev-parse --show-toplevel`)
LOG_FILE=$INITIAL_DIR/installation.log

# remove existing log file
rm -rf "${LOG_FILE}"
echo "${REPO_NAME} Installation log" > $LOG_FILE

if [ -z "$1" ]; then
	CONDA_OPTION=true
elif [ $1 == "--skip-conda" ]; then
	unset  MINICONDA_DIR
        MINICONDA_DIR="${CONDA_PREFIX}"
	echo "Using existing conda installation" >> $LOG_FILE
	echo "conda installation directory ${MINICONDA_DIR}" >> $LOG_FILE
	CONDA_OPTION=false
else
	CONDA_OPTION=true
fi

if [ "${CONDA_OPTION}" = true ]; then
        echo "Removing existing miniconda installation" >> $LOG_FILE
	rm -rf "${MINICONDA_VERSION}"
	rm -rf "${MINICONDA_DIR}"

	# get miniconda
	echo "Getting miniconda (${MINICONDA_VERSION})" >> $LOG_FILE
	wget "https://repo.anaconda.com/miniconda/${MINICONDA_VERSION}"
	chmod +x $MINICONDA_VERSION

	echo "Installing miniconda" >> $LOG_FILE
	./$MINICONDA_VERSION -b 
	eval "$(/home/$USER/miniconda3/bin/conda shell.bash hook)"
	conda init bash

	# clean up miniconda installation script
	rm -rf "${MINICONDA_VERSION}"
fi

source "${MINICONDA_DIR}/etc/profile.d/conda.sh"
source "${HOME}/.bashrc"

if conda info --envs | grep -q $MINICONDA_ENV; then
	echo "Updating existing ${MINICONDA_ENV} environment" >> $LOG_FILE 
	conda activate "${MINICONDA_ENV}"
	conda env update --name "${MINICONDA_ENV}" -f environment.yml --prune
else
	echo "Installing ${MINICONDA_ENV} environment" >> $LOG_FILE
	conda env create -f environment.yml
	conda activate "${MINICONDA_ENV}"
fi

# clone the MODFLOW 6 git repo
echo "Cloning MODFLOW 6 github repo" >> $LOG_FILE
cd "${ROOT_DIR}"
rm -rf modflow6/
git clone https://github.com/MODFLOW-USGS/modflow6.git

# compile modflow6
echo "Compiling and test parallel version of MODFLOW 6" >> $LOG_FILE
cd modflow6
meson setup builddir -Ddebug=false -Dparallel=true --prefix=$(pwd) --libdir=bin --wipe
meson install -C builddir
meson test --verbose --no-rebuild -C builddir

# make symbolic link for modflow6 in the mf6ext environment
ln -f ./bin/mf6 "${MINICONDA_DIR}/envs/${MINICONDA_ENV}/bin/mf6"

# run the test
echo "Testing installed miniconda environment and MODFLOW 6" >> $LOG_FILE
cd "${INITIAL_DIR}"
python test_installation.py

# write final message to the screen
if [ "$CONDA_OPTION" = true ]; then
	echo "==> For changes to take effect, close and re-open your current shell. <=="
fi

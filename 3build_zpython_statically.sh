#!/bin/bash

SCRIPT=$(readlink -f "$0")
SCRIPT_PATH=`dirname "$SCRIPT"`

ZVM_TOOLCHAIN=${ZVM_PREFIX}/bin
export PATH=${PATH}:${ZVM_TOOLCHAIN}:

export PYTHONHOME=$(pwd):$(pwd)/Lib
export HOSTPYTHON=./hostpython
export HOSTPGEN=./Parser/hostpgen
export PATH=${PATH}:${PLAT}"/bin"
export CROSS_COMPILE="x86_64-nacl-"
export CROSS_COMPILE_TARGET=yes
export HOSTARCH=amd64-linux
export BUILDARCH=x86_64-linux-gnu

#make 

#copy python files into _install directory, all installed files should be accessible
#in filesystem in order to run python on zerovm+zrt

INSTALL_PATH=${SCRIPT_PATH}/_install
PYTHONFILES_FOLDER=$(pwd)/../mounts/pythonfiles
TAR_NAME_TO_INSTALL=${PYTHONFILES_FOLDER}/python-install.tar

echo install zpython files
make install prefix=${INSTALL_PATH}

if [ -d ${INSTALL_PATH} ]
then
#prepare folder and remove old installed archive
    rm -f ${TAR_NAME_TO_INSTALL}
    mkdir ${PYTHONFILES_FOLDER} -p
    cd ${INSTALL_PATH}

#add files into tar archive and copy it to the zrt/mounts
    tar -cf ${TAR_NAME_TO_INSTALL} *
    echo created ${TAR_NAME_TO_INSTALL}
fi


#!/bin/env bash

function run_install() {
  DESTDIR=~/.local make clean install
}

set +x

BASEDIR=$(dirname $(realpath $0))

cd "${BASEDIR}/dmenu" && run_install
cd "${BASEDIR}/slock" && run_install
cd "${BASEDIR}/slstatus" && run_install
cd "${BASEDIR}/st" && run_install
cd "${BASEDIR}/dwm" && run_install

set -x

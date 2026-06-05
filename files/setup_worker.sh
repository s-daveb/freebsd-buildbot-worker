#!/bin/sh

SCRIPT_DIR="`dirname ${0}`"

eval "`cat ${SCRIPT_DIR}/creds`
BUILD_DIR=/var/db/buildbot/worker
NPROC=`sysctl -n hw.ncpu`"

cd "${BUILD_DIR}"
buildbot-worker create-worker --numcpus=${NPROC} --relocatable "${BUILD_DIR}" "${BUILD_MASTER}:${BUILD_MASTER_PORT}" "${WORKER_NAME}" "${BUILD_MASTER_PASS}"

#!/bin/sh

. ${BUILDPACK_TEST_RUNNER_HOME}/lib/test_utils.sh

testCompile()
{
  capture ${BUILDPACK_HOME}/bin/compile ${BUILD_DIR} ${CACHE_DIR}
  assertEquals 0 ${rtrn}
  assertEquals "" "`cat ${STD_ERR}`"

  assertContains "-----> Downloading ffmpeg"  "`cat ${STD_OUT}`"
  assertTrue "Should have cached ffmpeg `ls -la ${CACHE_DIR}`" "[ -f ${CACHE_DIR}/ffmpeg ]"

  assertFileMD5 "baeb004575d58a7b186737a3be6d5f07" "${CACHE_DIR}/ffmpeg"

  assertContains "-----> Installing ffmpeg"  "`cat ${STD_OUT}`"
  assertTrue "Should have installed ffmpeg in build dir: `ls -la ${BUILD_DIR}/bin`" "[ -f ${BUILD_DIR}/bin/ffmpeg ]"

  # Run again to ensure cache is used.
  rm -rf ${BUILD_DIR}/*
  resetCapture

  capture ${BUILDPACK_HOME}/bin/compile ${BUILD_DIR} ${CACHE_DIR}
  assertNotContains "-----> Downloading ffmpeg"  "`cat ${STD_OUT}`"
  assertContains "-----> Installing ffmpeg"  "`cat ${STD_OUT}`"

  assertEquals 0 ${rtrn}
  assertEquals "" "`cat ${STD_ERR}`"
}

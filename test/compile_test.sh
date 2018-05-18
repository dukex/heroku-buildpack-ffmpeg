#!/bin/sh

. ${BUILDPACK_TEST_RUNNER_HOME}/lib/test_utils.sh

testCompile()
{
  capture ${BUILDPACK_HOME}/bin/compile ${BUILD_DIR} ${CACHE_DIR}
  assertEquals 0 ${rtrn}
  assertEquals "" "`cat ${STD_ERR}`"

  assertContains "-----> Downloading ffmpeg"  "`cat ${STD_OUT}`"
  assertTrue "Should have cached ffmpeg `ls -la ${CACHE_DIR}`" "[ -f ${CACHE_DIR}/ffmpeg.tar.gz ]"

  assertFileMD5 "5b289f11e9969e670d7828e58f018141" "${CACHE_DIR}/ffmpeg.tar.gz"

  assertContains "-----> Installing ffmpeg"  "`cat ${STD_OUT}`"
  assertTrue "Should have installed ffmpeg in build dir: `ls -la ${BUILD_DIR}/vendor/ffmpeg/bin`" "[ -f ${BUILD_DIR}/vendor/ffmpeg/bin/ffmpeg ]"

  assertContains "-----> Configuring ffmpeg"  "`cat ${STD_OUT}`"
  assertTrue "Should have profile ffmpeg in build dir: `ls -la $BUILD_DIR/.profile.d/`" "[ -f $BUILD_DIR/.profile.d/ffmpeg.sh ]"
  assertTrue "Should set ffmpeg to PATH: `cat $BUILD_DIR/.profile.d/ffmpeg.sh`", 'export PATH="$PATH:'"/app/vendor/ffmpeg/bin"'"'
  assertTrue "Should set ffmpeg LD_LIBRARY_PATH: `cat $BUILD_DIR/.profile.d/ffmpeg.sh`", 'export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/app/vendor/ffmpeg"'

  # Run again to ensure cache is used.
  rm -rf ${BUILD_DIR}/*
  resetCapture

  capture ${BUILDPACK_HOME}/bin/compile ${BUILD_DIR} ${CACHE_DIR}
  assertNotContains "-----> Downloading ffmpeg"  "`cat ${STD_OUT}`"
  assertContains "-----> Installing ffmpeg"  "`cat ${STD_OUT}`"

  assertEquals 0 ${rtrn}
  assertEquals "" "`cat ${STD_ERR}`"
}

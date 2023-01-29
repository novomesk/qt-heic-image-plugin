project (libheif-dependency)

#Example:
#cmake .. -DEXTERNALS_DOWNLOAD_DIR=/dev2/d -DINSTALL_ROOT=/dev2/i

cmake_minimum_required(VERSION 3.7.2)
include(ExternalProject)

if(NOT IS_DIRECTORY ${EXTERNALS_DOWNLOAD_DIR})
    message(FATAL_ERROR "No externals download dir set. Use -DEXTERNALS_DOWNLOAD_DIR")
endif()

if(NOT IS_DIRECTORY ${INSTALL_ROOT})
    message(FATAL_ERROR "No install dir set. Use -DINSTALL_ROOT")
endif()

set(TOP_INST_DIR ${INSTALL_ROOT})
set(EXTPREFIX "${TOP_INST_DIR}")
set(CMAKE_PREFIX_PATH "${EXTPREFIX}")

SET(EXTPREFIX_heif "${EXTPREFIX}" )

ExternalProject_Add(
    ext_libde265
    DOWNLOAD_DIR ${EXTERNALS_DOWNLOAD_DIR}
    URL https://github.com/strukturag/libde265/releases/download/v1.0.10/libde265-1.0.10.tar.gz
    URL_HASH SHA256=8761333dd823a30fe19668b5290686d5438e0448d0c7d2e81ad49a75741c34a4

    CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${EXTPREFIX_heif} -DCMAKE_BUILD_TYPE=Release -DENABLE_DECODER=OFF -DENABLE_ENCODER=OFF

    UPDATE_COMMAND ""
)

ExternalProject_Add(
    ext_libheif
    DOWNLOAD_DIR ${EXTERNALS_DOWNLOAD_DIR}

    URL https://github.com/strukturag/libheif/releases/download/v1.14.2/libheif-1.14.2.tar.gz
    URL_HASH SHA256=d016905e247d6952cd7ee4f9b90957350b6a6caa466bc76fdfe6eb302b6d088c

    CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${EXTPREFIX_heif} -DCMAKE_BUILD_TYPE=Release -DWITH_AOM_DECODER=OFF -DWITH_AOM_ENCODER=OFF -DWITH_DAV1D=OFF -DWITH_LIBDE265=ON -DWITH_RAV1E=OFF -DWITH_X265=OFF -DWITH_SvtEnc=OFF -DWITH_EXAMPLES=OFF

    UPDATE_COMMAND ""
    DEPENDS ext_libde265
)

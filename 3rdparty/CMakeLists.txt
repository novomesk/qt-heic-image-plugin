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
    ext_openjpeg
    DOWNLOAD_DIR ${EXTERNALS_DOWNLOAD_DIR}

    URL https://github.com/uclouvain/openjpeg/archive/refs/tags/v2.5.0.tar.gz
    URL_HASH SHA256=0333806d6adecc6f7a91243b2b839ff4d2053823634d4f6ed7a59bc87409122a

    CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${EXTPREFIX_heif} -DCMAKE_BUILD_TYPE=Release -DBUILD_STATIC_LIBS=OFF -DBUILD_CODEC=OFF

    UPDATE_COMMAND ""
)

ExternalProject_Add(
    ext_libde265
    GIT_REPOSITORY https://github.com/strukturag/libde265.git

    CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${EXTPREFIX_heif} -DCMAKE_BUILD_TYPE=Release -DENABLE_DECODER=OFF -DENABLE_ENCODER=OFF

    UPDATE_COMMAND ""
)

ExternalProject_Add(
    ext_libheif
    DOWNLOAD_DIR ${EXTERNALS_DOWNLOAD_DIR}

    URL https://github.com/strukturag/libheif/releases/download/v1.17.6/libheif-1.17.6.tar.gz
    URL_HASH SHA256=8390baf4913eda0a183e132cec62b875fb2ef507ced5ddddc98dfd2f17780aee

    CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${EXTPREFIX_heif} -DCMAKE_BUILD_TYPE=Release -DENABLE_PLUGIN_LOADING=OFF -DWITH_AOM_DECODER=OFF -DWITH_AOM_ENCODER=OFF -DWITH_DAV1D=OFF -DWITH_LIBDE265=ON -DWITH_RAV1E=OFF -DWITH_X265=OFF -DWITH_SvtEnc=OFF -DWITH_OpenJPEG_DECODER=ON -DWITH_EXAMPLES=OFF

    UPDATE_COMMAND ""
    DEPENDS ext_openjpeg ext_libde265
)

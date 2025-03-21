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

    URL https://github.com/uclouvain/openjpeg/archive/refs/tags/v2.5.3.tar.gz
    URL_HASH SHA256=368fe0468228e767433c9ebdea82ad9d801a3ad1e4234421f352c8b06e7aa707
    DOWNLOAD_EXTRACT_TIMESTAMP FALSE

    CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${EXTPREFIX_heif} -DCMAKE_BUILD_TYPE=Release -DBUILD_STATIC_LIBS=OFF -DBUILD_CODEC=OFF

    UPDATE_COMMAND ""
)

ExternalProject_Add(
    ext_libde265
    GIT_REPOSITORY https://github.com/strukturag/libde265.git
    GIT_SHALLOW TRUE

    CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${EXTPREFIX_heif} -DCMAKE_BUILD_TYPE=Release -DENABLE_DECODER=OFF -DENABLE_ENCODER=OFF

    UPDATE_COMMAND ""
)

ExternalProject_Add(
    ext_libheif
    DOWNLOAD_DIR ${EXTERNALS_DOWNLOAD_DIR}

#    URL https://github.com/strukturag/libheif/releases/download/v1.19.7/libheif-1.19.7.tar.gz
#    URL_HASH SHA256=161c042d2102665fcee3ded851c78a0eb5f2d4bfe39fba48ba6e588fd6e964f3
#    DOWNLOAD_EXTRACT_TIMESTAMP FALSE
    GIT_REPOSITORY https://github.com/strukturag/libheif.git
    GIT_SHALLOW TRUE

    CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${EXTPREFIX_heif} -DCMAKE_BUILD_TYPE=Release -DENABLE_PLUGIN_LOADING=OFF -DWITH_AOM_DECODER=OFF -DWITH_AOM_ENCODER=OFF -DWITH_DAV1D=OFF -DWITH_LIBDE265=ON -DWITH_RAV1E=OFF -DWITH_X265=OFF -DWITH_SvtEnc=OFF -DWITH_OpenJPEG_DECODER=ON -DWITH_OpenJPEG_ENCODER=ON -DWITH_OpenH264_DECODER=ON -DWITH_EXAMPLES=OFF

    UPDATE_COMMAND ""
    DEPENDS ext_openjpeg ext_libde265
)

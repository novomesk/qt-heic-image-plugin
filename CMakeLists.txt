cmake_minimum_required(VERSION 3.6)

project(qt-heic-image-plugin)

set (CMAKE_CXX_STANDARD 14)

include(FeatureSummary)
find_package(ECM 5.89.0  NO_MODULE)
set_package_properties(ECM PROPERTIES TYPE REQUIRED DESCRIPTION "Extra CMake Modules." URL "https://commits.kde.org/extra-cmake-modules")
feature_summary(WHAT REQUIRED_PACKAGES_NOT_FOUND FATAL_ON_MISSING_REQUIRED_PACKAGES)


set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH})

include(KDEInstallDirs)
include(KDEFrameworkCompilerSettings NO_POLICY_SCOPE)
include(KDECMakeSettings)


include(CheckIncludeFiles)

set(REQUIRED_QT_VERSION 5.14.0)
find_package(Qt${QT_MAJOR_VERSION}Gui ${REQUIRED_QT_VERSION} REQUIRED NO_MODULE)

include(FindPkgConfig)

pkg_check_modules(LibHeif REQUIRED IMPORTED_TARGET libheif>=1.10.0)

add_definitions(-DQT_NO_FOREACH)
add_subdirectory(src)

feature_summary(WHAT ALL FATAL_ON_MISSING_REQUIRED_PACKAGES)

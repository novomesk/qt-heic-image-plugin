TARGET = kimg_heif

INCLUDEPATH += ../3rdparty/install/include

HEADERS = ../src/heif_p.h ../src/util_p.h
SOURCES = ../src/heif.cpp
OTHER_FILES = ../src/heif.json

LIBS += ../3rdparty/install/lib/heif.lib

TEMPLATE = lib

CONFIG += release skip_target_version_ext c++14 warn_on plugin
CONFIG -= separate_debug_info debug debug_and_release force_debug_info

win32:VERSION = 0.3.0
QMAKE_TARGET_COMPANY = "Daniel Novomesky"
QMAKE_TARGET_PRODUCT = "qt-heic-image-plugin"
QMAKE_TARGET_DESCRIPTION = "Qt plug-in to allow Qt and KDE based applications to read/write HEIF/HEIC images."
QMAKE_TARGET_COPYRIGHT = "Copyright (C) 2020-2023 Daniel Novomesky"

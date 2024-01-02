# NB: the desktop files are installed for the benefit of KImageIO in KDELibs4Support.

##################################

function(kimageformats_add_plugin plugin)
    set(options)
    set(oneValueArgs)
    set(multiValueArgs SOURCES)
    cmake_parse_arguments(KIF_ADD_PLUGIN "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})
    if(NOT KIF_ADD_PLUGIN_SOURCES)
        message(FATAL_ERROR "kimageformats_add_plugin called without SOURCES parameter")
    endif()

    add_library(${plugin} MODULE ${KIF_ADD_PLUGIN_SOURCES})
    set_target_properties(${plugin} PROPERTIES LIBRARY_OUTPUT_DIRECTORY "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/imageformats")
    target_link_libraries(${plugin} Qt${QT_MAJOR_VERSION}::Gui)
    install(TARGETS ${plugin} DESTINATION ${KDE_INSTALL_QTPLUGINDIR}/imageformats)
endfunction()

##################################

if (LibHeif_FOUND)
    kimageformats_add_plugin("kimg_heif${QT_MAJOR_VERSION}" SOURCES "heif.cpp")
    target_link_libraries("kimg_heif${QT_MAJOR_VERSION}" PkgConfig::LibHeif)

    if (QT_MAJOR_VERSION STREQUAL "5")
        install(FILES heif.desktop DESTINATION ${KDE_INSTALL_KSERVICES5DIR}/qimageioplugins/)
    endif()
endif()

##################################

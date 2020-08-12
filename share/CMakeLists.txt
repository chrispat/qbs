if(WIN32)
    install(
        FILES ../bin/ibmsvc.xml ../bin/ibqbs.bat
        DESTINATION "${CMAKE_INSTALL_PREFIX}/${QBS_APP_INSTALL_DIR}"
        )
endif()
install(
    PROGRAMS ../src/3rdparty/python/bin/dmgbuild
    DESTINATION "${CMAKE_INSTALL_PREFIX}/${QBS_LIBEXEC_PATH}"
    )
add_custom_target(copy-runtime-files-dmgbuild ALL
    COMMAND ${CMAKE_COMMAND} -E copy
        ${CMAKE_CURRENT_SOURCE_DIR}/../src/3rdparty/python/bin/dmgbuild
        ${CMAKE_BINARY_DIR}/${QBS_LIBEXEC_PATH}
    )
install(
    # trailing slash avoid copying the 'site-packages' dir and only copies its content
    DIRECTORY ../src/3rdparty/python/lib/python2.7/site-packages/
    DESTINATION "${CMAKE_INSTALL_PREFIX}/${QBS_RESOURCES_INSTALL_DIR}/share/qbs/python"
    FILES_MATCHING PATTERN "*.py"
    )
install(
    DIRECTORY qbs
    DESTINATION "${CMAKE_INSTALL_PREFIX}/${QBS_RESOURCES_INSTALL_DIR}/share")
add_custom_target(copy-runtime-files-qbs ALL
    COMMAND ${CMAKE_COMMAND} -E copy_directory
        ${CMAKE_CURRENT_SOURCE_DIR}/qbs
        ${CMAKE_BINARY_DIR}/share/qbs
    )
install(
    DIRECTORY ../examples
    DESTINATION "${CMAKE_INSTALL_PREFIX}/${QBS_RESOURCES_INSTALL_DIR}/share/qbs"
    )

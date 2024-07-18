cmake_minimum_required(VERSION 3.16)

project(histogram VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick)

qt_standard_project_setup()

qt_policy(SET QTP0001 NEW)

qt_add_executable(apphistogram
    main.cpp
)

qt_add_qml_module(apphistogram
    URI histogram
    VERSION 1.0
    QML_FILES
        qml/Main.qml
        qml/Histogram.qml
    RESOURCES qml.qrc
    SOURCES src/FileReader.h
    SOURCES src/HistogramModel.h
    SOURCES src/FileReader.cpp
    SOURCES src/HistogramModel.cpp
)

set_target_properties(apphistogram PROPERTIES
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(apphistogram
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS apphistogram
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

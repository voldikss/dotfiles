cmake_minimum_required(VERSION 3.18)
project(%HERE%%FDIR%)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_BUILD_PARALLEL_LEVEL 12)

# For Qt development
# set(CMAKE_AUTOUIC ON)
# set(CMAKE_AUTOMOC ON)
# set(CMAKE_AUTORCC ON)

set(
  HEADERS
  src/mainwindow.hpp
)

set(
  SOURCES
  src/main.cpp
  src/mainwindow.cpp
)

# For Qt development
# set(RESOURCES
#     src/qml.qrc
#     )

# set(QMLS
#     src/main.qml
#     )

# For Qt development
# find_package(
#   Qt5 COMPONENTS
#   Core
#   Gui
#   Widgets
#   Sql
#   Network
#   Xml
#   WebKit
#   WebEngine
#   REQUIRED
# )

add_executable(
  ${PROJECT_NAME}
  ${HEADERS}
  ${SOURCES}
  # ${RESOURCES}
  # ${QMLS}
)

# for QT
# target_link_libraries(
#   ${PROJECT_NAME} PRIVATE
#   Qt5::Core
#   Qt5::Gui
#   Qt5::Widgets
#   # Qt5::Sql
#   # Qt5::Network
#   # Qt5::Xml
#   # Qt5::WebKit
#   # Qt5::WebEngine
# )

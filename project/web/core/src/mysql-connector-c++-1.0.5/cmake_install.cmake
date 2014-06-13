# Install script for directory: /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5

# Set the install prefix
IF(NOT DEFINED CMAKE_INSTALL_PREFIX)
  SET(CMAKE_INSTALL_PREFIX "/media/big/projekty/mine/streetdog/project/web/core/libs")
ENDIF(NOT DEFINED CMAKE_INSTALL_PREFIX)
STRING(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
IF(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  IF(BUILD_TYPE)
    STRING(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  ELSE(BUILD_TYPE)
    SET(CMAKE_INSTALL_CONFIG_NAME "")
  ENDIF(BUILD_TYPE)
  MESSAGE(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
ENDIF(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)

# Set the component getting installed.
IF(NOT CMAKE_INSTALL_COMPONENT)
  IF(COMPONENT)
    MESSAGE(STATUS "Install component: \"${COMPONENT}\"")
    SET(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  ELSE(COMPONENT)
    SET(CMAKE_INSTALL_COMPONENT)
  ENDIF(COMPONENT)
ENDIF(NOT CMAKE_INSTALL_COMPONENT)

# Install shared libraries without execute permission?
IF(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  SET(CMAKE_INSTALL_SO_NO_EXE "1")
ENDIF(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/." TYPE FILE OPTIONAL FILES
    "/media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/README"
    "/media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/COPYING"
    "/media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/LICENSE.mysql"
    "/media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/ANNOUNCEMENT"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/." TYPE FILE OPTIONAL FILES "/media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/BUILDINFO")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  INCLUDE("/media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/cppconn/cmake_install.cmake")
  INCLUDE("/media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/driver/cmake_install.cmake")
  INCLUDE("/media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/examples/cmake_install.cmake")
  INCLUDE("/media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/cmake_install.cmake")
  INCLUDE("/media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework/cmake_install.cmake")
  INCLUDE("/media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/CJUnitTestsPort/cmake_install.cmake")
  INCLUDE("/media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/unit/cmake_install.cmake")

ENDIF(NOT CMAKE_INSTALL_LOCAL_ONLY)

IF(CMAKE_INSTALL_COMPONENT)
  SET(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
ELSE(CMAKE_INSTALL_COMPONENT)
  SET(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
ENDIF(CMAKE_INSTALL_COMPONENT)

FILE(WRITE "/media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/${CMAKE_INSTALL_MANIFEST}" "")
FOREACH(file ${CMAKE_INSTALL_MANIFEST_FILES})
  FILE(APPEND "/media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/${CMAKE_INSTALL_MANIFEST}" "${file}\n")
ENDFOREACH(file)

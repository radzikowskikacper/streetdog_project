# Install script for directory: /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/cppconn

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
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/cppconn" TYPE FILE FILES
    "/media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/cppconn/build_config.h"
    "/media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/cppconn/config.h"
    "/media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/cppconn/connection.h"
    "/media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/cppconn/datatype.h"
    "/media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/cppconn/driver.h"
    "/media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/cppconn/exception.h"
    "/media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/cppconn/metadata.h"
    "/media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/cppconn/parameter_metadata.h"
    "/media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/cppconn/prepared_statement.h"
    "/media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/cppconn/resultset.h"
    "/media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/cppconn/resultset_metadata.h"
    "/media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/cppconn/statement.h"
    "/media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/cppconn/warning.h"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")


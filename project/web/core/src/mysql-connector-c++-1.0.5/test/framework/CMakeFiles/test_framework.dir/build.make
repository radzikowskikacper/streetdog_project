# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 2.8

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list

# Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5

# Include any dependencies generated for this target.
include test/framework/CMakeFiles/test_framework.dir/depend.make

# Include the progress variables for this target.
include test/framework/CMakeFiles/test_framework.dir/progress.make

# Include the compile flags for this target's objects.
include test/framework/CMakeFiles/test_framework.dir/flags.make

test/framework/CMakeFiles/test_framework.dir/test_suite.o: test/framework/CMakeFiles/test_framework.dir/flags.make
test/framework/CMakeFiles/test_framework.dir/test_suite.o: test/framework/test_suite.cpp
	$(CMAKE_COMMAND) -E cmake_progress_report /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object test/framework/CMakeFiles/test_framework.dir/test_suite.o"
	cd /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework && /usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/test_framework.dir/test_suite.o -c /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework/test_suite.cpp

test/framework/CMakeFiles/test_framework.dir/test_suite.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/test_framework.dir/test_suite.i"
	cd /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework/test_suite.cpp > CMakeFiles/test_framework.dir/test_suite.i

test/framework/CMakeFiles/test_framework.dir/test_suite.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/test_framework.dir/test_suite.s"
	cd /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework/test_suite.cpp -o CMakeFiles/test_framework.dir/test_suite.s

test/framework/CMakeFiles/test_framework.dir/test_suite.o.requires:
.PHONY : test/framework/CMakeFiles/test_framework.dir/test_suite.o.requires

test/framework/CMakeFiles/test_framework.dir/test_suite.o.provides: test/framework/CMakeFiles/test_framework.dir/test_suite.o.requires
	$(MAKE) -f test/framework/CMakeFiles/test_framework.dir/build.make test/framework/CMakeFiles/test_framework.dir/test_suite.o.provides.build
.PHONY : test/framework/CMakeFiles/test_framework.dir/test_suite.o.provides

test/framework/CMakeFiles/test_framework.dir/test_suite.o.provides.build: test/framework/CMakeFiles/test_framework.dir/test_suite.o

test/framework/CMakeFiles/test_framework.dir/test_factory.o: test/framework/CMakeFiles/test_framework.dir/flags.make
test/framework/CMakeFiles/test_framework.dir/test_factory.o: test/framework/test_factory.cpp
	$(CMAKE_COMMAND) -E cmake_progress_report /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/CMakeFiles $(CMAKE_PROGRESS_2)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object test/framework/CMakeFiles/test_framework.dir/test_factory.o"
	cd /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework && /usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/test_framework.dir/test_factory.o -c /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework/test_factory.cpp

test/framework/CMakeFiles/test_framework.dir/test_factory.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/test_framework.dir/test_factory.i"
	cd /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework/test_factory.cpp > CMakeFiles/test_framework.dir/test_factory.i

test/framework/CMakeFiles/test_framework.dir/test_factory.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/test_framework.dir/test_factory.s"
	cd /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework/test_factory.cpp -o CMakeFiles/test_framework.dir/test_factory.s

test/framework/CMakeFiles/test_framework.dir/test_factory.o.requires:
.PHONY : test/framework/CMakeFiles/test_framework.dir/test_factory.o.requires

test/framework/CMakeFiles/test_framework.dir/test_factory.o.provides: test/framework/CMakeFiles/test_framework.dir/test_factory.o.requires
	$(MAKE) -f test/framework/CMakeFiles/test_framework.dir/build.make test/framework/CMakeFiles/test_framework.dir/test_factory.o.provides.build
.PHONY : test/framework/CMakeFiles/test_framework.dir/test_factory.o.provides

test/framework/CMakeFiles/test_framework.dir/test_factory.o.provides.build: test/framework/CMakeFiles/test_framework.dir/test_factory.o

test/framework/CMakeFiles/test_framework.dir/test_listener.o: test/framework/CMakeFiles/test_framework.dir/flags.make
test/framework/CMakeFiles/test_framework.dir/test_listener.o: test/framework/test_listener.cpp
	$(CMAKE_COMMAND) -E cmake_progress_report /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/CMakeFiles $(CMAKE_PROGRESS_3)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object test/framework/CMakeFiles/test_framework.dir/test_listener.o"
	cd /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework && /usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/test_framework.dir/test_listener.o -c /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework/test_listener.cpp

test/framework/CMakeFiles/test_framework.dir/test_listener.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/test_framework.dir/test_listener.i"
	cd /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework/test_listener.cpp > CMakeFiles/test_framework.dir/test_listener.i

test/framework/CMakeFiles/test_framework.dir/test_listener.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/test_framework.dir/test_listener.s"
	cd /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework/test_listener.cpp -o CMakeFiles/test_framework.dir/test_listener.s

test/framework/CMakeFiles/test_framework.dir/test_listener.o.requires:
.PHONY : test/framework/CMakeFiles/test_framework.dir/test_listener.o.requires

test/framework/CMakeFiles/test_framework.dir/test_listener.o.provides: test/framework/CMakeFiles/test_framework.dir/test_listener.o.requires
	$(MAKE) -f test/framework/CMakeFiles/test_framework.dir/build.make test/framework/CMakeFiles/test_framework.dir/test_listener.o.provides.build
.PHONY : test/framework/CMakeFiles/test_framework.dir/test_listener.o.provides

test/framework/CMakeFiles/test_framework.dir/test_listener.o.provides.build: test/framework/CMakeFiles/test_framework.dir/test_listener.o

test/framework/CMakeFiles/test_framework.dir/test_asserts.o: test/framework/CMakeFiles/test_framework.dir/flags.make
test/framework/CMakeFiles/test_framework.dir/test_asserts.o: test/framework/test_asserts.cpp
	$(CMAKE_COMMAND) -E cmake_progress_report /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/CMakeFiles $(CMAKE_PROGRESS_4)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object test/framework/CMakeFiles/test_framework.dir/test_asserts.o"
	cd /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework && /usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/test_framework.dir/test_asserts.o -c /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework/test_asserts.cpp

test/framework/CMakeFiles/test_framework.dir/test_asserts.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/test_framework.dir/test_asserts.i"
	cd /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework/test_asserts.cpp > CMakeFiles/test_framework.dir/test_asserts.i

test/framework/CMakeFiles/test_framework.dir/test_asserts.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/test_framework.dir/test_asserts.s"
	cd /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework/test_asserts.cpp -o CMakeFiles/test_framework.dir/test_asserts.s

test/framework/CMakeFiles/test_framework.dir/test_asserts.o.requires:
.PHONY : test/framework/CMakeFiles/test_framework.dir/test_asserts.o.requires

test/framework/CMakeFiles/test_framework.dir/test_asserts.o.provides: test/framework/CMakeFiles/test_framework.dir/test_asserts.o.requires
	$(MAKE) -f test/framework/CMakeFiles/test_framework.dir/build.make test/framework/CMakeFiles/test_framework.dir/test_asserts.o.provides.build
.PHONY : test/framework/CMakeFiles/test_framework.dir/test_asserts.o.provides

test/framework/CMakeFiles/test_framework.dir/test_asserts.o.provides.build: test/framework/CMakeFiles/test_framework.dir/test_asserts.o

test/framework/CMakeFiles/test_framework.dir/test_tapOutputter.o: test/framework/CMakeFiles/test_framework.dir/flags.make
test/framework/CMakeFiles/test_framework.dir/test_tapOutputter.o: test/framework/test_tapOutputter.cpp
	$(CMAKE_COMMAND) -E cmake_progress_report /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/CMakeFiles $(CMAKE_PROGRESS_5)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object test/framework/CMakeFiles/test_framework.dir/test_tapOutputter.o"
	cd /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework && /usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/test_framework.dir/test_tapOutputter.o -c /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework/test_tapOutputter.cpp

test/framework/CMakeFiles/test_framework.dir/test_tapOutputter.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/test_framework.dir/test_tapOutputter.i"
	cd /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework/test_tapOutputter.cpp > CMakeFiles/test_framework.dir/test_tapOutputter.i

test/framework/CMakeFiles/test_framework.dir/test_tapOutputter.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/test_framework.dir/test_tapOutputter.s"
	cd /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework/test_tapOutputter.cpp -o CMakeFiles/test_framework.dir/test_tapOutputter.s

test/framework/CMakeFiles/test_framework.dir/test_tapOutputter.o.requires:
.PHONY : test/framework/CMakeFiles/test_framework.dir/test_tapOutputter.o.requires

test/framework/CMakeFiles/test_framework.dir/test_tapOutputter.o.provides: test/framework/CMakeFiles/test_framework.dir/test_tapOutputter.o.requires
	$(MAKE) -f test/framework/CMakeFiles/test_framework.dir/build.make test/framework/CMakeFiles/test_framework.dir/test_tapOutputter.o.provides.build
.PHONY : test/framework/CMakeFiles/test_framework.dir/test_tapOutputter.o.provides

test/framework/CMakeFiles/test_framework.dir/test_tapOutputter.o.provides.build: test/framework/CMakeFiles/test_framework.dir/test_tapOutputter.o

test/framework/CMakeFiles/test_framework.dir/test_runner.o: test/framework/CMakeFiles/test_framework.dir/flags.make
test/framework/CMakeFiles/test_framework.dir/test_runner.o: test/framework/test_runner.cpp
	$(CMAKE_COMMAND) -E cmake_progress_report /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/CMakeFiles $(CMAKE_PROGRESS_6)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object test/framework/CMakeFiles/test_framework.dir/test_runner.o"
	cd /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework && /usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/test_framework.dir/test_runner.o -c /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework/test_runner.cpp

test/framework/CMakeFiles/test_framework.dir/test_runner.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/test_framework.dir/test_runner.i"
	cd /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework/test_runner.cpp > CMakeFiles/test_framework.dir/test_runner.i

test/framework/CMakeFiles/test_framework.dir/test_runner.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/test_framework.dir/test_runner.s"
	cd /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework/test_runner.cpp -o CMakeFiles/test_framework.dir/test_runner.s

test/framework/CMakeFiles/test_framework.dir/test_runner.o.requires:
.PHONY : test/framework/CMakeFiles/test_framework.dir/test_runner.o.requires

test/framework/CMakeFiles/test_framework.dir/test_runner.o.provides: test/framework/CMakeFiles/test_framework.dir/test_runner.o.requires
	$(MAKE) -f test/framework/CMakeFiles/test_framework.dir/build.make test/framework/CMakeFiles/test_framework.dir/test_runner.o.provides.build
.PHONY : test/framework/CMakeFiles/test_framework.dir/test_runner.o.provides

test/framework/CMakeFiles/test_framework.dir/test_runner.o.provides.build: test/framework/CMakeFiles/test_framework.dir/test_runner.o

test/framework/CMakeFiles/test_framework.dir/test_container.o: test/framework/CMakeFiles/test_framework.dir/flags.make
test/framework/CMakeFiles/test_framework.dir/test_container.o: test/framework/test_container.cpp
	$(CMAKE_COMMAND) -E cmake_progress_report /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/CMakeFiles $(CMAKE_PROGRESS_7)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object test/framework/CMakeFiles/test_framework.dir/test_container.o"
	cd /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework && /usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/test_framework.dir/test_container.o -c /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework/test_container.cpp

test/framework/CMakeFiles/test_framework.dir/test_container.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/test_framework.dir/test_container.i"
	cd /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework/test_container.cpp > CMakeFiles/test_framework.dir/test_container.i

test/framework/CMakeFiles/test_framework.dir/test_container.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/test_framework.dir/test_container.s"
	cd /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework/test_container.cpp -o CMakeFiles/test_framework.dir/test_container.s

test/framework/CMakeFiles/test_framework.dir/test_container.o.requires:
.PHONY : test/framework/CMakeFiles/test_framework.dir/test_container.o.requires

test/framework/CMakeFiles/test_framework.dir/test_container.o.provides: test/framework/CMakeFiles/test_framework.dir/test_container.o.requires
	$(MAKE) -f test/framework/CMakeFiles/test_framework.dir/build.make test/framework/CMakeFiles/test_framework.dir/test_container.o.provides.build
.PHONY : test/framework/CMakeFiles/test_framework.dir/test_container.o.provides

test/framework/CMakeFiles/test_framework.dir/test_container.o.provides.build: test/framework/CMakeFiles/test_framework.dir/test_container.o

test/framework/CMakeFiles/test_framework.dir/test_timer.o: test/framework/CMakeFiles/test_framework.dir/flags.make
test/framework/CMakeFiles/test_framework.dir/test_timer.o: test/framework/test_timer.cpp
	$(CMAKE_COMMAND) -E cmake_progress_report /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/CMakeFiles $(CMAKE_PROGRESS_8)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object test/framework/CMakeFiles/test_framework.dir/test_timer.o"
	cd /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework && /usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/test_framework.dir/test_timer.o -c /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework/test_timer.cpp

test/framework/CMakeFiles/test_framework.dir/test_timer.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/test_framework.dir/test_timer.i"
	cd /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework/test_timer.cpp > CMakeFiles/test_framework.dir/test_timer.i

test/framework/CMakeFiles/test_framework.dir/test_timer.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/test_framework.dir/test_timer.s"
	cd /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework/test_timer.cpp -o CMakeFiles/test_framework.dir/test_timer.s

test/framework/CMakeFiles/test_framework.dir/test_timer.o.requires:
.PHONY : test/framework/CMakeFiles/test_framework.dir/test_timer.o.requires

test/framework/CMakeFiles/test_framework.dir/test_timer.o.provides: test/framework/CMakeFiles/test_framework.dir/test_timer.o.requires
	$(MAKE) -f test/framework/CMakeFiles/test_framework.dir/build.make test/framework/CMakeFiles/test_framework.dir/test_timer.o.provides.build
.PHONY : test/framework/CMakeFiles/test_framework.dir/test_timer.o.provides

test/framework/CMakeFiles/test_framework.dir/test_timer.o.provides.build: test/framework/CMakeFiles/test_framework.dir/test_timer.o

test/framework/CMakeFiles/test_framework.dir/__/common/stringutils.o: test/framework/CMakeFiles/test_framework.dir/flags.make
test/framework/CMakeFiles/test_framework.dir/__/common/stringutils.o: test/common/stringutils.cpp
	$(CMAKE_COMMAND) -E cmake_progress_report /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/CMakeFiles $(CMAKE_PROGRESS_9)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object test/framework/CMakeFiles/test_framework.dir/__/common/stringutils.o"
	cd /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework && /usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/test_framework.dir/__/common/stringutils.o -c /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/common/stringutils.cpp

test/framework/CMakeFiles/test_framework.dir/__/common/stringutils.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/test_framework.dir/__/common/stringutils.i"
	cd /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/common/stringutils.cpp > CMakeFiles/test_framework.dir/__/common/stringutils.i

test/framework/CMakeFiles/test_framework.dir/__/common/stringutils.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/test_framework.dir/__/common/stringutils.s"
	cd /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/common/stringutils.cpp -o CMakeFiles/test_framework.dir/__/common/stringutils.s

test/framework/CMakeFiles/test_framework.dir/__/common/stringutils.o.requires:
.PHONY : test/framework/CMakeFiles/test_framework.dir/__/common/stringutils.o.requires

test/framework/CMakeFiles/test_framework.dir/__/common/stringutils.o.provides: test/framework/CMakeFiles/test_framework.dir/__/common/stringutils.o.requires
	$(MAKE) -f test/framework/CMakeFiles/test_framework.dir/build.make test/framework/CMakeFiles/test_framework.dir/__/common/stringutils.o.provides.build
.PHONY : test/framework/CMakeFiles/test_framework.dir/__/common/stringutils.o.provides

test/framework/CMakeFiles/test_framework.dir/__/common/stringutils.o.provides.build: test/framework/CMakeFiles/test_framework.dir/__/common/stringutils.o

test/framework/CMakeFiles/test_framework.dir/__/common/file.o: test/framework/CMakeFiles/test_framework.dir/flags.make
test/framework/CMakeFiles/test_framework.dir/__/common/file.o: test/common/file.cpp
	$(CMAKE_COMMAND) -E cmake_progress_report /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/CMakeFiles $(CMAKE_PROGRESS_10)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object test/framework/CMakeFiles/test_framework.dir/__/common/file.o"
	cd /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework && /usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/test_framework.dir/__/common/file.o -c /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/common/file.cpp

test/framework/CMakeFiles/test_framework.dir/__/common/file.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/test_framework.dir/__/common/file.i"
	cd /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/common/file.cpp > CMakeFiles/test_framework.dir/__/common/file.i

test/framework/CMakeFiles/test_framework.dir/__/common/file.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/test_framework.dir/__/common/file.s"
	cd /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/common/file.cpp -o CMakeFiles/test_framework.dir/__/common/file.s

test/framework/CMakeFiles/test_framework.dir/__/common/file.o.requires:
.PHONY : test/framework/CMakeFiles/test_framework.dir/__/common/file.o.requires

test/framework/CMakeFiles/test_framework.dir/__/common/file.o.provides: test/framework/CMakeFiles/test_framework.dir/__/common/file.o.requires
	$(MAKE) -f test/framework/CMakeFiles/test_framework.dir/build.make test/framework/CMakeFiles/test_framework.dir/__/common/file.o.provides.build
.PHONY : test/framework/CMakeFiles/test_framework.dir/__/common/file.o.provides

test/framework/CMakeFiles/test_framework.dir/__/common/file.o.provides.build: test/framework/CMakeFiles/test_framework.dir/__/common/file.o

test/framework/CMakeFiles/test_framework.dir/start_options.o: test/framework/CMakeFiles/test_framework.dir/flags.make
test/framework/CMakeFiles/test_framework.dir/start_options.o: test/framework/start_options.cpp
	$(CMAKE_COMMAND) -E cmake_progress_report /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/CMakeFiles $(CMAKE_PROGRESS_11)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object test/framework/CMakeFiles/test_framework.dir/start_options.o"
	cd /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework && /usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/test_framework.dir/start_options.o -c /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework/start_options.cpp

test/framework/CMakeFiles/test_framework.dir/start_options.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/test_framework.dir/start_options.i"
	cd /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework/start_options.cpp > CMakeFiles/test_framework.dir/start_options.i

test/framework/CMakeFiles/test_framework.dir/start_options.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/test_framework.dir/start_options.s"
	cd /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework/start_options.cpp -o CMakeFiles/test_framework.dir/start_options.s

test/framework/CMakeFiles/test_framework.dir/start_options.o.requires:
.PHONY : test/framework/CMakeFiles/test_framework.dir/start_options.o.requires

test/framework/CMakeFiles/test_framework.dir/start_options.o.provides: test/framework/CMakeFiles/test_framework.dir/start_options.o.requires
	$(MAKE) -f test/framework/CMakeFiles/test_framework.dir/build.make test/framework/CMakeFiles/test_framework.dir/start_options.o.provides.build
.PHONY : test/framework/CMakeFiles/test_framework.dir/start_options.o.provides

test/framework/CMakeFiles/test_framework.dir/start_options.o.provides.build: test/framework/CMakeFiles/test_framework.dir/start_options.o

test/framework/CMakeFiles/test_framework.dir/test_filter.o: test/framework/CMakeFiles/test_framework.dir/flags.make
test/framework/CMakeFiles/test_framework.dir/test_filter.o: test/framework/test_filter.cpp
	$(CMAKE_COMMAND) -E cmake_progress_report /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/CMakeFiles $(CMAKE_PROGRESS_12)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object test/framework/CMakeFiles/test_framework.dir/test_filter.o"
	cd /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework && /usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/test_framework.dir/test_filter.o -c /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework/test_filter.cpp

test/framework/CMakeFiles/test_framework.dir/test_filter.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/test_framework.dir/test_filter.i"
	cd /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework/test_filter.cpp > CMakeFiles/test_framework.dir/test_filter.i

test/framework/CMakeFiles/test_framework.dir/test_filter.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/test_framework.dir/test_filter.s"
	cd /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework/test_filter.cpp -o CMakeFiles/test_framework.dir/test_filter.s

test/framework/CMakeFiles/test_framework.dir/test_filter.o.requires:
.PHONY : test/framework/CMakeFiles/test_framework.dir/test_filter.o.requires

test/framework/CMakeFiles/test_framework.dir/test_filter.o.provides: test/framework/CMakeFiles/test_framework.dir/test_filter.o.requires
	$(MAKE) -f test/framework/CMakeFiles/test_framework.dir/build.make test/framework/CMakeFiles/test_framework.dir/test_filter.o.provides.build
.PHONY : test/framework/CMakeFiles/test_framework.dir/test_filter.o.provides

test/framework/CMakeFiles/test_framework.dir/test_filter.o.provides.build: test/framework/CMakeFiles/test_framework.dir/test_filter.o

# Object files for target test_framework
test_framework_OBJECTS = \
"CMakeFiles/test_framework.dir/test_suite.o" \
"CMakeFiles/test_framework.dir/test_factory.o" \
"CMakeFiles/test_framework.dir/test_listener.o" \
"CMakeFiles/test_framework.dir/test_asserts.o" \
"CMakeFiles/test_framework.dir/test_tapOutputter.o" \
"CMakeFiles/test_framework.dir/test_runner.o" \
"CMakeFiles/test_framework.dir/test_container.o" \
"CMakeFiles/test_framework.dir/test_timer.o" \
"CMakeFiles/test_framework.dir/__/common/stringutils.o" \
"CMakeFiles/test_framework.dir/__/common/file.o" \
"CMakeFiles/test_framework.dir/start_options.o" \
"CMakeFiles/test_framework.dir/test_filter.o"

# External object files for target test_framework
test_framework_EXTERNAL_OBJECTS =

test/framework/libtest_framework.a: test/framework/CMakeFiles/test_framework.dir/test_suite.o
test/framework/libtest_framework.a: test/framework/CMakeFiles/test_framework.dir/test_factory.o
test/framework/libtest_framework.a: test/framework/CMakeFiles/test_framework.dir/test_listener.o
test/framework/libtest_framework.a: test/framework/CMakeFiles/test_framework.dir/test_asserts.o
test/framework/libtest_framework.a: test/framework/CMakeFiles/test_framework.dir/test_tapOutputter.o
test/framework/libtest_framework.a: test/framework/CMakeFiles/test_framework.dir/test_runner.o
test/framework/libtest_framework.a: test/framework/CMakeFiles/test_framework.dir/test_container.o
test/framework/libtest_framework.a: test/framework/CMakeFiles/test_framework.dir/test_timer.o
test/framework/libtest_framework.a: test/framework/CMakeFiles/test_framework.dir/__/common/stringutils.o
test/framework/libtest_framework.a: test/framework/CMakeFiles/test_framework.dir/__/common/file.o
test/framework/libtest_framework.a: test/framework/CMakeFiles/test_framework.dir/start_options.o
test/framework/libtest_framework.a: test/framework/CMakeFiles/test_framework.dir/test_filter.o
test/framework/libtest_framework.a: test/framework/CMakeFiles/test_framework.dir/build.make
test/framework/libtest_framework.a: test/framework/CMakeFiles/test_framework.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking CXX static library libtest_framework.a"
	cd /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework && $(CMAKE_COMMAND) -P CMakeFiles/test_framework.dir/cmake_clean_target.cmake
	cd /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/test_framework.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
test/framework/CMakeFiles/test_framework.dir/build: test/framework/libtest_framework.a
.PHONY : test/framework/CMakeFiles/test_framework.dir/build

test/framework/CMakeFiles/test_framework.dir/requires: test/framework/CMakeFiles/test_framework.dir/test_suite.o.requires
test/framework/CMakeFiles/test_framework.dir/requires: test/framework/CMakeFiles/test_framework.dir/test_factory.o.requires
test/framework/CMakeFiles/test_framework.dir/requires: test/framework/CMakeFiles/test_framework.dir/test_listener.o.requires
test/framework/CMakeFiles/test_framework.dir/requires: test/framework/CMakeFiles/test_framework.dir/test_asserts.o.requires
test/framework/CMakeFiles/test_framework.dir/requires: test/framework/CMakeFiles/test_framework.dir/test_tapOutputter.o.requires
test/framework/CMakeFiles/test_framework.dir/requires: test/framework/CMakeFiles/test_framework.dir/test_runner.o.requires
test/framework/CMakeFiles/test_framework.dir/requires: test/framework/CMakeFiles/test_framework.dir/test_container.o.requires
test/framework/CMakeFiles/test_framework.dir/requires: test/framework/CMakeFiles/test_framework.dir/test_timer.o.requires
test/framework/CMakeFiles/test_framework.dir/requires: test/framework/CMakeFiles/test_framework.dir/__/common/stringutils.o.requires
test/framework/CMakeFiles/test_framework.dir/requires: test/framework/CMakeFiles/test_framework.dir/__/common/file.o.requires
test/framework/CMakeFiles/test_framework.dir/requires: test/framework/CMakeFiles/test_framework.dir/start_options.o.requires
test/framework/CMakeFiles/test_framework.dir/requires: test/framework/CMakeFiles/test_framework.dir/test_filter.o.requires
.PHONY : test/framework/CMakeFiles/test_framework.dir/requires

test/framework/CMakeFiles/test_framework.dir/clean:
	cd /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework && $(CMAKE_COMMAND) -P CMakeFiles/test_framework.dir/cmake_clean.cmake
.PHONY : test/framework/CMakeFiles/test_framework.dir/clean

test/framework/CMakeFiles/test_framework.dir/depend:
	cd /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5 && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5 /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5 /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/test/framework/CMakeFiles/test_framework.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : test/framework/CMakeFiles/test_framework.dir/depend


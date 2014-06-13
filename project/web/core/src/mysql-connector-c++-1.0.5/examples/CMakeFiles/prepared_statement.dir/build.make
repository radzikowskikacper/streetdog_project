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
include examples/CMakeFiles/prepared_statement.dir/depend.make

# Include the progress variables for this target.
include examples/CMakeFiles/prepared_statement.dir/progress.make

# Include the compile flags for this target's objects.
include examples/CMakeFiles/prepared_statement.dir/flags.make

examples/CMakeFiles/prepared_statement.dir/prepared_statement.o: examples/CMakeFiles/prepared_statement.dir/flags.make
examples/CMakeFiles/prepared_statement.dir/prepared_statement.o: examples/prepared_statement.cpp
	$(CMAKE_COMMAND) -E cmake_progress_report /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object examples/CMakeFiles/prepared_statement.dir/prepared_statement.o"
	cd /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/examples && /usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS)  -I/usr/include/mysql -DBIG_JOINS=1  -fno-strict-aliasing   -g -DNDEBUG  -o CMakeFiles/prepared_statement.dir/prepared_statement.o -c /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/examples/prepared_statement.cpp

examples/CMakeFiles/prepared_statement.dir/prepared_statement.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/prepared_statement.dir/prepared_statement.i"
	cd /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/examples && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS)  -I/usr/include/mysql -DBIG_JOINS=1  -fno-strict-aliasing   -g -DNDEBUG  -E /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/examples/prepared_statement.cpp > CMakeFiles/prepared_statement.dir/prepared_statement.i

examples/CMakeFiles/prepared_statement.dir/prepared_statement.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/prepared_statement.dir/prepared_statement.s"
	cd /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/examples && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS)  -I/usr/include/mysql -DBIG_JOINS=1  -fno-strict-aliasing   -g -DNDEBUG  -S /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/examples/prepared_statement.cpp -o CMakeFiles/prepared_statement.dir/prepared_statement.s

examples/CMakeFiles/prepared_statement.dir/prepared_statement.o.requires:
.PHONY : examples/CMakeFiles/prepared_statement.dir/prepared_statement.o.requires

examples/CMakeFiles/prepared_statement.dir/prepared_statement.o.provides: examples/CMakeFiles/prepared_statement.dir/prepared_statement.o.requires
	$(MAKE) -f examples/CMakeFiles/prepared_statement.dir/build.make examples/CMakeFiles/prepared_statement.dir/prepared_statement.o.provides.build
.PHONY : examples/CMakeFiles/prepared_statement.dir/prepared_statement.o.provides

examples/CMakeFiles/prepared_statement.dir/prepared_statement.o.provides.build: examples/CMakeFiles/prepared_statement.dir/prepared_statement.o

# Object files for target prepared_statement
prepared_statement_OBJECTS = \
"CMakeFiles/prepared_statement.dir/prepared_statement.o"

# External object files for target prepared_statement
prepared_statement_EXTERNAL_OBJECTS =

examples/prepared_statement: examples/CMakeFiles/prepared_statement.dir/prepared_statement.o
examples/prepared_statement: examples/CMakeFiles/prepared_statement.dir/build.make
examples/prepared_statement: driver/libmysqlcppconn-static.a
examples/prepared_statement: examples/CMakeFiles/prepared_statement.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking CXX executable prepared_statement"
	cd /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/examples && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/prepared_statement.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
examples/CMakeFiles/prepared_statement.dir/build: examples/prepared_statement
.PHONY : examples/CMakeFiles/prepared_statement.dir/build

examples/CMakeFiles/prepared_statement.dir/requires: examples/CMakeFiles/prepared_statement.dir/prepared_statement.o.requires
.PHONY : examples/CMakeFiles/prepared_statement.dir/requires

examples/CMakeFiles/prepared_statement.dir/clean:
	cd /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/examples && $(CMAKE_COMMAND) -P CMakeFiles/prepared_statement.dir/cmake_clean.cmake
.PHONY : examples/CMakeFiles/prepared_statement.dir/clean

examples/CMakeFiles/prepared_statement.dir/depend:
	cd /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5 && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5 /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/examples /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5 /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/examples /media/big/projekty/mine/streetdog/project/web/core/src/mysql-connector-c++-1.0.5/examples/CMakeFiles/prepared_statement.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : examples/CMakeFiles/prepared_statement.dir/depend


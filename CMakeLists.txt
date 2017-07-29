cmake_minimum_required(VERSION 3.4)
project(Vulkan-Tutorial LANGUAGES C CXX)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/modules/")

find_package(Vulkan REQUIRED)
find_package(GLFW3 REQUIRED)
find_package(CppCheck)
find_package(ClangTidy)

set (CMAKE_LINK_WHAT_YOU_USE TRUE)

set(EXE_NAME "main")
add_executable(${EXE_NAME} "${CMAKE_SOURCE_DIR}/src/main.cpp")
target_link_libraries(${EXE_NAME}
  PUBLIC
  "${Vulkan_LIBRARIES}"
  "${GLFW3_LIBRARY}")
target_include_directories(${EXE_NAME}
  PUBLIC
  "${CMAKE_SOURCE_DIR}/src"
  "${Vulkan_INCLUDE_DIRS}"
  "${GLFW3_INCLUDE_DIR}")
target_compile_features(${EXE_NAME}
  PRIVATE cxx_std_14 cxx_lambdas cxx_nullptr)
target_compile_options( ${EXE_NAME} PRIVATE $<$<CXX_COMPILER_ID:MSVC>:/W4> )
target_compile_options( ${EXE_NAME} PRIVATE
  $<$<CXX_COMPILER_ID:GNU>:-Wall -Wextra -pedantic> )
target_compile_options( ${EXE_NAME} PRIVATE
  $<$<CXX_COMPILER_ID:Clang>:-Wall -Wextra -pedantic -Weverything
  -Wno-c++98-compat> )

add_custom_command(TARGET ${EXE_NAME} POST_BUILD
  COMMAND "${CMAKE_COMMAND}" -E copy_directory
  "${CMAKE_SOURCE_DIR}/shaders/"
  "${CMAKE_BINARY_DIR}/shaders/")

add_custom_command(TARGET ${EXE_NAME} POST_BUILD
  COMMAND "/home/guajar/Program/VulkanSDK/1.0.54.0/x86_64/bin/glslangValidator" -V *.vert
  WORKING_DIRECTORY "shaders")
add_custom_command(TARGET ${EXE_NAME} POST_BUILD
  COMMAND "/home/guajar/Program/VulkanSDK/1.0.54.0/x86_64/bin/glslangValidator" -V *.frag
  WORKING_DIRECTORY "shaders")

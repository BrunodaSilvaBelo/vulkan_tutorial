cmake_minimum_required(VERSION 3.4)
project(Vulkan-Tutorial LANGUAGES C CXX)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/modules/")

find_package(Vulkan REQUIRED)
find_package(GLFW3 REQUIRED)
find_package(CppCheck)
find_package(ClangTidy)
find_package(GlslangValidator REQUIRED)

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

compile_shaders(${EXE_NAME})

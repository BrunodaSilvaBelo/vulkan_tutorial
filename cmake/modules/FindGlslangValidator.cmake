find_program(GLSLANGVALIDATOR_BIN NAMES glslangValidator)

include(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(
  GLSLANGVALIDATOR
  DEFAULT_MSG
  GLSLANGVALIDATOR_BIN)

function(compile_shaders target)
  add_custom_command(TARGET ${target} POST_BUILD
    COMMAND "${CMAKE_COMMAND}" -E copy_directory
    "${CMAKE_SOURCE_DIR}/shaders/"
    "${CMAKE_BINARY_DIR}/shaders/")
  add_custom_command(TARGET ${target} POST_BUILD
    COMMAND ${GLSLANGVALIDATOR_BIN} -V *.vert
    WORKING_DIRECTORY "shaders")
  add_custom_command(TARGET ${target} POST_BUILD
    COMMAND ${GLSLANGVALIDATOR_BIN} -V *.frag
    WORKING_DIRECTORY "shaders")
endfunction()

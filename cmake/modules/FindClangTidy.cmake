find_program(CLANG_TIDY_BIN NAMES clang-tidy)

include(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(
  CLANG_TIDY
  DEFAULT_MSG
  CLANG_TIDY_BIN)

if (CLANG_TIDY_FOUND)
  set (CMAKE_CXX_CLANG_TIDY "${CLANG_TIDY_BIN};-checks=-*,readability-*,performance-*")
endif()

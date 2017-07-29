find_program(CPPCHECK_BIN NAMES cppcheck)
set (CPPCHECK_THREADS "-j 2" CACHE STRING "The -j argument to have cppcheck use multiple threads / cores")
set (CPPCHECK_ARG "${CPPCHECK_THREADS}" CACHE STRING "The arguments to pass to cppcheck. If set will overwrite CPPCHECK_THREADS")
include(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(
    CPPCHECK
    DEFAULT_MSG
    CPPCHECK_BIN
    CPPCHECK_THREADS
    CPPCHECK_ARG)
mark_as_advanced(
    CPPCHECK_BIN
    CPPCHECK_THREADS
    CPPCHECK_ARG)

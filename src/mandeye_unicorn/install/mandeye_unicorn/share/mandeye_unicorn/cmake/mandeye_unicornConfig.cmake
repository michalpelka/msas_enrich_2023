# generated from ament/cmake/core/templates/nameConfig.cmake.in

# prevent multiple inclusion
if(_mandeye_unicorn_CONFIG_INCLUDED)
  # ensure to keep the found flag the same
  if(NOT DEFINED mandeye_unicorn_FOUND)
    # explicitly set it to FALSE, otherwise CMake will set it to TRUE
    set(mandeye_unicorn_FOUND FALSE)
  elseif(NOT mandeye_unicorn_FOUND)
    # use separate condition to avoid uninitialized variable warning
    set(mandeye_unicorn_FOUND FALSE)
  endif()
  return()
endif()
set(_mandeye_unicorn_CONFIG_INCLUDED TRUE)

# output package information
if(NOT mandeye_unicorn_FIND_QUIETLY)
  message(STATUS "Found mandeye_unicorn: 0.0.0 (${mandeye_unicorn_DIR})")
endif()

# warn when using a deprecated package
if(NOT "" STREQUAL "")
  set(_msg "Package 'mandeye_unicorn' is deprecated")
  # append custom deprecation text if available
  if(NOT "" STREQUAL "TRUE")
    set(_msg "${_msg} ()")
  endif()
  # optionally quiet the deprecation message
  if(NOT ${mandeye_unicorn_DEPRECATED_QUIET})
    message(DEPRECATION "${_msg}")
  endif()
endif()

# flag package as ament-based to distinguish it after being find_package()-ed
set(mandeye_unicorn_FOUND_AMENT_PACKAGE TRUE)

# include all config extra files
set(_extras "")
foreach(_extra ${_extras})
  include("${mandeye_unicorn_DIR}/${_extra}")
endforeach()

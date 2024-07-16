# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles/apphistogram_autogen.dir/AutogenUsed.txt"
  "CMakeFiles/apphistogram_autogen.dir/ParseCache.txt"
  "apphistogram_autogen"
  )
endif()

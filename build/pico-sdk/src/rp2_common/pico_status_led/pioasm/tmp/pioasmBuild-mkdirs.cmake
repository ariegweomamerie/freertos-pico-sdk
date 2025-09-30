# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.5)

file(MAKE_DIRECTORY
  "/home/general/pico/pico-sdk/tools/pioasm"
  "/home/general/pico/my_freertos_project/build/pioasm"
  "/home/general/pico/my_freertos_project/build/pioasm-install"
  "/home/general/pico/my_freertos_project/build/pico-sdk/src/rp2_common/pico_status_led/pioasm/tmp"
  "/home/general/pico/my_freertos_project/build/pico-sdk/src/rp2_common/pico_status_led/pioasm/src/pioasmBuild-stamp"
  "/home/general/pico/my_freertos_project/build/pico-sdk/src/rp2_common/pico_status_led/pioasm/src"
  "/home/general/pico/my_freertos_project/build/pico-sdk/src/rp2_common/pico_status_led/pioasm/src/pioasmBuild-stamp"
)

set(configSubDirs )
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "/home/general/pico/my_freertos_project/build/pico-sdk/src/rp2_common/pico_status_led/pioasm/src/pioasmBuild-stamp/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "/home/general/pico/my_freertos_project/build/pico-sdk/src/rp2_common/pico_status_led/pioasm/src/pioasmBuild-stamp${cfgdir}") # cfgdir has leading slash
endif()

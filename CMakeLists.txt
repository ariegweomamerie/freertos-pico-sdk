

cmake_minimum_required(VERSION 3.13)

# Import Pico SDK
include(${PICO_SDK_PATH}/external/pico_sdk_import.cmake)

project(my_freertos_project C CXX ASM)

# Initialize the SDK
pico_sdk_init()

# FreeRTOS configuration
set(FREERTOS_PORT "GCC_RP2040" CACHE STRING "")
set(FREERTOS_HEAP "4" CACHE STRING "")
set(FREERTOS_ENABLE_POSIX OFF CACHE BOOL "")
set(FREERTOS_ENABLE_TEST OFF CACHE BOOL "")
set(FREERTOS_USE_PTHREADS OFF CACHE BOOL "")

# ---- FreeRTOS Config ----
add_library(freertos_config INTERFACE)
target_include_directories(freertos_config SYSTEM
    INTERFACE
        ${CMAKE_CURRENT_LIST_DIR}/include
)
target_compile_definitions(freertos_config
    INTERFACE
        projCOVERAGE_TEST=0
)


# Add FreeRTOS-Kernel
add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/../FreeRTOS-Kernel FreeRTOS-Kernel)

# Add executable
add_executable(my_freertos_project
    main.c
    heap_4.c
    app_hooks.c
    # ../FreeRTOS-Kernel/event_groups.c
    # ../FreeRTOS-Kernel/tasks.c
    # ../FreeRTOS-Kernel/queue.c
    # ../FreeRTOS-Kernel/list.c
    # ../FreeRTOS-Kernel/timers.c
    # ../FreeRTOS-Kernel/croutine.c
    ../FreeRTOS-Kernel/portable/ThirdParty/GCC/RP2040/port.c
)

# Include directories
target_include_directories(my_freertos_project PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}/include
    ${CMAKE_CURRENT_LIST_DIR}/../FreeRTOS-Kernel/include
    ${CMAKE_CURRENT_LIST_DIR}/../FreeRTOS-Kernel/portable/ThirdParty/GCC/RP2040/include
    ${PICO_SDK_PATH}/src/rp2_common/hardware_exception/include
    ${PICO_SDK_PATH}/src/rp2040/hardware_structs/include
    ${PICO_SDK_PATH}/src/rp2_common/hardware_base/include
    ${PICO_SDK_PATH}/src/rp2_common/hardware_gpio/include
    ${PICO_SDK_PATH}/src/rp2_common/hardware_irq/include
    ${PICO_SDK_PATH}/src/rp2_common/hardware_sync/include
    ${PICO_SDK_PATH}/src/rp2_common/hardware_resets/include
    ${PICO_SDK_PATH}/src/rp2_common/hardware_structs/include
    ${PICO_SDK_PATH}/src/rp2040/hardware_clocks/include
    ${PICO_SDK_PATH}/src/rp2040/hardware_pll/include
    ${PICO_SDK_PATH}/src/rp2040/hardware_watchdog/include
    ${PICO_SDK_PATH}/src/rp2040/hardware_xosc/include
    ${PICO_SDK_PATH}/src/rp2_common/pico_platform/include
)

# Link libraries: Pico, hardware, FreeRTOS
target_link_libraries(my_freertos_project PRIVATE
    pico_stdlib
    # hardware_clocks       # <-- ensures hardware/clocks.h is found
    freertos_kernel
    freertos_config
    # freertos_event_groups
)

# Enable USB stdio (optional)
pico_enable_stdio_usb(my_freertos_project 1)
pico_enable_stdio_uart(my_freertos_project 0)

# Generate UF2, bin, etc.
pico_add_extra_outputs(my_freertos_project)
# pico_add_extra_outputs(my_freertos_project.elf)

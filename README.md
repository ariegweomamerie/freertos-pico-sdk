# freertos-pico-sdk

This project demonstrates how to build and run FreeRTOS on the Raspberry Pi Pico (RP2040) using the Pico SDK and CMake.

## Project Structure
- `my_freertos_project/` — Your main application and configuration
- `FreeRTOS-Kernel/` — FreeRTOS kernel sources
- `pico-sdk/` — Raspberry Pi Pico SDK

## Common Errors & Fixes

### 1. Implicit Declaration of FreeRTOS Functions
**Error:**
```
warning: implicit declaration of function 'xEventGroupSetBitsFromISR'
```
**Fix:**
- Ensure `configUSE_EVENT_GROUPS` is set to `1` in `FreeRTOSConfig.h`.
- Make sure `event_groups.h` is included in relevant source files.

### 2. Macro Redefinition Warnings
**Error:**
```
warning: "portNVIC_INT_CTRL_REG" redefined
```
**Fix:**
- Only define macros like `portNVIC_INT_CTRL_REG` and `portNVIC_PENDSVSET_BIT` in one place (preferably in `portmacro.h`).
- If needed in `port.c`, wrap with `#ifndef` guards.

### 3. Undefined Types or Macros
**Error:**
```
identifier "UBaseType_t" is undefined
```
**Fix:**
- Ensure `FreeRTOS.h` is included first in all FreeRTOS source files.
- Confirm your CMake include paths provide access to FreeRTOS headers and your `FreeRTOSConfig.h`.

### 4. Build System/Toolchain Issues
**Error:**
```
Pico SDK not found, wrong compiler/toolchain
```
**Fix:**
- Use the Pico SDK's native toolchain handling in CMake.
- Set `PICO_SDK_PATH` and use the provided CMake toolchain file if needed.

## How to Set Up This Project

1. **Clone the repository:**
   ```bash
   git clone https://github.com/ariegweomamerie/freertos-pico-sdk.git
   cd freertos-pico-sdk/my_freertos_project
   ```
2. **Install dependencies:**
   - Install ARM GCC toolchain (e.g., `arm-none-eabi-gcc`).
   - Install CMake and Ninja.
3. **Set up Pico SDK:**
   - Clone the Pico SDK into the workspace or set `PICO_SDK_PATH` to its location.
4. **Configure the project:**
   ```bash
   mkdir build
   cd build
   cmake .. -G Ninja -DPICO_SDK_PATH=/path/to/pico-sdk
   ```
5. **Build:**
   ```bash
   ninja
   ```
6. **Flash to Pico:**
   - Use `picotool` or drag-and-drop the UF2 file to the Pico's USB drive.

## Best Practices
- Always keep your `FreeRTOSConfig.h` in your project include directory and ensure the kernel build sees it.
- Clean and rebuild after changing config macros or include paths.
- Use CMake's `PRIVATE` include directories for kernel sources to avoid leaking config headers to other targets.

## Troubleshooting
If you encounter build errors:
- Check that all required macros are set in `FreeRTOSConfig.h`.
- Ensure all source files include the correct headers.
- Verify your toolchain and SDK paths.
- Clean your build directory and rebuild.

## License
See FreeRTOS and Pico SDK license files for details.

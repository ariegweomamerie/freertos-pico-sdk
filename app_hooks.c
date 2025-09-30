#include "FreeRTOS.h"
#include "task.h"

// Called if pvPortMalloc fails
void vApplicationMallocFailedHook(void) {
    taskDISABLE_INTERRUPTS();
    for(;;);
}

// Called if a task overflows its stack
void vApplicationStackOverflowHook(TaskHandle_t xTask, char *pcTaskName) {
    taskDISABLE_INTERRUPTS();
    for(;;);
}

// Optional hooks (not strictly required)
void vApplicationIdleHook(void) {}
void vApplicationTickHook(void) {}

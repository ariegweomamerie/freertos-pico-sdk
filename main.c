#include <stdio.h>
#include "pico/stdlib.h"
#include "FreeRTOS.h"
#include "task.h"

#define LED_PIN PICO_DEFAULT_LED_PIN

static void vBlinkTask(void *pvParameters) {
    (void) pvParameters;
    for (;;) {
        gpio_put(LED_PIN, 1);
        printf("LED ON\n");
        vTaskDelay(pdMS_TO_TICKS(500));
        gpio_put(LED_PIN, 0);
        printf("LED OFF\n");
        vTaskDelay(pdMS_TO_TICKS(500));
    }
}

int main(void) {
    stdio_init_all();
    gpio_init(LED_PIN);
    gpio_set_dir(LED_PIN, GPIO_OUT);

    // Create blink task: stack depth 256, priority 2
    xTaskCreate(vBlinkTask, "blink", 256, NULL, 2, NULL);

    printf("Starting scheduler\n");
    vTaskStartScheduler();

    // should never get here
    while (1) {
        tight_loop_contents();
    }
    return 0;
}

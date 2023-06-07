#!/usr/bin/env python3

import os
import sys
import time

import RPi.GPIO as GPIO

SHUTDOWN_BTN = 11  # GPIO_GEN0 (BCM #17)
SHUTDOWN_LED = 12  # GPIO_GEN1 (BCM #18)
T_CHECK = 1000  # in milliseconds
T_HOLD = 5000  # in milliseconds
T_BLINK = 100  # in milliseconds
BLINK_COUNT = 5


def main():
    print('raspi-safe-shutdown started.')
    print('Waiting for the user to press the shutdown button')

    GPIO.setmode(GPIO.BOARD)  # Physical/board pin-numbering scheme

    GPIO.setup(SHUTDOWN_BTN, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
    GPIO.setup(SHUTDOWN_LED, GPIO.OUT)
    GPIO.output(SHUTDOWN_LED, GPIO.LOW)

    while True:
        if GPIO.input(SHUTDOWN_BTN):
            print('Button pressed. Waiting', T_HOLD, 'milliseconds...')

            GPIO.output(SHUTDOWN_LED, GPIO.HIGH)
            time.sleep(T_HOLD / 1000)
            GPIO.output(SHUTDOWN_LED, GPIO.LOW)

            if GPIO.input(SHUTDOWN_BTN):
                print('The button is still pressed. Shutting down')

                for i in range(BLINK_COUNT):
                    GPIO.output(SHUTDOWN_LED, GPIO.LOW)
                    time.sleep(T_BLINK / 1000)
                    GPIO.output(SHUTDOWN_LED, GPIO.HIGH)
                    time.sleep(T_BLINK / 1000)

                GPIO.cleanup()
                os.execvp('poweroff', ['poweroff'])
            else:
                print('Button released. Waiting again for the user to press',
                      'the shutdown button')
        time.sleep(T_CHECK / 1000)


if __name__ == '__main__':
    sys.exit(main())

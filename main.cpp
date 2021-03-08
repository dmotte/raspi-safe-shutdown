#include <iostream>
#include <stdlib.h>
#include <wiringPi.h>

using namespace std;

#define SHUTDOWN_BTN 0 // GPIO_GEN0 (BCM #17)
#define SHUTDOWN_LED 1 // GPIO_GEN1 (BCM #18)
#define T_CHECK 1000   // in milliseconds
#define T_HOLD 5000	   // in milliseconds
#define T_BLINK 100	   // in milliseconds
#define BLINK_COUNT 5

int main()
{
	cout << "raspi-safe-shutdown started." << endl;
	cout << "Waiting for the user to press the shutdown button..." << endl;

	wiringPiSetup();

	pinMode(SHUTDOWN_BTN, INPUT);
	pinMode(SHUTDOWN_LED, OUTPUT);
	digitalWrite(SHUTDOWN_LED, 0);

	// Perform check every T_CHECK ms...
	while (true)
	{
		// If the user pressed the button
		if (digitalRead(SHUTDOWN_BTN))
		{
			// Wait T_HOLD ms
			digitalWrite(SHUTDOWN_LED, 1);
			delay(T_HOLD);
			digitalWrite(SHUTDOWN_LED, 0);

			// If, after T_HOLD ms, the button is still pressed
			if (digitalRead(SHUTDOWN_BTN))
			{
				// Blink the LED
				for (int i = 0; i < BLINK_COUNT; i++)
				{
					digitalWrite(SHUTDOWN_LED, 0);
					delay(T_BLINK);
					digitalWrite(SHUTDOWN_LED, 1);
					delay(T_BLINK);
				}

				// Shutdown the system
				system("poweroff");
				return 0;
			}
		}

		delay(T_CHECK);
	}
}

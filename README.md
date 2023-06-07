# raspi-safe-shutdown

![icon](icon-128.png)

Simple daemon service application for _Raspberry Pi_ to handle a **safe shutdown button** with an indicator LED.

:information_source: This has been tested on a **Raspberry Pi 3 B**, but may also work with other versions of the board.

:warning: **Disclaimer**: I am not responsible for any possible damage you may cause to your boards.

## Demo

Demonstration video:

<video width="100%" controls>
    <source src="demo.mp4">
    <a href="https://dmotte.github.io/raspi-safe-shutdown/#demo" target="_blank">Watch it on GitHub Pages</a>
</video>

## Circuit

To use this application you just need to connect two components to your Raspberry Pi via GPIO: an **LED** and a **button**. However, I also find very useful to know when the board is powered and when the operating system is running. This can be achieved by connecting two more LEDs.

The ideal scenario is therefore the following:

- The **button** should be connected to the `GPIO_GEN0` pin (`BCM #17`)
- The **red LED** (optional) should be connected to **3v3**
  - it is ON when the board is powered, even if the OS is not running
- The **yellow LED** should be connected to the `GPIO_GEN1` pin (`BCM #18`)
  - it is the indicator LED for the _raspi-safe-shutdown_ application
- The **green LED** (optional) should be connected to the `UART0_TXD` pin (`BCM #14`)
  - it is ON only when the operating system is up and running

To make the (optional) green LED work as explained, you need to have **Serial communication** enabled on the Raspberry Pi. To enable it, log in and execute the following command:

```bash
sudo raspi-config nonint do_serial 0
```

Then reboot the Raspberry Pi to make the changes effective:

```bash
sudo reboot
```

![Circuit diagram](circuit_bb.png)

## Installation

> :warning: **Warning**: Always examine scripts downloaded from the internet before running them locally.

To install or update _raspi-safe-shutdown_ into your Raspberry Pi, connect it to the internet and execute the following command:

```bash
curl -sSL https://raw.githubusercontent.com/dmotte/raspi-safe-shutdown/main/get.sh | sudo bash
```

This will automatically download the latest version of this application and install a **systemctl** service for running it in the background.

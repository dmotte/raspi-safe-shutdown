# raspi-safe-shutdown

![](icon-128.png)

Simple daemon service application for *Raspberry Pi* to handle a **safe shutdown button**.

:information_source: This has been tested with the **Raspberry Pi 3 B** board, but may also work with other versions.

:warning: **Disclaimer**: I am not responsible for any possible damage you may cause to your boards by following this tutorial.

TODO explanation. txd on only if serial enabled. command for enabling serial ( `sudo raspi-config` &rarr; Interfacing Options &rarr; Serial)

## Circuit diagram

- The **button** should be connected to the `GPIO_GEN0` pin (`BCM #17`)
- The **red LED** should be connected to **3v3**
- The **yellow LED** should be connected to the `GPIO_GEN1` pin (`BCM #18`)
- The **green LED** should be connected to the `UART0_TXD` pin (`BCM #14`)

![Circuit diagram](circuit_bb.png)

## Compiling

TODO

```bash
./compile.sh
```

## Installation

TODO

```bash
./install.sh
```

## Demo

Demonstration video:

<video width="100%" controls>
    <source src="demo.mp4">
    <a href="https://dmotte.github.io/raspi-safe-shutdown/#demo" target="_blank">Watch it on GitHub Pages</a>
</video>

---

TODO

```bash
sudo apt-get update && sudo apt-get install wiringpi
```

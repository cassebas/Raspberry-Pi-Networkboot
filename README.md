# Raspberry-Pi-Networkboot
Simple Vagrant box that contains a DHCP server and a TFTP server, with which a Raspberry Pi can connect to boot from the network.
In my case, the Pi is connected to my laptop with ethernet cable. A bridge is created on the laptop's ethernet adapter, which makes the
Pi, laptop and Vagrant box together form a tiny local network.

Usage:

`vagrant up`

During provisioning of the Ubuntu Bionic box you may get a question about the adapter you want for the bridge. Choose the one which is
going to be used for the ethernet cable.

For configuration of the Pi to allow for network boot, I followed the excellent
[blog by Mete Balci](https://metebalci.com/blog/bare-metal-rpi3-network-boot/).

After the vagrant box is created and it is running, the Pi can be connected to your laptop and turned on. If all is well, the Pi
will retrieve the necessary files from the shared folder tftp.

Happy network booting ;-)

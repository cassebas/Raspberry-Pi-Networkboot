# Raspberry-Pi-Networkboot
Simple Vagrant box that contains a DHCP server and a TFTP server, with which a Raspberry Pi can connect to boot from the network.
In my case, the Pi is connected to my laptop with ethernet cable. A bridge is created on the laptop's ethernet adapter, which makes the
Pi, laptop and Vagrant box together form a tiny local network.

## Requirements
- Vagrant
- provider for Vagrant virtual machine, e.g. VirtualBox

## Usage:

- Clone this repository into e.g. ```Raspberry-Pi-Networkboot```
- In the ```Raspberry-Pi-Networkboot``` folder, execute:
  `vagrant up`

During provisioning of the Ubuntu Bionic box you may get a question about the adapter you want for the bridge. Choose the one which is
going to be used for the ethernet cable.

For configuration of the Pi to allow for network boot, I followed the excellent
[blog by Mete Balci](https://metebalci.com/blog/bare-metal-rpi3-network-boot/).

After the vagrant box is created and it is running, the Pi can be connected to your laptop and turned on. If all is well, the Pi
will retrieve the necessary files from the shared folder tftp.

## Troubleshooting
- Sometimes it may be necessary to restart the DHCP server that runs in the virtual machine:

  ```vagrant@bootserver:~$ sudo systemctl restart isc-dhcp-server```
- Likewise for the TFTP server:

  ```vagrant@bootserver:~$ sudo systemctl restart tftpd-hpa```
- To inspect network packages sent to/from the Pi, ```tcpdump``` can be used in the virtual macine:

  ```sudo  tcpdump 'ether host aa:bb:cc:00:11:22' -i eth1 -vv```
  
  Or use wireshark on your host computer, where you capture the packages from the chosen network adapter (e.g. eth0). Make sure your user is in the group ```wireshark``` to be able to run wireshark as non-root. Example filter:
  
  ```ether host aa:bb:cc:00:11:22```
  
Happy network booting ;-)

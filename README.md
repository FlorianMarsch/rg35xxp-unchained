# RG35XX+ Unchained

## TL:DR;
Copy this repo into you SD card, put it into your RG35XX+ and activate SSH to get remote access and do whatever you want with root powers.

- [RG35XX+ Unchained](#rg35xx--unchained)
  * [TL:DR;](#tl-dr-)
  * [How to SSH on RG35XX+](#how-to-ssh-on-rg35xx-)
    + [Connect WiFi](#connect-wifi-optional)
    + [Install ssh server](#install-ssh-server)
    + [Troubleshout](#troubleshout)
    + [Change language via ssh](#change-language-via-ssh)
    + [Known issues](#known-issues)
  * [Whats next](#whats-next)
  * [Motivation](#motivation)


## How to SSH on RG35XX+
Luckily, executables put into Roms/APPS/ are executed with root access. Just copy this repo onto a SD card and navigate to
> RA Games > Apps

in your handheld.

I recommend to use a second empty SD card (TF2) so that the folders are empty and the view is more clean and simple to use. You will need to execute the UNCHAINED scripts only once.

### Connect WiFi [optional]
```
select unchained_connect_wifi
```
This script is not mandatory and only needed for users of the day one version/stock os of RG35XX+, where you can only put 36 characters into the systems WiFi ui. A working internet connection is crucial to activate SSH later. Edit this file and put your WiFi credentials there. Enable WiFi before running.

### Install SSH server
```
select unchained_install_ssh
```
This script requires internet to download new packages. It will download `openssh-server` and copy a proper settings file that allows root login via SSH. Also it updates the system set time, i need to do it weirdly because `ntpdate` is not found.

Check your systems WiFi ui and use the IP Address displayed there to login to your RG35XX+ via SSH.
```
ssh root@192.168.x.x
```

Known credentials:
|Username|Password|
|---|---|
|root|root|
|game|game|


### Troubleshout
```
run unchained_export_debug_info
```
Troubleshouting is quite hard because a running script cant ouput errors visually. In case you have troubles check the log files (you will find them in the UNCHAINED folder). Make sure you are connected to the internet and that the user running the scripts is root. When executing a script you wont see any output visualy but only the Anbernic Boot Screen or even an entirely black screen. Thats ok. The scripts create logfiles for troubleshooting, please be aware that you need to shutdown the handheld properly to make the device flush its write buffer for SD cards. In case you just eject the sd card too early or while the device is running you might experience write loss and no file is created.

### Change language via ssh

The system language is mandarin/chinese, no mater what you have configured in your ui. To change that please execute  
```
sh /mnt/sdcard/Roms/APPS/UNCHAINED/scripts/unchained_change_language.sh
```
and follow the wizard. reboot afterwards but exiting ssh session and relogin should be enough.

### Known issues
the sudo command does not work. as everything is executed as root anyways, i didnt care to fix it :)

For Step [change language via ssh](#change-language-via-ssh) : If you put the files into TF1 use /mnt/mmc/... instead of /mnt/sdcard/..., which is for TF2.

Put your Device onto a power plug while using ssh and set display always on, else the display might turn off because of inactivity and you will loose the connection.

## Whats nexts
I plan to simplify the scripts, so that they all can run automatically with a single action. I am not an Ubuntu expert, so it might take a while but ultimativelly i want to merge all provided steps into 1.

- install SSH
- change system language to english

## Motivation
I just wanted to write a small tool for the anbernic stock OS to check on the installed ROMS and download respective thumbnails if missing. Unfortunetly i could not make my programm run. I figured that the ARM Cortex-53 is capable of 64 bit commands but on the stock image i only found a 32 bit interpreter. I made my program run in 32 bit mode (Arm32 HF) but the Arm32 toolschain is just pain. Also some libraries i want to use are about to stop ARM32 support. Therefore i wanted to enable 64 Bit compability to make my life easier.

In addition the Garlic OS 2.0 Bootloader is somehow not working for me. I can imagine that this is true for many users, and for those who dont do unix every day: a drag-and-drop solution with an installation wizard is welcomed. The knowledge i got here, might inspire me to create a drop in UI replacement for the stock OS of anbernics RG35XX+ later.
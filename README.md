# RG35XX+ Unchained

## TL:DR;
Copy this Repo into you SD card, put it into your RG35XX+ and activate SSH to get remote access and do whatever you want with root powers.

- [RG35XX+ Unchained](#rg35xx--unchained)
  * [TL:DR;](#tl-dr-)
  * [Motivation](#motivation)
  * [How to SSH on RG35XX+](#how-to-ssh-on-rg35xx-)
    + [Connect Wifi](#connect-wifi)
    + [inject root password](#inject-new-root-password)
    + [install ssh server](#install-ssh-server)
    + [troubleshout](#troubleshout)
    + [change language via ssh](#change-language-via-ssh)
    + [known issues](#known-issues)
  * [whats next](#whats-next)

## Motivation
I just wanted to write a small tool for the anbernic stock OS to check on the installed ROMS and download respective thumbnails if missing. Unfortunetly i could not make my programm run. I figured that the ARM Cortex-53 is capable of 64 bit commands but on the stock image i only found a 32 bit interpreter. I made my program run in 32 bit mode (Arm32 HF) but the Arm32 toolschain is just pain. Also some libraries i want to use are about to stop ARM32 support. Therefore i wanted to enable 64 Bit compability to make my life easier.

In addition the Garlic OS 2.0 Bootloader is somehow not working for me. I can imagine that this is true for many users, and for those who dont do unix every day: a drag-and-drop solution with an installation wizard is welcomed. The knowledge i got here, might inspire me to create a drop in UI replacement for the stock OS of anbernics RG35XX+ later.

## How to SSH on RG35XX+
Luckily, executables put into Roms/APPS/ are executed with root access. Just copy this repo onto a SD card and navigate to
> RA Games > Apps

in your handheld.

I recommend to use a second empty SD card (TF2) so that the folders are empty and the view is more clean and simple to use. You will need to execute the UNCHAINED scripts only once.

### Connect Wifi
```
select unchained_1_connect_wifi
```
This script is optionally and only needed for users of the day one version, where you can only put 36 characters into the systems wifi ui. A working internet connection is crucial to activate ssh later. Edit this file and put your wifi credentials there. Enable Wifi before running.

### Inject new root password
 ```
 select unchained_2_change_root_passwd
 ```
 This script changes the system file that stores the passwords. Unfortunetly i was not able to get the original password so i created a new password that can be injected into the system. I found several sources claiming you could use root:root or game:game and for me it seems that for some it works, for others it doesnt. I keep that script here, because for me it seems that different stock images might use different passwords and having that script in the toolbelt is always good, so that you could reset the password if needed.

 The new password is 'admin'. If you want to change it, use passwd later via ssh. I rebooted here, but honestly im not sure if this is needed.


### install ssh server
```
select unchained_3_install_ssh
```
This script requires internet to download new packages. It will download openssh-server and copy a proper settings file that allows root login via ssh. Also it updates the system set time, i need to do it weirdly because `ntpdate` is not found.

Check your systems wifi ui and use the IP Address displayed there to login to your RG35XX+ via ssh.
```
ssh root@192.168.x.x
```
use default password or 'admin' when set with [inject root password](#inject-new-root-password). you should be logged in now.

### troubleshout
```
run unchained_4_export_debug_info
```
Troubleshouting is quite hard because a running script cant ouput errors visually. In case you have troubles check the log files (you will find them in the UNCHAINED folder). Make sure you are connected to the internet and that the user running the scripts is root. When executing a script you wont see any output visualy but only the Anbernic Boot Screen or even an entirely black screen. Thats ok. The scripts create logfiles for troubleshooting, please be aware that you need to shutdown the handheld properly to make the device flush its write buffer for SD cards. In case you just eject the sd card too early or while the device is running you might experience write loss and no file is created.

### change language via ssh

The system language is mandarin/chinese, no mater what you have configured in your ui. To change that please execute  
```
sh /mnt/sdcard/Roms/APPS/UNCHAINED/scripts/unchained_change_language.sh
```
and follow the wizard. reboot afterwards but exiting ssh session and relogin should be enough.

### known issues
the sudo command does not work. as everything is executed as root anyways, i didnt care to fix it :)

For Step [change language via ssh](#change-language-via-ssh) : If you put the files into TF1 use /mnt/mmc/... instead of /mnt/sdcard/..., which is for TF2.

Put your Device onto a power plug while using ssh and set display always on, else the display might turn off because of inactivity and you will loose the connection.

## whats nexts
I plan to simplify the scripts, so that they all can run automatically with a single action. I am not an Ubuntu expert, so it might take a while but ultimativelly i want to merge all provided steps into 1.

- install ssh
- change system language to english

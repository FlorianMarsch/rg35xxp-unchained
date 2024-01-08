# RG35XX+ Unchained

## TL:DR;
Copy this Repo into you SD card, put it into your RG35XX+ and activate SSH to get remote access and do whatever you want with root powers.

- [RG35XX+ Unchained](#rg35xx--unchained)
  * [TL:DR;](#tl-dr-)
  * [Motivation](#motivation)
  * [How to SSH on RG35XX+](#how-to-ssh-on-rg35xx-)
    + [Connect Wifi](#connect-wifi)
    + [install ssh server](#install-ssh-server)
    + [troubleshout](#troubleshout)
    + [change language via ssh](#change-language-via-ssh)
    + [enable 64 bit via ssh](#enable-64-bit-via-ssh)
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

### install ssh server
```
select unchained_2_install_ssh
```
This script requires internet to download new packages. It will download openssh-server and copy a proper settings file that allows root login via ssh. Also it updates the system set time, i need to do it weirdly because `ntpdate` is not found.

Check your systems wifi ui and use the IP Address displayed there to login to your RG35XX+ via ssh.
```
ssh root@192.168.x.x
```
use 'root' as password. you should be logged in now. (older versions of the script might have changed the password to 'admin')

### troubleshout
```
run unchained_3_export_debug_info
```
Troubleshouting is quite hard because a running script cant ouput errors visually. In case you have troubles check the log files (you will find them in the UNCHAINED folder). Make sure you are connected to the internet and that the user running the scripts is root. When executing a script you wont see any output visualy but only the Anbernic Boot Screen or even an entirely black screen. Thats ok. The scripts create logfiles for troubleshooting, please be aware that you need to shutdown the handheld properly to make the device flush its write buffer for SD cards. In case you just eject the sd card too early or while the device is running you might experience write loss and no file is created.

### change language via ssh

The system language is mandarin/chinese, no mater what you have configured in your ui. To change that please execute  
```
sh /mnt/sdcard/Roms/APPS/UNCHAINED/scripts/unchained_change_language.sh
```
and follow the wizard. reboot afterwards but exiting ssh session and relogin should be enough.

### enable 64 bit via ssh

Now we are talking :D 
As i said earlier, the arm64 interpreter is not pre-installed. The needed apt packages will cause conflicts with existing system packages and its really a pain to resolve them manually with apt-get. Maybe that was the reason, why Anbernic just discard doing it. Please keep in mind, that the tools preinstalled are most likely dynamically linked to the armhf/32bit interpreter (like retro arch). 

run
```
sh /mnt/sdcard/Roms/APPS/UNCHAINED/scripts/unchained_install_arm64.sh
```
the script will pause and ask you to accept this solution. continue with n (no), as this leaves the system unchanged.
```
     Keep the following packages at their current version:
1)     gcc-8-base:arm64 [Not Installed]                   
2)     libc6:arm64 [Not Installed]                        
3)     libgcc1:arm64 [Not Installed]                      



Accept this solution? [Y/n/q/?] n
```

Now aptitude will find a solution to resolve conflicts and install those packages.
```
      Remove the following packages:                                                                             
1)      libc-dev-bin [2.27-3ubuntu1.6 (bionic-updates, now)]                                                     

      Install the following packages:                                                                            
2)      libc-dev-bin:arm64 [2.27-3ubuntu1 (bionic)]                                                              

      Downgrade the following packages:                                                                          
3)      gcc-8-base [8.4.0-1ubuntu1~18.04 (bionic-security, bionic-updates, now) -> 8-20180414-1ubuntu2 (bionic)] 
4)      libatomic1 [8.4.0-1ubuntu1~18.04 (bionic-security, bionic-updates, now) -> 8-20180414-1ubuntu2 (bionic)] 
5)      libc6 [2.27-3ubuntu1.6 (bionic-updates, now) -> 2.27-3ubuntu1 (bionic)]                                  
6)      libc6-dev [2.27-3ubuntu1.6 (bionic-updates, now) -> 2.27-3ubuntu1 (bionic)]                              
7)      libcc1-0 [8.4.0-1ubuntu1~18.04 (bionic-security, bionic-updates, now) -> 8-20180414-1ubuntu2 (bionic)]   
8)      libgcc1 [1:8.4.0-1ubuntu1~18.04 (bionic-security, bionic-updates, now) -> 1:8-20180414-1ubuntu2 (bionic)]
9)      libgomp1 [8.4.0-1ubuntu1~18.04 (bionic-security, bionic-updates, now) -> 8-20180414-1ubuntu2 (bionic)]   
10)     libstdc++6 [8.4.0-1ubuntu1~18.04 (bionic-security, bionic-updates, now) -> 8-20180414-1ubuntu2 (bionic)] 



Accept this solution? [Y/n/q/?] y
```

Continue with y (yes). You will be greeted with 2 outputs validating that everything is installed correctly.

```
Dear Developer, this Umbrella was compiled for Linux Arm64.

Dear Developer, this Umbrella was compiled for Linux Arm32 HFP.
```

Any file not found error indicates an error in the setup. /lib/ld-linux-aarch64.so.1 is missing.

### known issues
the sudo command does not work. as everything is executed as root anyways, i didnt care to fix it :)

For Steps [change language via ssh](#change-language-via-ssh) and [enable 64 bit via ssh](#enable-64-bit-via-ssh) : If you put the files into TF1 use /mnt/mmc/... instead of /mnt/sdcard/..., which is for TF2.

Put your Device onto a power plug while using ssh and set display always on, else the display might turn off because of inactivity and you will loose the connection.

To make the Java JDK run i also needed to execute `aptitude install zlib1g:arm64`. (Cross Compile not possible, so i need to compile Native Java Applications on that RG35XX+ :sunglasses: ). But because of this, i am not sure if the steps described in [enable 64 bit via ssh](#enable-64-bit-via-ssh) are sufficient.

## whats next
I plan to simplify the scripts, so that they all can run automatically with a single action. I am not an Ubuntu expert, so it might take a while but ultimativelly i want to merge all provided steps into 1.

- install ssh
- change system language to english
- install arm64 capabilities


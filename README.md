# Rescue OS

A live rescue and recovery operating system built with Debian
[live-build](https://wiki.debian.org/DebianLive/Build).

Boot it from a USB stick to repair, back up, clone, wipe or analyze a broken
system - entirely from RAM, so the stick can be removed once booted and no
internal disk is touched unless you tell it to.

> ⚠️ **Work in progress.** This is an experimental project. Bugs can occur and
> things may not work as expected. See the [Disclaimer](#disclaimer).

## Highlights

- **Runs fully from RAM** (`toram`) - remove the boot medium after startup, leave
  target disks untouched. (There is also a normal live option if the device don't has enough RAM for the toram option.)
- **Based on Debian 13 (Trixie)** with the XFCE desktop, plus a broad set of
  non-free firmware for good hardware support out of the box.
- **TTY rescue menu** on TTY1 for quick access without a desktop session.
- **On-demand SSH server** with a randomly generated one-time password for
  remote rescue work.
- **Automated builds** roughly every two months with the latest packages.

## Included software

A non-exhaustive overview of what's on board:

| Category            | Tools |
|---------------------|-------|
| Disk recovery       | GNU ddrescue, ddrescueview, TestDisk/PhotoRec, foremost, scalpel, gpart |
| Backup & cloning    | Clonezilla, Rescuezilla, fsarchiver, GParted, rsync, grsync |
| Disk health         | GSmartControl, smartmontools, nvme-cli, dvdisaster |
| Secure erase        | nwipe |
| Encryption          | VeraCrypt, cryptsetup (LUKS), dislocker (BitLocker), GnuPG, OpenSSL, KeePassXC |
| Forensics           | Guymager, foremost, scalpel, exiftool, wxHexEditor |
| Password recovery   | ophcrack (+ CLI) |
| Antivirus           | ClamTk / ClamAV |
| Networking          | nmap/Zenmap, Wireshark, tcpdump, mtr, traceroute, iperf3 |
| File transfer       | FileZilla, rclone, LocalSend, Remmina, TigerVNC/x11vnc, Transmission, lftp    |
| System info         | hardinfo2, psensor, Conky, fastfetch |
| Other               | Firefox ESR, Mousepad, VSCodium, ... |

The full package list is located in
[`live-build/config/package-lists/`](live-build/config/package-lists) plus the
extra packages installed via
[`hooks/normal/100003-install-additional-packages.chroot`](live-build/config/hooks/normal/100003-install-additional-packages.chroot)
(VSCodium, LocalSend, Rescuezilla, VeraCrypt).

## Download

Download pre-built ISO images from
[GitHub Releases](https://github.com/jandie1505/rescue-os/releases/latest).

Because the ISO is too large for GitHub Releases, the image itself is hosted on
an external server and only the **latest** release is kept. The release notes
contain the direct download link and a matching `.sha256` checksum file.

Alternatively, you can grab the ISO from the
[latest workflow run](https://github.com/jandie1505/rescue-os/actions/workflows/build-live-image.yml), but GitHub requires you to be signed in to download Actions artifacts.

Verify your download before flashing it:

```bash
sha256sum -c live-image-amd64.hybrid.iso.sha256
```

## Installation

Flash the ISO to a USB drive (this **erases** the target drive, double-check
the device name):

```bash
sudo dd if=live-image-amd64.hybrid.iso of=/dev/sdX bs=4M oflag=sync status=progress && sync
```

Or use a graphical tool such as [balenaEtcher](https://etcher.balena.io/).

Then boot the target machine from the USB drive.  
You can choose between the `toram` mode, where rescue-os is copied into RAM (faster, USB drive can be removed) or the normal live mode (slow, USB drive needs to be connected).

## Usage

### Default credentials

- Username: `user`, Password: `live` (auto login)
- Root password: `live`

### TTY rescue menu

XFCe automatically starts on TTY1. When it is closed, it starts a text-mode rescue menu that lets you:

- start the XFCE desktop
- open a root shell
- change the keyboard layout
- configure networking (`nmtui`)
- view system logs
- enable/manage SSH access
- reboot or shut down

TTYs **7-12** are plain `getty` consoles without autologin, in case you need a
clean login prompt. Switch TTYs with `Ctrl`+`Alt`+`F1`..`F12`. The Magic SysRq
keys are enabled (`kernel.sysrq=1`).

### Remote access (SSH)

The SSH server is **disabled by default**. Enable it from the desktop shortcut, TTY menu or with
the `ssh-manager` command:

```bash
sudo ssh-manager enable            # start sshd and print a new one-time password
sudo ssh-manager show-password     # show the current password
sudo ssh-manager regenerate-password
sudo ssh-manager disable           # stop sshd and clear the password
sudo ssh-manager tui               # interactive dialog UI
```

Log in as the user `user` with the generated password. The firewall (UFW)
allows SSH and the LocalSend port (`53317/tcp`) by default.

## Building from source

You need a machine (or VM) running
[Debian 13 (Trixie)](https://www.debian.org/distrib/) with root access.  

```bash
git clone https://github.com/jandie1505/rescue-os.git
cd rescue-os
./build.sh
```

`build.sh` runs `lb clean`, `lb config` and `lb build`. The resulting image is
written to:

```
live-build/live-image-amd64.hybrid.iso
```

You can also use a privileged container to build the image (which is how [GitHub Actions](.github/workflows/build-live-image.yml) builds the image).

### Repository layout

```
build.sh                         # wrapper around lb clean/config/build
live-build/
  auto/config                    # live-build configuration (distribution, mirrors, ...)
  config/
    package-lists/               # packages grouped by purpose
    hooks/normal/                # chroot hooks (root password, extra TTYs, SSH, ...)
    includes.chroot_*_packages/  # files baked into the image (tty-menu, ssh-manager, skel, ...)
    bootloaders/                 # GRUB / isolinux boot menu config
.github/workflows/               # automated build & release
```

## Disclaimer

Note: The LICENSE file applies only to the files in the Git repository.
The releases / ISO images contain software under various licenses.
Information about which software is included can be found in the package-lists files, their dependencies and the install hook scripts.
  
Please note that this is an experimental project, bugs can occur. I am not responsible for any kind of damages.

```
THERE IS NO WARRANTY FOR THE PROGRAM, TO THE EXTENT PERMITTED BY
APPLICABLE LAW.  EXCEPT WHEN OTHERWISE STATED IN WRITING THE COPYRIGHT
HOLDERS AND/OR OTHER PARTIES PROVIDE THE PROGRAM "AS IS" WITHOUT WARRANTY
OF ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO,
THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
PURPOSE.  THE ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE PROGRAM
IS WITH YOU.  SHOULD THE PROGRAM PROVE DEFECTIVE, YOU ASSUME THE COST OF
ALL NECESSARY SERVICING, REPAIR OR CORRECTION.

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MODIFIES AND/OR CONVEYS
THE PROGRAM AS PERMITTED ABOVE, BE LIABLE TO YOU FOR DAMAGES, INCLUDING ANY
GENERAL, SPECIAL, INCIDENTAL OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE
USE OR INABILITY TO USE THE PROGRAM (INCLUDING BUT NOT LIMITED TO LOSS OF
DATA OR DATA BEING RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD
PARTIES OR A FAILURE OF THE PROGRAM TO OPERATE WITH ANY OTHER PROGRAMS),
EVEN IF SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF
SUCH DAMAGES.
```

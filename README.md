# Rescue OS
Rescue OS is a debian live-build configuration for a rescue OS that runs from RAM. 

It's currently work in progress and might not work as expected.

## Download

You can download pre-built ISOs from [GitHub Releases](https://github.com/jandie1505/rescue-os/releases/latest).  
  
Normally, the ISO is automatically built every 2 months with the newest available packages.  
You can also download them from the [lastest workflow run](https://github.com/jandie1505/rescue-os/actions/runs/18759563411), but you need to be logged in.  

## Installation

You can flash the ISO to a USB drive using `sudo dd if=live-image-amd64.hybrid.iso of=/dev/sdX bs=4M oflag=sync status=progress && sync` or a tool like Balena Etcher.

## How to build

1. Clone a repo on a system running [Debian 13 (Trixie)](https://www.debian.org/distrib/).  
   If you don't use debian on your computer, you can create a Debian VM using QEMU/KVM or VirtualBox.
3. Run `./build.sh`.  
   The script only works if `sudo` is available and the current user has root access.
5. The final iso image is generated at `PROJECT_DIR/live-build/live-image-amd64.hybrid.iso`

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

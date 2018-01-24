
Debian
====================
This directory contains files used to package ellocashd/ellocash-qt
for Debian-based Linux systems. If you compile ellocashd/ellocash-qt yourself, there are some useful files here.

## ellocash: URI support ##


ellocash-qt.desktop  (Gnome / Open Desktop)
To install:

	sudo desktop-file-install ellocash-qt.desktop
	sudo update-desktop-database

If you build yourself, you will either need to modify the paths in
the .desktop file or copy or symlink your ellocash-qt binary to `/usr/bin`
and the `../../share/pixmaps/ellocash128.png` to `/usr/share/pixmaps`

ellocash-qt.protocol (KDE)


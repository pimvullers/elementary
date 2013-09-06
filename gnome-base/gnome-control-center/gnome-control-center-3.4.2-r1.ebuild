# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-control-center/Attic/gnome-control-center-3.4.2-r1.ebuild,v 1.6 2013/01/25 22:56:49 eva dead $

EAPI=5

GCONF_DEBUG="yes"
GNOME2_LA_PUNT="yes" # gmodule is used, which uses dlopen

inherit autotools eutils gnome2

DESCRIPTION="GNOME Desktop Configuration Tool"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="2"
IUSE="+bluetooth +cheese +colord +cups +gnome-online-accounts input_devices_wacom +networkmanager +socialweb systemd"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-freebsd ~amd64-linux ~x86-linux ~x86-solaris"

# XXX: gnome-desktop-2.91.5 is needed for upstream commit c67f7efb
# XXX: NetworkManager-0.9 support is automagic, make hard-dep once it's released
#
# gnome-session-2.91.6-r1 is needed so that 10-user-dirs-update is run at login
# Latest gsettings-desktop-schemas is neededfor commit 73f9bffb
# gnome-settings-daemon-3.1.4 is needed for power panel (commit 4f08a325)
# g-s-d[policykit] needed for bug #403527
COMMON_DEPEND="
	>=dev-libs/glib-2.31.0:2
	>=x11-libs/gdk-pixbuf-2.23.0:2
	>=x11-libs/gtk+-3.3.5:3
	>=gnome-base/gsettings-desktop-schemas-3.3.0
	>=gnome-base/gnome-desktop-3.1.91:3
	>=gnome-base/gnome-settings-daemon-3.3.92[colord?,policykit]
	>=gnome-base/libgnomekbd-2.91.91

	app-text/iso-codes
	dev-libs/libxml2:2
	gnome-base/gnome-menus:3
	gnome-base/libgtop:2
	media-libs/fontconfig

	>=media-libs/libcanberra-0.13[gtk3]
	>=media-sound/pulseaudio-0.9.16[glib]
	>=sys-auth/polkit-0.97
	>=sys-power/upower-0.9.1
	>=x11-libs/libnotify-0.7.3

	x11-apps/xmodmap
	x11-libs/libX11
	x11-libs/libXxf86misc
	>=x11-libs/libxklavier-5.1
	>=x11-libs/libXi-1.2
	bluetooth? ( >=net-wireless/gnome-bluetooth-3.3.4 )
	cheese? (
		media-libs/gstreamer:0.10
		>=media-video/cheese-3.3.5 )
	colord? ( >=x11-misc/colord-0.1.8 )
	cups? ( >=net-print/cups-1.4[dbus] )
	gnome-online-accounts? ( net-libs/gnome-online-accounts )
	input_devices_wacom? (
		>=dev-libs/libwacom-0.3
		x11-libs/libXi )
	networkmanager? (
		>=gnome-extra/nm-applet-0.9.1.90
		>=net-misc/networkmanager-0.8.997 )
	socialweb? ( net-libs/libsocialweb )
	systemd? ( >=sys-apps/systemd-31 )
"
# <gnome-color-manager-3.1.2 has file collisions with g-c-c-3.1.x
RDEPEND="${COMMON_DEPEND}
	app-admin/apg
	gnome-base/gnome-settings-daemon[input_devices_wacom?]
	sys-apps/accountsservice
	x11-themes/gnome-icon-theme-symbolic
	colord? ( >=gnome-extra/gnome-color-manager-3 )
	cups? (
		>=app-admin/system-config-printer-gnome-1.3.5
		net-print/cups-pk-helper )
	!systemd? (
		app-admin/openrc-settingsd
		sys-auth/consolekit )

	!<gnome-base/gdm-2.91.94
	!<gnome-extra/gnome-color-manager-3.1.2
	!gnome-extra/gnome-media[pulseaudio]
	!<gnome-extra/gnome-media-2.32.0-r300
	!<net-wireless/gnome-bluetooth-3.3.2"
# PDEPEND to avoid circular dependency
PDEPEND=">=gnome-base/gnome-session-2.91.6-r1"
DEPEND="${COMMON_DEPEND}
	x11-proto/xproto
	x11-proto/xf86miscproto
	x11-proto/kbproto

	>=sys-devel/gettext-0.17
	>=dev-util/intltool-0.40.1
	virtual/pkgconfig

	app-text/scrollkeeper
	>=app-text/gnome-doc-utils-0.10.1

	cups? ( sys-apps/sed )

	gnome-base/gnome-common"
# Needed for autoreconf
#	gnome-base/gnome-common

pkg_setup() {
	G2CONF="${G2CONF}
		--disable-update-mimedb
		--disable-static
		$(use_enable bluetooth)
		$(use_with cheese)
		$(use_enable colord color)
		$(use_enable cups)
		$(use_enable input_devices_wacom wacom)
		$(use_enable gnome-online-accounts goa)
		$(use_with socialweb libsocialweb)
		$(use_enable systemd)"
	DOCS="AUTHORS ChangeLog NEWS README TODO"
}

src_prepare() {
	# Make some panels optional; requires eautoreconf
	epatch "${FILESDIR}/${PN}-3.4.2-optional-bt-colord-goa-wacom.patch"
	# Fix some absolute paths to be appropriate for Gentoo
	epatch "${FILESDIR}/${PN}-3.4.2-gentoo-paths.patch"
	# https://bugzilla.gnome.org/show_bug.cgi?id=679759
	epatch "${FILESDIR}/${PN}-3.4.2-cups-1.6.patch"
	# Fix building against newer gnome-bluetooth
	epatch "${FILESDIR}/${PN}-3.4.2-bluetooth.patch"
	# Fix build against newer gnome-desktop
	epatch "${FILESDIR}/${PN}-3.4.2-gnome-desktop.patch"
	eautoreconf

	gnome2_src_prepare

	# panels/datetime/Makefile.am gets touched as a result of something in our
	# src_prepare(). We need to touch timedated{c,h} to prevent them from being
	# regenerated (bug #415901)
	[[ -f panels/datetime/timedated.h ]] && touch panels/datetime/timedated.h
	[[ -f panels/datetime/timedated.c ]] && touch panels/datetime/timedated.c
}

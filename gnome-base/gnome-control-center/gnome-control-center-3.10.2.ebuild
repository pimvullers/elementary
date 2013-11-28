# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
GCONF_DEBUG="yes"
GNOME2_LA_PUNT="yes" # gmodule is used, which uses dlopen

inherit autotools bash-completion-r1 eutils gnome2

DESCRIPTION="GNOME's main interface to configure various aspects of the desktop"
HOMEPAGE="https://git.gnome.org/browse/gnome-control-center/"

LICENSE="GPL-2+"
SLOT="2"

IUSE="+bluetooth +colord +cups +gnome-online-accounts +i18n input_devices_wacom kerberos networkmanager modemmanager +socialweb v4l"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x86-solaris"

# False positives caused by nested configure scripts
QA_CONFIGURE_OPTIONS=".*"

# gnome-session-2.91.6-r1 is needed so that 10-user-dirs-update is run at login
# g-s-d[policykit] needed for bug #403527
#
# gnome-shell/gnome-control-center/mutter/gnome-settings-daemon better to be in sync for 3.8.3
# https://mail.gnome.org/archives/gnome-announce-list/2013-June/msg00005.html
#
# kerberos unfortunately means mit-krb5; build fails with heimdal
COMMON_DEPEND="
	>=dev-libs/glib-2.37.7:2
	>=x11-libs/gdk-pixbuf-2.23.0:2
	>=x11-libs/gtk+-3.9.12:3
	>=gnome-base/gsettings-desktop-schemas-3.9.91
	>=gnome-base/gnome-desktop-3.9.90:3=
	>=gnome-base/gnome-settings-daemon-3.8.3[policykit]
	>=gnome-base/libgnomekbd-2.91.91

	>=dev-libs/libpwquality-1.2.2
	dev-libs/libxml2:2
	gnome-base/gnome-menus:3
	gnome-base/libgtop:2
	media-libs/fontconfig
	media-libs/clutter

	>=media-libs/libcanberra-0.13[gtk3]
	>=media-sound/pulseaudio-2[glib]
	>=sys-auth/polkit-0.103
	>=sys-power/upower-0.9.1
	>=x11-libs/libnotify-0.7.3:0=

	networkmanager? ( 
		>=gnome-extra/nm-applet-0.9.7.995
		>=net-misc/networkmanager-0.9.8[modemmanager?]
	)

	virtual/opengl
	x11-apps/xmodmap
	x11-libs/libX11
	x11-libs/libXxf86misc
	>=x11-libs/libXi-1.2

	bluetooth? ( >=net-wireless/gnome-bluetooth-3.5.5:= )
	colord? ( >=x11-misc/colord-0.1.29 )
	cups? (
		>=net-print/cups-1.4[dbus]
		>=net-fs/samba-3.6.14-r1[smbclient] )
	gnome-online-accounts? ( >=net-libs/gnome-online-accounts-3.9.90 )
	i18n? ( >=app-i18n/ibus-1.4.99 )
	kerberos? ( app-crypt/mit-krb5 )
	modemmanager? ( >=net-misc/modemmanager-0.7.990 )
	socialweb? ( net-libs/libsocialweb )
	v4l? (
		media-libs/gstreamer:1.0
		media-libs/clutter-gtk:1.0
		>=media-video/cheese-3.5.91 )
	input_devices_wacom? (
		>=dev-libs/libwacom-0.7
		>=x11-libs/libXi-1.2 )
"
# <gnome-color-manager-3.1.2 has file collisions with g-c-c-3.1.x
RDEPEND="${COMMON_DEPEND}
	|| ( ( app-admin/openrc-settingsd sys-auth/consolekit ) >=sys-apps/systemd-31 )
	>=sys-apps/accountsservice-0.6.30
	x11-themes/gnome-icon-theme-symbolic
	colord? (
		>=gnome-extra/gnome-color-manager-3
		>=x11-misc/colord-0.1.34
		>=x11-libs/colord-gtk-0.1.24 )
	cups? (
		>=app-admin/system-config-printer-gnome-1.3.5
		net-print/cups-pk-helper )
	input_devices_wacom? ( gnome-base/gnome-settings-daemon[input_devices_wacom] )

	!<gnome-base/gdm-2.91.94
	!<gnome-extra/gnome-color-manager-3.1.2
	!gnome-extra/gnome-media[pulseaudio]
	!<gnome-extra/gnome-media-2.32.0-r300
	!<net-wireless/gnome-bluetooth-3.3.2
"
# PDEPEND to avoid circular dependency
PDEPEND=">=gnome-base/gnome-session-2.91.6-r1"

DEPEND="${COMMON_DEPEND}
	x11-proto/xproto
	x11-proto/xf86miscproto
	x11-proto/kbproto

	dev-libs/libxml2:2
	dev-libs/libxslt
	>=dev-util/intltool-0.40.1
	>=sys-devel/gettext-0.17
	virtual/pkgconfig

	cups? ( sys-apps/sed )

	gnome-base/gnome-common
"
# Needed for autoreconf
#	gnome-base/gnome-common

src_prepare() {
	# Gentoo handles completions in a different directory, bugs #465094 and #477390
	sed -i "s|^completiondir =.*|completiondir = $(get_bashcompdir)|" \
		shell/Makefile.am || die "sed completiondir failed"

	# Make some panels and dependencies optional; requires eautoreconf
	# https://bugzilla.gnome.org/686840, 697478, 700145
	epatch "${FILESDIR}/${PN}-3.10.2-optional.patch"

	# Fix some absolute paths to be appropriate for Gentoo
	epatch "${FILESDIR}/${PN}-3.8.0-paths-makefiles.patch"
	epatch "${FILESDIR}/${PN}-3.8.0-paths.patch"
	epatch "${FILESDIR}/${P}-fixbuild.patch"

	epatch_user
	eautoreconf

	# panels/datetime/Makefile.am gets touched as a result of something in our
	# src_prepare(). We need to touch timedated{c,h} to prevent them from being
	# regenerated (bug #415901)
	# Upstream think they should be removed, preventing compilation errors too
	# (https://bugzilla.gnome.org/704822)
	[[ -f panels/datetime/timedated.h ]] && rm -f panels/datetime/timedated.h
	[[ -f panels/datetime/timedated.c ]] && rm -f panels/datetime/timedated.c

	gnome2_src_prepare
}

src_configure() {
	gnome2_src_configure \
		--disable-update-mimedb \
		--disable-static \
		--enable-documentation \
		$(use_enable bluetooth) \
		$(use_enable colord color) \
		$(use_enable cups) \
		$(use_enable gnome-online-accounts goa) \
		$(use_enable i18n ibus) \
		$(use_enable kerberos) \
		$(use_enable modemmanager) \
		$(use_with socialweb libsocialweb) \
		$(use_with v4l cheese) \
		$(use_enable input_devices_wacom wacom)
}

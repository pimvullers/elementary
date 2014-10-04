# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-screensaver/gnome-screensaver-3.6.1.ebuild,v 1.6 2013/12/08 18:49:18 pacho Exp $

EAPI="5"
GCONF_DEBUG="yes"

inherit eutils gnome2 autotools

DESCRIPTION="Replaces xscreensaver, integrating with the desktop"
HOMEPAGE="http://live.gnome.org/GnomeScreensaver"
SRC_URI="${SRC_URI}
	https://launchpad.net/ubuntu/+archive/primary/+files/${PN}_${PV}-0ubuntu13.debian.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
IUSE="debug doc pam systemd +ubuntu"
KEYWORDS="~alpha amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc x86 ~x86-fbsd"

RDEPEND="
	>=dev-libs/glib-2.25.6:2
	>=x11-libs/gtk+-2.99.3:3
	>=gnome-base/gnome-desktop-3.1.91:3=
	>=gnome-base/gsettings-desktop-schemas-0.1.7
	>=gnome-base/libgnomekbd-3.6
	>=dev-libs/dbus-glib-0.71

	sys-apps/dbus
	x11-libs/libxklavier
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXrandr
	x11-libs/libXScrnSaver
	x11-libs/libXxf86misc
	x11-libs/libXxf86vm
	x11-themes/gnome-icon-theme-symbolic

	pam? ( virtual/pam )
	systemd? ( >=sys-apps/systemd-31:0= )
"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35
	sys-devel/gettext
	virtual/pkgconfig
	x11-proto/xextproto
	x11-proto/randrproto
	x11-proto/scrnsaverproto
	x11-proto/xf86miscproto
	doc? (
		app-text/xmlto
		app-text/docbook-xml-dtd:4.1.2
		app-text/docbook-xml-dtd:4.4 )
"

src_prepare() {
	# Ubuntu patches
	if use ubuntu; then
		einfo "Applying patches from Ubuntu:"
		for patch in `cat "${FILESDIR}/${P}-ubuntu-patch-series"`; do
			epatch "${WORKDIR}/debian/patches/${patch}"
		done
	fi

	epatch_user
	# Regenerate marshaling code for <glib-2.31 compat
	rm -v src/gs-marshal.{c,h} || die

	gnome2_src_prepare

	eautoreconf
}

src_configure() {
	DOCS="AUTHORS ChangeLog HACKING NEWS README"
	G2CONF="${G2CONF}
		$(use_enable doc docbook-docs)
		$(use_enable pam locking)
		$(use_with systemd)
		--with-mit-ext
		--with-pam-prefix=/etc
		--with-xf86gamma-ext
		--with-kbd-layout-indicator"
	# Do not use --without-console-kit, it would provide no benefit: there is
	# no build-time or run-time check for consolekit, $PN merely listens to
	# consolekit's messages over dbus.
	# xscreensaver and custom screensaver capability removed
	# poke and inhibit commands were also removed, bug 579430
	gnome2_src_configure
}

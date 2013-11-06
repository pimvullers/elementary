# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/gnome-bluetooth/Attic/gnome-bluetooth-3.6.1.ebuild,v 1.4 2013/10/10 18:38:28 pacho dead $

EAPI="5"
GCONF_DEBUG="yes"
GNOME2_LA_PUNT="yes"

inherit eutils gnome2 multilib udev user

DESCRIPTION="Fork of bluez-gnome focused on integration with GNOME"
HOMEPAGE="http://live.gnome.org/GnomeBluetooth"

LICENSE="GPL-2+ LGPL-2.1+ FDL-1.1+"
SLOT="2/11" # subslot = libgnome-bluetooth soname version
IUSE="+introspection sendto"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86"

COMMON_DEPEND=">=dev-libs/glib-2.29.90:2
	>=x11-libs/gtk+-2.91.3:3[introspection?]
	>=x11-libs/libnotify-0.7:=
	virtual/udev

	introspection? ( >=dev-libs/gobject-introspection-0.9.5 )
	sendto? ( >=gnome-extra/nautilus-sendto-2.91 )
"
RDEPEND="${COMMON_DEPEND}
	>=net-wireless/bluez-4.34
	app-mobilephone/obexd
	x11-themes/gnome-icon-theme-symbolic"
DEPEND="${COMMON_DEPEND}
	!net-wireless/bluez-gnome
	app-text/docbook-xml-dtd:4.1.2
	dev-libs/libxml2:2
	dev-util/gdbus-codegen
	>=dev-util/gtk-doc-am-1.9
	>=dev-util/intltool-0.40.0
	>=sys-devel/gettext-0.17
	virtual/pkgconfig
	x11-libs/libX11
	x11-libs/libXi
	x11-proto/xproto
"
# eautoreconf needs:
#	gnome-base/gnome-common
#	dev-util/gtk-doc-am

pkg_setup() {
	enewgroup plugdev
}

src_prepare() {
	# Regenerate gdbus-codegen files to allow using any glib version; bug #436236
	rm -v lib/bluetooth-client-glue.{c,h} || die
	gnome2_src_prepare
}

src_configure() {
	# FIXME: Add geoclue support
	G2CONF="${G2CONF}
		$(use_enable introspection)
		$(use_enable sendto nautilus-sendto)
		--enable-documentation
		--disable-maintainer-mode
		--disable-desktop-update
		--disable-icon-update
		--disable-static
		ITSTOOL=$(type -P true)"
	gnome2_src_configure
}

src_install() {
	gnome2_src_install
	udev_dorules "${FILESDIR}"/61-${PN}.rules
}

pkg_postinst() {
	gnome2_pkg_postinst
	# Notify about old libraries that might still be around
	preserve_old_lib_notify /usr/$(get_libdir)/libgnome-bluetooth.so.7

	if ! has_version sys-auth/consolekit[acl] ; then
		elog "Don't forget to add yourself to the plugdev group "
		elog "if you want to be able to control bluetooth transmitter."
	fi
}

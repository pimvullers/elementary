# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/geoclue/geoclue-2.0.0.ebuild,v 1.2 2014/01/14 12:12:43 blueness Exp $

EAPI="5"

inherit gnome2 user versionator

MY_PV=$(get_version_component_range 1-2)
DESCRIPTION="A geoinformation D-Bus service"
HOMEPAGE="http://freedesktop.org/wiki/Software/GeoClue"
SRC_URI="http://www.freedesktop.org/software/${PN}/releases/${MY_PV}/${P}.tar.xz"

LICENSE="LGPL-2"
SLOT="2.0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd"
IUSE="modemmanager nls server"

RDEPEND="
	>=dev-libs/glib-2.34:2
	>=dev-libs/json-glib-0.14
	net-libs/libsoup:2.4
	sys-apps/dbus
	server? ( >=dev-libs/geoip-1.5.1 )
	modemmanager? ( net-misc/modemmanager )
	!<sci-geosciences/geocode-glib-3.10.0
"
DEPEND="${RDEPEND}
	>=dev-util/gtk-doc-am-1
	>=dev-util/intltool-0.40
	virtual/pkgconfig
"

RESTRICT="test"

src_configure() {
	gnome2_src_configure \
		--with-dbus-service-user=geoclue \
		$(use_enable server geoip-server) \
		$(use_enable nls) \
		$(use_enable modemmanager 3g-source) \
		$(use_enable modemmanager modem-gps-source) \
		$(use_enable modemmanager wifi-source)
}

pkg_preinst() {
	enewgroup geoclue
	enewuser geoclue -1 -1 /var/lib/geoclue geoclue
}

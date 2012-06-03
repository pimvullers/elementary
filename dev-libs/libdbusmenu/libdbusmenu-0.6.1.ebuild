# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libdbusmenu/libdbusmenu-0.5.1-r300.ebuild,v 1.3 2011/11/28 22:37:34 zmedico Exp $

EAPI=4

inherit autotools-utils

DESCRIPTION="Library to pass menu structure across DBus"
HOMEPAGE="https://launchpad.net/dbusmenu"
SRC_URI="http://launchpad.net/dbusmenu/0.6/${PV}/+download/${P}.tar.gz"

LICENSE="LGPL-2.1 LGPL-3"
SLOT="3"
KEYWORDS="~amd64 ~x86"
IUSE="gtk +introspection static-libs"

RDEPEND="
	dev-libs/glib:2
	dev-libs/dbus-glib
	dev-libs/libxml2
	gtk? ( x11-libs/gtk+:3 )
	introspection? ( dev-libs/gobject-introspection )"
DEPEND="${RDEPEND}
	dev-lang/vala:0.16[vapigen]
	app-text/gnome-doc-utils
	dev-util/intltool
	dev-util/pkgconfig"

pkg_setup() {
	DOCS=( AUTHORS ChangeLog README )
}

src_configure() {
	local myeconfargs=(
		VALA_API_GEN="$(type -p vapigen-0.16)"
		$(use_enable gtk)
		$(use_enable introspection)
		--disable-dumper
		--disable-tests
		--docdir=/usr/share/doc/${PF}
		--with-html-dir=/usr/share/doc/${PF}
		--with-gtk=3
	)

	autotools-utils_src_configure
}


# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libindicator/libindicator-0.4.1-r300.ebuild,v 1.1 2011/11/26 16:25:05 ssuominen Exp $

EAPI=5

inherit autotools-utils

DESCRIPTION="Library for the integration of web applications with the Unity desktop"
HOMEPAGE="http://launchpad.net/libunity-webapps"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/unity_webapps-${PV}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

RDEPEND="
	app-admin/packagekit-base
	dev-db/sqlite:3
	dev-libs/glib:2
	dev-libs/gobject-introspection
	dev-libs/json-glib
	dev-libs/libdbusmenu:3[gtk]
	dev-libs/libindicate[gtk]
	dev-libs/libunity
	dev-util/gdbus-codegen
	net-libs/libsoup:2.4
	net-libs/telepathy-glib
	sys-auth/polkit
	x11-libs/gtk+:3
	x11-libs/libnotify
	x11-libs/libwnck:3"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

pkg_setup() {
	S="${WORKDIR}/unity_webapps-${PV}/"
}

src_install() {
	autotools-utils_src_install

	rm -f "${ED}"usr/lib*/*.la
}

# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libindicator/libindicator-0.4.1-r300.ebuild,v 1.1 2011/11/26 16:25:05 ssuominen Exp $

EAPI=4

inherit autotools-utils

DESCRIPTION="A library for instrumenting- and integrating with all aspects of the Unity shell"
HOMEPAGE="http://launchpad.net/libunity"
SRC_URI="http://launchpad.net/${PN}/6.0/${PV}/+download/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

RDEPEND="
	dev-libs/dee
	dev-libs/glib:2
	dev-libs/gobject-introspection
	dev-libs/libdbusmenu:3
	dev-libs/libgee
	x11-libs/gtk+:3"
DEPEND="${RDEPEND}
	dev-lang/vala:0.18
	dev-util/pkgconfig"

src_configure() {
	local myeconfargs=(
		VALAC="$(type -p valac-0.18)"
	)

	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install

	rm -f "${ED}"usr/lib*/*.la
}

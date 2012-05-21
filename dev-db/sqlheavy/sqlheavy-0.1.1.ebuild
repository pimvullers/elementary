# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit autotools-utils

DESCRIPTION="GObject SQLite wrapper, providing very nice APIs for C and Vala, GObject Introspection support, and additional functionality not present in SQLite"
HOMEPAGE="http://code.google.com/p/sqlheavy/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.xz"

LICENSE="LGPL-2.1"
SLOT="0.1"
KEYWORDS="~amd64"
IUSE="static-libs"

RDEPEND="
	>=dev-db/sqlite-3.6.20:3
	>=dev-libs/glib-2.22:2
	>=x11-libs/gtk+-2.24:2"
DEPEND="${RDEPEND}
	dev-lang/vala:0.16"

AUTOTOOLS_IN_SOURCE_BUILD=1

pkg_setup() {
	DOCS=(AUTHORS COPYING ChangeLog NEWS README)
}

src_configure() {
	local myeconfargs=(
		VALAC="$(type -p valac-0.16)"
	)

	autotools-utils_src_configure
}

src_compile() {
	autotools-utils_src_compile -j1
}

src_install() {
	autotools-utils_src_install

	# Create a slotted version of the binary
	mv ${ED}/usr/bin/sqlheavy-gen-orm ${ED}/usr/bin/sqlheavy-gen-orm-${SLOT}
	mv ${ED}/usr/share/man/man1/sqlheavy-gen-orm.1 ${ED}/usr/share/man/man1/sqlheavy-gen-orm-${SLOT}.1
}


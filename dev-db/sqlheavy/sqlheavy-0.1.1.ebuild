# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

VALA_MIN_API_VERSION=0.20

inherit vala autotools-utils

DESCRIPTION="GObject SQLite wrapper"
HOMEPAGE="https://code.google.com/archive/p/sqlheavy/"
SRC_URI="https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/${PN}/${P}.tar.xz"

LICENSE="LGPL-2.1"
SLOT="0.1"
KEYWORDS="amd64 x86"
IUSE="static-libs"

RDEPEND="
	>=dev-db/sqlite-3.6.20:3
	>=dev-libs/glib-2.22:2
	>=x11-libs/gtk+-2.24:2"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig"

AUTOTOOLS_IN_SOURCE_BUILD=1
AUTOTOOLS_AUTORECONF=1

pkg_setup() {
	DOCS=(AUTHORS COPYING ChangeLog NEWS README)
}

src_prepare() {
	epatch "${FILESDIR}/${P}-drop-sqlheavy-gen-orm.patch"

	autotools-utils_src_prepare
	vala_src_prepare
}

src_compile() {
	autotools-utils_src_compile -j1
}

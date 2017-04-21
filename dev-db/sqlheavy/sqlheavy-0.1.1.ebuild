# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

VALA_MIN_API_VERSION=0.26

inherit vala autotools

DESCRIPTION="GObject SQLite wrapper"
HOMEPAGE="https://code.google.com/archive/p/sqlheavy/"
SRC_URI="https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/${PN}/${P}.tar.xz"

LICENSE="LGPL-2.1"
SLOT="0.1"
KEYWORDS="amd64 x86"

RDEPEND="
	>=dev-db/sqlite-3.6.20:3
	>=dev-libs/glib-2.22:2
	>=x11-libs/gtk+-2.24:2"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig"

src_prepare() {
	eapply "${FILESDIR}/${P}-drop-sqlheavy-gen-orm.patch"
	eapply_user

	eautoreconf
	vala_src_prepare
}


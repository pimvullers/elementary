# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2 meson vala

DESCRIPTION="Elementary Screenshot Tool"
HOMEPAGE="https://github.com/elementary/screenshot"
SRC_URI="https://github.com/elementary/screenshot/archive/${PV}.tar.gz -> ${P}.tar.gz"

S=${WORKDIR}/screenshot-${PV}

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

DEPEND="
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
"

RDEPEND="${DEPEND}
	dev-libs/glib:2
	dev-libs/granite:7
	gui-libs/libhandy:1
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
"

src_prepare() {
	eapply_user
	vala_setup
}

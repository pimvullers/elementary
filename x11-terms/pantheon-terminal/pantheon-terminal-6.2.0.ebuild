# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_API_VERSION=0.40

inherit gnome2 meson vala

DESCRIPTION="The terminal of the 21st century"
HOMEPAGE="https://github.com/elementary/terminal"
SRC_URI="https://github.com/elementary/terminal/archive/${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/terminal-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="
	dev-libs/libgee:0.8
	dev-libs/glib:2
	dev-libs/granite:0
	dev-libs/libpcre2
	gui-libs/libhandy:1
	x11-libs/gtk+:3
	x11-libs/vte:2.91[vala]
"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
"

pkg_setup() {
	vala_setup
}

src_prepare() {
	eapply "${FILESDIR}/drop-tests.patch"
	eapply_user
}

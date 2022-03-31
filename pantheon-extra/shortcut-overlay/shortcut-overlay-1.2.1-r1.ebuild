# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson vala xdg-utils

DESCRIPTION="A native OS-wide shortcut overlay to be launched by Gala"
HOMEPAGE="https://github.com/elementary/shortcut-overlay"
SRC_URI="https://github.com/elementary/shortcut-overlay/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="
	$(vala_depend)
	virtual/pkgconfig
"
RDEPEND="${DEPEND}
	dev-libs/glib:2
	>=dev-libs/granite-5.4.0:=
	dev-libs/libgee:0.8
	>=gui-libs/libhandy-0.80.0:1
	x11-libs/gtk+:3
"

src_prepare() {
	eapply ${FILESDIR}/113.diff

	eapply_user
	vala_src_prepare
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}

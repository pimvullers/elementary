# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson vala xdg-utils

DESCRIPTION="A native OS-wide shortcut overlay to be launched by Gala"
HOMEPAGE="https://github.com/elementary/shortcut-overlay"
SRC_URI="https://github.com/elementary/shortcut-overlay/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="nls"

DEPEND="
	$(vala_depend)
	nls? ( sys-devel/gettext )
	virtual/pkgconfig
"
RDEPEND="${DEPEND}
	dev-libs/glib:2
	dev-libs/granite
	dev-libs/libgee:0.8
	x11-libs/gtk+:3
"


src_prepare() {
	eapply_user
	eapply "${FILESDIR}/${PV}-fix_static_initialize.patch"
	vala_src_prepare
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}

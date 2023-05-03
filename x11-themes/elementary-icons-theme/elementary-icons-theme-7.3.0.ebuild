# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson xdg

DESCRIPTION="An original set of vector icons designed specifically for elementary OS"
HOMEPAGE="https://github.com/elementary/icons"
SRC_URI="https://github.com/elementary/icons/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND="gnome-base/librsvg"
BDEPEND="${RDEPEND}
	x11-apps/xcursorgen"
S=${WORKDIR}/icons-${PV}

src_configure() {
	local emesonargs=(
		-Dvolume_icons=false
		-Dpalettes=false
	)
	meson_src_configure
}

pkg_preinst() {
	xdg_pkg_preinst
}

pkg_postinst() {
	xdg_pkg_postinst
}

pkg_postrm() {
	xdg_pkg_postrm
}

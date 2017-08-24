# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils gnome2-utils git-r3

DESCRIPTION="Elementary icon theme is designed to be smooth, sexy, clear, and efficient"
HOMEPAGE="https://launchpad.net/elementaryicons"
EGIT_REPO_URI="https://github.com/elementary/icons.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=""
DEPEND="x11-libs/gtk+:2"

RESTRICT="binchecks mirror strip"

DOCS=( AUTHORS CONTRIBUTORS COPYING )

src_prepare() {
	sed -i '/add_subdirectory (volumeicon)/d' CMakeLists.txt

	cmake-utils_src_prepare
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}

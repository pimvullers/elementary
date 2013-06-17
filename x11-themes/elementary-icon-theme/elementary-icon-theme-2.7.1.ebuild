# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit gnome2-utils

DESCRIPTION="Elementary icon theme is designed to be smooth, sexy, clear, and efficient"
HOMEPAGE="https://launchpad.net/elementaryicons"
SRC_URI="http://launchpad.net/elementaryicons/2.0/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="monochrome"

CDEPEND=""
RDEPEND="${CDEPEND}"
DEPEND="${CDEPEND}
	x11-libs/gtk+:2"

RESTRICT="binchecks strip"

pkg_setup() {
	DOCS="elementary/AUTHORS elementary/COPYING elementary/CONTRIBUTORS"
	S="${WORKDIR}/${PN}"
}

src_install() {
	dodoc ${DOCS}
	rm ${DOCS}

	insinto /usr/share/icons
	doins -r elementary
	use monochrome && doins -r elementary-mono-dark
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


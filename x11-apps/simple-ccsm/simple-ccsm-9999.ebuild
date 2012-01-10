# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit gnome2-utils distutils git

DESCRIPTION="Simplified Compizconfig Settings Manager (git)"
HOMEPAGE="http://www.compiz.org/"
EGIT_REPO_URI="git://anongit.compiz-fusion.org/fusion/compizconfig/${PN}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	~dev-python/compizconfig-python-${PV}
	>=dev-python/pygtk-2.10"
DEPEND="${RDEPEND}"

src_install() {
	distutils_src_install --prefix="/usr"
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


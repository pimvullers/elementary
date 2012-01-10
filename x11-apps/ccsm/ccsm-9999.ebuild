# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit fdo-mime gnome2-utils distutils git

DESCRIPTION="Compizconfig Settings Manager"
HOMEPAGE="http://www.compiz.org/"
EGIT_REPO_URI="git://anongit.compiz-fusion.org/compiz/compizconfig/${PN}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	=dev-python/compizconfig-python-${PV}*
	>=dev-python/pygtk-2.10"
DEPEND="${RDEPEND}"

pkg_setup() {
	DOCS="AUTHORS COPYING ChangeLog LICENSE NEWS TODO VERSION"
}

src_install() {
	distutils_src_install --prefix="/usr"
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}


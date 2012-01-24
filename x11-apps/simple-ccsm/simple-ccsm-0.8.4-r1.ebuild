# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/simple-ccsm/simple-ccsm-0.8.4-r1.ebuild,v 1.2 2011/04/11 20:14:39 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"

inherit distutils gnome2-utils

DESCRIPTION="Simplified Compizconfig Settings Manager"
HOMEPAGE="http://www.compiz.org/"
SRC_URI="http://releases.compiz.org/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND="
	>=dev-python/compizconfig-python-${PV}
	>=dev-python/pygtk-2.10:2
	>=x11-apps/ccsm-${PV}
"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_compile() {
	distutils_src_compile --prefix=/usr
}

src_install() {
	distutils_src_install --prefix=/usr
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	distutils_pkg_postinst
	gnome2_icon_cache_update
}

pkg_postrm() {
	distutils_pkg_postrm
	gnome2_icon_cache_update
}

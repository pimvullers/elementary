# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit gnome2-utils cmake-utils git

DESCRIPTION="Compizconfig Gconf Backend"
HOMEPAGE="http://www.compiz.org/"
EGIT_REPO_URI="git://anongit.compiz-fusion.org/compiz/compizconfig/${PN}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	>=gnome-base/gconf-2.0
	>=x11-libs/libcompizconfig-${PV}
	>=x11-wm/compiz-${PV}"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		-DCOMPIZ_DISABLE_SCHEMAS_INSTALL=ON
	)

	cmake-utils_src_configure
}

pkg_preinst() {
	gnome2_gconf_savelist
}

pkg_postinst() {
	gnome2_gconf_install
}

pkg_prerm() {
	gnome2_gconf_uninstall
}


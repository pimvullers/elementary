# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit gnome2-utils cmake-utils git

DESCRIPTION="Compizconfig GSettings Backend"
HOMEPAGE="http://www.compiz.org/"
EGIT_REPO_URI="git://anongit.compiz-fusion.org/compiz/compizconfig/${PN}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	dev-libs/glib:2
	>=x11-libs/libcompizconfig-${PV}
	>=x11-wm/compiz-${PV}"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		-DCOMPIZ_DISABLE_GS_SCHEMAS_INSTALL=ON
		-DGLIB_COMPILE_SCHEMAS=OFF
	)

	cmake-utils_src_configure
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update --uninstall
}

